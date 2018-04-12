Received: from eggs.gnu.org ([2001:4830:134:3::10]:46204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6XSy-0005cY-BY
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6XSu-0005zQ-BA
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:20:24 -0400
Date: Thu, 12 Apr 2018 09:19:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180412081954.GB31024@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180409154921.29906-1-wei@redhat.com>
	<20180409155634.GO18283@redhat.com>
	<6bb12858-3b4e-e92f-93ea-b8708c8be870@redhat.com>
	<1523346093.16671.23.camel@redhat.com>
	<20180410085200.GD5155@redhat.com>
	<1523460955.2942.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523460955.2942.5.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Change default cpu and
 gic-version setting to "max"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Wei Huang <wei@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org

On Wed, Apr 11, 2018 at 05:35:55PM +0200, Andrea Bolognani wrote:
> On Tue, 2018-04-10 at 09:52 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Apr 10, 2018 at 09:41:33AM +0200, Andrea Bolognani wrote:
> > > I figure the people not explicitly specifying a CPU model on the
> > > command line will probably also use '-M virt' instead of versioned
> > > machine types, which means they will get a different guest behavior
> > > after upgrading QEMU regardless.
> >=20
> > Libvirt uses versioned machine types and does not specify -cpu unless=
 the
> > user has added <cpu> to their XML. IOW libvirt assumes the default CP=
U
> > model is stable because that's what QEMU has promised in the past.
>=20
> Hm, you have a point.
>=20
> I wonder how well that works in practice, though. I started a guest
> with no <cpu> element on my laptop and it ended up having
>=20
>   vendor_id	 : GenuineIntel
>   cpu family : 6
>   model      : 6
>   model name : QEMU Virtual CPU version 2.5+
>   stepping   : 3
>=20
> which I guess translates to the qemu64 CPU model, based on the
> description. I have verified the -cpu option is not present on the
> command line.
>=20
> The name seems to imply that if I were using a QEMU release older
> than 2.5 I would get a different CPU model, but maybe the stable CPU
> guarantee you mention is just a fairly recent development.

That model ID string is tied to the machine type, so it is stable. Older
machine types use PC_CPU_MODEL_IDS() in pc.h to ensure they have not
changed.

> I also know that ppc64 performs some trickery if you don't specify a
> CPU model, so by default you get a behavior which is pretty close to
> using -cpu host.
>=20
> Basically I'm wondering how reasonable it is to expect a migratable
> machine and a stable guest ABI when relying on QEMU defaults instead
> of explicitly picking a CPU model.

Provided you have picked a versioned machine type, it is expected that al=
l
other defaults are stable, and that includes CPU models.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
