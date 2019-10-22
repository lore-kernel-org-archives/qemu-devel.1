Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A4B2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A4B2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMvG8-0003KB-Fu
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMuTI-0002AU-Hs
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMuTH-0006jk-ES
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:45:12 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:36756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMuTH-0006hX-8c
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:45:11 -0400
Received: from player793.ha.ovh.net (unknown [10.108.35.95])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8CE101AF91E
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 15:45:09 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 3F6CCB3EB508;
 Tue, 22 Oct 2019 13:45:04 +0000 (UTC)
Subject: Re: [PATCH v4 0/6] ppc: reset the interrupt presenter from the CPU
 reset handler
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191022134254.28692-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <520f6c05-c323-4633-863a-9642e8f81960@kaod.org>
Date: Tue, 22 Oct 2019 15:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022134254.28692-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 568860930691599139
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.53.149
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/2019 15:42, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> On the sPAPR machine and PowerNV machine, the interrupt presenters are
> created by a machine handler at the core level and are reseted
> independently. This is not consistent and it raises issues when it
> comes to handle hot-plugged CPUs. In that case, the presenters are not
> reseted. This is less of an issue in XICS, although a zero MFFR could
> be a concern, but in XIVE, the OS CAM line is not set and this breaks
> the presenting algorithm. The current code has workarounds which need
> a global cleanup.
>=20
> Extend the sPAPR IRQ backend and the PowerNV Chip class with a new
> cpu_intc_reset() handler called by the CPU reset handler and remove
> the XiveTCTX reset handler which is now redundant.
>=20
> Set the OS CAM line when the interrupt presenter of the sPAPR core is
> reseted. This will also cover the case of hot-plugged CPUs.

This series is missing one patch. It needs a resend.

C.

