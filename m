Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D97AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236EF206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236EF206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcLl-0002id-8p
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOcL3-0001kx-D6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOcL2-0000At-BB
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:20:01 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOcL0-00008k-4k; Wed, 15 Apr 2020 03:19:58 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 7ED3EBF603;
 Wed, 15 Apr 2020 07:19:56 +0000 (UTC)
Date: Wed, 15 Apr 2020 09:19:52 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 10/48] nvme: remove redundant cmbloc/cmbsz members
Message-ID: <20200415071952.cdrdjura6aj3j346@apples.localdomain>
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-11-its@irrelevant.dk>
 <62ec4481-a31d-d2cf-efb4-9107ae23bb76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62ec4481-a31d-d2cf-efb4-9107ae23bb76@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 15 09:10, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> "hw/block/nvme.h" should not pull in "block/nvme.h", both should includ=
e a
> common "hw/block/nvme_spec.h" (or better named). Not related to this pa=
tch
> although.
>=20

Hmm. It does pull in the "include/block/nvme.h" which is basically the
"nvme_spec.h" you are talking about. That file holds all spec related
structs that are shared between the VFIO based nvme driver
(block/nvme.c) and the emulated device (hw/block/nvme.c).

Isn't that what is intended?

