Received: from eggs.gnu.org ([2001:4830:134:3::10]:39782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7iY5-0001of-3x
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7iXz-0001x2-Kd
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7iXz-0001wC-DU
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:50:11 -0400
Date: Thu, 26 Oct 2017 14:50:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171026135005.GE10055@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
	<CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
	<20171026070608.GC5847@redhat.com>
	<CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
	<20171026100645.GA24581@redhat.com>
	<8774f2a0-274f-b358-c316-d3484f15b2cb@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8774f2a0-274f-b358-c316-d3484f15b2cb@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Oct 26, 2017 at 10:29:59AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 10/26/2017 07:06 AM, Daniel P. Berrange wrote:
> > Do we really expect make/configure todo the right thing when going
> > backwards in time ?
>=20
> "Yes"? Ideally at least :)

What we could do is get scripts/git-submodule.sh to filter the list of
modules it receives, against the list of modules that exist. This would
probably make it safe against going backwards over a commit that added
a new submodule


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
