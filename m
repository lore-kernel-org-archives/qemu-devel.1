Received: from eggs.gnu.org ([2001:4830:134:3::10]:39728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1do0d0-0000Xp-19
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 01:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1do0cv-0007pI-2K
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 01:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1do0cu-0007oV-Ru
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 01:05:48 -0400
Date: Sat, 2 Sep 2017 13:05:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170902050542.GC5845@lemon.lan>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<c751fc1d-602a-25ed-edb9-84ccdaeb2ecb@amsat.org>
	<20170830033445.GE4208@lemon.lan>
	<02eb8166-d0a4-a0e9-ec82-bc45a3626fd1@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <02eb8166-d0a4-a0e9-ec82-bc45a3626fd1@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, 09/01 16:29, Philippe Mathieu-Daud=E9 wrote:
> On 08/30/2017 12:34 AM, Fam Zheng wrote:
> > On Tue, 08/29 14:34, Philippe Mathieu-Daud=E9 wrote:
> > > > +        self._args =3D [ \
> > > > +            "-nodefaults", "-m", "2G",
> > > > +            "-cpu", "host",
> > > > +            "-netdev", "user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22"=
,
> > > > +            "-device", "virtio-net-pci,netdev=3Dvnet",
> > > > +            "-vnc", ":0,to=3D20",
> > > > +            "-serial", "file:%s" % os.path.join(self._tmpdir, "s=
erial.out")]
> > > > +        if vcpus:
> > > > +            self._args +=3D ["-smp", str(vcpus)]
> > >=20
> > > What about enabling mttcg which isn't default?
> > >=20
> > >              self._args +=3D ["--accel", "tcg,thread=3Dmulti"]
> >=20
> > Any specific reason to enable it? I think it is not available on olde=
r QEMU.
>=20
> Neither is dynamic portfwd :)

I figured, but portfwd is strongly justified, whereas ...

>=20
> I see 2 reasons:
> - faster test

Any data? And if it is noticably faster, I doubt anyone is going to actua=
lly use
it, because it probably take a whole day to run one build.

> - cover mttcg

Testing mttcg is good, but we don't want to test mttcg and building at th=
e same
time. Again, it can take a whole day.

But anyway --accel and any other options should be possible to get passed=
 as
command line options.

Fam

>=20
> >=20
> > >=20
> > > > +        if os.access("/dev/kvm", os.R_OK | os.W_OK):
> > > > +            self._args +=3D ["-enable-kvm"]
> > > > +        else:
> > > > +            logging.info("KVM not available, not using -enable-k=
vm")
> > > > +        self._data_args =3D []
> > > [...]
> >=20
> > Fam
> >=20
>=20
