Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB457C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9CA22207
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV/csIGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9CA22207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIToB-00087T-6e
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kITmz-0007CM-Ey
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kITmw-0005yI-5I
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600248701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8vvkpVgpzaDYW0Wo5Ffo+8XI26dpu/TsIF2OJSrbr9Y=;
 b=aV/csIGNt0ZfaD+0ce6jXGnQzg1Gzsabqgdth30Th8AwnueBCv1nT0F9fa2VRlCU9Mh4w4
 pZmuAfzOCLFLpz2puxPivwxo9NGuIB+AP4YyqaMXVH5WG0ipQsyG9S6TkFsx7t8Lkz4+fG
 leklDZliLdQXpIg49CEey32VK+n4Row=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-8yrhlIGDMoGmfHfTJCpICQ-1; Wed, 16 Sep 2020 05:31:38 -0400
X-MC-Unique: 8yrhlIGDMoGmfHfTJCpICQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A480718B9F83;
 Wed, 16 Sep 2020 09:31:37 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D71360BFA;
 Wed, 16 Sep 2020 09:31:34 +0000 (UTC)
Date: Wed, 16 Sep 2020 10:31:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/3] hostmem-file: add readonly=on|off option
Message-ID: <20200916093133.GA749356@stefanha-x1.localdomain>
References: <20200804101244.1283503-1-stefanha@redhat.com>
 <20200804101244.1283503-3-stefanha@redhat.com>
 <8f7b344e-87a5-3260-ae71-96758270fb27@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8f7b344e-87a5-3260-ae71-96758270fb27@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
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
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 02:50:42PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 8/4/20 12:12 PM, Stefan Hajnoczi wrote:
> > Let -object memory-backend-file work on read-only files when the
> > readonly=3Don option is given. This can be used to share the contents o=
f a
> > file between multiple guests while preventing them from consuming
> > Copy-on-Write memory if guests dirty the pages, for example.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  backends/hostmem-file.c | 26 +++++++++++++++++++++++++-
> >  qemu-options.hx         |  5 ++++-
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 37c70acfe2..6bd5bf9b91 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -30,6 +30,7 @@ struct HostMemoryBackendFile {
> >      uint64_t align;
> >      bool discard_data;
> >      bool is_pmem;
> > +    bool readonly;
> >  };
> > =20
> >  static void
> > @@ -57,7 +58,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
> >                                       backend->size, fb->align,
> >                                       (backend->share ? RAM_SHARED : 0)=
 |
> >                                       (fb->is_pmem ? RAM_PMEM : 0),
> > -                                     fb->mem_path, false, errp);
> > +                                     fb->mem_path, fb->readonly, errp)=
;
> >      g_free(name);
> >  #endif
> >  }
> > @@ -152,6 +153,26 @@ static void file_memory_backend_set_pmem(Object *o=
, bool value, Error **errp)
> >      fb->is_pmem =3D value;
> >  }
> > =20
> > +static bool file_memory_backend_get_readonly(Object *o, Error **errp)
> > +{
> > +    return MEMORY_BACKEND_FILE(o)->readonly;
> > +}
> > +
> > +static void file_memory_backend_set_readonly(Object *o, bool value,
> > +                                             Error **errp)
> > +{
> > +    HostMemoryBackend *backend =3D MEMORY_BACKEND(o);
> > +    HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(o);
> > +
> > +    if (host_memory_backend_mr_inited(backend)) {
> > +        error_setg(errp, "cannot change property 'readonly' of %s.",
> > +                   object_get_typename(o));
>=20
>=20
> The 'host_memory_backend_mr_inited()' function is not documented;
> my understanding is a backend is considered initialized once it has
> a MemoryRegion assigned to it.
>=20
> So this error message is not very helpful, it doesn't explain the
> reason. I see all other setters in this file use the same error,
> so it is almost a predating issue.
>=20
> Still I'd rather use a different message, something like:
> "'%s' already initialized, can not set it 'readonly'".
>=20
> Preferably with the error message reworded:
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

I haven't reworded the error message because it's used in
hostmem-file.c, hostmem-memfd.c, and hostmem.c. A separate patch would
need to change the error messages across these files.

There is no time when users can actually change these QOM properties, so
"cannot change FOO" is a reasonable wording form the user perspective.
Telling the user that there is a pre-initialization state when the
property can be change isn't useful because they cannot observe that
state (the object is created and ->complete is called in a single step).

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h23UACgkQnKSrs4Gr
c8hnzAgAoviaWFUC5tjwGMLvaqvV3Iro2uYFSIIPutdc+nEvREG5ogEbt/MKCsnP
h06wVkTcm4UXym9y76yxlsH89sVJov2uj/sjYnUQCgZdQnB6ZMhXa9qTyVLjgIhX
DfztbCCIBpMjHP3Sa6Plk+UxyGGiHg5dbgQGRBiTGShR0rfK+jWNXn92wzdHh2Nc
WYP0U+wcnqEo2Z2u+utCxAue9KTU5f+mhJffg+5W7jWVZGHdIfgwZl3AJdNB9Lhq
Ga1DoVs2BgYjDJYXP6p4rSLNs9GCAud1sT17PO7D1Mw1JaynldrCyn08vCxsNgu8
SvP78H14J5RZJFoF0spKymHwJR4grQ==
=YpW4
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


