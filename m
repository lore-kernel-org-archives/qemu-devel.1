Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B0DC2D0EB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9461D206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zmk8jwjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9461D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIrXO-0004Ac-MV
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jIrWc-0003XS-UV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jIrWa-0007qr-Tu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:20:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jIrWa-0007pt-Jq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585563607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6E/dAk2RnlJp9AQMbHdDVYq/j7w3RXnkQoUbm2tREo=;
 b=Zmk8jwjcPKF1a0hTgML3NWgBD9JLovyeXMbO1tM4bwEBs9bhV/WoWwnoH5OT0M9asK3HHl
 fFZZ1NO32R+/qLLyLGCIJhfcHAANVsvXrwIWSLkeZjOxG01PuBt1s9W1LUzZfhwYf74q3f
 6An2hUezt9/3ibm9Fb21z2+WH1dLsMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-YRVcN6SzOI-iXKPBNOz4nw-1; Mon, 30 Mar 2020 06:20:05 -0400
X-MC-Unique: YRVcN6SzOI-iXKPBNOz4nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E5F1005509;
 Mon, 30 Mar 2020 10:20:03 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CDF61001925;
 Mon, 30 Mar 2020 10:19:57 +0000 (UTC)
Date: Mon, 30 Mar 2020 12:19:55 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 06/13] arm/arm64: ITS: Introspection
 tests
Message-ID: <20200330101955.2rlksuzkkvopk52t@kamzik.brq.redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-7-eric.auger@redhat.com>
 <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
 <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
 <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
 <7d6dc4e7-82b4-3c54-574f-2149d4a85c48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7d6dc4e7-82b4-3c54-574f-2149d4a85c48@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, Zenghui Yu <yuzenghui@huawei.com>,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 11:56:00AM +0200, Auger Eric wrote:
> Hi,
>=20
> On 3/30/20 11:11 AM, Andrew Jones wrote:
> > On Mon, Mar 30, 2020 at 10:46:57AM +0200, Auger Eric wrote:
> >> Hi Zenghui,
> >>
> >> On 3/30/20 10:30 AM, Zenghui Yu wrote:
> >>> Hi Eric,
> >>>
> >>> On 2020/3/20 17:24, Eric Auger wrote:
> >>>> +static void its_cmd_queue_init(void)
> >>>> +{
> >>>> +=A0=A0=A0 unsigned long order =3D get_order(SZ_64K >> PAGE_SHIFT)=
;
> >>>> +=A0=A0=A0 u64 cbaser;
> >>>> +
> >>>> +=A0=A0=A0 its_data.cmd_base =3D (void *)virt_to_phys(alloc_pages(=
order));
> >>>
> >>> Shouldn't the cmd_base (and the cmd_write) be set as a GVA?
> >> yes it should
> >=20
> > If it's supposed to be a virtual address, when why do the virt_to_phy=
s?
> What is programmed in CBASER register is a physical address. So the
> virt_to_phys() is relevant. The inconsistency is in its_allocate_entry(=
)
> introduced later on where I return the physical address instead of the
> virtual address. I will fix that.
>=20
>=20
> >=20
> >>>
> >>> Otherwise I think we will end-up with memory corruption when writin=
g
> >>> the command queue.=A0 But it seems that everything just works fine =
...
> >>> So I'm really confused here :-/
> >> I was told by Paolo that the VA/PA memory map is flat in kvmunit tes=
t.
> >=20
> > What does flat mean?
>=20
> Yes I meant an identity map.
>=20
>  kvm-unit-tests, at least arm/arm64, does prepare
> > an identity map of all physical memory, which explains why the above
> > is working.
>=20
> should be the same on x86

Maybe, but I didn't write or review how x86 does their default map, so I
don't know.

>=20
>  It's doing virt_to_phys(some-virt-addr), which gets a
> > phys addr, but when the ITS uses it as a virt addr it works because
> > we *also* have a virt addr =3D=3D phys addr mapping in the default pa=
ge
> > table, which is named "idmap" for good reason.
> >=20
> > I think it would be better to test with the non-identity mapped addre=
sses
> > though.
>=20
> is there any way to exercise a non idmap?

You could create your own map and then switch to it. See lib/arm/asm/mmu-=
api.h

But, you don't have to switch the whole map to use non-identity mapped
addresses. Just create new virt mappings to the phys addresses you're
interested in, and then use those new virt addresses instead. If you're
worried that somewhere an identity mapped virt address is getting used
because of a phys/virt address mix up, then you could probably sprinkle
some assert(virt_to_phys(addr) !=3D addr)'s around to ensure it.

Thanks,
drew

>=20
> Thanks
>=20
> Eric
> >=20
> > Thanks,
> > drew
> >=20
> >>
> >>>
> >>>> +
> >>>> +=A0=A0=A0 cbaser =3D ((u64)its_data.cmd_base | (SZ_64K / SZ_4K - =
1)=A0=A0=A0 |
> >>>> GITS_CBASER_VALID);
> >>>> +
> >>>> +=A0=A0=A0 writeq(cbaser, its_data.base + GITS_CBASER);
> >>>> +
> >>>> +=A0=A0=A0 its_data.cmd_write =3D its_data.cmd_base;
> >>>> +=A0=A0=A0 writeq(0, its_data.base + GITS_CWRITER);
> >>>> +}
> >>>
> >>> Otherwise this looks good,
> >>> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> >> Thanks!
> >>
> >> Eric
> >>>
> >>>
> >>> Thanks
> >>>
> >>
> >>
>=20
>=20


