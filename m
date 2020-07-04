Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F48BC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821F207CD
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="Dpd7DIZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821F207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkDw-0008G0-M9
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrkDC-0007iw-Mm
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:36:18 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:40044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrkDA-0006rF-OP
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593876976; bh=SusQTs1DCw+RrTtc3aNLEdJO5MZLd8kbX9I4
 x/KzpS0=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=Dpd7DIZb+vp87IhjdqWRAUwSxBsVaQ8L3z/CjyZJ1Lr7K4
 SmGO5AHnTdl1NAExAOvHsMZNEv2lLnyIrJHl3oocHltqbAgihin0YKLjTE/HXl0xcpS
 JKoHVZj7C/NvBHqXxdx8zuvgLdtjt7UHVcZEjddSdkNs8EB3jxrcwfWQXB8YdBlHtNn
 HnDykJ/dimneeOCt8diIHMA6TElxVcOy0Kxou/4gvA38gDRcy+5ltYBR7Wu7B2uvpaf
 WH84Gv9M0GiKXvbc74mwHiWV7y8wwzo7zbkTCKw/6SwDx3J+KZLcDk1VbLcK/uJ9flr
 xDSmjcUA5pKZ/KMKnDzcQ/Fm6PMg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=WUNobcrh9LgRvzsr9c7H/jSe/VhIuWFCV+lhZs65dSDPEeG4fqEjxtLeq/emS9SvnrG25LRFlooRZNNlHbOPIODwNwfczF9OZNBYowBd89OexKqvyzlDEI0gooykXbhF70UCXZWG7WXnY4c+4L3qbD7cnbUw1GLLImQPX88barrbX9f/lUKqRqhIqIRhKiVsdrb130A63pFpcF12CIA5PZaxj9xgUC/gUfiUGP9miXSfbs01GVw/ZyDZeLKmnrvbrN7MEIc/SrhCzsoQlum0oWYg4t1XdtmOFJ04RmpzDzDbdswdYNFZ46plZKbFJ0ApXYvLWE7kHkgFp5aJHkPukg==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrkD8-000Eca-Qq; Sat, 04 Jul 2020 11:36:14 -0400
Message-ID: <5F00A1ED.6040909@mindspring.com>
Date: Sat, 04 Jul 2020 11:36:13 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
Subject: Re: gmake in Solaris 11.4: TFR missing
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <3474053c-12d7-cf4a-5470-62845c166127@redhat.com>
In-Reply-To: <3474053c-12d7-cf4a-5470-62845c166127@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------080206090909050609080907"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca54918243cafc5ae7f606870548bcf4523350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.62; envelope-from=denber@mindspring.com;
 helo=elasmtp-dupuy.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:36:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------080206090909050609080907
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/20 08:02, Thomas Huth wrote:
> TFR is a macro that is defined in our qemu-common.h header ... does it
> work if you add a #include "qemu-common.h" somewhere at the beginning of
> net/tap-solaris.c ?
Yes, thank you, that fixed it:

root@hemlock:~/qemu-5.0.0# gmake -j16
gmake[1]: Entering directory '/export/home/denber/qemu-5.0.0/slirp'
grep: illegal option -- m
Usage: grep [-c|-l|-q] -bhinsvw pattern file . . .
gmake[1]: Nothing to be done for 'all'.
gmake[1]: Leaving directory '/export/home/denber/qemu-5.0.0/slirp'
         CHK version_gen.h
   CC      net/tap-solaris.o
   LINK    moxie-softmmu/qemu-system-moxie
   LINK    cris-softmmu/qemu-system-cris
   LINK    microblaze-softmmu/qemu-system-microblaze
   LINK    microblazeel-softmmu/qemu-system-microblazeel
   LINK    nios2-softmmu/qemu-system-nios2
   LINK    lm32-softmmu/qemu-system-lm32
   LINK    m68k-softmmu/qemu-system-m68k
   LINK    hppa-softmmu/qemu-system-hppa
   LINK    alpha-softmmu/qemu-system-alpha
   LINK    mips64-softmmu/qemu-system-mips64
   LINK    mips64el-softmmu/qemu-system-mips64el
   LINK    mipsel-softmmu/qemu-system-mipsel
   LINK    mips-softmmu/qemu-system-mips
   LINK    i386-softmmu/qemu-system-i386
   LINK    aarch64-softmmu/qemu-system-aarch64
   LINK    arm-softmmu/qemu-system-arm
   LINK    or1k-softmmu/qemu-system-or1k
   CC      s390x-softmmu/gen-features
/bin/sh: cc: not found
gmake[1]: *** 
[/export/home/denber/qemu-5.0.0/target/s390x/Makefile.objs:25: 
/export/home/denber/qemu-5.0.0/s390x-softmmu/gen-features] Error 127
gmake: *** [Makefile:527: s390x-softmmu/all] Error 2
gmake: *** Waiting for unfinished jobs....
   LINK    rx-softmmu/qemu-system-rx
   LINK    riscv32-softmmu/qemu-system-riscv32
   LINK    riscv64-softmmu/qemu-system-riscv64
   LINK    ppc64-softmmu/qemu-system-ppc64
   LINK    ppc-softmmu/qemu-system-ppc
root@hemlock:~/qemu-5.0.0#

I still have one grep/ggrep issue and one "wrong sh" issue.  And it 
doesn't look like it really completed correctly because for example I see:

root@hemlock:~/qemu-5.0.0# cd x86_64-softmmu
root@hemlock:~/qemu-5.0.0/x86_64-softmmu# ls
config-devices.mak      config-devices.mak.old  Makefile
config-devices.mak.d    config-target.mak
root@hemlock:~/qemu-5.0.0/x86_64-softmmu#

So even though gmake finished, it didn't make at least one VM.  Is that 
because of the two remaining errors?

             - Michele


--------------080206090909050609080907
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 07/04/20 08:02, Thomas Huth wrote:<br>
    <blockquote
      cite="mid:3474053c-12d7-cf4a-5470-62845c166127@redhat.com"
      type="cite">
      <pre wrap="">
TFR is a macro that is defined in our qemu-common.h header ... does it
work if you add a #include "qemu-common.h" somewhere at the beginning of
net/tap-solaris.c ?</pre>
    </blockquote>
    Yes, thank you, that fixed it:<br>
    <small><font face="Courier New, Courier, monospace"><br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> gmake -j16<br>
        gmake[1]: Entering directory
        '/export/home/denber/qemu-5.0.0/slirp'<br>
        grep: illegal option -- m<br>
        Usage: grep [-c|-l|-q] -bhinsvw pattern file . . .<br>
        gmake[1]: Nothing to be done for 'all'.<br>
        gmake[1]: Leaving directory
        '/export/home/denber/qemu-5.0.0/slirp'<br>
                CHK version_gen.h<br>
          CC      net/tap-solaris.o<br>
          LINK    moxie-softmmu/qemu-system-moxie<br>
          LINK    cris-softmmu/qemu-system-cris<br>
          LINK    microblaze-softmmu/qemu-system-microblaze<br>
          LINK    microblazeel-softmmu/qemu-system-microblazeel<br>
          LINK    nios2-softmmu/qemu-system-nios2<br>
          LINK    lm32-softmmu/qemu-system-lm32<br>
          LINK    m68k-softmmu/qemu-system-m68k<br>
          LINK    hppa-softmmu/qemu-system-hppa<br>
          LINK    alpha-softmmu/qemu-system-alpha<br>
          LINK    mips64-softmmu/qemu-system-mips64<br>
          LINK    mips64el-softmmu/qemu-system-mips64el<br>
          LINK    mipsel-softmmu/qemu-system-mipsel<br>
          LINK    mips-softmmu/qemu-system-mips<br>
          LINK    i386-softmmu/qemu-system-i386<br>
          LINK    aarch64-softmmu/qemu-system-aarch64<br>
          LINK    arm-softmmu/qemu-system-arm<br>
          LINK    or1k-softmmu/qemu-system-or1k<br>
          CC      s390x-softmmu/gen-features<br>
        /bin/sh: cc: not found<br>
        gmake[1]: ***
        [/export/home/denber/qemu-5.0.0/target/s390x/Makefile.objs:25:
        /export/home/denber/qemu-5.0.0/s390x-softmmu/gen-features] Error
        127<br>
        gmake: *** [Makefile:527: s390x-softmmu/all] Error 2<br>
        gmake: *** Waiting for unfinished jobs....<br>
          LINK    rx-softmmu/qemu-system-rx<br>
          LINK    riscv32-softmmu/qemu-system-riscv32<br>
          LINK    riscv64-softmmu/qemu-system-riscv64<br>
          LINK    ppc64-softmmu/qemu-system-ppc64<br>
          LINK    ppc-softmmu/qemu-system-ppc<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> </font></small><br>
    <br>
    I still have one grep/ggrep issue and one "wrong sh" issue.  And it
    doesn't look like it really completed correctly because for example
    I see:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        cd x86_64-softmmu<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0/x86_64-softmmu#">root@hemlock:~/qemu-5.0.0/x86_64-softmmu#</a> ls<br>
        config-devices.mak      config-devices.mak.old  Makefile<br>
        config-devices.mak.d    config-target.mak<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0/x86_64-softmmu#">root@hemlock:~/qemu-5.0.0/x86_64-softmmu#</a> </font></small><br>
    <br>
    So even though gmake finished, it didn't make at least one VM.  Is
    that because of the two remaining errors?<br>
    <br>
                - Michele<br>
    <br>
  </body>
</html>

--------------080206090909050609080907--

