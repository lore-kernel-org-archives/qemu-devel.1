Received: from eggs.gnu.org ([2001:4830:134:3::10]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZxdX-000426-FL
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZxdU-0003uZ-AP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:41:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZxdT-0003tc-Uo
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:41:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id c126so2011735wmh.0
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 04:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
	<20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
	<20181211135230-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKuoWWxLqZKQRU-g_144jX2bwsQJUzeW0W-QicNrbPfQw@mail.gmail.com>
	<20181218181803-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJmT5O3x84upBDhvvCPCK5x51RP0TxBMsodLzVeQgC-vw@mail.gmail.com>
	<20181219103112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181219103112-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Dec 2018 16:40:55 +0400
Message-ID: <CAJ+F1CLKftEt8g5WyW8NPOPNsKPXhNnS3BkdVqjrny4cjb+kWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

Hi

On Wed, Dec 19, 2018 at 7:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Dec 19, 2018 at 12:01:59PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Dec 19, 2018 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Tue, Dec 18, 2018 at 10:35:05PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Tue, Dec 11, 2018 at 10:56 PM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> > > > >
> > > > > On Tue, Dec 11, 2018 at 09:29:44AM +0000, Daniel P. Berrang=C3=A9=
 wrote:
> > > > > > On Tue, Dec 11, 2018 at 08:42:41AM +0100, Hoffmann, Gerd wrote:
> > > > > > >   Hi,
> > > > > > >
> > > > > > > > Right. The main issue is that we need to make sure only
> > > > > > > > in-tree devices are supported.
> > > > > > >
> > > > > > > Well, that is under debate right now, see:
> > > > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg0491=
2.html
> > > > > >
> > > > > > I've previously been against the idea of external plugins for Q=
EMU,
> > > > > > however, that was when the plugin was something that would be d=
lopen'd
> > > > > > by QEMU. That would cause our internal ABI to be exposed to 3rd=
 parties
> > > > > > which is highly undesirable, even if they were open source to c=
omply
> > > > > > with the license needs.
> > > > > >
> > > > > > When the plugin is a completely isolated process communicating =
with a
> > > > > > well defined protocol, it is not placing a significant burden o=
n the
> > > > > > QEMU developers' ongoing maintainence, nor has problems with li=
cense
> > > > > > compliance. The main problem would come from debugging the comb=
ined
> > > > > > system as the external process is essentially a black box from =
QEMU's
> > > > > > POV. Downstream OS vendors are free to place restrictions on wh=
ich
> > > > > > backend processes they'd be willing to support with QEMU, and u=
pstream
> > > > > > is under no obligation to debug stuff beyond the QEMU boundary.
> > > > > >
> > > > > > We have already accepted that tradeoff with networking by suppo=
rting
> > > > > > vhost-user and have externals impls like DPDK, so I don't see a
> > > > > > compelling reason to try to restrict it for other vhost-user ba=
ckends.
> > > > >
> > > > > OK seems to be more or less a rough concensus then.
> > > > >
> > > > > I wonder what's the approach wrt migration though.
> > > >
> > > > The series doesn't take care of migration.
> > > >
> > > > >
> > > > > Even the compatibility story about vhost-user isn't
> > > > > great, I would like to see something solid before
> > > > > we allow that.
> > > >
> > > > To allow migration? vhost-user has partial support for migration
> > > > (dirty memory tracking), and there is also "[PATCH v2 for-4.0 0/7]
> > > > vhost-user-blk: Add support for backend reconnecting" - allowing th=
e
> > > > backend to store some state, if I understand correctly, which could=
 be
> > > > leveraged I guess...
> > > >
> > > > But I don't think we should block this series because migration isn=
't
> > > > tackled here.
> > > >
> > > > thanks
> > > >
> > > >
> > > > .
> > >
> > > How about blocking migration for now then?
> >
> > The device here (vhost-user-input) blocks migration (unmigratable =3D 1=
)
>
> Right. But that device is just an excersize, right?

Mostly

> It bothers me that next device might not remember and
> we will get a mess.

The next device (the one I care most about) is vhost-user-gpu.

> Could we make it somehow that if there is no vmsd
> then migration is blocked?

Where would you do that? in DeviceClass? That might break other
devices, needs code review. In VirtIODevice? that would be probably
simpler.



--=20
Marc-Andr=C3=A9 Lureau
