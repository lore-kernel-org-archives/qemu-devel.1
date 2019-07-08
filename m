Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40380C606CF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CB32171F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Py/pm6Jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CB32171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkc6A-0004Ui-9F
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 18:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hkc5N-0003qr-1c
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hkc5L-00072H-Tu
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:26:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hkc5L-000712-KS
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:26:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68MJw6X007812;
 Mon, 8 Jul 2019 22:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=Ot7+YKDleZIfEW5l8dXnyNNeTcEMUMBllDJlLoXCH+g=;
 b=Py/pm6JbDLY+p/pu18m33hHbQaAf2fAaLq5c12iiS+HVDenCaIrO218WYvUJN8fBs8pZ
 p4U/Q8/LrYnLnN3cVVY6BRFP2BbY9PiH9ND3NDHiYKZzZAMHH3CAmhRDJmWj+g/OdTY9
 SpC9xDiNtTD7cqJwEbxPW5aUtVwMTSBdqCbntF+oMowwdBOBs80A6ZFImbvSqNs633o8
 tXUxzGbMIVoAuqlL18UeULTWmliDpnFiTh0NVfoRrGxR9ikkwqDMptXLP/Mw3z8DzSwT
 OovxCcaDECIOurYBkj5gDVdPWVKJwDCwSM1ni/+Tl4FOQesyA/ovMaCDkvJnvCJ1oO2m 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2tjm9qgx0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2019 22:26:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68MHiij050202;
 Mon, 8 Jul 2019 22:26:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2tjgrtrgfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2019 22:26:07 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x68MQ6r1019005;
 Mon, 8 Jul 2019 22:26:06 GMT
Received: from [192.168.14.112] (/109.66.236.176)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 08 Jul 2019 15:26:06 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <a63806a8-995a-82de-a74b-a8e791073f3d@siemens.com>
Date: Tue, 9 Jul 2019 01:26:03 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <80B9E0EE-275B-412C-93C0-54DD7038B5ED@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-18-git-send-email-pbonzini@redhat.com>
 <a63806a8-995a-82de-a74b-a8e791073f3d@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080276
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080276
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PULL 17/25] target/i386: kvm: Block migration for
 vCPUs exposed with nested virtualization
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 8 Jul 2019, at 21:21, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>=20
> On 21.06.19 13:30, Paolo Bonzini wrote:
>> From: Liran Alon <liran.alon@oracle.com>
>=20
> This broke bisection (which I currently have to do because this pull =
manages to
> lock up 5.1 host kernels): cpu_has_nested_virt will only come later in =
this series.
>=20
> Jan
>=20

That=E2=80=99s correct Jan.
The original patch series I sent upstream didn=E2=80=99t had this =
problem. (See: =
https://patchwork.kernel.org/project/kvm/list/?series=3D135023)
But commit was changed during merge to upstream which mistakenly =
introduced compile errors to some of the commits.
As this is already merged, there is no way to fix it anymore. But this =
is just an honest innocent mistake.

-Liran


