Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FFC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B00D20771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FGUaO1DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B00D20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnDL-0005Jo-HC
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jrn1f-0006si-MV
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:36:37 -0400
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com
 ([40.107.92.66]:6256 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jrn1c-0002wK-OW
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9Y965cuz6RKc3Y7CCO7i1VLL+c77QD+UJM0b/CkrxHouQsQ+5b9EmYjy9HdCaD3MlRCmj8gHCNnVjfdOsmYlDB3tbYcVNgEBaMwsXNXHe2W7GJjAnTAnHV+u/v65Hzl43wKp4QN5v+Z+1eUkUFDNomgFt8FQCoZf4mR6Sd4oae744N+6q/e0gWIngJ99mbVcmvd5aal1PCy+UAALcbFvN3+b+kPfPlP/y+8GZFlVVy7J0xeho1daVQaWpgKrsBA3Bmz4G883dA6Wu7SMvjCX0C6sCpYYezLyCE51aj6MpJTxstT8VyXRZ+sIusPODZZMHpWupluVT0fgFq+fSRjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe3Ue8lauAEuITh1toZt6OmpEigjDuemB3xqa6HJQVk=;
 b=Yb2i+IX3DCIOaZKP5hZR2wOlGFK+15ND/vfrANK4sUQF+sOVbvXX0w5BK33SqKPvK0dzpH9+OiATx12GnFABQLObNiJ+Xpr57k9fU7vt00y3sAiG/C4zEXj1PsF71+DVLXYRYYP27FnfkE9Z4GTKpV1J03GJd+RzsXK1Im6XeK2SKVe1O8EWR3NgyosS+08ebS/G5NZ42VDZ0wQJCrrUC9pR695gLCOz+uYybWjetpTKfT+AnXJr4bDNbRze/wcRAZsd2+FDUkxT7qVWzO/NY4jjlPIdmqsgQIIdhThzMa4zTHL00BhACSL9dC6yR6jZCopQdiHc+Iimh279DJPBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe3Ue8lauAEuITh1toZt6OmpEigjDuemB3xqa6HJQVk=;
 b=FGUaO1DCy6cVCNb8sSzyk23IxVi9f6xeW02mfkuT5asuD+o3QsZypxwcAm3QClwb2yj/I0lC24ruEJlE1Q/GPkiknsGnTxWUQ4rN78wXkqvbem5JFp7VjNvAKlX9JQs2VMowfW6s/G00Vu0DfqiULB23FfNe2IiStlyOvWfxjWo=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5656.namprd02.prod.outlook.com (2603:10b6:a03:96::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Sat, 4 Jul
 2020 18:21:27 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3153.029; Sat, 4 Jul 2020
 18:21:27 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "pauldzim@gmail.com"
 <pauldzim@gmail.com>
Subject: Failure prints during format or mounting a usb storage device
Thread-Topic: Failure prints during format or mounting a usb storage device
Thread-Index: AdZSL+wC1X+/I9vcR9S9Qi5ROsMRPw==
Date: Sat, 4 Jul 2020 18:21:26 +0000
Message-ID: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64b7954b-f1d3-4799-74b5-08d8204710d9
x-ms-traffictypediagnostic: BYAPR02MB5656:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB56567D9886BD580B2D0900BCCA6B0@BYAPR02MB5656.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0454444834
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJsw2wsRdVXTGGQYCDO9Ir7Z7BLtNuAwZa+nr2419z8wTTZOnAf7Sqvx2iFMJA6HR/00BoWFjNPpczMC6Og1Swp63K6C2yDAzJsS8q1nbLXwYoEfMhzjK4wmAMEL6YUsVcIxBZJy/vOjDs0mB8c8cbULHnjnlm0aJBDVc77vIr5mHU5pfIn4+Rlke/70OlOTCdd/HcGF4y64RtDWsn//2owLY1z/EBsDYzdG8EuieW7AFioE8zwwIRkDar6jL8SwzASRbR8QseQbcuu3nchzUhLRgRQOYwETIQUKd4DZJA2vNEzF8c2vinfsRcpQgm+JTXXcvkP1yLIgLy4jyw++sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(39850400004)(376002)(346002)(366004)(83380400001)(33656002)(9686003)(186003)(71200400001)(6506007)(66946007)(76116006)(66476007)(7696005)(8936002)(66556008)(64756008)(66446008)(5660300002)(2906002)(478600001)(9326002)(52536014)(26005)(8676002)(4326008)(86362001)(110136005)(55016002)(54906003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qB3dUGBr0NX39bSPcbwVswDyYnDLA8sjMVXoMLxIxlyjWXYYWMMrijl5663tCztTdgUx78+3qg6sVz1pb1QYwTlv/rkjpuQ+Onf5uhRRXG72GyNP7g/WYp+l5Ge3pMmFziAiOlFP6g9qOSc4I0iF2ZyM5XJq/1l+MJFVqLJ0HAv36880QwCrEMNhsYGIRB9fJ6HZZJh8RDVLn1/ecPW/XvEQnoJcDX1GO3ZjLaQR2UKMvmGTMC6xAAf7gmG8lKpmbpDdSAyWghwaKV/47TAKEjXdlUog6Q4KXoV2iNnLMbPPWn8Bx4Kbc3/Iyaei1ARoAuwXs66xaBRv9kzPVNjFo4o0VFhOyIf7hRQBiNRc/xXLzzDds9SPsQXCQ1KjmMWKCxDw01hAwLagCH/MNkiHUk8WKvlkCy9FEchDRmRscdf80aq+rwpf0lHiIbEgsYzaiu6xo9B2nkqNXCe5wzUW37bAwTr5q7oD0wmOt0IMNTeVF5tD5q8vsaTPW+lyIBXb
Content-Type: multipart/alternative;
 boundary="_000_BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0BY5PR02MB6772namp_"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b7954b-f1d3-4799-74b5-08d8204710d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2020 18:21:26.9512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLR+B0pol5cOrfWb7SpYWISsw5zhsDz0xJikVi3OGV0WC7P49hO5M0Vg42iwiqyhxdjvrGG5FHIBsTmSSfEmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5656
Received-SPF: pass client-ip=40.107.92.66; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 14:36:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vikram Garhwal <fnuv@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0BY5PR02MB6772namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We are seeing some errors when a usb-storage device is formatted or mounted=
 on the guest. Below is commit I have bisected it.

**************
Errors:

/ # mount /dev/sda /mnt
[New Thread 0x7fffd4680700 (LWP 23270)]
[   33.258454] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using xh=
ci_hcd
[   33.399528] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using xh=
ci_hcd
[   33.544621] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using xh=
ci_hcd
[   33.560460] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=3DDID_ERROR =
driverbyte=3DDRIVER_OK
[   33.562405] sd 2:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 10 00 00 0=
0 01 00
[   33.563389] blk_update_request: I/O error, dev sda, sector 4096 op 0x0:(=
READ) flags 0x80700 phys_seg 1 prio class 0
/ # [Thread 0x7fffd4680700 (LWP 23270) exited]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bisect commit :

commit 7ad3d51ebb8a522ffcad391c4bef281245739dde
Author: Paul Zimmerman <pauldzim@gmail.com>
Date:   Wed May 20 16:53:47 2020 -0700

    usb: add short-packet handling to usb-storage driver

    The dwc-hsotg (dwc2) USB host depends on a short packet to
    indicate the end of an IN transfer. The usb-storage driver
    currently doesn't provide this, so fix it.

    I have tested this change rather extensively using a PC
    emulation with xhci, ehci, and uhci controllers, and have
    not observed any regressions.

    Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
    Message-id: 20200520235349.21215-6-pauldzim@gmail.com
    Signed-off-by: Peter Maydell peter.maydell@linaro.org<mailto:peter.mayd=
ell@linaro.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Steps to reproduce:

  1.  x86_64-softmmu/qemu-system-x86_64 -kernel bzImage -nographic -append =
"console=3DttyS0" -m 512M -initrd initramfs.cpio.gz -device qemu-xhci,id=3D=
xhci1 -drive file=3D./usb.img,if=3Dnone,id=3Dstick
  2.  Hotplug usb-storage:
                                device_add usb-storage,bus=3Dxhci1.0,port=
=3D1,id=3Dusbdev1,drive=3Dstick

  1.  Format &  mount the detected device
mkfs.vfat -F 32 /dev/sda
mount /dev/sda /mnt
You can find the similar errors mentioned above at this stage.
Test Environment:
       Host:  Ubuntu 16.04 LTS
       Guest:  kernel version: 5.4.0 & BusyBox v1.31.1

Thanks & Regards,
Sai Pavan


--_000_BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0BY5PR02MB6772namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:585842584;
	mso-list-type:hybrid;
	mso-list-template-ids:-2072089764 -709853614 67698713 67698715 67698703 67=
698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.25in;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:1.75in;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:3.25in;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.75in;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.25in;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:4.75in;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are seeing some errors when a usb-storage device =
is formatted or mounted on the guest. Below is commit I have bisected it.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">**************<o:p></o:p></p>
<p class=3D"MsoNormal">Errors:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">/ # mount /dev/sda /mnt<o:p></o:p></p>
<p class=3D"MsoNormal">[New Thread 0x7fffd4680700 (LWP 23270)]<o:p></o:p></=
p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 33.258454] usb 2-1: reset SuperSpeed G=
en 1 USB device number 2 using xhci_hcd<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 33.399528] usb 2-1: reset SuperSpeed G=
en 1 USB device number 2 using xhci_hcd<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 33.544621] usb 2-1: reset SuperSpeed G=
en 1 USB device number 2 using xhci_hcd<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 33.560460] sd 2:0:0:0: [sda] tag#0 FAI=
LED Result: hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 33.562405] sd 2:0:0:0: [sda] tag#0 CDB=
: Read(10) 28 00 00 00 10 00 00 00 01 00<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp;&nbsp; 33.563389] blk_update_request: I/O err=
or, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class =
0<o:p></o:p></p>
<p class=3D"MsoNormal">/ # [Thread 0x7fffd4680700 (LWP 23270) exited]<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p=
></o:p></p>
<p class=3D"MsoNormal">Bisect commit :<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">commit 7ad3d51ebb8a522ffcad391c4bef281245739dde<o:p>=
</o:p></p>
<p class=3D"MsoNormal">Author: Paul Zimmerman &lt;pauldzim@gmail.com&gt;<o:=
p></o:p></p>
<p class=3D"MsoNormal">Date:&nbsp;&nbsp; Wed May 20 16:53:47 2020 -0700<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; usb: add short-packet handling to=
 usb-storage driver<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; The dwc-hsotg (dwc2) USB host dep=
ends on a short packet to<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; indicate the end of an IN transfe=
r. The usb-storage driver<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; currently doesn't provide this, s=
o fix it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; I have tested this change rather =
extensively using a PC<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; emulation with xhci, ehci, and uh=
ci controllers, and have<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; not observed any regressions.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Paul Zimmerman &lt=
;pauldzim@gmail.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Message-id: 20200520235349.21215-=
6-pauldzim@gmail.com<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Peter Maydell <a h=
ref=3D"mailto:peter.maydell@linaro.org">
peter.maydell@linaro.org</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">Steps to reproduce:<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:.25in;mso-list:l0 level=
1 lfo1">x86_64-softmmu/qemu-system-x86_64 -kernel bzImage -nographic -appen=
d &quot;console=3DttyS0&quot; -m 512M -initrd initramfs.cpio.gz -device qem=
u-xhci,id=3Dxhci1 -drive file=3D./usb.img,if=3Dnone,id=3Dstick<o:p></o:p></=
li><li class=3D"MsoListParagraph" style=3D"margin-left:.25in;mso-list:l0 le=
vel1 lfo1">Hotplug usb-storage:<o:p></o:p></li></ol>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_add usb-stora=
ge,bus=3Dxhci1.0,port=3D1,id=3Dusbdev1,drive=3Dstick<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"3" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:.25in;mso-list:l0 level=
1 lfo1">Format &amp; &nbsp;mount the detected device<o:p></o:p></li></ol>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in">mkfs.vfat -F 32 /dev/sda=
 <br>
mount /dev/sda /mnt<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in;text-indent:.5in">You can =
find the similar errors mentioned above at this stage.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">Test Environment:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Host: &nbsp;Ubu=
ntu 16.04 LTS<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Guest: &nbsp;ke=
rnel version: 5.4.0 &amp; BusyBox v1.31.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Pavan<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0BY5PR02MB6772namp_--

