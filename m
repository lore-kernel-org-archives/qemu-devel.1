Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF47420720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="NzAaETpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF47420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1vX-0001VW-1W
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jr1qU-0000ep-Ae
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:13:55 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:50478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jr1qQ-0003SZ-QD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593706430; bh=xfUkqzdPljSkrRaXTIXJ15+rsgN98TJ6rD0K
 85e76CA=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=NzAaETpyJReMLNLLV7XhxXOE8Hcrx0imJh7L3vRXJNfw0j
 V7N69tuuc7som7oHY8kf22lgtmFEqrqebxC4BdAB/wJfOS6CnICyUZK02r/idOi+56u
 790gHrFjC8PMuGfjOzdkxFre5791bat/kt5UHsblCheJismZbe0gul+52IHwvA1ZrzC
 6hJ0ap8UYHTPGWo771paWcTizrqWmVFKGBWY43yeT5rRQSZxEWzytNWM529kHvUX7Q5
 DU10vXTXx/vWnvzCnIEDHlcAmx8Pp5oboKVZTNSJlY4gdpvo52Nn1Ww+Tl8JqsdVSFl
 +TBZUisr7sXgkG3pkn+Rfdsd9r5w==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=J0i7l7MdlZPtBeTK7Ar/zqT6J855q6c380gNTm0fjnchFLEt+hKQ5s87saB4iUJjXBYC+Gi8qGpYHhQJWGq53YybIAcJIC9HrUcHO4jAds0UYKP2hDlon+9u92PsJ3U1cs/N1k8RPMJX2kgqLj2H9x4Bv1ocwmJw8GX/OXZ0Czw+pRvCTxwduEzzXLmOv+jRZuxSPNvvR5eze2CGDum1e4RDyADBSQudvpfods5AxsP8mPs/GaXstnSVJMRCP5MYMejec+VFGpvcnFM+a+UscPxhU7sl3qJ1kvzvgTayuhcC/d5apFsqZW3ZWhEq29COxmqx2r2PYHbSPk4venyNVQ==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jr1qP-000B7a-0d; Thu, 02 Jul 2020 12:13:49 -0400
Message-ID: <5EFE07BC.6040407@mindspring.com>
Date: Thu, 02 Jul 2020 12:13:48 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
References: <20200702143955.678-1-thuth@redhat.com>
In-Reply-To: <20200702143955.678-1-thuth@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------050604020603080105070303"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca5e96715abca0cfe096f5023fa2f8edf0d350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.61; envelope-from=denber@mindspring.com;
 helo=elasmtp-galgo.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:13:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Tribble <peter.tribble@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------050604020603080105070303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 07/02/20 10:39, Thomas Huth wrote:
> Recent versions of Solaris (v11.4) now feature an openpty() function,
> too, causing a build failure since we ship our own implementation of
> openpty() for Solaris in util/qemu-openpty.c so far. Since there are
> now both variants available in the wild, with and without this function,
> let's introduce a proper HAVE_OPENPTY define for this to fix the build
> failure.
>
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   Note: Untested, since I do not have a VM with Solaris. Michele,
>   Peter, I'd really appreciate a "Tested-by:" from you here. Thanks!
Sorry, I was off on another project (doing my taxes).  Is this patch 
missing something?  It looks like there should be more.  The last line is

static void cfmakeraw (struct termios *termios_p) {

with no matching "}".


			- Michele

>
>   configure           | 9 ++++++++-
>   util/qemu-openpty.c | 4 +++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index 4a22dcd563..0b5fd30fc4 100755
> --- a/configure
> +++ b/configure
> @@ -5134,10 +5134,14 @@ extern int openpty(int *am, int *as, char *name, void *termp, void *winp);
>   int main(void) { return openpty(0, 0, 0, 0, 0); }
>   EOF
>
> -if ! compile_prog "" "" ; then
> +have_openpty="no"
> +if compile_prog "" "" ; then
> +  have_openpty="yes"
> +else
>     if compile_prog "" "-lutil" ; then
>       libs_softmmu="-lutil $libs_softmmu"
>       libs_tools="-lutil $libs_tools"
> +    have_openpty="yes"
>     fi
>   fi
>
> @@ -7380,6 +7384,9 @@ fi
>   if test "$have_broken_size_max" = "yes" ; then
>       echo "HAVE_BROKEN_SIZE_MAX=y">>  $config_host_mak
>   fi
> +if test "$have_openpty" = "yes" ; then
> +    echo "HAVE_OPENPTY=y">>  $config_host_mak
> +fi
>
>   # Work around a system header bug with some kernel/XFS header
>   # versions where they both try to define 'struct fsxattr':
> diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
> index 2e8b43bdf5..14e5c8ae8f 100644
> --- a/util/qemu-openpty.c
> +++ b/util/qemu-openpty.c
> @@ -52,7 +52,8 @@
>   #endif
>
>   #ifdef __sun__
> -/* Once Solaris has openpty(), this is going to be removed. */
> +
> +#if !defined(HAVE_OPENPTY)
>   static int openpty(int *amaster, int *aslave, char *name,
>                      struct termios *termp, struct winsize *winp)
>   {
> @@ -93,6 +94,7 @@ err:
>           close(mfd);
>           return -1;
>   }
> +#endif
>
>   static void cfmakeraw (struct termios *termios_p)
>   {

--------------050604020603080105070303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    On 07/02/20 10:39, Thomas Huth wrote:
    <blockquote cite="mid:20200702143955.678-1-thuth@redhat.com"
      type="cite">
      <pre wrap="">Recent versions of Solaris (v11.4) now feature an openpty() function,
too, causing a build failure since we ship our own implementation of
openpty() for Solaris in util/qemu-openpty.c so far. Since there are
now both variants available in the wild, with and without this function,
let's introduce a proper HAVE_OPENPTY define for this to fix the build
failure.

Signed-off-by: Thomas Huth <a class="moz-txt-link-rfc2396E" href="mailto:thuth@redhat.com">&lt;thuth@redhat.com&gt;</a>
---
 Note: Untested, since I do not have a VM with Solaris. Michele,
 Peter, I'd really appreciate a "Tested-by:" from you here. Thanks!</pre>
    </blockquote>
    Sorry, I was off on another project (doing my taxes).&nbsp; Is this patch
    missing something?&nbsp; It looks like there should be more.&nbsp; The last
    line is <br>
    <br>
    <small><font face="Courier New, Courier, monospace">static void
        cfmakeraw (struct termios *termios_p) {</font></small><br>
    <br>
    with no matching "}".&nbsp; <br>
    <pre wrap=""><big><font face="Helvetica, Arial, sans-serif">
			- Michele</font></big>

</pre>
    <blockquote cite="mid:20200702143955.678-1-thuth@redhat.com"
      type="cite">
      <pre wrap="">

 configure           | 9 ++++++++-
 util/qemu-openpty.c | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 4a22dcd563..0b5fd30fc4 100755
--- a/configure
+++ b/configure
@@ -5134,10 +5134,14 @@ extern int openpty(int *am, int *as, char *name, void *termp, void *winp);
 int main(void) { return openpty(0, 0, 0, 0, 0); }
 EOF
 
-if ! compile_prog "" "" ; then
+have_openpty="no"
+if compile_prog "" "" ; then
+  have_openpty="yes"
+else
   if compile_prog "" "-lutil" ; then
     libs_softmmu="-lutil $libs_softmmu"
     libs_tools="-lutil $libs_tools"
+    have_openpty="yes"
   fi
 fi
 
@@ -7380,6 +7384,9 @@ fi
 if test "$have_broken_size_max" = "yes" ; then
     echo "HAVE_BROKEN_SIZE_MAX=y" &gt;&gt; $config_host_mak
 fi
+if test "$have_openpty" = "yes" ; then
+    echo "HAVE_OPENPTY=y" &gt;&gt; $config_host_mak
+fi
 
 # Work around a system header bug with some kernel/XFS header
 # versions where they both try to define 'struct fsxattr':
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 2e8b43bdf5..14e5c8ae8f 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -52,7 +52,8 @@
 #endif
 
 #ifdef __sun__
-/* Once Solaris has openpty(), this is going to be removed. */
+
+#if !defined(HAVE_OPENPTY)
 static int openpty(int *amaster, int *aslave, char *name,
                    struct termios *termp, struct winsize *winp)
 {
@@ -93,6 +94,7 @@ err:
         close(mfd);
         return -1;
 }
+#endif
 
 static void cfmakeraw (struct termios *termios_p)
 {
</pre>
    </blockquote>
  </body>
</html>

--------------050604020603080105070303--

