Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D10C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C838320735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C838320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXTk-0002oN-1c
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47950 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rosnbrg@us.ibm.com>) id 1jQXSt-0002EQ-9L
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:32:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <rosnbrg@us.ibm.com>) id 1jQXSr-0005n0-Ai
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:32:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41060
 helo=mx0a-001b2d01.pphosted.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rosnbrg@us.ibm.com>)
 id 1jQXSq-0005gU-SF
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:32:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03KE4HBK090016
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:31:57 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [192.155.248.67])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30ggr1dnuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:31:57 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <qemu-devel@nongnu.org> from <rosnbrg@us.ibm.com>;
 Mon, 20 Apr 2020 14:31:56 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
 by smtp.notes.na.collabserv.com (10.106.227.16) with
 smtp.notes.na.collabserv.com ESMTP; Mon, 20 Apr 2020 14:31:50 -0000
Received: from us1a3-mail34.a3.dal06.isc4sb.com ([10.146.6.29])
 by us1a3-smtp02.a3.dal06.isc4sb.com
 with ESMTP id 2020042014314904-577865 ;
 Mon, 20 Apr 2020 14:31:49 +0000 
In-Reply-To: <3399bbd8-a85b-9e42-cd16-a40c4a963e9e@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
From: "Bryan S Rosenburg" <rosnbrg@us.ibm.com>
Date: Mon, 20 Apr 2020 10:31:49 -0400
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
 <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
 <CAD_3s9KuB7QaXCTygRfOsscXbrhm0kHbHRpUjb51EiwRpEM5MA@mail.gmail.com>
 <93052f9b-6539-0d4a-c922-fff7618c542d@redhat.com>
 <CAD_3s9+pSepV76-wp_AQTB-EQGwmga1FS+fT-Cb4n0Z48Zhxpg@mail.gmail.com>
 <3399bbd8-a85b-9e42-cd16-a40c4a963e9e@virtuozzo.com>
MIME-Version: 1.0
X-KeepSent: 6B6CB4FB:FFD51055-85258550:0049F242;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Build V1001FP1_03262019 March 26, 2019
X-LLNOutbound: False
X-Disclaimed: 7711
X-TNEFEvaluated: 1
Content-Type: multipart/alternative;
 boundary="=_alternative 004FCE1685258550_="
x-cbid: 20042014-7279-0000-0000-0000028369C9
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.417846; ST=0; TS=0; UL=0; ISC=; MB=0.000068
X-IBM-SpamModules-Versions: BY=3.00012940; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01365205; UDB=6.00729057; IPR=6.01147564; 
 MB=3.00031787; MTD=3.00000008; XFM=3.00000015; UTC=2020-04-20 14:31:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-04-20 06:49:40 - 6.00011264
x-cbparentid: 20042014-7280-0000-0000-00004F8271F6
Message-Id: <OF6B6CB4FB.FFD51055-ON85258550.0049F242-85258550.004FD137@notes.na.collabserv.com>
Subject: RE: Avoid copying unallocated clusters during full backup
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-20_04:2020-04-20,
 2020-04-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rosnbrg@us.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 10:31:57
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Leo Luan <leoluan@gmail.com>,
 John Snow <jsnow@redhat.com>,
 Qemu-devel <qemu-devel-bounces+rosnbrg=us.ibm.com@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=_alternative 004FCE1685258550_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"

Vladimir, thank you for outlining the current state of affairs regarding=20
efficient backup. I'd like to describe what we know about the=20
image-expansion problem we're having using the current (qemu 4.2.0) code,=20
just to be sure that your work is addressing it.

In our use case, the image-expansion problem occurs only when the source=20
disk file and the target backup file are in different file systems. Both=20
files are qcow2 files, and as long as they both reside in the same file=20
system, the target file winds up with roughly the same size as the source. =

But if the target is in another file system (we've tried a second ext4=20
hard disk file system, a tmpfs file system, and fuse-based file systems=20
such as s3fs), the target ends up with a size comparable to the nominal=20
size of the source disk.

I think the expansion is related to this comment in=20
qemu/include/block/block.h:

/**
 * bdrv=5Fco=5Fcopy=5Frange:
. . . .
 * Note: block layer doesn't emulate or fallback to a bounce buffer=20
approach
 * because usually the caller shouldn't attempt offloaded copy any more=20
(e.g.
 * calling copy=5Ffile=5Frange(2)) after the first error, thus it should fa=
ll=20
back
 * to a read+write path in the caller level.

The bdrv=5Fco=5Fcopy=5Frange() service does the right things with respect t=
o=20
skipping unallocated ranges in the source disk and not writing zeros to=20
the target. But qemu gives up on using this service the first time an=20
underlying copy=5Ffile=5Frange() system call fails, and copy=5Ffile=5Frange=
()=20
always fails with EXDEV when the source and destination files are on=20
different file systems. In this specific case (at least), I think that=20
falling back to a bounce buffer approach would make sense so that we don't =

lose the rest of the logic in bdrv=5Fco=5Fcopy=5Frange. As it is, qemu fall=
s=20
back on a very high-level loop reading from the source and writing to the=20
target. At this high level, reading an unallocated range from the source=20
simply returns a buffer full of zeroes, with no indication that the range=20
was unallocated. The zeroes are then written to the target as if they were =

real data.

As a quick experiment, I tried a very localized fallback when=20
copy=5Ffile=5Frange returns EXDEV in handle=5Faiocb=5Fcopy=5Frange() in=20
qemu/block/file-posix.c. It's not a great fix because it has to allocate=20
and free a buffer on the spot and it does not head off future calls to=20
copy=5Ffile=5Frange that will also fail, but it does fix the image-expansio=
n=20
problem when crossing file systems. I can provide the patch if anyone=20
wants to see it.

I just wanted to get this aspect of the problem onto the table, to make=20
sure it gets addressed in the current rework. Maybe it's a non-issue=20
already.

- Bryan



--=_alternative 004FCE1685258550_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="US-ASCII"

<span style=3D" font-size:10pt;font-family:sans-serif">Vladimir, thank you
for outlining the current state of affairs regarding efficient backup.
I'd like to describe what we know about the image-expansion problem we're
having using the current (qemu 4.2.0) code, just to be sure that your work
is addressing it.</span><br><br><span style=3D" font-size:10pt;font-family:=
sans-serif">In our use case,
the image-expansion problem occurs only when the source disk file and the
target backup file are in different file systems. Both files are qcow2
files, and as long as they both reside in the same file system, the target
file winds up with roughly the same size as the source. But if the target
is in another file system (we've tried a second ext4 hard disk file system,
a tmpfs file system, and fuse-based file systems such as s3fs), the target
ends up with a size comparable to the nominal size of the source disk.</spa=
n><br><br><span style=3D" font-size:10pt;font-family:sans-serif">I think th=
e expansion
is related to this comment in qemu/include/block/block.h:</span><br><p styl=
e=3D"margin-top:4px;margin-Bottom:4px"><tt><span style=3D" font-size:9pt;co=
lor:#2f2f2f">/**<br> * bdrv=5Fco=5Fcopy=5Frange:<br>. . . .<br> * Note: blo=
ck layer doesn't emulate or fallback to a bounce buffer approach<br> * beca=
use usually the caller shouldn't attempt offloaded copy any more
(e.g.<br> * calling copy=5Ffile=5Frange(2)) after the first error, thus it =
should fall
back<br> * to a read+write path in the caller level.</span></tt></p><br><br=
><span style=3D" font-size:10pt;font-family:sans-serif">The bdrv=5Fco=5Fcop=
y=5Frange()
service does the right things with respect to skipping unallocated ranges
in the source disk and not writing zeros to the target. But qemu gives
up on using this service the first time an underlying copy=5Ffile=5Frange()
system call fails, and copy=5Ffile=5Frange() always fails with EXDEV when t=
he
source and destination files are on different file systems. In this specific
case (at least), I think that falling back to a bounce buffer approach
would make sense so that we don't lose the rest of the logic in bdrv=5Fco=
=5Fcopy=5Frange.
As it is, qemu falls back on a very </span><span style=3D" font-size:10pt;c=
olor:#2f2f2f;font-family:sans-serif">high-level
loop reading from the source and writing to the target. At this high level,
reading an unallocated range from the source simply returns a buffer full
of zeroes, with no indication that the range was unallocated. The zeroes
are then written to the target as if they were real data.</span><br><br><sp=
an style=3D" font-size:10pt;color:#2f2f2f;font-family:sans-serif">As
a quick experiment, I tried a very localized fallback when copy=5Ffile=5Fra=
nge
returns EXDEV in handle=5Faiocb=5Fcopy=5Frange() in qemu/block/file-posix.c.
It's not a great fix because it has to allocate and free a buffer on the
spot and it does not head off future calls to copy=5Ffile=5Frange that will
also fail, but it does fix the image-expansion problem when crossing file
systems. I can provide the patch if anyone wants to see it.</span><br><br><=
span style=3D" font-size:10pt;color:#2f2f2f;font-family:sans-serif">I
just wanted to get this aspect of the problem onto the table, to make sure
it gets addressed in the current rework. Maybe it's a non-issue already.</s=
pan><br><br><span style=3D" font-size:10pt;color:#2f2f2f;font-family:sans-s=
erif">-
Bryan</span><p style=3D"margin-top:4px;margin-Bottom:4px"></p><BR>

--=_alternative 004FCE1685258550_=--


