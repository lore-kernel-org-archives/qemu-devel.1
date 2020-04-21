Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76053C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B4B206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B4B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQu6e-0000Ro-UB
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rosnbrg@us.ibm.com>) id 1jQu5q-0008MR-O2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <rosnbrg@us.ibm.com>) id 1jQu5k-0005K1-MV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:41:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rosnbrg@us.ibm.com>)
 id 1jQu5k-0005Gm-46
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:41:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03LEbwhu109049
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 10:41:36 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [192.155.248.91])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30gmu86qmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 10:41:36 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <qemu-devel@nongnu.org> from <rosnbrg@us.ibm.com>;
 Tue, 21 Apr 2020 14:41:35 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
 by smtp.notes.na.collabserv.com (10.106.227.143) with
 smtp.notes.na.collabserv.com ESMTP; Tue, 21 Apr 2020 14:41:27 -0000
Received: from us1a3-mail34.a3.dal06.isc4sb.com ([10.146.6.29])
 by us1a3-smtp05.a3.dal06.isc4sb.com
 with ESMTP id 2020042114412693-568031 ;
 Tue, 21 Apr 2020 14:41:26 +0000 
In-Reply-To: <59e3fb48-b397-1e59-6f29-8e7f9148fe41@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
From: "Bryan S Rosenburg" <rosnbrg@us.ibm.com>
Date: Tue, 21 Apr 2020 10:41:26 -0400
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
 <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
 <CAD_3s9KuB7QaXCTygRfOsscXbrhm0kHbHRpUjb51EiwRpEM5MA@mail.gmail.com>
 <93052f9b-6539-0d4a-c922-fff7618c542d@redhat.com>
 <CAD_3s9+pSepV76-wp_AQTB-EQGwmga1FS+fT-Cb4n0Z48Zhxpg@mail.gmail.com>
 <3399bbd8-a85b-9e42-cd16-a40c4a963e9e@virtuozzo.com>
 <OF6B6CB4FB.FFD51055-ON85258550.0049F242-85258550.004FD137@notes.na.collabserv.com>
 <59e3fb48-b397-1e59-6f29-8e7f9148fe41@virtuozzo.com>
MIME-Version: 1.0
X-KeepSent: 1A8659FD:3A0BC2A3-85258551:00504BEA;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Build V1001FP1_03262019 March 26, 2019
X-LLNOutbound: False
X-Disclaimed: 41391
X-TNEFEvaluated: 1
Content-Type: multipart/alternative;
 boundary="=_alternative 0050B24385258551_="
x-cbid: 20042114-2475-0000-0000-000002E18FA0
X-IBM-SpamModules-Scores: BY=0.170781; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.417846; ST=0; TS=0; UL=0; ISC=; MB=0.035390
X-IBM-SpamModules-Versions: BY=3.00012946; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01365686; UDB=6.00729343; IPR=6.01148047; 
 MB=3.00031805; MTD=3.00000008; XFM=3.00000015; UTC=2020-04-21 14:41:33
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-04-21 10:49:37 - 6.00011268
x-cbparentid: 20042114-2476-0000-0000-0000BEA197BA
Message-Id: <OF1A8659FD.3A0BC2A3-ON85258551.00504BEA-85258551.0050B28F@notes.na.collabserv.com>
Subject: RE: Avoid copying unallocated clusters during full backup
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-21_05:2020-04-20,
 2020-04-21 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rosnbrg@us.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:59:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Leo Luan <leoluan@gmail.com>,
 John Snow <jsnow@redhat.com>,
 Qemu-devel <qemu-devel-bounces+rosnbrg=us.ibm.com@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=_alternative 0050B24385258551_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote on=20
04/20/2020 11:04:33 AM:

> Yes, the problem is that copy=5Frange subsystem handles block-status,=20
> when generic backup copying loop doesn't. I'm not sure that adding=20
> fallback into copy-range is a correct thing to do, at least it=20
> should be optional, enabled by flag.. But you don't need it for your=20
problem,
> as it is already fixed upstream:
>=20
> You need to backport my commit 2d57511a88 "block/block-copy: use=20
> block=5Fstatus" (together with 3 preparing patches before it, or with=20
> the whole series (including some refactoring after the 2d57511 commit)

Vladimir, thanks for the pointer to the "block/block-copy: use=20
block=5Fstatus" patch set. Those 4 patches do in fact solve the problem we =

were seeing.

- Bryan



--=_alternative 0050B24385258551_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="US-ASCII"

<tt><span style=3D" font-size:10pt">Vladimir Sementsov-Ogievskiy &lt;vsemen=
tsov@virtuozzo.com&gt;
wrote on 04/20/2020 11:04:33 AM:<br><br>&gt; Yes, the problem is that copy=
=5Frange subsystem handles block-status,
<br>&gt; when generic backup copying loop doesn't. I'm not sure that adding
<br>&gt; fallback into copy-range is a correct thing to do, at least it <br=
>&gt; should be optional, enabled by flag.. But you don't need it for your
problem,<br>&gt; as it is already fixed upstream:<br>&gt; <br>&gt; You need=
 to backport my commit 2d57511a88 &quot;block/block-copy:
use <br>&gt; block=5Fstatus&quot; (together with 3 preparing patches before=
 it, or
with <br>&gt; the whole series (including some refactoring after the 2d5751=
1 commit)<br></span></tt><br><tt><span style=3D" font-size:10pt">Vladimir, =
thanks for the pointer
to the &quot;block/block-copy: use block=5Fstatus&quot; patch set. Those
4 patches do in fact solve the problem we were seeing.</span></tt><br><br><=
tt><span style=3D" font-size:10pt">- Bryan</span></tt><br><BR>

--=_alternative 0050B24385258551_=--


