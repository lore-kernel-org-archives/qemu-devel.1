Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B8C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C52206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C52206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvX1-0006sG-6U
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:46:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYvVv-0006IY-SK
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYvVu-0002qg-SA
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hYvVu-0002pd-NM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04BF330872CC;
	Thu,  6 Jun 2019 16:45:18 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B6CE1062244;
	Thu,  6 Jun 2019 16:45:12 +0000 (UTC)
Date: Thu, 6 Jun 2019 18:45:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190606184507.2c52cd41@redhat.com>
In-Reply-To: <02c9615a-fb59-664f-e878-124c9f43e54a@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-8-tao3.xu@intel.com>
	<20190604170456.5b3c198e@redhat.com>
	<729bde4a-bcb9-dac5-3a8a-04cc5f4d2bf9@intel.com>
	<20190605140841.63e8aa85@redhat.com>
	<02c9615a-fb59-664f-e878-124c9f43e54a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 06 Jun 2019 16:45:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hmat acpi: Build Memory Side
 Cache Information Structure(s) in ACPI HMAT
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
Cc: "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
	"mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rth@twiddle.net" <rth@twiddle.net>,
	"ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Jun 2019 11:00:33 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 6/5/2019 8:12 PM, Igor Mammedov wrote:
> > On Wed, 5 Jun 2019 14:04:10 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >  =20
> >> On 6/4/2019 11:04 PM, Igor Mammedov wrote: =20
> >>> On Wed,  8 May 2019 14:17:22 +0800
> >>> Tao Xu <tao3.xu@intel.com> wrote:
> >>>     =20
> ...
> >>>> +
> >>>> +                /* SMBIOS Handles */
> >>>> +                /* TBD: set smbios handles */
> >>>> +                build_append_int_noprefix(table_data, 0, 2 * n); =20
> >>> Is memory side cache structure useful at all without pointing to SMBI=
OS entries?
> >>>     =20
> >> They are not useful yet, and the kernel 5.1 HMAT sysfs doesn't show
> >> SMBIOS entries. We can update it if it useful in the future. =20
> >=20
> > In that case I'd suggest to drop it for now until this table is properly
> > populated and ready for consumption. (i.e. drop this patch and correspo=
nding
> > CLI 9/11 patch).
> >  =20
>=20
> But the kernel HMAT can read othe Memory Side Cache Information except=20
> SMBIOS entries and the host HMAT tables also haven=E2=80=99t SMBIOS Handl=
es it=20
> also shows Number of SMBIOS handles (n) as 0. So I am wondering if it is=
=20
> better to setting "SMBIOS handles (n)" as 0, remove TODO and comment the=
=20
> reason why set it 0?

My understanding is that SMBIOS handles are used to associate side cache
descriptions with RAM pointed by SMBIOS handles, so that OS would be
able to figure out what RAM modules are cached by what cache.
Hence I suspect that side cache table is useless in the best case without
valid references to SMBIOS handles.
(I might be totally mistaken but the matter requires clarification before
we commit to it)

