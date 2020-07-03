Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770ADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0BC20884
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="WUq4rmWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0BC20884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrTLu-0001mc-ID
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrTLD-0001GV-9F
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:35:27 -0400
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:54268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrTLB-0001He-2W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593812125; bh=rT5QmpfRtbmrzlxiCBkb0YhXl3wzsOUH6BQc
 wX8KWmI=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=WUq4rmWsA2F/Hok1r7K3sQDzhzBR/z2kJU0/3r7HyGLFvl
 YIdQEy7SnM/FKmrZEbHf4XaOCB6jCBdNgvZ5oMdOBMUB7yB5atRE82Epa8Xg7v+cEwU
 5thdd2PagFfhz62DxcstV+f7ds2+tDYzNOFGB0Q/qoKIRYNo5yy7bRBCZDt6q+hwjsx
 R4y90F/KaYb62bhAj8dmGNrYaqW2G/fHXNcwG6NSGSWM0GsICLPdMV6oviaa6mv1zu5
 nP13kowhJTtKYETPdBRsZZnkRs9ldrRBiNSiXDwOh6H7cKPdUzsjLgiux/GwygJysQa
 t0H4yillGL9YDMneKxWrq9tzS7Tw==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=mijpC8oR2T6jMgN5BJAJm1ENpe/x+KkQbY3PFtnDMv08gFd5kBjOjwBRipFQcILI0O+WtOw5HPK+jsCH1drZgVL1Alvr3F6ED4zLuYhoVkNRRAeZXeczV1WanKgMe60y0F76CIqrxOyvYLY41+zEmfhkLfHMS8+E5xaJEMMpLK3vu1/ekMLKAJXN3fHgskRjc3FbzetNXLa4HF6tZuByDK9jllEP3HQgUoXQf0GOUEljcnl60Oey7mxXAyuhUp8FHuoYFULsjB9tw/UFEw4yqC59VfnCjjVK6HEdD5aHHS2OsaGJbDbDOJaP11bw64XpLc4mx8t2rZmeKmHtF4yVaw==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrTL8-000AxM-7I; Fri, 03 Jul 2020 17:35:22 -0400
Message-ID: <5EFFA499.7050008@mindspring.com>
Date: Fri, 03 Jul 2020 17:35:21 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Peter Maydell <peter.maydell@linaro.org>
Subject: gmake in Solaris 11.4: TFR missing
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com>
In-Reply-To: <5EFF7DD7.1000605@mindspring.com>
Content-Type: multipart/alternative;
 boundary="------------040503030601070800080100"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca5ef7882f85c7159e38c2b72c475feab2e350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.65; envelope-from=denber@mindspring.com;
 helo=elasmtp-kukur.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 17:35:22
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------040503030601070800080100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>
> It appears that _IOR & friends are defined in 
> /usr/include/sys/ioccom.h, but I can't figure out how to point gmake 
> to that.  Do I need some sort of "-I" in the Makefile?
>
>
> When I built QEMU 2.12, I ran into this too and ended up just 
> commenting out all the references to _IOR, etc. in hw/tpm/tpm_ioctl.h 
> but maybe we can do something more elegant this time.  Thanks.

OK, I fixed this by adding the line

#include </usr/include/sys/ioccom.h>

to hw/tpm/tpm_ioctl.h.

gmake now went to the end but threw a bunch of errors all complaining 
about something called TFR.  This is the tail:

  ...
CC      aarch64-softmmu/trace/generated-helpers.o
Undefined                       first referenced
  symbol                             in file
TFR                                 ../net/tap-solaris.o
ld: fatal: symbol referencing errors
collect2: error: ld returned 1 exit status
gmake[1]: *** [Makefile:208: qemu-system-mipsel] Error 1
gmake: *** [Makefile:527: mipsel-softmmu/all] Error 2
   LINK    mips-softmmu/qemu-system-mips
Undefined                       first referenced
  symbol                             in file
TFR                                 ../net/tap-solaris.o
ld: fatal: symbol referencing errors
collect2: error: ld returned 1 exit status
gmake[1]: *** [Makefile:208: qemu-system-mips] Error 1
gmake: *** [Makefile:527: mips-softmmu/all] Error 2
   LINK    arm-softmmu/qemu-system-arm
Undefined                       first referenced
  symbol                             in file
TFR                                 ../net/tap-solaris.o
ld: fatal: symbol referencing errors
collect2: error: ld returned 1 exit status
gmake[1]: *** [Makefile:208: qemu-system-arm] Error 1
gmake: *** [Makefile:527: arm-softmmu/all] Error 2
   LINK    aarch64-softmmu/qemu-system-aarch64
Undefined                       first referenced
  symbol                             in file
TFR                                 ../net/tap-solaris.o
ld: fatal: symbol referencing errors
collect2: error: ld returned 1 exit status
gmake[1]: *** [Makefile:208: qemu-system-aarch64] Error 1
gmake: *** [Makefile:527: aarch64-softmmu/all] Error 2
root@hemlock:~/qemu-5.0.0#

A web search for "solaris undefined symbol TFR" turned up nothing and 
I'm not seeing it on the machine.  man TFR returns nothing.  I didn't 
encounter this error while building 2.12.  Here's an example of its use 
(in tap-solaris.c):

  TFR(ip_fd = open("/dev/udp", O_RDWR, 0));

   What is TFR?

             - Michele



--------------040503030601070800080100
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <blockquote cite="mid:5EFF7DD7.1000605@mindspring.com" type="cite">
      <br>
      It appears that _IOR &amp; friends are defined in
      /usr/include/sys/ioccom.h, but I can't figure out how to point
      gmake to that.  Do I need some sort of "-I" in the Makefile?<br>
      <br>
      <br>
      When I built QEMU 2.12, I ran into this too and ended up just
      commenting out all the references to _IOR, etc. in
      hw/tpm/tpm_ioctl.h but maybe we can do something more elegant this
      time.  Thanks.<br>
    </blockquote>
    <br>
    OK, I fixed this by adding the line<br>
    <br>
    #include &lt;/usr/include/sys/ioccom.h&gt;<br>
    <br>
    to hw/tpm/tpm_ioctl.h.<br>
    <br>
    gmake now went to the end but threw a bunch of errors all
    complaining about something called TFR.  This is the tail:<br>
    <br>
     ...<br>
    <small><font face="Courier New, Courier, monospace">CC     
        aarch64-softmmu/trace/generated-helpers.o<br>
        Undefined                       first referenced<br>
         symbol                             in file<br>
        TFR                                 ../net/tap-solaris.o<br>
        ld: fatal: symbol referencing errors<br>
        collect2: error: ld returned 1 exit status<br>
        gmake[1]: *** [Makefile:208: qemu-system-mipsel] Error 1<br>
        gmake: *** [Makefile:527: mipsel-softmmu/all] Error 2<br>
          LINK    mips-softmmu/qemu-system-mips<br>
        Undefined                       first referenced<br>
         symbol                             in file<br>
        TFR                                 ../net/tap-solaris.o<br>
        ld: fatal: symbol referencing errors<br>
        collect2: error: ld returned 1 exit status<br>
        gmake[1]: *** [Makefile:208: qemu-system-mips] Error 1<br>
        gmake: *** [Makefile:527: mips-softmmu/all] Error 2<br>
          LINK    arm-softmmu/qemu-system-arm<br>
        Undefined                       first referenced<br>
         symbol                             in file<br>
        TFR                                 ../net/tap-solaris.o<br>
        ld: fatal: symbol referencing errors<br>
        collect2: error: ld returned 1 exit status<br>
        gmake[1]: *** [Makefile:208: qemu-system-arm] Error 1<br>
        gmake: *** [Makefile:527: arm-softmmu/all] Error 2<br>
          LINK    aarch64-softmmu/qemu-system-aarch64<br>
        Undefined                       first referenced<br>
         symbol                             in file<br>
        TFR                                 ../net/tap-solaris.o<br>
        ld: fatal: symbol referencing errors<br>
        collect2: error: ld returned 1 exit status<br>
        gmake[1]: *** [Makefile:208: qemu-system-aarch64] Error 1<br>
        gmake: *** [Makefile:527: aarch64-softmmu/all] Error 2<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> <br>
      </font></small><br>
    A web search for "solaris undefined symbol TFR" turned up nothing
    and I'm not seeing it on the machine.  man TFR returns nothing.  I
    didn't encounter this error while building 2.12.  Here's an example
    of its use (in tap-solaris.c):<br>
    <br>
    <small><font face="Courier New, Courier, monospace"> TFR(ip_fd =
        open("/dev/udp", O_RDWR, 0));</font></small><br>
    <br>
      What is TFR?<br>
    <br>
                - Michele<br>
    <br>
    <br>
  </body>
</html>

--------------040503030601070800080100--

