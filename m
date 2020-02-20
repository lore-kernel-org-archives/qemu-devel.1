Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EC0C11D41
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 05:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D558324656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 05:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH75W5cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D558324656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4eaM-0008RW-3N
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 00:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1j4eZV-0007xD-4n
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 00:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1j4eZT-0001f9-W7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 00:40:25 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35]:38232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1j4eZT-0001ee-P3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 00:40:23 -0500
Received: by mail-io1-xd35.google.com with SMTP id s24so3329185iog.5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 21:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XpUvSMXyRD3z5fSJMN3JcEX0vjhaxC0G5oiclnrjVn8=;
 b=SH75W5cBzrJ39+WKUvCaBcbNRrRMKFmQeCLt6Mi9HG3Oa0nV8p1XlbWClo3V7Todse
 xt6c8JpPOUn+UwpdNJektmKamB/qA3xOBT19SjodYeJNJs5X+zOyn4GNqPRTcdNYFhqA
 Pgk0cCdUlIWopUMDwMSmtslscletfVyOTvCj15bF9AAeGmKF/zCPW3CefRTGf4KkPTnB
 4hu50H5ram0ZXJ/gjdG5ELMMPcqCKhcKgGRLR4qAB2RiCCzq6l5SY4Xlb7K1nH5ei3Je
 nOA4Ht4dRGJCe7azk7AkceMS1ixHa/jg4IJmBHHRfUiiTzWY9AewicANDVCicfitxUl0
 gr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XpUvSMXyRD3z5fSJMN3JcEX0vjhaxC0G5oiclnrjVn8=;
 b=pmd1eN/wzmeTFMcbJXmV8zEj3d1Wm0c1ZLbG3XmL0/1ew3L6VhC/6ja6zMKMO8Qr3a
 V7HnCW0fx+dhrKleaPAn5nOc4bXuDugxpb5bRymXSzoLfapxZjxhD+O/oyh8HxHFbq0h
 8qUqfgzTON8ANKSkTHNIsanIdsUAfv8C105n19fwnGH4gT7X0nhVaFKxbnjvRSKpo2NE
 E0m/qmTqzfD8VoCruzAQRV9nl4m+gz2yS9uGjECGHPGIy7aMrW5cVc5ObBEPqmv65R86
 mRWfe5T1gq8ECgik+M5gUyAPKlkWCd62pcn2E7qrjev5uTAztfQ7twkUKoa4OVZxmbJ+
 PGZw==
X-Gm-Message-State: APjAAAWyGjfdott1HqtKENzv46meLhBgKh8Pj99Gkjh3AZn5pSegmgab
 ocjC9swRgUeJLz1R69KdcVFWx03utzvx47yaJBy0pw==
X-Google-Smtp-Source: APXvYqxaHbg9wGrhPDC7KY9h4/T6gJtOK/cjPOQuHZ/cm5bMXyegNG4BJPnQF+hwTrK2/cIW5aXbEGRonidH9XKFVMo=
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr23106426iof.166.1582177221738; 
 Wed, 19 Feb 2020 21:40:21 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 19 Feb 2020 23:40:10 -0600
Message-ID: <CAM2K0npCdHfCeMCKO9TX_ifQGDZFFNyMEKH2qByYL9SnXnaPmw@mail.gmail.com>
Subject: 
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000460395059efb57af"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d35
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000460395059efb57af
Content-Type: text/plain; charset="UTF-8"

Dear QEMU list members,

This will kind of be a repost but I'd like to post my question again
because I've gained some more knowledge that makes me feel that my question
would be easier to answer.  So we developed a custom-made QEMU VM that
emulates a custom machine that has an e5500 processor.  I'm running this VM
on a T4240-RDB board which has an e6500 processor and I'm trying to get the
VM running with KVM enabled.  The problem I'm having is the program counter
refuses to increment at all.  It just stays at the address 0xFFFFFFFC.  On
a run without KVM enabled, the VM will also start executing at this same
address but the program counter beings to increment immediately.  I know
this is a custom QEMU VM and maybe some of the startup stuff we do could be
causing problems, but what could possibly stop the program counter from
incrementing altogether?

Also, I do have another side question.  When running with KVM enabled, I
see the kernel-level ioctl call KVM_RUN running and then returning over and
over again (by the way before the VM kinda grinds to a halt I only see QEMU
make the KVM_RUN call twice, but the kernel-level ioctl function is being
called over and over again for some reason).  And each time the KVM_RUN
call returns, the return-from-interrupt takes the VM to the address
0xFFFFFFFC.  What is the KVM_RUN ioctl call used for?  Why is it being
called over and over again?  Maybe if I understood this better I'd be able
to figure out what's stopping my program counter from incrementing.

-Thanks, Wayne Li

--000000000000460395059efb57af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear QEMU list members,<div><br></div><div>This will kind =
of be a repost but I&#39;d like to post my question again because I&#39;ve =
gained some more knowledge that makes me feel that my question would be eas=
ier to answer.=C2=A0 So we developed a custom-made QEMU VM that emulates a =
custom machine that has an e5500 processor.=C2=A0 I&#39;m running this VM o=
n a T4240-RDB board which has an e6500 processor and I&#39;m trying to get =
the VM running with KVM enabled.=C2=A0 The problem I&#39;m having is the pr=
ogram counter refuses to increment at all.=C2=A0 It just stays at the addre=
ss 0xFFFFFFFC.=C2=A0 On a run without KVM enabled, the VM will also start e=
xecuting at this same address but the program counter beings to increment i=
mmediately.=C2=A0 I know this is a custom QEMU VM and maybe some of the sta=
rtup stuff we do could be causing problems, but what could possibly stop th=
e program counter from incrementing altogether?</div><div><br></div><div>Al=
so, I do have another side question.=C2=A0 When running with KVM enabled, I=
 see the kernel-level ioctl call KVM_RUN running and then returning over an=
d over again (by the way before the VM kinda grinds to a halt I only see QE=
MU make the KVM_RUN call twice, but the kernel-level ioctl function is bein=
g called over and over again for some reason).=C2=A0 And each time the KVM_=
RUN call returns, the return-from-interrupt takes the VM to the address 0xF=
FFFFFFC.=C2=A0 What is the KVM_RUN ioctl call used for?=C2=A0 Why is it bei=
ng called over and over again?=C2=A0 Maybe if I understood this better I&#3=
9;d be able to figure out what&#39;s stopping my program counter from incre=
menting.</div><div><br></div><div>-Thanks, Wayne Li</div></div>

--000000000000460395059efb57af--

