Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9177CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 19:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E2D207CD
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 19:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="p6D/kx5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E2D207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrneh-0002Fa-KF
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrndG-00010L-Hu
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 15:15:26 -0400
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:41934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrndE-0002aD-DF
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 15:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593890124; bh=rWfiki62H/m6w6n+NHPQ7FEqI1ky8Jvhhgrf
 TnZb360=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:
 X-Originating-IP; b=p6D/kx5wnzH/c0ijNZr16qLYtReDOIzwqmat5J6yJOdB7Q
 +hPAdqHJhLtAruyThoRSxDx+LKVUS8krsNKtobQat502OlnkKgwAnfYaiz97dv5VQPH
 1sbOnR7KymxwKbF+TqQMuK7GqkKIj3DR8h2+2xTc2GnKnfcFzZ24bvpE4PprqAx28R3
 11wi8+3/TPy4qskqJa/d44Qn6l4nGyHaZRMPRgfMFS43rnQdBCuJz6ZOlZJp6S8ALZm
 I4sTmWzHWnOH2DI6GhsmN/lzr7ClQHKkxpRxMXizY20FJoL3j/26ckRqaDuz0f/x9sv
 Qwq2IT3frAMb8cfNDR81HvSx/2pA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=p0rivGb2Ph3bn3tLvTpF2Gk8xKDjiJ21cvNWW+Ozc4R2/FnQRFbanylPpBrXBh0ZdoNJ7em8GcuF7dMCuhtB+cRDKwL0hPwzULKi/DF4PCcZ9bDk28XmRGhT6gNP8h8IGy+T1MzMa95PnT8DPv9PXoRzi/mS38KdWtw4CttMSJQPIzuo/BNU0U+QaNS1J3kq5khhHShCcBcNwAvk07VOkkpATeQRgk2lhGntDhxFZntnTlLaRiflAXzfrXf5pqWQmNxMhoeZ9ZnVyKvApVCVNya7LdWO9BnwpSg1nnZ0WJVX6yFkmlQtb5RmH2G8JG6pPmT5IfcE2hXvHqUKqEAA8g==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrndA-00039c-NA; Sat, 04 Jul 2020 15:15:20 -0400
Message-ID: <5F00D548.5050305@mindspring.com>
Date: Sat, 04 Jul 2020 15:15:20 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
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
 <5F00A1ED.6040909@mindspring.com>
 <69adae2a-8c3c-ec17-08f4-c2109b1d0993@amsat.org>
In-Reply-To: <69adae2a-8c3c-ec17-08f4-c2109b1d0993@amsat.org>
Content-Type: multipart/alternative;
 boundary="------------060407050906070105000507"
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca560f253835c45648768724f8d9b219674350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.68; envelope-from=denber@mindspring.com;
 helo=elasmtp-masked.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 15:15:22
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------060407050906070105000507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/04/20 11:57, Philippe Mathieu-Daudé wrote:
> Odd...
>
> Assuming you are using gcc, have you tried 'configure --host-cc=gcc'?
OK, so I changed it from

# /opt/csw/bin/bash ./configure --cc=gcc  --extra-cflags="-m32"

to

# /opt/csw/bin/bash ./configure --cc=gcc  --extra-cflags="-m32" 
--host-cc=gcc

and then reran gmake -j16.   That seems to have fixed it.  ppc64 is 
there now:

root@hemlock:~/qemu-5.0.0# ppc64-softmmu/qemu-system-ppc64 -machine help
Supported machines are:
40p                  IBM RS/6000 7020 (40p)
bamboo               bamboo
g3beige              Heathrow based PowerMAC
mac99                Mac99 based PowerMAC
mpc8544ds            mpc8544ds
... and a bunch more ...
root@hemlock:~/qemu-5.0.0#

And I also have the right stuff in x86_64-softmmu. So I tried running my 
Win XP image and it started up OK, opening the QEMU window and 
displaying the XP logo.  But unfortunately it's really really slow, like 
20 minutes just to get to the XP desktop appearing.  That takes about 2 
minutes in QEMU 2.12 on the same host hardware.  I had been hoping 5.0 
would be faster.  Is there a reason for it to be an order of magnitude 
slower?  I'm saying:

root@hemlock:~/qemu-5.0.0/x86_64-softmmu# ./qemu-system-x86_64  -m 2047  
-usb -device usb-tablet -smp 3 -device rtl8139,netdev=net0 -netdev 
user,id=net0 -boot d -hda  /bkpool/qemuimages/XP.img -cdrom 
/bkpool/qemuimages/xp.iso &

But in any case, I will now cautiously claim  that I have succeeded in 
building QEMU 5.0 in Solaris 11.4 SPARC.  Thanks very much to everyone 
for all your help.

             - Michele



--------------060407050906070105000507
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 07/04/20 11:57, Philippe Mathieu-Daudé wrote:<br>
    <blockquote
      cite="mid:69adae2a-8c3c-ec17-08f4-c2109b1d0993@amsat.org"
      type="cite">
      <pre wrap="">
Odd...

Assuming you are using gcc, have you tried 'configure --host-cc=gcc'?</pre>
    </blockquote>
    OK, so I changed it from<br>
    <small><font face="Courier New, Courier, monospace"><br>
        # /opt/csw/bin/bash ./configure --cc=gcc  --extra-cflags="-m32"</font></small><br>
    <br>
    to<br>
    <br>
    <small><font face="Courier New, Courier, monospace">#
        /opt/csw/bin/bash ./configure --cc=gcc  --extra-cflags="-m32"
        --host-cc=gcc</font></small><br>
    <br>
    and then reran gmake -j16.   That seems to have fixed it.  ppc64 is
    there now:<br>
    <br>
    <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a>
        ppc64-softmmu/qemu-system-ppc64 -machine help<br>
        Supported machines are:<br>
        40p                  IBM RS/6000 7020 (40p)<br>
        bamboo               bamboo<br>
        g3beige              Heathrow based PowerMAC<br>
        mac99                Mac99 based PowerMAC<br>
        mpc8544ds            mpc8544ds<br>
        ... and a bunch more ...<br>
        <a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0#">root@hemlock:~/qemu-5.0.0#</a> </font></small><br>
    <br>
    And I also have the right stuff in <small><font face="Courier New,
        Courier, monospace">x86_64-softmmu. <big><font face="Helvetica,
            Arial, sans-serif"> So I tried running my Win XP image and
            it started up OK, opening the QEMU window and displaying the
            XP logo.  But unfortunately it's really really slow, like 20
            minutes just to get to the XP desktop appearing.  That takes
            about 2 minutes in QEMU 2.12 on the same host hardware.  I
            had been hoping 5.0 would be faster.  Is there a reason for
            it to be an order of magnitude slower?  I'm saying:<br>
            <br>
            <small><font face="Courier New, Courier, monospace"><a class="moz-txt-link-abbreviated" href="mailto:root@hemlock:~/qemu-5.0.0/x86_64-softmmu#">root@hemlock:~/qemu-5.0.0/x86_64-softmmu#</a>
                ./qemu-system-x86_64  -m 2047  -usb -device usb-tablet
                -smp 3 -device rtl8139,netdev=net0 -netdev user,id=net0
                -boot d -hda  /bkpool/qemuimages/XP.img -cdrom
                /bkpool/qemuimages/xp.iso &amp;</font></small><br>
            <br>
            But in any case, I will now cautiously claim  that I have
            succeeded in building QEMU 5.0 in Solaris 11.4 SPARC. 
            Thanks very much to everyone for all your help.<br>
            <br>
                        - Michele<br>
            <br>
          </font></big></font></small><br>
  </body>
</html>

--------------060407050906070105000507--

