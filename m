Received: from eggs.gnu.org ([2001:4830:134:3::10]:38793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmtmK-0000iK-Q3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmtmE-0002ky-Ge
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:34:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmtmE-0002kL-9j
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:34:50 -0400
Date: Wed, 30 Aug 2017 11:34:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830033445.GE4208@lemon.lan>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<c751fc1d-602a-25ed-edb9-84ccdaeb2ecb@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c751fc1d-602a-25ed-edb9-84ccdaeb2ecb@amsat.org>
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
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 08/29 14:34, Philippe Mathieu-Daud=E9 wrote:
> > +        self._args =3D [ \
> > +            "-nodefaults", "-m", "2G",
> > +            "-cpu", "host",
> > +            "-netdev", "user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22",
> > +            "-device", "virtio-net-pci,netdev=3Dvnet",
> > +            "-vnc", ":0,to=3D20",
> > +            "-serial", "file:%s" % os.path.join(self._tmpdir, "seria=
l.out")]
> > +        if vcpus:
> > +            self._args +=3D ["-smp", str(vcpus)]
>=20
> What about enabling mttcg which isn't default?
>=20
>             self._args +=3D ["--accel", "tcg,thread=3Dmulti"]

Any specific reason to enable it? I think it is not available on older QE=
MU.

>=20
> > +        if os.access("/dev/kvm", os.R_OK | os.W_OK):
> > +            self._args +=3D ["-enable-kvm"]
> > +        else:
> > +            logging.info("KVM not available, not using -enable-kvm")
> > +        self._data_args =3D []
> [...]

Fam
