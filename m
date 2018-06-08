Received: from eggs.gnu.org ([2001:4830:134:3::10]:39806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKv7-0000DX-8l
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKv4-0000eR-0m
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:11:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fRKv3-0000eH-SW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:11:21 -0400
Date: Fri, 8 Jun 2018 18:11:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180608171117.GD18233@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
	<20180416161753.GA12819@redhat.com>
	<87r2lwnn3c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2lwnn3c.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, el13635@mail.ntua.gr, f4bug@amsat.org, qemu-devel@nongnu.org, pbonzini@redhat.com

On Mon, May 28, 2018 at 11:31:03AM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > Just a ping to say I'd like us to restart work this patch and try to =
get
> > it mergable for the 2.13 cycle, so I can rely it on for the ACL suppo=
rt
> > I've had out of tree since 2.6 :-)
>=20
> Fair enough.  I'll see what I can do.

Heads up that in retrospect I don't think this is a blocker for my
ACL work anymore. I decided it was more useful to store the access
control list in external files, so we can auto-reload them on the
fly without involving the monitor.

Still desirable long term, but no need to rush.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
