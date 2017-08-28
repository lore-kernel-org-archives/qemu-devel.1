Received: from eggs.gnu.org ([2001:4830:134:3::10]:55572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmNgM-00066J-FS
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmNgI-0004xQ-Eo
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:18:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmNgI-0004wf-5e
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:18:34 -0400
Date: Tue, 29 Aug 2017 01:18:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170828171827.GF18194@lemon.lan>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-4-famz@redhat.com>
	<51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
	<20170822140000.GF3210@lemon>
	<cf40501d-a61f-6e48-687c-fff4b9db47c4@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <cf40501d-a61f-6e48-687c-fff4b9db47c4@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/10] tests: Add vm test lib
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

On Tue, 08/22 11:23, Philippe Mathieu-Daud=E9 wrote:
> On 08/22/2017 11:00 AM, Fam Zheng wrote:
> > On Tue, 08/22 08:19, Philippe Mathieu-Daud=E9 wrote:
> > > > +    def add_source_dir(self, data_dir):
> > > > +        name =3D "data-" + hashlib.sha1(data_dir).hexdigest()[:5=
]
> > > > +        tarfile =3D os.path.join(self._tmpdir, name + ".tar")
> > > > +        logging.debug("Creating archive %s for data dir: %s", ta=
rfile, data_dir)
> > > > +        subprocess.check_call(["tar", "--exclude-vcs",
> > >=20
> > > --exclude-vcs-ignores will process .gitignore,
> >=20
> > Sounds useful, thanks!
> >=20
> > > you can also list with 'git ls-files',
> > > or generate tarball with scripts/make-release
> >=20
> > They won't handle submodules, will they?
>=20
> "git ls-files --recurse-submodules"

Not good, I somehow hit an infinite erroneous output with
"--recurse-submodules":

$ git ls-files --recurse-submodules
...
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w/timer/imx_epit.h
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w/timer/imx_gpt.h
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w/timer/m48t59.h
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w/timer/mc146818rtc.h
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w/timer/mc146818rtc_regs.h
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w/timer/mips_gictimer.h
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w/timer/stm32f2xx_timer.h
pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pix=
man/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman=
/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/pixman/include/h=
w^C

$ git version

2.13.5

So it's opted out.

So I'll add some detection code for gtar, use --exclude-vcs-ignores and c=
all it a day.

Fam

>=20
> This way you can avoid the --exclude-vcs-ignores which is too recent fo=
r
> NetBSD as remarked Kamil, and avoid the tar --exclude=3D
>=20
> > >=20
> > > > +                               "--exclude=3Dtests/vm/*.img",
> > > > +                               "--exclude=3Dtests/vm/*.img.*",
> > > > +                               "--exclude=3D*.d",
> > > > +                               "--exclude=3D*.o",
> > > > +                               "--exclude=3Ddocker-src.*",
> > > > +                               "-cf", tarfile, '.'], cwd=3Ddata_=
dir,
> > > > +                              stdin=3Dself._devnull, stdout=3Dse=
lf._stdout)
> > > > +        self._data_args +=3D ["-drive",
> > > > +                            "file=3D%s,if=3Dnone,id=3D%s,cache=3D=
writeback,format=3Draw" % \
> > > > +                                    (tarfile, name),
> > > > +                            "-device",
> > > > +                            "virtio-blk,drive=3D%s,serial=3D%s,b=
ootindex=3D1" % (name, name)]
> > >=20
> > > what about mounting readonly via '-device virtio-9p-pci' (not using
> > > tarball)?
> > >=20
> >=20
> > It doesn't work. That way an out-of-tree build is required in the gue=
st, but if
> > an in-tree build has been done in host side, out-of-tree builds fail.=
  Also the
> > performance will be much worse, I believe: untar is sequential read, =
and after
> > that everything is in the guest page cache; with virtio-9p, there wil=
l be a
> > large amount of "random" requests between guest and host.
>=20
> Indeed you are correct, I didn't think of it, thank to remember me that=
 :)
