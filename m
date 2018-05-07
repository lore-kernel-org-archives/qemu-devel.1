Received: from eggs.gnu.org ([2001:4830:134:3::10]:56361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fFkcM-0002vn-SE
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fFkcH-0007xo-SE
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:12:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1fFkcH-0007x2-L0
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:12:05 -0400
Date: Mon, 7 May 2018 20:12:02 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180507201202.6bddce4b@kitsune.suse.cz>
In-Reply-To: <70cb944b-269c-2969-4727-b889298ece30@linaro.org>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<20180427210120.03d037b0@naga.suse.cz>
	<70cb944b-269c-2969-4727-b889298ece30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Sun, 29 Apr 2018 09:56:37 -0500
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 04/27/2018 02:01 PM, Michal Such=C3=A1nek wrote:
> > Is there any reason why the 64bit emulator would not run on 32bit
> > system? The emulated 64bit system is .. emulated after all. =20
>=20
> It does run, but it requires that the 32-bit host perform double-word
> arithmetic to emulate the 64-bit guest.  When the 64-bit guest is
> really a 32-bit guest in disguise, this carries a performance penalty.
>=20
> If we ever stop caring about 32-bit hosts, the question becomes moot.
>=20

So if I installed 32bit pc binaries and 32bit qemu instead of the
x86_64 binaries on my ARM board it would be faster. Good to know if I
ever try wacky experiments like that again ;-)

Thanks

Michal
