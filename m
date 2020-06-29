Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA253C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A693C23B23
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK+sa7l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A693C23B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsiU-0001GU-Ta
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jpsgc-0008DT-Sn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:14:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jpsgY-0002YR-7T
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593432893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yRgfjhVD9oLd81ruHIaBv+/p6hpBn47iuPPxrmSq64=;
 b=XK+sa7l2sN04E2wFwW5MEYrMAj9OE5fGQQKkBpzgIkR6fpDeDCWKcxzm40JVnrHXtH8sNW
 Cf+ZorGz9QymFgraqI73YDN6AxTSpKN/TEieMcuEXlWZv0Bzc7uGcJFcD4/4VDZpFurqQW
 KeNLA2B6xf5kLGPZVzeTdxZpotHGusA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-L-MuwiPjMq6jP0svL8YnlQ-1; Mon, 29 Jun 2020 08:14:45 -0400
X-MC-Unique: L-MuwiPjMq6jP0svL8YnlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F5E8E2319;
 Mon, 29 Jun 2020 12:12:07 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-140.ams2.redhat.com [10.36.112.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB6A5D9DA;
 Mon, 29 Jun 2020 12:12:05 +0000 (UTC)
Subject: Re: Building in Solaris 11.4
To: Michele Denber <mdenber@gmx.com>, qemu-devel@nongnu.org
References: <5EF3C648.4060506@gmx.com> <5EF772B6.2010901@gmx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fcdd4b6c-eec5-2bfd-1004-8ac86e80bf0e@redhat.com>
Date: Mon, 29 Jun 2020 14:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5EF772B6.2010901@gmx.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Peter Tribble <peter.tribble@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/06/2020 18.24, Michele Denber wrote:
> Well the make ran for a while and then stopped here:
> 
> 
> root@hemlock:~/qemu-5.0.0# gmake -j16
> ...
>    CC      util/bitops.o
> util/qemu-openpty.c:56:12: error: static declaration of 
> \u2018openpty\u2019 follows non-static declaration
>   static int openpty(int *amaster, int *aslave, char *name,
>              ^~~~~~~
> In file included from /usr/include/termios.h:8:0,
>                   from util/qemu-openpty.c:48:
> /usr/include/sys/termios.h:538:12: note: previous declaration of 
> \u2018openpty\u2019 was here
>   extern int openpty(int *, int *, char *, struct termios *, struct 
> winsize *);
>              ^~~~~~~
> gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69: 
> util/qemu-openpty.o] Error 1
> 
> Interestingly, I ran across this openpty issue last year while building 
> QEMU 2.12 in Solaris 10, here: https://bugs.launchpad.net/qemu/+bug/1777252
> 
> It looks like the change to fix that issue (missing openpty in Solaris) 
> is having some trouble.  I'm not a good enough C programmer to figure it 
> out.  Remove the openpty declaration from util/openpty.c perhaps?

It's not the same bug as last year, but a new one: Seems like newer 
versions of Solaris now have this functions in their libraries! So what 
you want is something like this (completely untested):

diff --git a/configure b/configure
--- a/configure
+++ b/configure
@@ -5159,10 +5159,14 @@ extern int openpty(int *am, int *as, char *name, 
void *termp, void *winp);
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

@@ -7407,6 +7411,9 @@ fi
  if test "$have_broken_size_max" = "yes" ; then
      echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
  fi
+if test "$have_openpty" = "yes" ; then
+    echo "HAVE_OPENPTY=y" >> $config_host_mak
+fi

  # Work around a system header bug with some kernel/XFS header
  # versions where they both try to define 'struct fsxattr':
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
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

  HTH,
   Thomas


