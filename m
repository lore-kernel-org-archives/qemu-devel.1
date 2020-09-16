Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E218DC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A0C20809
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISxyJgoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0C20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITw1-0004MG-Dq
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kITv6-0003oK-9T
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kITv3-0007Ew-La
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5YHReJg9ruLQPhx8Wm1nqEp9LLfabGow8aKg/1oCrcE=;
 b=ISxyJgoWhhl8IhKuNRs9X4gDCxf327DiHFyDvmN2bRlsf8EL5dZBWWqpa8RThsxKsa5HSR
 jxywiGrc8VxcMkejMHhyQbKOkSaX/zL6jrA6pnEYmpHa0byvCbR75IjGLmcWIlVA0kVdxT
 hWi6tqmmYWu79Zsr+On2Rh0iRK8I3Hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-PdneZ8RkOUm1jRq31pT6Bg-1; Wed, 16 Sep 2020 05:40:00 -0400
X-MC-Unique: PdneZ8RkOUm1jRq31pT6Bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F22CD05F;
 Wed, 16 Sep 2020 09:39:56 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7134968D63;
 Wed, 16 Sep 2020 09:39:55 +0000 (UTC)
Date: Wed, 16 Sep 2020 10:39:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/3] nvdimm: honor -object memory-backend-file,
 readonly=on option
Message-ID: <20200916093954.GB749356@stefanha-x1.localdomain>
References: <20200804101244.1283503-1-stefanha@redhat.com>
 <20200804101244.1283503-4-stefanha@redhat.com>
 <db6f0cae-88ee-fba0-2d2c-82255f52e7f6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <db6f0cae-88ee-fba0-2d2c-82255f52e7f6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 03:03:50PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 8/4/20 12:12 PM, Stefan Hajnoczi wrote:
> > Make it possible to present read-only files to the guest as "unarmed"
> > NVDIMMs. The Linux NVDIMM device (/dev/pmemX) is read-only.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  docs/nvdimm.txt | 8 +++++++-
> >  hw/mem/nvdimm.c | 4 ++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > index c2c6e441b3..c0b52de111 100644
> > --- a/docs/nvdimm.txt
> > +++ b/docs/nvdimm.txt
> > @@ -17,7 +17,7 @@ following command line options:
> > =20
> >   -machine pc,nvdimm
> >   -m $RAM_SIZE,slots=3D$N,maxmem=3D$MAX_SIZE
> > - -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3D$PATH,siz=
e=3D$NVDIMM_SIZE
> > + -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3D$PATH,siz=
e=3D$NVDIMM_SIZE,readonly=3Doff
> >   -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1
> > =20
> >  Where,
> > @@ -42,6 +42,12 @@ Where,
> >     "share=3Doff", then guest writes won't be applied to the backend
> >     file and thus will be invisible to other guests.
> > =20
> > +   "readonly=3Don/off" controls whether the the file $PATH is opened r=
ead-only or
>=20
> Double "the the".

Will fix.

> > diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> > index e1574bc07c..694223450e 100644
> > --- a/hw/mem/nvdimm.c
> > +++ b/hw/mem/nvdimm.c
> > @@ -151,6 +151,10 @@ static void nvdimm_prepare_memory_region(NVDIMMDev=
ice *nvdimm, Error **errp)
> >                               "nvdimm-memory", mr, 0, pmem_size);
> >      memory_region_set_nonvolatile(nvdimm->nvdimm_mr, true);
> >      nvdimm->nvdimm_mr->align =3D align;
> > +
> > +    if (memory_region_is_rom(mr)) {
> > +        nvdimm->unarmed =3D true; /* this device is read-only */
> > +    }
>=20
> Can you move this hunk before the alias creation?
> (Just before nvdimm->nvdimm_mr =3D ...).

Will fix.

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h3WoACgkQnKSrs4Gr
c8gb7ggAqkYALCALUBNdThQO8k8pF+5vrmVRhoZNFDuzwKgF8eyxUFZYpbLUuwG7
l6JNf4bq/Vl5ezcrOmqDfcwCL0AR5Zy+/0I9DhtQ6WkPbdfMFJQW/qPxNmi0EXYj
J2QdwxeUz0WEJNBJTqotBE+K46S2RTnR4f6CmMbZhzExJ6uWvKK9y7AwmT4agw55
Ya/hovmOUf8VmU4d/NgrBGUXXo2ReinH65lmRt6Y/J4Qm4t37Eo+Q5BHOZQEqnF8
mtM5aiaOm5qsOJW8IMJaYCEpbTvGK6uACMwZ2+i1bSIUAupWS1XBPl/NHejGgu89
2UgIR0yS5vVgeBw8okKG24gvfODULA==
=FZnS
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--


