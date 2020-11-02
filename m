Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43ABC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C1921D40
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGwjzGlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C1921D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZX6Q-0001y5-3w
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZX4V-0000wg-0Z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZX4T-00041B-8I
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604312895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xNiT3mtdjmKOVHyg2YncVZENVTVwm67KySSR9FdXYF0=;
 b=FGwjzGlHY1z4R8ofDbA0hIaWyF0G69uyerN/x9mKYjpDTVAoVcwYs5ZkMPqB8a2vU+K2YS
 4kVicbpfN8CcwQJz0C6CoLGTgphiyJZWyluC8urmnwKbuEzNI0T4qDDpvAR7hEsW+4BYAy
 wXruB2hh3P+gA0xHO9lcDnaqaX4mUYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-LcSvZ8AVOWCNMcyEaoQx-g-1; Mon, 02 Nov 2020 05:28:14 -0500
X-MC-Unique: LcSvZ8AVOWCNMcyEaoQx-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93052809DC6;
 Mon,  2 Nov 2020 10:28:11 +0000 (UTC)
Received: from localhost (ovpn-114-205.ams2.redhat.com [10.36.114.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 724A65C1A3;
 Mon,  2 Nov 2020 10:27:55 +0000 (UTC)
Date: Mon, 2 Nov 2020 10:27:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201102102754.GB42093@stefanha-x1.localdomain>
References: <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <0cabda60-f10d-fb74-f3eb-d21be7db7334@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0cabda60-f10d-fb74-f3eb-d21be7db7334@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
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

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 11:00:12AM +0800, Jason Wang wrote:
>=20
> On 2020/10/30 =E4=B8=8B=E5=8D=887:13, Stefan Hajnoczi wrote:
> > > I still don't get why it must be opaque.
> > If the device state format needs to be in the VMM then each device
> > needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).
> >=20
> > Let's invert the question: why does the VMM need to understand the
> > device state of a_passthrough_  device?
>=20
>=20
> It's not a 100% passthrough device if you want to support live migration.
> E.g the device state save and restore is not under the control of drivers=
 in
> the guest.

VFIO devices are already not pure passthrough (even without mdev) since
the PCI bus is emulated and device-specific quirks may be implemented.
Adding device state save/load does not change anything here.

> And if I understand correctly, it usually requires device emulation or
> mediation in either userspace or kernel to support e.g dirty page trackin=
g
> and other things.

Breaking down the options further:

1. VFIO on physical PCI devices. Here I see two approaches:

   a. An mdev vendor driver implements the migration region described in
      Kirti's patch series. Individual device state fields are
      marshalled by the driver.

   b. The VFIO PCI core parses a PCI Capability that indicates migration
      support on the physical device and filters it out. The remainder
      of the device is passed through. The device state representation
      is saved/loaded by the physical hardware when the VFIO PCI core
      receives the ioctl and notifies the hardware. QEMU and host
      kernel code does not marshall individual device state fields.

      In the future it may be desirable to also expose the PCI
      Capability so that the guest is able to snapshot and restore the
      device. That could be useful for checkpointing AI/HPC workloads on
      GPUs, for example. I don't think there is a fundamental reason why
      device state save/load needs to be handled by the host except that
      VM live migration is supposed to be transparent to guests and
      cannot rely on guest cooperation.

2. vfio-user device backends. The device backend implements the
   save/load.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+f3yoACgkQnKSrs4Gr
c8gWcAgAoCiy21hOSiIA16R00aXmGP4LvIWL1OpiPh9FQUDHtJDxb7VI2EA3c4yR
Yfl4pOxt0QTqoQxrSISwWmiEqDbTRF/+KRKjs0gx4apWv/XyaSYcxFMHnDxIO/GQ
/Hx4MTSNNBdWspmv3ksECOPZ1PS4L9+OoWvZuv/jP45RwZHF+siHIdVrWgxaNCd1
K8LRrVcaQmYloUlhutfiKvOf24D62jGF2vnU25RWgGdjAu/pmfF/RqCl381GDJx1
9yDs3zRBRXXHbalK6Mk0B7nv21kR1kfbkrm326P877E6/LavetpGNF3MvsY8cMM8
mSmKT34KnI2hBolgapfJV0MbGB1vhA==
=uYTE
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--


