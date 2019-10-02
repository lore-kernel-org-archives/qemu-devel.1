Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FAC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F092D2133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F092D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFd5l-0007uj-4R
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cmull@us.ibm.com>) id 1iFcum-0005Sx-US
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cmull@us.ibm.com>) id 1iFcuj-00032W-Nf
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:35:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50372
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cmull@us.ibm.com>) id 1iFcuj-0002za-IL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:35:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x92BVsFa005038
 for <qemu-devel@nongnu.org>; Wed, 2 Oct 2019 07:35:23 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [158.85.210.104])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcs29kwu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 07:35:23 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <qemu-devel@nongnu.org> from <cmull@us.ibm.com>;
 Wed, 2 Oct 2019 11:35:22 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
 by smtp.notes.na.collabserv.com (10.122.47.44) with
 smtp.notes.na.collabserv.com ESMTP; Wed, 2 Oct 2019 11:35:16 -0000
Received: from us1b3-mail196.a3dr.sjc03.isc4sb.com ([10.168.5.55])
 by us1b3-smtp02.a3dr.sjc01.isc4sb.com
 with ESMTP id 2019100211351626-347431 ;
 Wed, 2 Oct 2019 11:35:16 +0000 
In-Reply-To: <20191001114304.GZ9210@angien.pipo.sk>
From: "Craig Mull" <cmull@us.ibm.com>
To: pkrempa@redhat.com
Date: Wed, 2 Oct 2019 11:35:15 +0000
Sensitivity: 
MIME-Version: 1.0
References: <20191001114304.GZ9210@angien.pipo.sk>,
 <OFADB7E923.8BF08D6B-ON00258485.0069D537-00258485.006AC672@notes.na.collabserv.com>
 <facf5e37-18e0-7de5-09cf-a088f471d8ad@redhat.com>
 <20191001084553.GA4688@linux.fritz.box>
Importance: Normal
X-Priority: 3 (Normal)
X-Mailer: IBM Verse Build 17652-1619 | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 01384F6D:E7CC6611-00258487:003EC1CB;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 39287
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8
x-cbid: 19100211-5525-0000-0000-000000F8126F
X-IBM-SpamModules-Scores: BY=0.060805; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.386589; ST=0; TS=0; UL=0; ISC=; MB=0.025292
X-IBM-SpamModules-Versions: BY=3.00011876; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01269608; UDB=6.00671966; IPR=6.01051646; 
 MB=3.00028912; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-02 11:35:20
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-02 09:30:44 - 6.00010477
x-cbparentid: 19100211-5526-0000-0000-000062AF131C
Message-Id: <OF01384F6D.E7CC6611-ON00258487.003EC1CB-00258487.003FA722@notes.na.collabserv.com>
Subject: RE: Qemu Dirty Bitmap backup to encrypted target
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-02_06:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Leo Luan <leoluan@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, H=
elvetica, sans-serif;font-size:10pt" ><div dir=3D"ltr" >Thanks to all who r=
esponded on&nbsp;this thread.</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >This bugzills appears to outline a procedure&nbsp;we can =
try&nbsp;..&nbsp;<a href=3D"https://bugzilla.redhat.com/show=5Fbug.cgi?id=
=3D1662412" style=3D"font-size: 10pt;" >https://bugzilla.redhat.com/show=5F=
bug.cgi?id=3D1662412</a></div>
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
hitect<br>cmull@us.ibm.com<br>&nbsp;</div></div></div></div></div></div></d=
iv></div></div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<blockquote data-history-content-modified=3D"1" dir=3D"ltr" style=3D"border=
-left:solid #aaaaaa 2px; margin-left:5px; padding-left:5px; direction:ltr; =
margin-right:0px" >----- Original message -----<br>From: Peter Krempa &lt;p=
krempa@redhat.com&gt;<br>Sent by: "Qemu-devel" &lt;qemu-devel-bounces+cmull=
=3Dus.ibm.com@nongnu.org&gt;<br>To: Kevin Wolf &lt;kwolf@redhat.com&gt;<br>=
Cc: Craig Mull &lt;cmull@us.ibm.com&gt;, John Snow &lt;jsnow@redhat.com&gt;=
, qemu-devel@nongnu.org, Qemu-block &lt;qemu-block@nongnu.org&gt;, Leo Luan=
 &lt;leoluan@us.ibm.com&gt;<br>Subject: [EXTERNAL] Re: Qemu Dirty Bitmap ba=
ckup to encrypted target<br>Date: Tue, Oct 1, 2019 6:45 AM<br>&nbsp;
<div><font face=3D"Default Monospace,Courier New,Courier,monospace" size=3D=
"2" >On Tue, Oct 01, 2019 at 10:45:53 +0200, Kevin Wolf wrote:<br>&gt; Am 0=
1.10.2019 um 02:24 hat John Snow geschrieben:<br>&gt; &gt;<br>&gt; &gt;<br>=
&gt; &gt; On 9/30/19 3:26 PM, Craig Mull wrote:<br>&gt; &gt; &gt; How can h=
ave QEMU backup write the output&nbsp;to an encrypted target?<br>&gt; &gt; =
&gt; &nbsp;<br>&gt; &gt; &gt; Blocks in the dirty bitmap are unencrypted, a=
nd as such when I write<br>&gt; &gt; &gt; them with QEMU backup they are wr=
itten to the target unencrypted.<br>&gt; &gt; &gt; &nbsp;<br>&gt; &gt; &gt;=
 I've experimented with providing a json string as the target but with no<b=
r>&gt; &gt; &gt; luck.<br>&gt; &gt; &gt; &nbsp;<br>&gt; &gt; &gt;<br>&gt; &=
gt; &gt; transaction=3D'{ "execute": "transaction",&nbsp;<br>&gt; &gt; &gt;=
<br>&gt; &gt; &gt; &nbsp; "arguments": {&nbsp;<br>&gt; &gt; &gt;<br>&gt; &g=
t; &gt; &nbsp; &nbsp; "actions": [<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &nbs=
p; &nbsp; &nbsp; {"type": "block-dirty-bitmap-add",&nbsp;<br>&gt; &gt; &gt;=
<br>&gt; &gt; &gt; &nbsp;&nbsp; &nbsp; &nbsp; "data": {"node": "drive-virti=
o-disk0", "granularity": 2097152,<br>&gt; &gt; &gt; "name": "mybitmap"} },<=
br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; {"type": "drive-ba=
ckup",<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &nbsp;&nbsp; &nbsp; &nbsp; "data=
": {"device": "drive-virtio-disk0", "target":<br>&gt; &gt; &gt; "json:{\"en=
crypt.format\": \"luks\", \"encrypt.key-secret\":<br>&gt; &gt; &gt; \"virti=
o-disk0-luks-secret0\", \"driver\": \"qcow2\", \"file\":<br>&gt; &gt; &gt; =
{\"driver\": \"file\", \"filename\": \"/tmp/target-encrypt-test.qcow2\"}}",=
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; "sync": "full", "format": "qcow2"} }&nbsp;<br>&gt; &gt; &=
gt;<br>&gt; &gt; &gt; &nbsp; &nbsp; ]&nbsp;<br>&gt; &gt; &gt;<br>&gt; &gt; =
&gt; &nbsp; }&nbsp;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; }'<br>&gt; &gt; &gt=
;<br>&gt; &gt; &gt; &nbsp;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; virsh -c qem=
u:///system qemu-monitor-command --pretty 28 $transaction<br>&gt; &gt; &gt;=
<br>&gt; &gt; &gt; &nbsp;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; {<br>&gt; &gt=
; &gt;<br>&gt; &gt; &gt; &nbsp; "id": "libvirt-45",<br>&gt; &gt; &gt;<br>&g=
t; &gt; &gt; &nbsp; "error": {<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &nbsp; &=
nbsp; "class": "GenericError",<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &nbsp; &=
nbsp; "desc": "Unknown protocol 'json'"<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;=
 &nbsp; }<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; }<br>&gt; &gt; &gt;<br>&gt; &=
gt; &gt;<br>&gt; &gt;<br>&gt; &gt; I'll be honest, I'm not very good at the=
 json specifications and don't<br>&gt; &gt; really know when they're approp=
riate to use. At the basic level,<br>&gt; &gt; drive-backup expects a filen=
ame. Sometimes the filename can get fancy,<br>&gt; &gt; but... I stay away =
from that.<br>&gt; &gt;<br>&gt; &gt; Try using qmp-blockdev-create to creat=
e the target node instead, and<br>&gt; &gt; then using blockdev-backup to b=
ackup to that target.<br>&gt;<br>&gt; As the actual invocation is a virsh c=
ommand, I think this is more of a<br>&gt; libvirt question than a QEMU one.=
<br><br>The above virsh command is a direct (unsupported/experimental) comm=
and<br>passthrough to qemu, thus the syntax is identical to raw QMP.<br><br=
>You must use blockdev-backup as outlined above along with any management<b=
r>necessary for adding the devices previously. Obviously this may<br>desync=
hronize state with libvirt.<br><br>&gt; I suspect that libvirt won't suppor=
t this without -blockdev support<br>&gt; (which will enable blockdev-backup=
 instead of drive-backup), but even<br>&gt; then libvirt might not even off=
er an API for an encrypted target. Not<br>&gt; sure, though, so CCing Peter=
.<br><br>The current state is that libvirt will support backup only with<br=
>-blockdev. In that case everything including encrypted images should be<br=
>supported same way as we (will [1]) support them with snapshots or<br>norm=
al disks.<br><br>This is currently being worked on.<br><br>[1] All the code=
 for blockdev is in but it's not enabled yet as we are<br>waiting for the p=
ossibility to detect the fix for 'savevm' done<br>recently. -blockdev will =
be supported with qemu-4.2.</font><br>&nbsp;</div></blockquote>
<div dir=3D"ltr" >&nbsp;</div></div><BR>


