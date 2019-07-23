Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02ABC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D8F2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D8F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpzty-0005jh-GB
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 14:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpzth-0004mC-8Z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpztg-0006hT-5z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:52:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpztf-0006gp-U4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:52:24 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NIqHpk031093
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 14:52:22 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60rmey3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 14:52:22 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 19:52:18 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 19:52:15 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NIqFgA33095956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 18:52:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CACD124052;
 Tue, 23 Jul 2019 18:52:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3ED5124053;
 Tue, 23 Jul 2019 18:52:14 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 18:52:14 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAL1e-=hp2dAkCki=sewqvMTkFTL_XoChyKOgiWur_q1f4YHAFg@mail.gmail.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
 <CAL1e-=hp2dAkCki=sewqvMTkFTL_XoChyKOgiWur_q1f4YHAFg@mail.gmail.com>
User-Agent: alot/0.7
Date: Tue, 23 Jul 2019 13:52:05 -0500
X-TM-AS-GCONF: 00
x-cbid: 19072318-2213-0000-0000-000003B4C9D6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011483; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236412; UDB=6.00651660; IPR=6.01017768; 
 MB=3.00027857; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 18:52:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072318-2214-0000-0000-00005F5BF434
Message-Id: <156390792554.16169.8175627986302359952@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230190
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH 00/36] Patch Round-up for stable 3.1.1,
 freeze on 2019-07-29
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Aleksandar Markovic (2019-07-23 12:12:27)
> On Tue, Jul 23, 2019 at 7:04 PM Michael Roth <mdroth@linux.vnet.ibm.com>
> wrote:
> =

> > Hi everyone,
> >
> >
> > The following new patches are queued for QEMU stable v3.1.1:
> >
> >   https://github.com/mdroth/qemu/commits/stable-3.1-staging
> >
> >
> Hello, Michael.
> =

> There is usually a breakdown by modified files within a cover letter.
> =

> Why is it not present here?

Sorry meant to include it before hitting send. I've just sent it as a reply.

> =

> Sincerely,
> Aleksandar
> =

> =

> =

> > The release is planned for 2019-08-01:
> >
> >   https://wiki.qemu.org/Planning/3.1
> >
> > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > think should be included in the release.
> >
> > Note that this update falls outside the normal stable release support
> > window (~1 development cycle), but is being released now since it was
> > delayed from its intended release date.
> >
> > Thanks!
> >
> >
> >
> >
>=20


