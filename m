Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B5ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F9021D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F9021D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLE8O-0001XJ-Dm
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iLE7j-0000zc-HZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iLE7i-0006xc-8a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:19:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iLE7h-0006wz-47; Thu, 17 Oct 2019 18:19:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9HMHiX8127610; Thu, 17 Oct 2019 18:19:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vq0hkgwt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 18:19:54 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9HMHhTL127576;
 Thu, 17 Oct 2019 18:19:54 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vq0hkgwsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 18:19:53 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HMFbSw013653;
 Thu, 17 Oct 2019 22:19:52 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02wdc.us.ibm.com with ESMTP id 2vq0bqr8fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 22:19:52 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9HMJqZl40763820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2019 22:19:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6955FB20A3;
 Thu, 17 Oct 2019 22:19:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D580B209E;
 Thu, 17 Oct 2019 22:19:52 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2019 22:19:52 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <8117fa49-f0d8-c4ed-f992-95bc04051442@redhat.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
 <78c46a05-76eb-ccec-df4d-103bee7c2760@redhat.com>
 <157063064956.3717.12528742598919174752@sif>
 <8117fa49-f0d8-c4ed-f992-95bc04051442@redhat.com>
Message-ID: <157135078759.15348.487787048799987873@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/97] Patch Round-up for stable 4.0.1,
 freeze on 2019-10-10
Date: Thu, 17 Oct 2019 17:19:47 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170194
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Philippe Mathieu-Daud=C3=A9 (2019-10-09 09:23:22)
> On 10/9/19 4:17 PM, Michael Roth wrote:
> > Quoting Philippe Mathieu-Daud=C3=A9 (2019-10-08 08:04:52)
> >> Hi Michael,
> >>
> >> On 10/2/19 1:44 AM, Michael Roth wrote:
> >>> Hi everyone,
> >>>
> >>> The following new patches are queued for QEMU stable v4.0.1:
> >>>
> >>>     https://github.com/mdroth/qemu/commits/stable-4.0-staging
> >>>
> >>> The release is planned for 2019-10-17:
> >>>
> >>>     https://wiki.qemu.org/Planning/4.0
> >>>
> >>> Please respond here or CC qemu-stable@nongnu.org on any patches you
> >>> think should be included in the release.
> >>
> >> Since it is a "release", these probably fit:
> >>
> >> commit 45c61c6c23918e3b05ed9ecac5b2328ebae5f774
> >> Author: Michael Roth <mdroth@linux.vnet.ibm.com>
> >> Date:   Thu Sep 12 18:12:01 2019 -0500
> >>
> >>       make-release: pull in edk2 submodules so we can build it from ta=
rballs
> >>
> >> commit f3e330e3c319160ac04954399b5a10afc965098c
> >> Author: Michael Roth <mdroth@linux.vnet.ibm.com>
> >> Date:   Thu Sep 12 18:12:02 2019 -0500
> >>
> >>       roms/Makefile.edk2: don't pull in submodules when building from =
tarball
> >>
> >> When is the next qemu-stable release scheduled? Do we care about Pytho=
n2
> >> use for this one?
> > =

> > 4.1.1, likely early November during 4.2 hard-freeze. I think Python2 is=
 okay
> > since presumably downstreams would've crossed that bridge with 4.1.0, a=
ssuming
> > you're thinking of the changes in your recent edk2 pull.
> =

> Yes.
> =

> Do you mind adding these dates to https://wiki.qemu.org/Planning/4.1?

Sure, I've set the freeze date for November 18th, and the release for
the 21st.

> =

> Thanks,
> =

> Phil.
>=20

