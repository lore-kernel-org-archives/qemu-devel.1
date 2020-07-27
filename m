Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4992C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8267E2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVSAdh5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8267E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02j7-0003fE-PN
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratkpranav@gmail.com>)
 id 1jzyA3-0007Eu-RG
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:07:03 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:39286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratkpranav@gmail.com>)
 id 1jzyA1-0001Ye-H0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:07:03 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id x1so798158oox.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=7OkWUtl9SZVc1PlWzRN/hhPIxrUZC/JPyp+gftJ91CQ=;
 b=UVSAdh5R4uB4tjg9MQf9yupg79Q7unlQofUZ+AcC3peEWg5qZn71XDERyKK+MRFVpA
 5yIv74duf+aE4MSPOfN5KxhCyV1V1vMbA6xgLCepE/FMhB8SSJTOah7BGmkzH7XckVQB
 acGFADuz7flofIQmTClPxxNBuk5cKgQ3T1ncipAEjHKZIT4dxEckhoYCQ6CwomtsMm5s
 I2n49GqaANevPegpFZ7m9F79DQLnZno4c7wXIyfCZJc7XTBw6hz7U0LV7HwfqZWOkUZd
 ceSJgb2FBoHVQ6xeKIT4sjUPXZRWFGy2u9PbzoKBgLZmOddS+9dvJxt+HNgp+G1Ob2Td
 3TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7OkWUtl9SZVc1PlWzRN/hhPIxrUZC/JPyp+gftJ91CQ=;
 b=pFngQx68styjHKVdHAFgzDpidHqc4PGr/yPlXjpBZWJSIMrvB2BSZVwaF/FlPut2+7
 OHil43jkm8DkQgRSQBkDSEEzbhh4VpllP46G7W/h1ZcW/lDPWR7nf+5hUNJK2piBXdFl
 BqTGRksmKLLmIydbAIYKPgXlcY/Uhp41z70xA7i0bk3B6XLM/xhJ4qG+w3BSVLWtYf0R
 7arF2xYj56qHiBfYgq2C5VCfJKuDHl3lnuaPt8VvPdoKVnX6thgTl2JmWmpbqAXze0kT
 ckhg28dnCxMuoP7Z8bBuONcaAgdMoPBSU2kVfiyR/Q5jhemi6byWGYXnl+kpbAF7snzr
 zDbQ==
X-Gm-Message-State: AOAM531RLhH15K2Z9Ane9bsZZoZsyBEHuWLH6VDiny2/r06TgMaJMdyg
 TcDwxdquukPjuwh3i+eumz4kU/tBmYnqt8rrmyv2Q6rVFqY=
X-Google-Smtp-Source: ABdhPJwun8WVlUkbLGoz0p6Gb/Sg/wSLeaSMdULMO7lHx8WFTPj/pXj76xQV6hqpowYXBCnuTvTvkKJ4RHMztcnLqEU=
X-Received: by 2002:a4a:d74d:: with SMTP id h13mr19862687oot.56.1595837220048; 
 Mon, 27 Jul 2020 01:07:00 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Pranav <pratkpranav@gmail.com>
Date: Mon, 27 Jul 2020 13:36:21 +0530
Message-ID: <CA+qpawCEFXbDdmvmXxOnxxU2rHhKJ8QqW3Ze7mb6E2fdXqgNKg@mail.gmail.com>
Subject: Problem with msix interrupts
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009ed06b05ab67cefb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=pratkpranav@gmail.com; helo=mail-oo1-xc2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_REMOTE_IMAGE=0.01,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jul 2020 08:58:53 -0400
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

--0000000000009ed06b05ab67cefb
Content-Type: text/plain; charset="UTF-8"

Hi,
I have a problem with MSI-X interrupt delivery between different VM guests
on QEMU. Could you tell me whether QEMU needs KVM for interrupt delivery
between QEMU guests?

I am currently using an ivshmem driver to work on a messaging layer between
two VMs, one running on qemu-system-x86 and another on qemu-system-aarch64.
When I try to interrupt the x86 VM from ARM VM, it gets interrupted but
doesn't occur the other way. When I removed KVM from x86, I couldn't even
interrupt x86.

Yours Sincerely,
Pratik Pranav

[image: photo]
Pratik Pranav
Student, Computer Science and Engineering at  Indian Institute of
Technology, Delhi
A  Satpura Hostel, IIT Delhi, Hauz Khas, New Delhi-110016
M  8936051771  <8936051771>
E  cs1180368@cse.iitd.ac.in  <cs1180368@cse.iitd.ac.in>
<http://www.linkedin.com/in/pratik-pranav-92629616b/>

--0000000000009ed06b05ab67cefb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>I have a problem with MSI-X interrupt delivery betw=
een different VM guests on QEMU. Could you tell me whether QEMU needs KVM f=
or interrupt delivery between QEMU guests?<br><br>I am currently using an i=
vshmem driver to work on a messaging layer between two VMs, one running on =
qemu-system-x86 and another on qemu-system-aarch64. When I try to interrupt=
 the x86 VM from ARM VM, it gets interrupted but doesn&#39;t occur the othe=
r way. When I removed KVM from x86, I couldn&#39;t even interrupt x86.<br><=
br>Yours Sincerely,<br>Pratik Pranav<div><br clear=3D"all"><div><div dir=3D=
"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><table style=3D"max-width:600px;direction:ltr">
			<tbody><tr><td>=20
			 <table style=3D"max-width:440px;padding-bottom:10px;margin-bottom:8px" =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0"> <tbody><tr> <td> <table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"display:inline-fle=
x"> <tbody><tr> <td valign=3D"top" style=3D"vertical-align:top"> <table bor=
der=3D"0" cellpadding=3D"0" cellspacing=3D"0"> <tbody><tr> <td> <img src=3D=
"https://d36urhup7zbd7q.cloudfront.net/be596108-86aa-4cbd-8344-fb168a5004e4=
/IMG_20191006_132415.format_png.resize_200x.jpeg#logo" alt=3D"photo" width=
=3D"96" height=3D"110" style=3D"vertical-align:initial;border-radius:4px;ma=
x-width:120px"> </td> </tr> </tbody></table> </td> <td valign=3D"top" style=
=3D"vertical-align:top;padding-left:12px"> <table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0"> <tbody><tr> <td style=3D"padding-bottom:7px"> <ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=
=3D"line-height:1.6;font-family:sans-serif;font-size:11px;color:rgb(78,75,7=
6);padding-left:2px;font-weight:normal;width:100%"> <tbody><tr> <td> <span =
style=3D"font-family:sans-serif;color:rgb(69,102,142);padding:0px;margin:0p=
x;font-size:12px;font-weight:bold">Pratik Pranav</span><br> <span style=3D"=
color:rgb(69,102,142);font-family:sans-serif;font-size:12px">Student, Compu=
ter Science and Engineering </span> <span style=3D"color:rgb(69,102,142);fo=
nt-family:sans-serif;font-size:12px">at=C2=A0 </span><span style=3D"color:r=
gb(69,102,142);font-family:sans-serif;font-size:12px">Indian Institute of T=
echnology, Delhi</span> </td> </tr> </tbody></table> </td> </tr> <tr> <td s=
tyle=3D"border-top:5px solid rgb(69,102,142);line-height:0px">  </td> </tr>=
 <tr> <td style=3D"padding-bottom:7px;padding-top:5px;width:328px" width=3D=
"328"> <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"100=
%" style=3D"line-height:1.6;font-family:sans-serif;font-size:11px;color:rgb=
(78,75,76);padding-left:2px;font-weight:normal;width:100%"> <tbody><tr> <td=
> <span style=3D"color:rgb(69,102,142);font-family:sans-serif;font-weight:b=
old;font-size:12px">A=C2=A0</span> <span style=3D"font-size:12px;font-famil=
y:arial,serif"> Satpura Hostel, IIT Delhi, Hauz Khas, New Delhi-110016</spa=
n> </td> </tr> <tr> <td> <table align=3D"left" border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0"> <tbody><tr> <td>  <span style=3D"display:inline-flex"=
> <span style=3D"color:rgb(69,102,142);font-family:sans-serif;font-weight:b=
old;font-size:12px">M=C2=A0</span> <a href=3D"tel:8936051771" style=3D"text=
-decoration:none;font-family:sans-serif;font-size:12px;color:rgb(78,75,76)"=
 target=3D"_blank"> 8936051771=C2=A0 </a> </span> </td> </tr> </tbody></tab=
le> <table align=3D"left" border=3D"0" cellpadding=3D"0" cellspacing=3D"0">=
 <tbody><tr> <td>  <span style=3D"display:inline-flex"> <span style=3D"colo=
r:rgb(69,102,142);font-family:sans-serif;font-weight:bold;font-size:12px">E=
=C2=A0</span> <a href=3D"mailto:cs1180368@cse.iitd.ac.in" style=3D"text-dec=
oration:none;font-family:sans-serif;font-size:12px;color:rgb(78,75,76)" tar=
get=3D"_blank"> cs1180368@cse.iitd.ac.in=C2=A0 </a> </span> </td> </tr> </t=
body></table> </td> </tr> <tr> <td> </td> </tr> </tbody></table> </td> </tr=
> </tbody></table> </td> </tr> <tr> <td colspan=3D"2"> <table border=3D"0" =
cellpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=3D"line-height:1.6=
;font-family:sans-serif;font-size:11px;color:rgb(78,75,76);padding-left:2px=
;font-weight:bold;width:100%"> <tbody><tr> <td style=3D"padding-top:7px"> <=
table border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr style=3D"=
padding-top:10px"><td align=3D"left" style=3D"padding-right:5px;text-align:=
center;padding-top:0px"> <a href=3D"http://www.linkedin.com/in/pratik-prana=
v-92629616b/" target=3D"_blank"><img src=3D"https://cdn.gifo.wisestamp.com/=
social/linkedin/0077b5/16/0.png"></a></td></tr></tbody></table> </td> </tr>=
 </tbody></table> </td> </tr> <tr> <td style=3D"padding-top:6px" colspan=3D=
"2"> </td> </tr> </tbody></table> </td> </tr> </tbody></table> <table cellp=
adding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td></td></tr></tbod=
y></table></td></tr></tbody></table>
		=09
	=09
	</div></div></div></div></div></div>

--0000000000009ed06b05ab67cefb--

