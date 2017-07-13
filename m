Received: from eggs.gnu.org ([2001:4830:134:3::10]:39474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dVZvW-0003Wg-Kt
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dVZvT-0006bp-Ih
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:56:50 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dVZvT-0006bA-BW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:56:47 -0400
Received: by mail-wm0-f54.google.com with SMTP id f67so18425037wmh.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 01:56:47 -0700 (PDT)
Date: Thu, 13 Jul 2017 10:56:42 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170713105642.39a482ad@fiorina>
In-Reply-To: <912a31de-a26b-9267-a5ea-9f1f9ffa04bd@redhat.com>
References: <cover.1498222907.git.tgolembi@redhat.com>
	<7e2e1329dbe5a6d93c3d58eb2251b8862e2d1340.1498222907.git.tgolembi@redhat.com>
	<912a31de-a26b-9267-a5ea-9f1f9ffa04bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/3] qemu-ga: add support for events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri, 7 Jul 2017 15:53:37 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 06/23/2017 08:02 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> > Events can play an integral role when monitoring internal state of the
> > guest OS. This patch adds the core functionality for adding events to
> > QEMU Guest Agent. =20
>=20
> Will sending events confuse existing clients that aren't expecting them?
> Do we need to add some sort of protocol handshake when the client first
> connects so that we know whether the client is able to parse events
> (including ignoring unknown events)?  (It's a shame that events were
> built into QMP from the beginning, so we've never had to figure out how
> to portably hand-shake a client/server negotiation on additional
> features to be used across the wire)

You're probably right. Something like this will be necessary.

>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
