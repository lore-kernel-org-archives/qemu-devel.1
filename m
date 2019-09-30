Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67497C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34000224EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34000224EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF1LQ-0000nV-EO
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 15:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cmull@us.ibm.com>) id 1iF1JW-0008U6-Pk
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cmull@us.ibm.com>) id 1iF1JP-0004hB-3s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:26:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cmull@us.ibm.com>) id 1iF1JO-0004g1-SJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:26:23 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8UJLYT7025242
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 15:26:20 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [192.155.248.73])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2va35shxac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 15:26:19 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <qemu-devel@nongnu.org> from <cmull@us.ibm.com>;
 Mon, 30 Sep 2019 19:26:18 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
 by smtp.notes.na.collabserv.com (10.106.227.90) with
 smtp.notes.na.collabserv.com ESMTP; Mon, 30 Sep 2019 19:26:16 -0000
Received: from us1a3-mail196.a3.dal06.isc4sb.com ([10.146.77.145])
 by us1a3-smtp03.a3.dal06.isc4sb.com
 with ESMTP id 2019093019261564-942830 ;
 Mon, 30 Sep 2019 19:26:15 +0000 
In-Reply-To: 
Subject: Qemu Dirty Bitmap backup to encrypted target
From: "Craig Mull" <cmull@us.ibm.com>
To: qemu-devel@nongnu.org, "Leo Luan" <leoluan@us.ibm.com>
Date: Mon, 30 Sep 2019 19:26:16 +0000
Sensitivity: 
References: 
MIME-Version: 1.0
Importance: Normal
X-Priority: 3 (Normal)
X-Mailer: IBM Verse Build 17652-1619 | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 4251
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8
x-cbid: 19093019-8877-0000-0000-000001498E36
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.423878; ST=0; TS=0; UL=0; ISC=; MB=0.109822
X-IBM-SpamModules-Versions: BY=3.00011866; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01268829; UDB=6.00671493; IPR=6.01050853; 
 MB=3.00028889; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-30 19:26:18
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-30 17:43:14 - 6.00010471
x-cbparentid: 19093019-8878-0000-0000-00000468A1AB
Message-Id: <OFADB7E923.8BF08D6B-ON00258485.0069D537-00258485.006AC672@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-30_11:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
elvetica, sans-serif;font-size:10pt" ><div dir=3D"ltr" >How can have QEMU b=
ackup write the output&nbsp;to an encrypted target?</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Blocks in the dirty bitmap are unencrypted, and as such w=
hen I write them with QEMU backup they are written to the target unencrypte=
d.</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >I've experimented with providing a json string as the tar=
get but with no luck.</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" ><p class=3D"p1" ><span style=3D"font-size:11pt;" ><span s=
tyle=3D"font-family:Courier New,Courier,monospace;" >transaction=3D'{ "exec=
ute": "transaction",&nbsp;</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; "arguments": {&nbsp;</span></span=
></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; &nbsp; "actions": [</span></span>=
</p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; &nbsp; &nbsp; {"type": "block-dir=
ty-bitmap-add",&nbsp;</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp;&nbsp; &nbsp; &nbsp; "data": {"nod=
e": "drive-virtio-disk0", "granularity": 2097152, "name": "mybitmap"} },</s=
pan></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; &nbsp; &nbsp; {"type": "drive-bac=
kup",</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp;&nbsp; &nbsp; &nbsp; "data": {"dev=
ice": "drive-virtio-disk0", "target": "json:{\"encrypt.format\": \"luks\", =
\"encrypt.key-secret\": \"virtio-disk0-luks-secret0\", \"driver\": \"qcow2\=
", \"file\": {\"driver\": \"file\", \"filename\": \"/tmp/target-encrypt-tes=
t.qcow2\"}}",</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; "sync": "full", "format": "qcow2"} }&nbsp;</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; &nbsp; ]&nbsp;</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; }&nbsp;</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >}'</span></span></p>
<p class=3D"p1" >&nbsp;</p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >virsh -c qemu:///system qemu-monitor-com=
mand --pretty 28 $transaction</span></span></p>
<p class=3D"p2" >&nbsp;</p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >{</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; "id": "libvirt-45",</span></span>=
</p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; "error": {</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; &nbsp; "class": "GenericError",</=
span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; &nbsp; "desc": "Unknown protocol =
'json'"</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >&nbsp; }</span></span></p>
<p class=3D"p1" ><span style=3D"font-size:11pt;" ><span style=3D"font-famil=
y:Courier New,Courier,monospace;" >}</span></span></p></div>
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
hitect<br>cmull@us.ibm.com<br><br>&nbsp;</div></div></div></div></div></div=
></div></div></div></div><BR>


