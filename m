Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E0CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34E420578
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nxHbQbjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34E420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRh1n-0002H8-0x
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1iRh0b-0001E9-Pw
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1iRh0W-0000NF-2y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:23:17 -0500
Received: from m12-12.163.com ([220.181.12.12]:50312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liq3ea@163.com>) id 1iRh0U-0000Gj-To
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=MIME-Version:From:Subject:Date:Message-Id; bh=M9BWe
 r0vcLDAdeZ22XkCMo2MP1isMdn5SBnBrgyhGiM=; b=nxHbQbjXBuUjQ+D98b1Dj
 tOXGrHTgzAqLQ6D7Vli/1PY2t/Xl3u/xkVaa/fM+N+jE6LfFulPZa05DXroJxaYJ
 39QF+y+it3oIbONLFrzR82SYVo250ruTW4WDRmIgMIWTJnE12M1SNIsyxnTIFsFx
 eGSoWlTmeKmfV3E391kAZA=
Received: from [IPv6:::ffff:192.168.0.7] (unknown [115.204.244.11])
 by smtp8 (Coremail) with SMTP id DMCowABXHvNqVMBdVkvORw--.48551S3;
 Tue, 05 Nov 2019 00:40:11 +0800 (CST)
MIME-Version: 1.0
To: Alex Williamson <alex.l.williamson@gmail.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "liq3ea@gmail.com" <liq3ea@gmail.com>
From: Li Qiang <liq3ea@163.com>
Subject: Questions about the VFIO BAR region
Date: Tue, 5 Nov 2019 00:40:39 +0800
Importance: normal
X-Priority: 3
Content-Type: multipart/alternative;
 boundary="_0B207E59-83CD-4C1A-836C-BB915ECC71F1_"
X-CM-TRANSID: DMCowABXHvNqVMBdVkvORw--.48551S3
Message-Id: <5DC05485.008EAA.00665@m12-12.163.com>
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryfuFW5AFWfKry8CF48WFg_yoWxZwcEg3
 47Crykt3y8Wr4fZ3W3XF45Jws2va17WFZ7Gr1UXFs7tFWFg3ZY9r4vkr1qkF1jqay3Ar45
 tr4rGa18Kr1UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8iSdDUUUUU==
X-Originating-IP: [115.204.244.11]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTwVjbVsGSA9Y2gAAsc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.12.12
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

--_0B207E59-83CD-4C1A-836C-BB915ECC71F1_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hello Alex, Auger and all,

I have a question about the VFIO virtual device BAR.

In vfio_region_setup, it initialize a =E2=80=98region->mem=E2=80=99 MR and =
set its ops to =E2=80=98vfio_regions_ops=E2=80=99.=20
In =E2=80=98vfio_region_mmap=E2=80=99, it maps the physical device=E2=80=99=
s MMIO to QEMU=E2=80=99s virtual address space=20
as a raw MR =E2=80=98region->mmaps[i].mem=E2=80=99.=20
And also it set the latter MR as a subregion of the first one.

So when the guest accesses the BAR, it will direct go to the physical devic=
e=E2=80=99s BAR.
My question is here:
When the qemu will use the =E2=80=98vfio_regions_ops=E2=80=99 to read/write=
 the BAR?
Also whey in the last of =E2=80=98vfio_region_write/read=E2=80=99 we need t=
o call =E2=80=98vbasedev->ops->vfio_eoi(vbasedev);=E2=80=99?


Thanks,
Li Qiang


--_0B207E59-83CD-4C1A-836C-BB915ECC71F1_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DZH-CN link=3Dblue vlink=3D"#954F72"><div cla=
ss=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US>Hello Alex, Auger=
 and all,</span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-US>I have a question abou=
t the VFIO virtual device BAR.</span></p><p class=3DMsoNormal><span lang=3D=
EN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>I=
n vfio_region_setup, it initialize a =E2=80=98region-&gt;mem=E2=80=99 MR an=
d set its ops to =E2=80=98vfio_regions_ops=E2=80=99. </span></p><p class=3D=
MsoNormal><span lang=3DEN-US>In =E2=80=98vfio_region_mmap=E2=80=99, it maps=
 the physical device=E2=80=99s MMIO to QEMU=E2=80=99s virtual address space=
 </span></p><p class=3DMsoNormal><span lang=3DEN-US>as a raw MR =E2=80=98re=
gion-&gt;mmaps[i].mem=E2=80=99. </span></p><p class=3DMsoNormal><span lang=
=3DEN-US>And also it set the latter MR as a subregion of the first one.</sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US>So when the guest accesses the BAR,=
 it will direct go to the physical device=E2=80=99s BAR.</span></p><p class=
=3DMsoNormal><span lang=3DEN-US>My question is here:</span></p><p class=3DM=
soNormal><span lang=3DEN-US>When the qemu will use the =E2=80=98vfio_region=
s_ops=E2=80=99 to read/write the BAR?</span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Also whey in the last of =E2=80=98vfio_region_write/read=E2=80=
=99 we need to call =E2=80=98vbasedev-&gt;ops-&gt;vfio_eoi(vbasedev);=E2=80=
=99?</span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-US>Thanks,</span></p><p class=3DMsoNo=
rmal><span lang=3DEN-US>Li Qiang</span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'><o:p>&nbsp;</o:p></s=
pan></p></div></body></html>=

--_0B207E59-83CD-4C1A-836C-BB915ECC71F1_--



