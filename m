Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5cLN-00021s-4f
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5cLJ-0003KC-WC
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:48:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e5cLJ-0003Jw-NO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 14:48:25 -0400
Date: Fri, 20 Oct 2017 16:48:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171020184820.GP2942@localhost.localdomain>
References: <20170911165929.2791-3-marcandre.lureau@redhat.com>
	<20171009110336.GA17824@redhat.com>
	<20171009144344.38bbd1e9@nial.brq.redhat.com>
	<20171009130218.GK2954@redhat.com>
	<20171010003951-mutt-send-email-mst@kernel.org>
	<20171010083143.GA30015@redhat.com>
	<CAJ+F1CLGJLXYnJ8SnrbVkWc6bdU2geYKeEaKrxWaYBhXwA=Opg@mail.gmail.com>
	<20171010150628.GI30015@redhat.com>
	<20171010180110.GI3246@localhost.localdomain>
	<20171015044800-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171015044800-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/7] hw/misc: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Sun, Oct 15, 2017 at 04:56:28AM +0300, Michael S. Tsirkin wrote:
> On Tue, Oct 10, 2017 at 03:01:10PM -0300, Eduardo Habkost wrote:
> > On Tue, Oct 10, 2017 at 04:06:28PM +0100, Daniel P. Berrange wrote:
> > > On Tue, Oct 10, 2017 at 05:00:18PM +0200, Marc-Andr=E9 Lureau wrote=
:
> > > > Hi
> > > >=20
> > > > On Tue, Oct 10, 2017 at 10:31 AM, Daniel P. Berrange
> > > > <berrange@redhat.com> wrote:
> > > > > On Tue, Oct 10, 2017 at 12:44:26AM +0300, Michael S. Tsirkin wr=
ote:
> > > > >> On Mon, Oct 09, 2017 at 02:02:18PM +0100, Daniel P. Berrange w=
rote:
> > > > >> > On Mon, Oct 09, 2017 at 02:43:44PM +0200, Igor Mammedov wrot=
e:
> > > > >> > > On Mon, 9 Oct 2017 12:03:36 +0100
> > > > >> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > > > >> > >
> > > > >> > > > On Mon, Sep 11, 2017 at 06:59:24PM +0200, Marc-Andr=E9 L=
ureau wrote:
> > > > >> > > > > See docs/specs/vmcoreinfo.txt for details.
> > > > >> > > > >
> > > > >> > > > > "etc/vmcoreinfo" fw_cfg entry is added when using "-de=
vice vmcoreinfo".
> > > > >> > > >
> > > > >> > > > I'm wondering if you considered just adding the entry to=
 fw_cfg by
> > > > >> > > > default, without requiring any -device arg ? Unless I'm =
misunderstanding,
> > > > >> > > > this doesn't feel like a device to me - its just a well =
known bucket
> > > > >> > > > in fw_cfg IIUC ?  Obviously its existance would need to =
be tied to
> > > > >> > > > the latest machine type for ABI reasons though. The bene=
fit of this
> > > > >> > > > is that it would "just work" without us having to plumb =
it through to
> > > > >> > > > all the downstream applications that use QEMU for mgmt g=
uest (OpenStack,
> > > > >> > > > oVirt, GNOME Boxes, virt-manager, and countless other mg=
mt apps).
> > > > >> > > it follows model set by pvpanic device, it's easier to man=
age from migration
> > > > >> > > POV, one could use it even for old machine types with new =
qemu (just by adding
> > > > >> > > device, it makes instance not backwards migratable to old =
qemu but should work
> > > > >> > > for forward migration) and if user doesn't need it, device=
 could be just omitted
> > > > >> > > from CLI.
> > > > >> >
> > > > >> > Sure but it means that in effect no one will have this funct=
ionality enabled
> > > > >> > for several years. pvpanic has been around a long time and I=
 rarely see it
> > > > >> > present in configured guests :-(
> > > > >> >
> > > > >> >
> > > > >> > Regards,
> > > > >> > Daniel
> > > > >>
> > > > >> libvirt runs with -nodefaults, right? I'd argue pretty strongl=
y -nodefaults
> > > > >> shouldn't add optional devices anyway.
> > > > >
> > > > > This isn't really adding a device though is it - it is just a w=
ell known
> > > > > location in fw_cfg to receive data.
> > > >=20
> > > > Enabling the device on some configurations by default can be done=
 as a
> > > > follow-up patch. Can we get this series reviewed & merged?
> > >=20
> > > The problem with the -device approach + turning it on by default is=
 that there
> > > is no way to turn it off again if you don't want it. eg there's way=
 to undo
> > > an implicit '-device foo' except via -nodefaults, but since libvirt=
 uses that
> > > already it would negate the effect of enabling it by default uncond=
itionally.
> >=20
> > It's still possible to add a -machine option that can
> > enable/disable automatic creation of the device.
> >=20
> > But I also don't see why it needs to be implemented using -device
> > if it's not really a device.  A boolean machine or fw_cfg
> > property is good enough for that.
>=20
> It certainly feels like a device. It has state
> (that needs to be migrated), it has a host/guest interface.

(Sorry for the late reply)

That's convincing enough to me.  :)


> > >=20
> > > Your previous approach of "-global fw_cfg.vmcoreinfo=3Don" is nicer=
 in this
> > > respect, as you can trivially turn it on/off, overriding the defaul=
t state
> > > in both directions.
> >=20
> > Both "-global fw_cfg.vmcoreinfo=3Don|off" and
> > "-machine vmcoreinfo=3Don|off" sound good enough to me.
>=20
>=20
> Certainly not a fw cfg flag. Can be a machine flag I guess
> but then we'd have to open-code each such device.
> And don't forget auto - this is what Daniel asks for.

I'm not sure Daniel is really asking for "auto": he is just
asking for a way to disable the new default.  If "vmcoreinfo=3Doff"
and "vmcoreinfo=3Doff" works, there's no need for a user-visible
"auto" value.

(Actually, "auto" values makes compatibility code even messier,
because we would need one additional compat property/field to
tell QEMU what "auto" means on each machine)

--=20
Eduardo
