Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EE3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01D12053B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw8KZv6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01D12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVd1Y-0002dY-V7
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iVd0p-00026T-Vn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iVd0n-0000Ih-8t
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:55:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27446
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iVd0n-0000II-5x
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573829748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rorQVHKK9jfAoq/OSb/+Jl9+t1z4hwT4nWpoleuD6s=;
 b=Hw8KZv6qo/ROgH2xZt1qFuS7bb1/a136O2wjh3mPFPUJFvtQBVuwvRoTcsPxTDPgR+WrIo
 7mNy5Rs+gqJNxgV79czheqR8Wy279raoESmllzBCMibmaZAgF6nHdVLmMW7xLozm6v9laS
 1mDiz87Ek0uXgMwwGIC+/SdWFTNWzFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-U1O2p4rXNzuo3glGwPq_PQ-1; Fri, 15 Nov 2019 09:55:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F2ED104FB65;
 Fri, 15 Nov 2019 14:55:42 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B67DD4645F;
 Fri, 15 Nov 2019 14:55:29 +0000 (UTC)
Date: Fri, 15 Nov 2019 15:55:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [RESEND PATCH v21 3/6] ACPI: Add APEI GHES table generation
 support
Message-ID: <20191115155527.287ee95b@redhat.com>
In-Reply-To: <19b1b4b9ceb24aad9f34ab4e58bccab3@huawei.com>
References: <19b1b4b9ceb24aad9f34ab4e58bccab3@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U1O2p4rXNzuo3glGwPq_PQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Wanghaibin \(D\)" <wanghaibin.wang@huawei.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "zhengxiang \(A\)" <zhengxiang9@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "james.morse@arm.com" <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 14:32:47 +0000
gengdongjiu <gengdongjiu@huawei.com> wrote:

> > > + */
> > > +static void acpi_ghes_build_notify(GArray *table, const uint8_t type=
) =20
> >=20
> > typically format should be build_WHAT(), so
> >  build_ghes_hw_error_notification()
> >=20
> > And I'd move this out into its own patch.
> > this applies to other trivial in-depended sub-tables, that take all dat=
a needed to construct them from supplied arguments. =20
>=20
> I very used your suggested method in previous series[1], but other mainta=
iner suggested to move this function to this file, because he think only GH=
ES used it

Using this file is ok, what I've meant for you to split function from
this patch into a separate smaller patch.

With the way code split now I have to review 2 big complex patches at
the same which makes reviewing hard and I have a hard time convincing
myself that code it correct.

Moving small self-contained chunks of code in to separate smaller patches
makes review easier.

>=20
> [1]:
> https://patchwork.ozlabs.org/cover/1099428/
>=20
> >  =20
> > > +{
> > > +        /* Type */
> > > +        build_append_int_noprefix(table, type, 1);
> > > +        /*
> > > +         * Length:
> > > +         * Total length of the structure in bytes
> > > +         */
> > > +        build_append_int_noprefix(table, 28, 1);
> > > +        /* Configuration Write Enable */
> > > +        build_append_int_noprefix(table, 0, 2);
> > > +        /* Poll Interval */
> > > +        build_append_int_noprefix(table, 0, 4);
> > > +        /* Vector */
> > > +        build_append_int_noprefix(table, 0, 4);
> > > +        /* Switch To Polling Threshold Value */
> > > +        build_append_int_noprefix(table, 0, 4);
> > > +        /* Switch To Polling Threshold Window */
> > > +        build_append_int_noprefix(table, 0, 4);
> > > +        /* Error Threshold Value */
> > > +        build_append_int_noprefix(table, 0, 4);
> > > +        /* Error Threshold Window */
> > > +        build_append_int_noprefix(table, 0, 4); }
> > > + =20
> >=20
> > /*
> >   Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fwcfg=
 blobs.
> >   See docs/specs/acpi_hest_ghes.rst for blobs format */ =20
> > > +void acpi_ghes_build_error_table(GArray *hardware_errors, BIOSLinker
> > > +*linker) =20
> > build_ghes_error_table()
> >=20
> > also I'd move this function into its own patch along with other related=
 code that initializes and wires it into virt board. =20
>=20
> I ever use your suggested method[1], but other maintainer, it seems Micha=
el, suggested to move these functions to this file that used it, because he=
 think only GHES used it.
>=20
> [1]:
> https://patchwork.ozlabs.org/patch/1099424/
> https://patchwork.ozlabs.org/patch/1099425/
> https://patchwork.ozlabs.org/patch/1099430/
>=20
>=20


