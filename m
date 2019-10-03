Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5742C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 18:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE26F20862
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 18:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE26F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG6Ir-0005EN-RH
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 14:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iG6Hk-0004Sl-7k
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 14:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iG6Hi-0002sG-Tp
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 14:57:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6648
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iG6Hh-0002rS-Pt; Thu, 03 Oct 2019 14:57:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x93IqU5m058539; Thu, 3 Oct 2019 14:56:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vdmgqvwq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2019 14:56:55 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x93IqXjM059011;
 Thu, 3 Oct 2019 14:56:55 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vdmgqvwpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2019 14:56:55 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x93ItuSG024822;
 Thu, 3 Oct 2019 18:56:54 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02dal.us.ibm.com with ESMTP id 2v9y58a5hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2019 18:56:54 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x93IurNU26673454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Oct 2019 18:56:53 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2D002805C;
 Thu,  3 Oct 2019 18:56:53 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84CAC28059;
 Thu,  3 Oct 2019 18:56:53 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  3 Oct 2019 18:56:53 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <a9231694-e38b-8bf8-6d97-68c4593bbbfb@redhat.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
 <a9231694-e38b-8bf8-6d97-68c4593bbbfb@redhat.com>
Message-ID: <157012900887.11473.13354215633405542907@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/97] Patch Round-up for stable 4.0.1,
 freeze on 2019-10-10
Date: Thu, 03 Oct 2019 13:56:48 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-03_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=997 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030155
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
Cc: Michal Privoznik <mprivozn@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Thomas Huth (2019-10-01 23:40:49)
> On 02/10/2019 01.44, Michael Roth wrote:
> > Hi everyone,                                                           =
                                   =

> > =

> > The following new patches are queued for QEMU stable v4.0.1:
> > =

> >   https://github.com/mdroth/qemu/commits/stable-4.0-staging
> > =

> > The release is planned for 2019-10-17:
> > =

> >   https://wiki.qemu.org/Planning/4.0
> > =

> > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > think should be included in the release.
> >
> Would it make sense to include the slirp update:
> =

>  e1a4a24d262ba5ac74ea1795adb3ab1cd574c7fb
>  "slirp: update with CVE-2019-14378 fix"

4.0 hadn't yet moved to using slirp submodule, but the following
patches are included here and should provide the equivalent fixes:

  slirp: ip_reass: Fix use after free
  slirp: Fix heap overflow in ip_reass on big packet input

> =

> ?
> =

> And maybe these commits:
> =

>  22235bb609c18547cf6b215bad1f9d2ec56ad371
>  "pc-dimm: fix crash when invalid slot number is used"
> =

>  95667c3be0c9f5fc62f58fe845879250f63f7d32
>  "nvme: Set number of queues later in nvme_init()"
> =

>  c0bccee9b40ec58c9d165b406ae3d4f63652ce53
>  "hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO"
> =

>  a09ef5040477643a7026703199d8781fe048d3a8
>  "hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO"

Applied, thanks!

> =

> Thomas
>=20

