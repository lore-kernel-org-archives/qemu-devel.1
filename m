Received: from eggs.gnu.org ([2001:4830:134:3::10]:33692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC06V-0002ts-7r
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC06R-0004dV-9S
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC06R-0004dG-4C
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:23:27 -0500
Date: Tue, 7 Nov 2017 09:23:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171107092322.GE14232@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509988303.22094.8.camel@intel.com>
	<20171106172646.GO23361@redhat.com>
	<1510002125.22094.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510002125.22094.10.camel@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RFC: connecting chardev to a command forked by qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: qemu-devel@nongnu.org, Amarnath Valluri <amarnath.valluri@intel.com>

On Mon, Nov 06, 2017 at 10:02:05PM +0100, Patrick Ohly wrote:
> On Mon, 2017-11-06 at 17:26 +0000, Daniel P. Berrange wrote:
> > I can see the argument about it making QEMU easier to use, and those
> > who care about security aren't forced to use this new feature. It
> > none the less has a cost on maintainers and existance of these
> > features does reflect on QEMU's security reputation even if many
> > don't use it.
>=20
> With Yocto we really don't have much choice: we need a patch like this
> because the alternative (introducing support for spawning and stopping
> swtpm and then passing the right parameters to QEMU) is way more
> complex.=C2=A0So if this patch isn't acceptable to QEMU upstream, then =
I
> will keep it as simple as possible and propose it as a local patch in
> Yocto.

I don't really buy this argument. Any distro's core job is the ability
to start/stop/manage processes. Saying yocto is unable to manage
runing of swtpm is really dubious - it is simply a choice to declare
that it is QEMU's job.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
