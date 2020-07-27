Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24635C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2514206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXwFbDZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2514206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k032F-0008BV-8b
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k031i-0007lH-De
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:18:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k031g-0005xh-OI
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595855923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xLuhxXYa2IWvZP4jLP4cim7yq3VenN8tkJZWxiVg+jw=;
 b=gXwFbDZLNeVwm5TfBnvkQmP4sZ8hOQJBjCRZo8Qx4zaQB550Eg+PLX3TeKidjsUj2QB3uE
 gYbn3fyRTE6fmpTh6PYObZhMgNjZreDshPZcZ6wIg5y3vBHe9MAd8nkUo7V/ZNmvkqQFk4
 YcB7qh3dD3Tz/ySrxzi+mqjLUnaVrpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-20CCsXeEPzu2KRH6mnwkCQ-1; Mon, 27 Jul 2020 09:18:39 -0400
X-MC-Unique: 20CCsXeEPzu2KRH6mnwkCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694F159;
 Mon, 27 Jul 2020 13:18:37 +0000 (UTC)
Received: from localhost (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE97860BF4;
 Mon, 27 Jul 2020 13:18:30 +0000 (UTC)
Date: Mon, 27 Jul 2020 14:18:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v7 12/21] multi-process: Connect Proxy Object with device
 in the remote process
Message-ID: <20200727131829.GD386429@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <20f42fce1b701586a23c9abdb3b53d080845e94a.1593273671.git.elena.ufimtseva@oracle.com>
 <20200701092043.GE126613@stefanha-x1.localdomain>
 <BE91B4AA-7E18-47CE-8747-97152D6462CC@oracle.com>
MIME-Version: 1.0
In-Reply-To: <BE91B4AA-7E18-47CE-8747-97152D6462CC@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, John G Johnson <john.g.johnson@oracle.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 12:57:22PM -0400, Jag Raman wrote:
> > On Jul 1, 2020, at 5:20 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> > On Sat, Jun 27, 2020 at 10:09:34AM -0700, elena.ufimtseva@oracle.com wr=
ote:
> > In a 1:1 model the CONNECT_DEV message is not necessary because each
> > socket is already associated with a specific remote device (e.g. qemu -=
M
> > remote -object mplink,dev=3Dlsi-scsi-1,sockpath=3D/tmp/lsi-scsi-1.sock)=
.
> > Connecting to the socket already indicates which device we are talking
> > to.
> >=20
> > The N:1 model will work but it's more complex. There is a main socket
> > that is used for CONNECT_DEV (anything else?) and we need to worry abou=
t
> > the lifecycle of the per-device sockets that are passed over the main
> > socket.
>=20
> The main socket is only used for CONNECT_DEV. The CONNECT_DEV
> message sticks a fd to the remote device.
>=20
> We are using the following command-line in the remote process:
> qemu-system-x86_64 -machine remote,fd=3D4 -device lsi53c895a,id=3Dlsi1 ..=
.
>=20
> The alternative approach would be to let the orchestrator to assign fds f=
or
> each remote device. In this approach, we would specify an =E2=80=98fd=E2=
=80=99 for each
> device object like below:
> qemu-system-x86_64 -machine remote -device lsi53c895a,id=3Dlsi1,fd=3D4 =
=E2=80=A6
>=20
> The alternative approach would entail changes to the DeviceState struct
> and qdev_device_add() function, which we thought is not preferable. Could
> you please share your thoughts on this?

I suggest dropping multi-device support for now. It will be implemented
differently with VFIO-over-socket anyway, so it's not worth investing
much time into.

The main socket approach needs authentication support if multiple guests
share a remote device emulation process. Otherwise guest A can access
guest B's devices.

It's simpler if each device has a separate UNIX domain socket. It is not
necessary to modify lsi53c895a in order to do this. Either the socket
can be associated with the remote PCIe port (although I think the
current code implements the older PCI Local Bus instead of PCIe) or a
separate -object mpqlink,device=3Dlsi1,fd=3D4 object can be defined (I thin=
k
that's the syntax I've shared in the past).

For now though, just using the -machine remote,fd=3D4 approach is fine -
but limited to 1 device.

Stefan

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8e1CUACgkQnKSrs4Gr
c8hvtAf/Sxd0kEVrgv0E5LixbooDEOXaqtDIjxOe5e0zCjmywBQAy3q8TPj2ene/
Mzm1e49XV+jtutouNvjT13FO+rATFK/yvk/BFTKn1W+VvnHJE1rxWyR4SFaQlYqd
IribPCA8mnXsjyYGo8DqxKZwArLeJdz14kzn67KI7SB6/Rf4hrXbd8WCwfaK0s3j
rmddAPtudNUWGlfEeuqaYmJqCheccY/IaxIGR3nAEXknVGAvABRxaYLtTnJA+7QK
jbamwKsqhcZpRVYom/7jNqGeUr7wpqc5an7vzWdk9KY9830QdBBpZScXBqvnHVVO
7vTWseJHw3Jf4wQyQOm36FUUzP3chQ==
=D98U
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--


