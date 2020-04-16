Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1711CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E174820771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E174820771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOxdv-00016Y-0T
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 02:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOxcl-00006t-2p
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOxck-0007Sk-5L
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:03:43 -0400
Received: from charlie.dont.surf ([128.199.63.193]:49930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOxci-0007QS-1m; Thu, 16 Apr 2020 02:03:40 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 4BD57BF470;
 Thu, 16 Apr 2020 06:03:34 +0000 (UTC)
Date: Thu, 16 Apr 2020 08:03:30 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 13/16] nvme: factor out namespace setup
Message-ID: <20200416060330.46nqnva2azi3yhev@apples.localdomain>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-14-its@irrelevant.dk>
 <b05fdbb7-2f74-be05-e108-36b14abce0be@redhat.com>
 <20200415132004.zei3gqxg5l6r5c6y@apples.localdomain>
 <075d6fbf-f4a0-fa71-f8c0-978b262b5d63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <075d6fbf-f4a0-fa71-f8c0-978b262b5d63@redhat.com>
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

On Apr 15 15:26, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/15/20 3:20 PM, Klaus Birkelund Jensen wrote:
> >=20
> > I'll get the v1.3 series ready next.
> >=20
>=20
> Cool. What really matters (to me) is seeing tests. If we can merge test=
s
> (without multiple namespaces) before the rest of your series, even bett=
er.
> Tests give reviewers/maintainers confidence that code isn't breaking ;)
>=20

The patches that I contribute have been pretty extensively tested by
various means in a "host setting" (e.g. blktests and some internal
tools), which really exercise the device by doing heavy I/O, testing for
compliance and also just being mean to it (e.g. tripping bus mastering
while doing I/O).

Don't misunderstand me as trying to weasel my way out of writing tests,
but I just want to understand the scope of the tests that you are
looking for? I believe (hope!) that you are not asking me to implement a
user-space NVMe driver in the test, so I assume the tests should varify
more low level details?

