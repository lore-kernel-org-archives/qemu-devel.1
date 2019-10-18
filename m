Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF016CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E03222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E03222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPic-0000If-7S
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iLPhU-000888-EJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iLPhT-0002hp-EI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:41:40 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:43181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iLPhT-0002g7-2q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:41:39 -0400
Received: from player714.ha.ovh.net (unknown [10.108.54.217])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 38BDF13871C
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:41:35 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 14AEFB11AC18;
 Fri, 18 Oct 2019 10:41:31 +0000 (UTC)
Subject: Re: [PATCH 2/2] spapr/xive: Set the OS CAM line at reset
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191017144241.12522-1-clg@kaod.org>
 <20191017144241.12522-3-clg@kaod.org> <20191018035557.GC2000@umbus.fritz.box>
 <cacfb9a2-4bbf-54e6-a493-8b362e4789c0@kaod.org>
Message-ID: <ecf898f4-bfa6-9841-d847-6c061edf7d8c@kaod.org>
Date: Fri, 18 Oct 2019 12:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <cacfb9a2-4bbf-54e6-a493-8b362e4789c0@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 10871126552282368921
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeelgdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.39.218
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

On 18/10/2019 11:42, C=E9dric Le Goater wrote:
> On 18/10/2019 05:55, David Gibson wrote:
>> On Thu, Oct 17, 2019 at 04:42:41PM +0200, C=E9dric Le Goater wrote:
>>> When a Virtual Processor is scheduled to run on a HW thread, the
>>> hypervisor pushes its identifier in the OS CAM line. When running in
>>> TCG or kernel_irqchip=3Doff, QEMU needs to emulate the same behavior.
>>>
>>> Introduce a 'os-cam' property which will be used to set the OS CAM
>>> line at reset and remove the spapr_xive_set_tctx_os_cam() calls which
>>> are done when the XIVE interrupt controller are activated.
>>
>> I'm not immediately seeing the advantage of doing this via a property,
>> rather than poking it from the PAPR code which already knows the right
>> values.
>=20
> we can simplify by passing the OS CAM line value as a parameter of the=20
> xive_tctx_reset routine, as suggested by Greg.

and if we remove the reset handlers from XiveTCTX and rely only on the=20
CPU reset handler to reset the presenter.=20

C.

