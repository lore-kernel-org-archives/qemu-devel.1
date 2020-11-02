Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B8C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F43222EC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ln5vIn4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F43222EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbKK-0001eo-TC
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZbIw-0000L1-Ao
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZbIl-0002VI-TT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604329156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llIO71ZCFVa0ng1Y5tokRvg93/ncIdaI9WlsB4WX9UQ=;
 b=Ln5vIn4HPBSmjLXHxURI3iuGF5S/+/ap5HTaSynnxmCbdPsbGlUC0dFc+naByMxuuWQ6ZF
 VMbbG4J5seaTszjipCEfvoXLYE+xBwVChnBB10vKGT6j50wzpuv2tzlpdrHcoFCerZ9Ano
 INDFHfFc3MWoTBLAfDEniF/qSsR/cm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-F5FVvW4BPgeFMuCMcXoBfg-1; Mon, 02 Nov 2020 09:59:15 -0500
X-MC-Unique: F5FVvW4BPgeFMuCMcXoBfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79720CFF48;
 Mon,  2 Nov 2020 14:59:12 +0000 (UTC)
Received: from localhost (ovpn-114-65.ams2.redhat.com [10.36.114.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 761A41002C18;
 Mon,  2 Nov 2020 14:59:11 +0000 (UTC)
Date: Mon, 2 Nov 2020 14:59:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201102145910.GB186617@stefanha-x1.localdomain>
References: <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <0cabda60-f10d-fb74-f3eb-d21be7db7334@redhat.com>
 <20201102102754.GB42093@stefanha-x1.localdomain>
 <20201102053142-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201102053142-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
 Jag Raman <jag.raman@oracle.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 05:34:50AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 02, 2020 at 10:27:54AM +0000, Stefan Hajnoczi wrote:
> > On Mon, Nov 02, 2020 at 11:00:12AM +0800, Jason Wang wrote:
> > >=20
> > > On 2020/10/30 =E4=B8=8B=E5=8D=887:13, Stefan Hajnoczi wrote:
> > > > > I still don't get why it must be opaque.
> > > > If the device state format needs to be in the VMM then each device
> > > > needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc)=
.
> > > >=20
> > > > Let's invert the question: why does the VMM need to understand the
> > > > device state of a_passthrough_  device?
> > >=20
> > >=20
> > > It's not a 100% passthrough device if you want to support live migrat=
ion.
> > > E.g the device state save and restore is not under the control of dri=
vers in
> > > the guest.
> >=20
> > VFIO devices are already not pure passthrough (even without mdev) since
> > the PCI bus is emulated and device-specific quirks may be implemented.
>=20
> So since it's not a pure passthrough anyway, let's try to
> introduce some standards even if we can not always enforce
> them.

Yes, I agree. I've sent a document called "VFIO Migration" in a separate
email thread that defines how to orchestrate migration with versioning.
Maybe we can discuss the details there and figure out which guidelines
and device state representations to standardize.

Stefan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+gHr4ACgkQnKSrs4Gr
c8hAhQf/X2WbF3CZFPHsk3pdHqjJf9mBVikDW5lwZh3efNdqun5scNWsMx/RlL8c
mZBRD0ZpWX/hUlbcy/HYEIyO76cUaylnkJ3g9QF63htXYb+EgWmPoDljZRDrYmWn
0McjH43JfQIlsVC7aOXA89sOjGf8SHvZnRs3yYWwoxWsFFKuwWBjbOW3yArJ7K0+
u6grng9RqLglYJTpvYrYbOSE5g/ojH0DY4VTQXCrS7GqXKm0DfFwYVeHCFczZwJY
QPS7rgAvmPl2UDNQgfGm7wVb5Tqiu1xoMpcjl07piknD98dGMyV7PkTVnCqFQT86
CrDonbuILqzosLYqJkI/K5YiNnX3kw==
=6tB6
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--


