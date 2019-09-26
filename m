Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC9C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A87222C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A87222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDTBf-0001Al-Ga
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cmull@us.ibm.com>) id 1iDTAI-0008SX-0x
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cmull@us.ibm.com>) id 1iDTAE-0005xg-OS
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:46:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cmull@us.ibm.com>) id 1iDTAE-0005n6-Ah
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:46:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8QCjFN3146821
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:46:18 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [158.85.210.104])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8wjbg8rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:46:18 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <qemu-devel@nongnu.org> from <cmull@us.ibm.com>;
 Thu, 26 Sep 2019 12:46:17 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
 by smtp.notes.na.collabserv.com (10.122.47.44) with
 smtp.notes.na.collabserv.com ESMTP; Thu, 26 Sep 2019 12:46:15 -0000
Received: from us1b3-mail196.a3dr.sjc03.isc4sb.com ([10.168.5.55])
 by us1b3-smtp02.a3dr.sjc01.isc4sb.com
 with ESMTP id 2019092612461219-457384 ;
 Thu, 26 Sep 2019 12:46:12 +0000 
In-Reply-To: 
Subject: qcow2 native encryption -- change passphrase?
From: "Craig Mull" <cmull@us.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 26 Sep 2019 12:46:12 +0000
Sensitivity: 
References: 
MIME-Version: 1.0
Importance: Normal
X-Priority: 3 (Normal)
X-Mailer: IBM Verse Build 17652-1619 | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: CD06A903:1875D335-00258481:00455734;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 18835
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8
x-cbid: 19092612-5525-0000-0000-000000E12C42
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.413459; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00011843; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01266819; UDB=6.00670263; IPR=6.01048800; 
 MB=3.00028818; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-26 12:46:16
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-26 11:24:48 - 6.00010454
x-cbparentid: 19092612-5526-0000-0000-00001FC132A4
Message-Id: <OFCD06A903.1875D335-ON00258481.00455734-00258481.004625E5@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-26_06:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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

<div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, H=
elvetica, sans-serif;font-size:10pt" ><div dir=3D"ltr" >How do&nbsp;you cha=
nge the&nbsp;passphrase for&nbsp;QCOW2 native encrypted volume?</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >I've played with qemu-img create and it appears&nbsp;I ca=
n only add a passphrase to slot 0 at volume creation time.&nbsp; I don't be=
lieve cryptsetup is supported with QCOW2 native encryption to manage LUKS s=
lots.</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >thxs, -craig</div>
<div dir=3D"ltr" ><div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"fo=
nt-family:Arial, Helvetica, sans-serif;font-size:10.5pt" ><div class=3D"soc=
maildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, Helvetica, sans-se=
rif;font-size:10.5pt" ><div class=3D"socmaildefaultfont" dir=3D"ltr" style=
=3D"font-family:Arial, Helvetica, sans-serif;font-size:10.5pt" ><div class=
=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, Helvetica, =
sans-serif;font-size:10.5pt" ><div class=3D"socmaildefaultfont" dir=3D"ltr"=
 style=3D"font-family:Arial, Helvetica, sans-serif;font-size:10.5pt" ><div =
class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, Helvet=
ica, sans-serif;font-size:10.5pt" ><div class=3D"socmaildefaultfont" dir=3D=
"ltr" style=3D"font-family:Arial, Helvetica, sans-serif;font-size:10.5pt" >=
<div dir=3D"ltr" ><br>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>Craig Mull<br>VPC Storage Arc=
hitect<br>cmull@us.ibm.com<br>Home office (512) 515-7833<br>Austin Site off=
ice (512) 973-1919, t/l 363-1919<br>&nbsp;</div></div></div></div></div></d=
iv></div></div></div></div><BR>


