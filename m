Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE0AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89A821924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89A821924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsgd-0000ut-46
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAsfc-0000Aa-Hz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAsfX-0001XL-F9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAsfV-0001Vm-I0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:24:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D0A789C31
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:24:03 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09E4919C5B;
 Thu, 19 Sep 2019 09:23:59 +0000 (UTC)
Date: Thu, 19 Sep 2019 10:23:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190919092358.GA3606@stefanha-x1.localdomain>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-6-marcandre.lureau@redhat.com>
 <20190916100035.GC2887@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20190916100035.GC2887@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 19 Sep 2019 09:24:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] docs: start a document to describe
 D-Bus usage
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 11:00:35AM +0100, Dr. David Alan Gilbert wrote:
> (Copying in Stefan since he was looking at DBus for virtiofs)
>=20
> * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/interop/dbus.rst  | 73 ++++++++++++++++++++++++++++++++++++++++++
> >  docs/interop/index.rst |  1 +
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 docs/interop/dbus.rst
> >=20
> > diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
> > new file mode 100644
> > index 0000000000..c08f026edc
> > --- /dev/null
> > +++ b/docs/interop/dbus.rst
> > @@ -0,0 +1,73 @@
> > +=3D=3D=3D=3D=3D
> > +D-Bus
> > +=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +QEMU may be running with various helper processes involved:
> > + - vhost-user* processes (gpu, virtfs, input, etc...)
> > + - TPM emulation (or other devices)
> > + - user networking (slirp)
> > + - network services (DHCP/DNS, samba/ftp etc)
> > + - background tasks (compression, streaming etc)
> > + - client UI
> > + - admin & cli
> > +
> > +Having several processes allows stricter security rules, as well as
> > +greater modularity.
> > +
> > +While QEMU itself uses QMP as primary IPC (and Spice/VNC for remote
> > +display), D-Bus is the de facto IPC of choice on Unix systems. The
> > +wire format is machine friendly, good bindings exist for various
> > +languages, and there are various tools available.
> > +
> > +Using a bus, helper processes can discover and communicate with each
> > +other easily, without going through QEMU. The bus topology is also
> > +easier to apprehend and debug than a mesh. However, it is wise to
> > +consider the security aspects of it.
> > +
> > +Security
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +A QEMU D-Bus bus should be private to a single VM. Thus, only
> > +cooperative tasks are running on the same bus to serve the VM.
> > +
> > +D-Bus, the protocol and standard, doesn't have mechanisms to enforce
> > +security between peers once the connection is established. Peers may
> > +have additional mechanisms to enforce security rules, based for
> > +example on UNIX credentials.
> > +
> > +dbus-daemon can enforce various policies based on the UID/GID of the
> > +processes that are connected to it. It is thus a good idea to run
> > +helpers as different UID from QEMU and set appropriate policies (so
> > +helper processes are only allowed to talk to qemu for example).
> > +
> > +For example, this allows only ``qemu`` user to talk to ``qemu-helper``
> > +``org.qemu.Helper1`` service:
> > +
> > +.. code:: xml
> > +
> > +  <policy user=3D"qemu">
> > +     <allow send_destination=3D"org.qemu.Helper1"/>
> > +     <allow receive_sender=3D"org.qemu.Helper1"/>
> > +  </policy>
> > +
> > +  <policy user=3D"qemu-helper">
> > +     <allow own=3D"org.qemu.Helper1"/>
> > +  </policy>
> > +
> > +
> > +dbus-daemon can also perfom SELinux checks based on the security
> > +context of the source and the target. For example, ``virtiofs_t``
> > +could be allowed to send a message to ``svirt_t``, but ``virtiofs_t``
> > +wouldn't be allowed to send a message to ``virtiofs_t``.
>=20
> I think we need to start thinking about this more now rather than
> 'can'. .

virtiofsd has two DBus interfaces:

1. org.qemu.Virtiofsd - the management interface

   We don't expect QEMU to communicate with this.  Administrators or
   management tools will connect to this.

2. dbus-vmstate - we'll probably need this for live migration

   This is for QEMU<->vhost-user device backend communication.

Stefan

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DSS4ACgkQnKSrs4Gr
c8iCOQf7BdVqZ08twPcRP9wCP/6zceyy4Q7V1DRPMNQF1VSUVOfRclv7TfTszia0
rIRKWg3Urs9kpEwU6gb5gETxKFeSnf8mmSOSbqn2M2gkMhrBYyzfuIkIsT61lNCl
U8yuxPRebVvaW3Z1x4cN2O2gONWHGe4DSKIwC1GNFtZsalppHUVXJZlwuXGllmV+
R1kpFTYr5w9pX+/5KGCg3upNeuUvlny0ajQD3epijqkweI6VLLrGETFBQuaDM5zo
mwRopXB3nXJjgEcqwlwW9yfD0xdMJsT+RwlGwbX+U5aCgcRIn89DByL+ttBCgCFP
fgdfDfLSk/yU5kR7OAcDbGidZuTZiA==
=YBu4
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

