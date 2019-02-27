Received: from eggs.gnu.org ([209.51.188.92]:44441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyvZP-0006Rb-2l
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyvZN-0005V2-Jo
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:32:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gyvZI-0005Q9-QG
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:32:03 -0500
Date: Wed, 27 Feb 2019 09:31:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227093141.GC31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190225123111.30363-1-berrange@redhat.com>
	<CAFEAcA9_AeKMZxrGE7pSp0j1JSSWTLCk2g7aP=QCtTWGNFposQ@mail.gmail.com>
	<41d3532c-0ab4-db82-dc9a-cc9fb45c6162@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41d3532c-0ab4-db82-dc9a-cc9fb45c6162@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Merge authz core patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Tue, Feb 26, 2019 at 08:07:34PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 2/26/19 8:04 PM, Peter Maydell wrote:
> > On Mon, 25 Feb 2019 at 12:35, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >>
> >> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a=
62be116:
> >>
> >>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-2=
0190221.0' into staging (2019-02-22 15:48:04 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/berrange/qemu tags/authz-core-pull-request
> >>
> >> for you to fetch changes up to cfde05c6c0db7d3122a5491d50f62f7910ab8=
abb:
> >>
> >>   authz: delete existing ACL implementation (2019-02-25 12:28:25 +00=
00)
> >>
> >> ----------------------------------------------------------------
> >> Add a standard authorization framework
> >>
> >> The current network services now support encryption via TLS and in s=
ome
> >> cases support authentication via SASL. In cases where SASL is not
> >> available, x509 client certificates can be used as a crude authoriza=
tion
> >> scheme, but using a sub-CA and controlling who you give certs to. In
> >> general this is not very flexible though, so this series introduces =
a
> >> new standard authorization framework.
> >>
> >=20
> > Applied, thanks.
>=20
> Argh there is a v2... Daniel didn't NACK'd this one.

It is no big deal. The only changes were very minor and were fine as
a followup.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
