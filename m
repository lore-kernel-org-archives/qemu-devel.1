Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8272BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1394720679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1394720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXIP-0002vz-0N
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMXGm-0001D7-9Q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMXGl-00074N-95
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:58:44 -0400
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:56325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMXGl-00073E-1i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:58:43 -0400
Received: from player771.ha.ovh.net (unknown [10.109.159.68])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 883591E69E3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 14:58:39 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 648A9B36EC99;
 Mon, 21 Oct 2019 12:58:35 +0000 (UTC)
Subject: Re: [PATCH 0/9] ppc/pnv: XIVE cleanup and fixes
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191007084102.29776-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <27d92b9d-87d7-7d74-c8dc-3acdce069a98@kaod.org>
Date: Mon, 21 Oct 2019 14:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007084102.29776-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12357595904197954457
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeehgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.54.31
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/2019 10:40, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> Here is a short series adding the cleanups and fixes of the bigger
> series "ppc/pnv: add XIVE support for KVM guests". There is still some
> rework to be done on the XivePresenter before it can be resent.
>=20
> These are valuable changes which can come first and which should not
> impact the work yet to come. Comments have been addressed. They were
> mostly on the changelog.

David, Do you have some time for these patches ? There are larger
series coming after.

Thanks,

C.
=20
> C=C3=A9dric Le Goater (9):
>   ppc/pnv: Improve trigger data definition
>   ppc/pnv: Use address_space_stq_be() when triggering an interrupt from
>     PSI
>   ppc/xive: Record the IPB in the associated NVT
>   ppc/xive: Introduce helpers for the NVT id
>   ppc/pnv: Remove pnv_xive_vst_size() routine
>   ppc/pnv: Dump the XIVE NVT table
>   ppc/pnv: Quiesce some XIVE errors
>   ppc/xive: Introduce OS CAM line helpers
>   ppc/xive: Check V bit in TM_PULL_POOL_CTX
>=20
>  include/hw/ppc/xive.h      |   5 --
>  include/hw/ppc/xive_regs.h |  50 ++++++++++-
>  hw/intc/pnv_xive.c         | 166 +++++++++++++++++++++----------------
>  hw/intc/xive.c             |  61 ++++++++++++--
>  hw/ppc/pnv_psi.c           |  15 +++-
>  5 files changed, 206 insertions(+), 91 deletions(-)
>=20


