Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D07AC43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 11:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AF820675
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 11:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="474zLfzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AF820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hee2G-0004wP-Tq
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 07:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hee15-0004SG-JB
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 07:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hee14-0004gh-AT
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 07:17:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hee14-0004eh-0z
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 07:17:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5MBEGZI168501;
 Sat, 22 Jun 2019 11:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=/EaBAgTMLjmBUpoQgq+GiCeS477LmWIwq5biAbeeR34=;
 b=474zLfzlE16ebCrDEjmXBgwJQLqAeUdxtVvD/pXNGeS5d5NE4Usgx0pr8HgxqAIsTPb6
 +L+4lk2iwdUvMKjSQLBfmw1wAkBgIuoVP28B5/VZ7AgQEXWzX0OMJxI6N9G8kzc4Ai/g
 tqhoQ0urTlBFb6XMX6SGoJ+vYFgzxd0abfHgA4RT0S11Sgv98yogLsMMPIdiGF1E9OSZ
 zy/QnDHdC+w9q2m4lUNAlFIFPjoWBPl7qf5jlXA6XLX31RlF3IJOT78puysaHn89Gf5H
 /b34zB6ZDccI7UuuFhNiX+tqmzUT4XsD/PTSAh+W0orJGxem2UDImqZAoS3mH/f4vHcd Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t9c9p8r1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 11:17:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5MBGfGJ150335;
 Sat, 22 Jun 2019 11:17:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2t9c523fr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Jun 2019 11:17:01 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5MBH1Md016903;
 Sat, 22 Jun 2019 11:17:01 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 22 Jun 2019 11:17:01 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <156117114996.4070.7484891206134271759@ce79690b2cb9>
Date: Sat, 22 Jun 2019 14:16:58 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <90A73F18-6CC2-48CB-AADB-77883ABF6F04@oracle.com>
References: <156117114996.4070.7484891206134271759@ce79690b2cb9>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH 0/2] target/i386: kvm: Fix treatment of AMD
 SVM in nested migration
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, maran.wilson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 22 Jun 2019, at 5:39, no-reply@patchew.org wrote:
>=20
> Patchew URL: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchew.org_QEMU_20=
190621213712.16222-2D1-2Dliran.alon-40oracle.com_&d=3DDwIGaQ&c=3DRoP1YumCX=
CgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXP=
NGZbpTx0&m=3DXheZ4_IReq-ruli16BfJeGb3_F7yec8LhFweZ5i6zf8&s=3DZYZOCSnRRy8FB=
DWmZ7sm21_IHQoZJHKXDo6_GHyY6xo&e=3D
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20
> Subject: [Qemu-devel] [PATCH 0/2] target/i386: kvm: Fix treatment of =
AMD SVM in nested migration
> Type: series
> Message-id: 20190621213712.16222-1-liran.alon@oracle.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> =46rom =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_patchew-=
2Dproject_qemu&d=3DDwIGaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&=
r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DXheZ4_IReq-ruli16BfJeG=
b3_F7yec8LhFweZ5i6zf8&s=3DQFR1iC1wuS3a7nr5wT0nl1N49SaJCGcwFH_g0Uv7FrU&e=3D=

> * [new tag]               =
patchew/20190621213712.16222-1-liran.alon@oracle.com -> =
patchew/20190621213712.16222-1-liran.alon@oracle.com
> Switched to a new branch 'test'
> a5de9408a8 target/i386: kvm: Init nested-state in case of vCPU exposed =
with SVM
> 06ca99d907 target/i386: kvm: Block migration on vCPU exposed with SVM =
when kernel lacks caps to save/restore nested state
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/2 Checking commit 06ca99d907bc (target/i386: kvm: Block migration on =
vCPU exposed with SVM when kernel lacks caps to save/restore nested =
state)
> ERROR: return is not a function, parentheses are not required
> #46: FILE: target/i386/cpu.h:1877:
> +    return (cpu_has_vmx(env) || cpu_has_svm(env));
>=20
> total: 1 errors, 0 warnings, 32 lines checked
>=20
> Patch 1/2 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 2/2 Checking commit a5de9408a89a (target/i386: kvm: Init nested-state =
in case of vCPU exposed with SVM)
> =3D=3D=3D OUTPUT END =3D=3D=3D

I kinda disagree that adding parentheses at return statements is a bad =
thing=E2=80=A6
Why do we enforce such a coding convention?

Anyway, I think this can be fixed when applying if we decide to apply =
this.

-Liran


