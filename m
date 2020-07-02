Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43405C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093F220724
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="clq6wMC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093F220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr6qC-0005b7-9W
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 17:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jr6pS-00059X-Ce
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 17:33:10 -0400
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:44578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jr6pQ-0005rV-45
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 17:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593725588; bh=5k5Nn4LM7CuRbU1hzIBsnWuJWpISk4Ne8Gsn
 AnQAJrw=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=clq6wMC8f1je692FS9ahpbeOLvPkeKkQeo2w7O+JWm4mQF
 rKB/atwZ7HRinrzKG2FG1R5QUouhCMJsNziecwTiOJY3Iqsirh6MUSiYBROiqevP6sI
 CWim1Wm/9dy2aSZz3xukU7LyX/MnfXCfcuYY/kWxkdrhSdJUQMlra0VHBp7UXhVvbft
 hPFlm8BlvjqsawZPjmHfTiwQ03U5ffVSnKvCpzxqMtAt0MHlB0NJdu2ChVatpYQ0Xs/
 AePxSScu9Pl1KkdVaTJmGHGb8pnUqUPRoPIeCiLzJQQ7c1NOqz9BvIvAlk/mc12RBCM
 GHwvChkuPyFcEebzcr+uAwVgI0JA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=WwFhKsP/fft8lvDojJZZqkaXDDlURSH6vJtbHkGl74Y47fKVw5VXJ+wtxVPI4xirY+LejNnTqQdmVa+h5/pXha4DsnirzNitvpMLan1M48+TVJ3cmysjBWOBhODUPWd9QF/MjV76EAtqRzpC0OvpRVQHe5kkmhRS2kwIiSt5vjr/dmW2LEGUc+Ic5LenHCMLngrwNQldKYMUwnTHxJ8JeO1hVlCf/OvAhs/xhhopsSuPSyxQm0djAhwB0P7xOFIBBBbXXxXCc1n47zP38vuQZlYN5WcNuz+VKnAJlIuIsuTSx063AOkvx0ivcAFCeK3KsGdTCV2+bWp7sj9TFolPQA==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jr6pN-000Bb6-Pg; Thu, 02 Jul 2020 17:33:05 -0400
Message-ID: <5EFE5291.6030300@mindspring.com>
Date: Thu, 02 Jul 2020 17:33:05 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
In-Reply-To: <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------080407090606010809000603"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca52a5bf1ecbc992f665fcf2c362b6908e3350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.68; envelope-from=denber@mindspring.com;
 helo=elasmtp-masked.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 17:33:06
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
--------------080407090606010809000603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/20 13:34, Thomas Huth wrote:
>
> That's just the context, cut at three lines after the last change. 
> Simply try to apply the patch with "patch -p1 -i ..." or "git am" in a 
> separate git branch if you're using git. It should hopefully apply 
> cleanly.

Looks like it partly worked:

root@hemlock:~/qemu-5.0.0# gpatch -p1 -i < configpatch.diff
gpatch: option requires an argument -- 'i'
gpatch: Try 'gpatch --help' for more information.
root@hemlock:~/qemu-5.0.0# gpatch -p1 < configpatch.diff
patching file configure
Hunk #1 succeeded at 5049 (offset -85 lines).
Hunk #2 succeeded at 7117 (offset -267 lines).
patching file util/qemu-openpty.c
Hunk #1 FAILED at 52.
Hunk #2 succeeded at 95 with fuzz 2 (offset 2 lines).
1 out of 2 hunks FAILED -- saving rejects to file util/qemu-openpty.c.rej
root@hemlock:~/qemu-5.0.0# cat util/qemu-openpty.c.rej
--- util/qemu-openpty.c
+++ util/qemu-openpty.c
@@ -52,7 +52,8 @@
  #endif

  #ifdef __sun__
-/* Once Solaris has openpty(), this is going to be removed. */
+
+#if !defined(HAVE_OPENPTY)
  static int openpty(int *amaster, int *aslave, char *name,
                     struct termios *termp, struct winsize *winp)
  {
root@hemlock:~/qemu-5.0.0#


             - Michele


--------------080407090606010809000603
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 07/02/20 13:34, Thomas Huth wrote:
    <blockquote
      cite="mid:1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com"
      type="cite"><br>
      That's just the context, cut at three lines after the last change.
      Simply try to apply the patch with "patch -p1 -i ..." or "git am"
      in a separate git branch if you're using git. It should hopefully
      apply cleanly.
      <br>
    </blockquote>
    <br>
    Looks like it partly worked:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        gpatch -p1 -i &lt; configpatch.diff<br>
        gpatch: option requires an argument -- 'i'<br>
        gpatch: Try 'gpatch --help' for more information.<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> gpatch -p1 &lt; configpatch.diff<br>
        patching file configure<br>
        Hunk #1 succeeded at 5049 (offset -85 lines).<br>
        Hunk #2 succeeded at 7117 (offset -267 lines).<br>
        patching file util/qemu-openpty.c<br>
        Hunk #1 FAILED at 52.<br>
        Hunk #2 succeeded at 95 with fuzz 2 (offset 2 lines).<br>
        1 out of 2 hunks FAILED -- saving rejects to file
        util/qemu-openpty.c.rej<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> cat util/qemu-openpty.c.rej<br>
        --- util/qemu-openpty.c<br>
        +++ util/qemu-openpty.c<br>
        @@ -52,7 +52,8 @@<br>
         #endif<br>
         <br>
         #ifdef __sun__<br>
        -/* Once Solaris has openpty(), this is going to be removed. */<br>
        +<br>
        +#if !defined(HAVE_OPENPTY)<br>
         static int openpty(int *amaster, int *aslave, char *name,<br>
                            struct termios *termp, struct winsize *winp)<br>
         {<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> <br>
      </font></small><br>
    <br>
                - Michele<br>
    <br>
  </body>
</html>

--------------080407090606010809000603--

