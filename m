Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F31C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5033C207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="RdmOceLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5033C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOfC-0001ZG-HW
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrOVW-0000hg-5j
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:25:46 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:57476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrOVP-0006CZ-RC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593793539; bh=TfCbsIBXlk2jWa41rrk6IwLd6letlsQBImO5
 OVZIF/c=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=RdmOceLdqKEWFyyvYY26Zr/pXWTv5B6LVZ/NaO2J7ux0ov
 TRoj1l6TVaQCUX+cpmYyk2ejFxI8/LC1SU1k8/xTGYute3k4ZRJ/aAYFf55EZd87tS3
 8Otxalj5Cim5cbteWsv9+Nqt/MwWyn1TLFzawNfYEXv2KeLBaipxF0LXiCOiUYJL7XS
 6ZW0AP+MculjuD5TXMWqLboXHa3B+HKqdnLSIpRCqN1d4ycCr4VTA25zpKwTM0qUeGl
 RNYF7hurpGdDORuySsFFkBVs6otsEuRIYSuilDOxFC0PPOK9oLmve2gF69XB+SZuSev
 m/dTzg/Cou4yg1qEAzxrLmWwmYwA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=PlIfeJnDQsAH/KBuflJfcmdhK7EiHiteOB7C4vM5fiMT7AYgfRKmU8qBamPpaADap54eGFoil+AMTEuzT3SJ9oRgAbn0PxXQtv3foG1syryfB0KsM8K+KUxz27/wLj+OYWbb2WuSnXuVTsSt6BPaC06624ijwSxvZYmnKh1Wg5GjhuvTWhFczH5gzPKwdwTQ4PH+h32ca7zxKWgyqLi1qJkeh5IO/E/HaQPh9FTFxai/hH+obwLPIByK0kOOTT4tnRoeoMefyKuc4/A8nacMaXeu0XAfmUxdf4qbcar6hcxcjrQCe+AeHIthTu4q4LyZdLw6cW6CrQ0+ieohSxuqiA==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrOVK-0009WR-Et; Fri, 03 Jul 2020 12:25:34 -0400
Message-ID: <5EFF5BFE.9000209@mindspring.com>
Date: Fri, 03 Jul 2020 12:25:34 -0400
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
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
In-Reply-To: <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------010604090409010201070601"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca59f1aaeab4e4575b44df35aa7777b3767350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.61; envelope-from=denber@mindspring.com;
 helo=elasmtp-galgo.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 12:25:34
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
--------------010604090409010201070601
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/03/20 01:11, Thomas Huth wrote:
>
> Did you have a local modification to that file?
Oops yes, I had changed the line


static int openpty(int *amaster, int *aslave, char *name,
                    struct termios *termp, struct winsize *winp)

to

int openpty(int *amaster, int *aslave, char *name,
                    struct termios *termp, struct winsize *winp)
> If so, please revert it first before applying the patch (or add the 
> "#if !defined(HAVE_OPENPTY)" now manually to see whether it works).

OK - looks like that did it:

root@hemlock:~/qemu-5.0.0# gpatch -p1 < configpatch.diff
patching file configure
Hunk #1 succeeded at 5049 (offset -85 lines).
Hunk #2 succeeded at 7117 (offset -267 lines).
patching file util/qemu-openpty.c
Hunk #2 succeeded at 94 with fuzz 2.
root@hemlock:~/qemu-5.0.0#

Then

root@hemlock:~/qemu-5.0.0# /opt/csw/bin/bash ./configure --cc=gcc  
--extra-cflags="-m32"

succeeded with only one odd thing:

./configure: line 6326: pod2man: command not found

I fixed that with

root@hemlock:~/qemu-5.0.0# PATH=$PATH:/usr/perl5/5.26/bin

So I can confirm your patch works in Solaris 11.4.

gmake then ran successfully through qemu-openpty.c  becfore stopping with:

  ...
CC      crypto/trace.o
util/drm.c: In function \u2018qemu_drm_rendernode_open\u2019:
util/drm.c:41:16: error: \u2018struct dirent\u2019 has no member named 
\u2018d_type\u2019; did you mean \u2018d_name\u2019?
          if (e->d_type != DT_CHR) {
                 ^~~~~~
                 d_name
util/drm.c:41:26: error: \u2018DT_CHR\u2019 undeclared (first use in 
this function); did you mean \u2018TH_CWR\u2019?
          if (e->d_type != DT_CHR) {
                           ^~~~~~
                           TH_CWR
util/drm.c:41:26: note: each undeclared identifier is reported only once 
for each function it appears in
gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69: util/drm.o] Error 1

PMM said about this:

Ah, the Haiku folks just ran into exactly this issue.
Their fix should also be good for Solaris:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08800.html
(This whole file is for using a Linux-specific feature so there's
no point even compiling it for other OSes.)




             - Michele


--------------010604090409010201070601
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 07/03/20 01:11, Thomas Huth wrote:
    <blockquote
      cite="mid:975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com"
      type="cite"><br>
      Did you have a local modification to that file?</blockquote>
    Oops yes, I had changed the line<br>
    <br>
    <br>
    <small><font face="Courier New, Courier, monospace">static int
        openpty(int *amaster, int *aslave, char *name,<br>
                           struct termios *termp, struct winsize *winp)</font></small><br>
    <br>
    to<br>
    <br>
    <small><font face="Courier New, Courier, monospace">int openpty(int
        *amaster, int *aslave, char *name,<br>
                           struct termios *termp, struct winsize *winp)</font></small><br>
    <blockquote
      cite="mid:975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com"
      type="cite"> If so, please revert it first before applying the
      patch (or add the "#if !defined(HAVE_OPENPTY)" now manually to see
      whether it works).
      <br>
    </blockquote>
    <br>
    OK - looks like that did it:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        gpatch -p1 &lt; configpatch.diff<br>
        patching file configure<br>
        Hunk #1 succeeded at 5049 (offset -85 lines).<br>
        Hunk #2 succeeded at 7117 (offset -267 lines).<br>
        patching file util/qemu-openpty.c<br>
        Hunk #2 succeeded at 94 with fuzz 2.<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> </font></small><br>
    <br>
    Then<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        /opt/csw/bin/bash ./configure --cc=gcc  --extra-cflags="-m32"</font></small><br>
    <br>
    succeeded with only one odd thing:<br>
    <br>
    <small><font face="Courier New, Courier, monospace">./configure:
        line 6326: pod2man: command not found</font></small><br>
    <br>
    I fixed that with<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        PATH=$PATH:/usr/perl5/5.26/bin</font></small><br>
    <br>
    So I can confirm your patch works in Solaris 11.4.<br>
    <br>
    gmake then ran successfully through qemu-openpty.c  becfore stopping
    with:<br>
    <small><font face="Courier New, Courier, monospace"><br>
         ...<br>
        CC      crypto/trace.o<br>
        util/drm.c: In function \u2018qemu_drm_rendernode_open\u2019:<br>
        util/drm.c:41:16: error: \u2018struct dirent\u2019 has no member
        named \u2018d_type\u2019; did you mean \u2018d_name\u2019?<br>
                 if (e-&gt;d_type != DT_CHR) {<br>
                        ^~~~~~<br>
                        d_name<br>
        util/drm.c:41:26: error: \u2018DT_CHR\u2019 undeclared (first
        use in this function); did you mean \u2018TH_CWR\u2019?<br>
                 if (e-&gt;d_type != DT_CHR) {<br>
                                  ^~~~~~<br>
                                  TH_CWR<br>
        util/drm.c:41:26: note: each undeclared identifier is reported
        only once for each function it appears in<br>
        gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69:
        util/drm.o] Error 1</font></small><br>
    <br>
    PMM said about this:<br>
    <br>
    <pre wrap="">Ah, the Haiku folks just ran into exactly this issue.
Their fix should also be good for Solaris:
<a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08800.html">https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08800.html</a>
(This whole file is for using a Linux-specific feature so there's
no point even compiling it for other OSes.)</pre>
    <br>
    <br>
    <br>
                - Michele<br>
    <br>
  </body>
</html>

--------------010604090409010201070601--

