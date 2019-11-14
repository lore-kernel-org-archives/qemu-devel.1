Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DCDC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B33D206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="drJWESGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B33D206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60125 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVIiu-0000OR-ET
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <janine.schneider@fau.de>) id 1iVHjP-0002xt-V2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 11:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <janine.schneider@fau.de>) id 1iVHjO-00024B-E0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 11:12:27 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:33525)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <janine.schneider@fau.de>)
 id 1iVHjK-0001uq-MT; Thu, 14 Nov 2019 11:12:23 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de
 (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47DRMJ4wcNz8tb0;
 Thu, 14 Nov 2019 17:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
 t=1573747932; bh=TFW8IRQQAQ83C3ERCW/pMN6KV0BPOO1zLXfNhSWbKsI=;
 h=From:To:Subject:Date:From:To:CC:Subject;
 b=drJWESGYh0S4ZrgVPmRTd8T25RH0SYKY46bDAmczybNE/Vv0P2R08tO8uUv5EaYJR
 bLT2jIC2BBSMQuF0M/iZzNdTTeDoUb/4SEo3IUununP6lfvCBMjPqq3XwvS3wcJyRi
 rbjaTbuzIw/h6VgkO923zl+aLS5rH8oLubUAMLo4VGBnFNOwWVb+Fya9b/1pPJPIaM
 6kDz8fWY5Oqk3bXI34jnILBxeaFFAc2CQ286S91vVYFNWpfy6oXPLVFayXgf+SF5+8
 OI7mRSMI82XNgjv6zrCR3y9JTqim/SMhnT95SL7H0GXIl5LBgirqvUr8fTXwcRL78Z
 sSXPdxtLSFsIg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.31.97
Received: from LenovoJS (faui1-97.informatik.uni-erlangen.de [131.188.31.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: U2FsdGVkX1+CZ0g9ytG5i8NPflQjkaOmK8al27qIWro=)
 by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47DRMF38Gcz8tNx;
 Thu, 14 Nov 2019 17:12:09 +0100 (CET)
From: <janine.schneider@fau.de>
To: <qemu-devel@nongnu.org>,
	<qemu-block@nongnu.org>
Subject: Convert VMDK to RAW
Date: Thu, 14 Nov 2019 17:12:14 +0100
Message-ID: <009201d59b06$475883f0$d6098bd0$@fau.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0093_01D59B0E.A91CEBF0"
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AdWbAvRCCzVB3tUBQxKkTQEQDKtfLg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 131.188.11.20
X-Mailman-Approved-At: Thu, 14 Nov 2019 12:11:33 -0500
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

This is a multipart message in MIME format.

------=_NextPart_000_0093_01D59B0E.A91CEBF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ladies and Gentlemen,

 

I am a PhD student at the Friedrich-Alexander-University Erlangen-Nuremberg
in Bavaria, Germany and am currently working on a forensic reconstruction
tool. The tool can be used to analyze physical and virtual hard disks and to
reconstruct files. I would now like to extend the tool so that it is able to
analyze VMDK files and convert them to raw. Unfortunately I have not been
able to understand how to correctly unpack and assemble VMDK containers.
Since qemu is able to convert VMDK to raw, I wanted to ask you if you could
explain to me how to put the grains together?

 

Many thanks and greetings

Janine Schneider


------=_NextPart_000_0093_01D59B0E.A91CEBF0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DDE =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoNormal><span lang=3DEN-US>Ladies and =
Gentlemen,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>I am a PhD student at the Friedrich-Alexander-University =
Erlangen-Nuremberg in Bavaria, Germany and am currently working on a =
forensic reconstruction tool. The tool can be used to analyze physical =
and virtual hard disks and to reconstruct files. I would now like to =
extend the tool so that it is able to analyze VMDK files and convert =
them to raw. Unfortunately I have not been able to understand how to =
correctly unpack and assemble VMDK containers. Since qemu is able to =
convert VMDK to raw, I wanted to ask you if you could explain to me how =
to put the grains together?<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Many thanks and =
greetings<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Janine Schneider<o:p></o:p></span></p></div></body></html>
------=_NextPart_000_0093_01D59B0E.A91CEBF0--


