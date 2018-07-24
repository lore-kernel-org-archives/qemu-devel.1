Received: from eggs.gnu.org ([2001:4830:134:3::10]:56481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fhugZ-0004Qm-Gg
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fhugW-00080c-FV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:36:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fhugW-0007tc-9I
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17EDF401EF05
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 10:36:46 +0000 (UTC)
Date: Tue, 24 Jul 2018 11:36:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180724103638.GH19167@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180724102215.31866-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724102215.31866-1-dgilbert@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio/hda: Fix migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, marcandre.lureau@redhat.com

On Tue, Jul 24, 2018 at 11:22:15AM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Fix outgoing migration which was crashing in
> vmstate_hda_audio_stream_buf_needed, I think the problem
> is that we have room for upto 4 streams in the array but only
> use 2, when we come to try and save the state of the unused
> streams we hit st->state =3D=3D NULL.
>=20
> Fixes: 280c1e1cdb24d80ecdfc
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/audio/hda-codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
