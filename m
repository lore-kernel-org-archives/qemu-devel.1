Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8CCC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D0F20748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D0F20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZJXA-0007tw-Ki
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msuchanek@suse.de>) id 1iZJW4-0007Ns-EV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msuchanek@suse.de>) id 1iZJW3-0003UI-9o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:55:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39090 helo=mx1.suse.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1iZJW2-0003SM-Rz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:55:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id F1539AB87;
 Mon, 25 Nov 2019 18:55:12 +0000 (UTC)
Date: Mon, 25 Nov 2019 19:55:11 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: karina filer <kafiler0911@gmail.com>
Subject: Re: QEMU Licensing query
Message-ID: <20191125185511.GW11661@kitsune.suse.cz>
References: <CAM+cExHMQQTxOHT7vmWNDTpGcoJZAbt-T=X+4WZBRwNzvFYqeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAM+cExHMQQTxOHT7vmWNDTpGcoJZAbt-T=X+4WZBRwNzvFYqeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 195.135.220.15
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Fri, Nov 22, 2019 at 03:57:07PM +0530, karina filer wrote:
> Hi All,
>=20
> [1]QEMU is used in Android Emulator and is licensed under [2]GPLv2.
>=20
> For one of our customer support we may have to modify QEMU.
>=20
> =A0I have below queries,
>=20
>   * Case 1: No modification in QEMU (QEMU delivered by Google)
>=20
> Is there any implications if we are not modifying and releasing QEMU
> externally, but we are sharing an Android image externally that runs on=
 QEMU
>=20
> =A0
>=20
>   * Case 2: Modification in QEMU (QEMU delivered by Google)
>=20
> What are the implications if we need to modify and release QEMU, consid=
ering
> that we will also have to release an Android image that will run on thi=
s
> QEMU.

First off, this is a question that you should ask your lawyer, not a
mailing list.

As far as GPL v2 obligations go you should provide the source to anybody
to whom you distribute binaries of a GPL v2 software.

The preferred way to provide the source is alongside the binary package.
However, if you use Google Play store this is not reasonable way of
distribution. I would suggest you provide a link in the application
description pointing to a website where users can download the sources.

Thanks

Michal

