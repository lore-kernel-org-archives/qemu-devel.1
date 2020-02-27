Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547F8C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2071A2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jy5iSBGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2071A2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MUz-0004xW-7C
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j7MUO-0004Vb-V3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j7MUN-0007LA-Ms
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:58:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j7MUN-0007L1-IC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ujikxr32PVcDLm7SrLysq7rM7d02JbQP2MNv4KjctL8=;
 b=Jy5iSBGOzGNSGYEtRsSRllxaa+RclQgxMuVZl9Qh5nsUsQmOmaictBxlxQHZ+4pLCSH3hv
 FNon3W8FhAcM2GRFiKVQNW8EXKNbw4tINPngK1HB5H+iICSUuyubpuZZoapbe3JW+Ua3MI
 Zh5irFhIIImkioS6hhQUi0Vgf5vz8bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-n4LwxCVcP3SGxMmhvveRUA-1; Thu, 27 Feb 2020 11:58:17 -0500
X-MC-Unique: n4LwxCVcP3SGxMmhvveRUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A55D107ACC7;
 Thu, 27 Feb 2020 16:58:12 +0000 (UTC)
Received: from localhost (ovpn-117-38.ams2.redhat.com [10.36.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E87428C089;
 Thu, 27 Feb 2020 16:58:05 +0000 (UTC)
Date: Thu, 27 Feb 2020 16:58:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 50/50] multi-process: add configure and usage
 information
Message-ID: <20200227165804.GE315098@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <bbba8cdef9f876ec6d194f3e1974347860eca732.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <bbba8cdef9f876ec6d194f3e1974347860eca732.1582576372.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 03:55:41PM -0500, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  docs/qemu-multiprocess.txt | 86 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 docs/qemu-multiprocess.txt
>=20
> diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
> new file mode 100644
> index 0000000..f156177
> --- /dev/null
> +++ b/docs/qemu-multiprocess.txt
> @@ -0,0 +1,86 @@
> +Multi-process QEMU
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document describes how to configure and use multi-process qemu.
> +For the design document refer to docs/devel/qemu-multiprocess.
> +
> +1) Configuration
> +----------------
> +
> +To enable support for multi-process add --enable-mpqemu
> +to the list of options for the "configure" script.
> +
> +
> +2) Usage
> +--------
> +
> +To start qemu with devices intended to run in a separate emulation
> +process without libvirtd support, the following should be used on QEMU
> +command line. As of now, we only support the emulation of lsi53c895a
> +in a separate process
> +
> +* Since parts of the RAM are shared between QEMU & remote process, a
> +  memory-backend-file is required to facilitate this, as follows:
> +
> +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=3D4096M=
,share=3Don

memory-backend-memfd is more convenient.  It doesn't require a mem-path
and share=3Don is the default.

> +
> +* The devices to be emulated in the separate process are defined as
> +  before with addition of "rid" suboption that serves as a remote group
> +  identificator.
> +
> +  -device <device options>,rid=3D"remote process id"
> +
> +  For example, for non multi-process qemu:
> +    -device lsi53c895a,id=3Dscsi0 device
> +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0
> +    -drive id=3Ddrive0,file=3Ddata-disk.img
> +
> +  and for multi-process qemu and no libvirt
> +  support (i.e. QEMU forks child processes):
> +    -device lsi53c895a,id=3Dscsi0,rid=3D0
> +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,rid=3D0

This approach is invasive:
 * lsi53c895a should not need to be modified with a new rid=3D option.
 * QEMU should not know about the scsi-hd device or drive0.  Only the
   device emulation process needs to know about scsi-hd.

In order to cleanly separate QEMU and the device emulation process
syntax like this is needed:

  -object remote-device,id=3Drid0,...
  -device remote-pci-device,id=3Dscsi0,remote-device=3Drid0

The "remote-device" object could be part of remote-pci-device, but
keeping it separate may be useful in the future in order to support
things like reconnection.

The generic "remote-pci-device" device handles any remote PCI device,
not just the LSI SCSI controller.

Do you agree with this approach?

> +* The command-line options for the remote process are added to the "comm=
and"
> +  suboption of the newly added "-remote" option.=20
> +
> +   -remote [socket],rid=3D0,exec=3D"...",command=3D"..."

QEMU has been using the -object TYPE syntax instead of adding new -TYPE
command-line options.  This gives you object_add hotplug for free, for
example.  I suggest using -object remote-device,id=3D,exec=3D,command=3D,
instead of -remote.

> +
> +  The drives to be emulated by the remote process are specified as part =
of
> +  this command sub-option. The device to be used to connect to the monit=
or
> +  is also specified as part of this suboption.
> +
> +  For example, the following option adds a drive and monitor to the remo=
te
> +  process:
> +  -remote rid=3D0,exec=3D"qemu-scsi-dev",command=3D"-drive id=3Ddrive0,,=
file=3Ddata-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
> +
> +  Note: There's an issue with this "command" sub-option which we are in =
the
> +  process of fixing. To work around this issue, it requires additional
> +  "comma" characters as illustrated above, and in the example below.

command=3D (which could be called args=3D for clarity) will be difficult to
use not just because of comma escaping but also because of double-quote
escaping.  How do you pass a command-line argument that contains spaces?

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5X9RwACgkQnKSrs4Gr
c8jv9wf9EZP2BakHg/7wQXbFCXXZ8PnLiN5hogzlDh0ZT8lSSHgLbDHyldEoNkEa
2nfKmZRRUPlSiMavcxLPF6C414o8XaAOgAlALpFU2JbvEOZggTxoAhVwVgOa0yYg
RM2YCmA9pMB4Bh1yguZNLkZj0qU0j7efxpgnn7a3zr2INoLeQt1NwKZ2zFXK7Pxi
F1HLe4yQ9Cf6FcL652KLtvgvdUjv7gQRDbkuFGTnvF1faYdTE+u516oY04NK2Kmo
OBthIIOMvuA1mrr6/xZI/HkYHU78t89CRUPk7JVVs3qfnBiX9PPXJywYkX7OSvmx
JlMaUThPh5rB+gEKlJSY1mK0Go5ixw==
=baE2
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--


