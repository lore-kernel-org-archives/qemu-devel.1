Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E434BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD004206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDhaeSwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD004206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCmd-0006N6-0h
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqCkD-0003iL-KZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:40:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqCkB-0000aH-P1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7U1eDyaFVKc4xIgFDlBscwNxSL+RWJFQCOyDTR2WB4=;
 b=ZDhaeSwPxtrii0uyvck43/ByhaB083k72uqPcW13YVMn+4FsyB+Umv4j8EaYjgbYcrlPrr
 tG0HsrzhbkXlps8vTFZHwmVFXzcp9zZUPAiyKymvAGB2BnB7s/xEUsaj0iUB2KV3U1W+Hc
 3OMaNJgpGakkCEsPGVFanD78cwY/DOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-y03lNSTIOdaSg26QhIHJ1Q-1; Tue, 30 Jun 2020 05:39:56 -0400
X-MC-Unique: y03lNSTIOdaSg26QhIHJ1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 691B619067E6;
 Tue, 30 Jun 2020 09:39:55 +0000 (UTC)
Received: from gondolin (ovpn-113-12.ams2.redhat.com [10.36.113.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC64D60C81;
 Tue, 30 Jun 2020 09:39:44 +0000 (UTC)
Date: Tue, 30 Jun 2020 11:39:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
Message-ID: <20200630113932.484b3fde.cohuck@redhat.com>
In-Reply-To: <20200630090451.GE81930@stefanha-x1.localdomain>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
 <20200629125305.GH31392@stefanha-x1.localdomain>
 <20200629130716.GQ1298906@redhat.com>
 <20200630090451.GE81930@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/EdTKuiXSaLBVO8rGMFs_Bes";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/EdTKuiXSaLBVO8rGMFs_Bes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jun 2020 10:04:51 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Mon, Jun 29, 2020 at 02:07:16PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jun 29, 2020 at 01:53:05PM +0100, Stefan Hajnoczi wrote: =20
> > > On Thu, Jun 25, 2020 at 12:04:26PM +0200, Marc Hartmayer wrote: =20
> > > > This RFC is about enabling virtio-fs on s390x. For that we need
> > > >  + some shim code (first patch), and we need
> > > >  + libvhost-user to deal with virtio endiannes as mandated by the s=
pec.
> > > > =20
> > > > The second part is trickier, because unlike QEMU we are not certain
> > > > about the guest's native endianness, which is needed to handle the
> > > > legacy-interface appropriately. In fact, this is the reason why jus=
t
> > > > RFC.
> > > >=20
> > > > One of the open questions is whether to build separate versions, on=
e
> > > > for guest little endian and one for guest big endian, or do we want
> > > > something like a command line option? (Digression on the libvirt
> > > > modeling)
> > > >=20
> > > > A third option would be to refuse legacy altogether. =20
> > >=20
> > > I suggest the following:
> > >=20
> > > 1. Combinations that worked with libvhost-user in the past must not b=
reak.
> > >=20
> > > 2. New combinations should only support VIRTIO 1.0 and later.
> > >=20
> > > This means continue to allow Legacy mode devices where they already r=
un
> > > today but don't add new code for the cases that didn't work. =20
> >=20
> > What I'm missing here is what PCI product ID was being used when the
> > current impl is in legacy/transitional mode ?
> >=20
> > Normally legacy and transitional mode devices need an explicit PCI ID
> > reserved, where as modern-only devices have a PCI ID derived from their
> > VirtIO ID + a fixed offset.
> >=20
> > Was this mistakenly using a VirtIO ID + fixed offset for the legacy
> > mode too ? =20
>=20
> vhost-user-fs-pci does not support Legacy or Transitional mode. See
> hw/virtio/vhost-user-fs-pci.c:
>=20
>   static const VirtioPCIDeviceTypeInfo vhost_user_fs_pci_info =3D {
>       .base_name             =3D TYPE_VHOST_USER_FS_PCI,
>       .non_transitional_name =3D "vhost-user-fs-pci",
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>       .instance_size =3D sizeof(VHostUserFSPCI),
>       .instance_init =3D vhost_user_fs_pci_instance_init,
>       .class_init    =3D vhost_user_fs_pci_class_init,
>   };

This makes it very unlikely that someone accidentally configures
non-modern, but does not prevent it AFAICS. See
<20200630113527.7b27f34f.cohuck@redhat.com>, which I just sent.

(I may be off, because that is all very confusing...)

--Sig_/EdTKuiXSaLBVO8rGMFs_Bes
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl77CFQACgkQ3s9rk8bw
L6825Q/+NFkDCgcuIQ36wa2jKmoUW5Af/jj5GCy7DWriPJeoEYCMghRRZdlkOVYw
asoZ1z0x0VbuexT9Ho8ncpWtLTcUR83jQ93Nj/RxDv/v8TyoTdXbj+B6Gw1ISMWe
4eyNNjRAuZ1M0RcR2kMKUv33PbkeUnGC9co52opa8hc3NIP6G11vfJ2/8Vs/59qb
TLGbJzt6GpO2Qb9kCkliBzS2yxjCeFEKtFTkfn8suXuyOJufoq6Cuz6vf6FKvFd/
HjYr0M0iy4FYrCNbCRpFJhzSeVMEjQ6fbNoI9iZFon28NnYii1EvowyRV9cpGJdi
fF26bKyY4lApLMQs4IrxjMRBjAyH/2wSWdFLqijOqA+MgmnvrKg4Q6GIuEhqznTd
xJVFsUvVOqHBGT6K/5DtftjfphT38baIfQLNBz4+dYiwRmbhUZ0yB+6BZToleilO
k+L/EVJUhQQSNzory/UqrC7j4ofedubGDKfOp/x8nSaVTaCrB/A6+PIVTg9jCPVk
tQ99V+KILx6zRKrEDeRmjQzfW7M87mxG6QPjzQ7cVuh7jPWTMjrQckgHrRqpQ9oL
QAp2/rx+rmiaOjyoHGD0gx44InDR83GZxKexlqz6bhGbG9mJnmPYKPTia/bC7Gbj
zMlss5EFG6gQ3lcVnUO8p+WgxXFYEVWO5AtCWqC/HVO+TSB2+dU=
=saXa
-----END PGP SIGNATURE-----

--Sig_/EdTKuiXSaLBVO8rGMFs_Bes--


