Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F066C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506212146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506212146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7OX-0004KJ-K1
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:37:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hQ7NF-0003Ne-WB
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hQ7NE-0001ws-Sp
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hQ7NE-0001vM-Nf
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:35:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF2E53082B4D;
	Mon, 13 May 2019 09:35:55 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0BEEE60BEC;
	Mon, 13 May 2019 09:35:45 +0000 (UTC)
Date: Mon, 13 May 2019 11:35:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190513113540.07a450a7@Igors-MacBook-Pro>
In-Reply-To: <20190513110440.7b03eb0d@Igors-MacBook-Pro>
References: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
	<20190512141838-mutt-send-email-mst@kernel.org>
	<20190513110440.7b03eb0d@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 13 May 2019 09:35:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 01/15] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
	Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 11:04:40 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Sun, 12 May 2019 14:19:08 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Thu, May 02, 2019 at 04:51:49PM +0200, Igor Mammedov wrote:
> > > so name would reflect what the function does
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> > > ---
> > > v4:
> > >  * make it as the first patch in series
> > > ---
> >=20
> >=20
> > FYI this trips up git am.
> > Don't do two --- please: just one is enough,
> > second is not needed.
>=20
> strange, git am works for me just fine.
> I've always formated par patch comments this way and I think it's rather
> common approach on the list.
>=20
> What version of git do you use?
>=20
[...]
> (it doesn't apply to master anymore)
  never mind, it applies just fine (I've missed one patch when applying)

>=20
> >=20
> [...]
>=20
>=20


