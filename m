Received: from eggs.gnu.org ([2001:4830:134:3::10]:33641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e1w17-0007Or-CV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e1w16-0004Ua-Bs
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:00:21 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:49775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e1w16-0004U4-72
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:00:20 -0400
Received: by mail-oi0-x22c.google.com with SMTP id w197so41030449oif.6
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 08:00:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010083143.GA30015@redhat.com>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
	<20170911165929.2791-3-marcandre.lureau@redhat.com>
	<20171009110336.GA17824@redhat.com>
	<20171009144344.38bbd1e9@nial.brq.redhat.com>
	<20171009130218.GK2954@redhat.com>
	<20171010003951-mutt-send-email-mst@kernel.org>
	<20171010083143.GA30015@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Oct 2017 17:00:18 +0200
Message-ID: <CAJ+F1CLGJLXYnJ8SnrbVkWc6bdU2geYKeEaKrxWaYBhXwA=Opg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Hi

On Tue, Oct 10, 2017 at 10:31 AM, Daniel P. Berrange
<berrange@redhat.com> wrote:
> On Tue, Oct 10, 2017 at 12:44:26AM +0300, Michael S. Tsirkin wrote:
>> On Mon, Oct 09, 2017 at 02:02:18PM +0100, Daniel P. Berrange wrote:
>> > On Mon, Oct 09, 2017 at 02:43:44PM +0200, Igor Mammedov wrote:
>> > > On Mon, 9 Oct 2017 12:03:36 +0100
>> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
>> > >
>> > > > On Mon, Sep 11, 2017 at 06:59:24PM +0200, Marc-Andr=C3=A9 Lureau w=
rote:
>> > > > > See docs/specs/vmcoreinfo.txt for details.
>> > > > >
>> > > > > "etc/vmcoreinfo" fw_cfg entry is added when using "-device vmcor=
einfo".
>> > > >
>> > > > I'm wondering if you considered just adding the entry to fw_cfg by
>> > > > default, without requiring any -device arg ? Unless I'm misunderst=
anding,
>> > > > this doesn't feel like a device to me - its just a well known buck=
et
>> > > > in fw_cfg IIUC ?  Obviously its existance would need to be tied to
>> > > > the latest machine type for ABI reasons though. The benefit of thi=
s
>> > > > is that it would "just work" without us having to plumb it through=
 to
>> > > > all the downstream applications that use QEMU for mgmt guest (Open=
Stack,
>> > > > oVirt, GNOME Boxes, virt-manager, and countless other mgmt apps).
>> > > it follows model set by pvpanic device, it's easier to manage from m=
igration
>> > > POV, one could use it even for old machine types with new qemu (just=
 by adding
>> > > device, it makes instance not backwards migratable to old qemu but s=
hould work
>> > > for forward migration) and if user doesn't need it, device could be =
just omitted
>> > > from CLI.
>> >
>> > Sure but it means that in effect no one will have this functionality e=
nabled
>> > for several years. pvpanic has been around a long time and I rarely se=
e it
>> > present in configured guests :-(
>> >
>> >
>> > Regards,
>> > Daniel
>>
>> libvirt runs with -nodefaults, right? I'd argue pretty strongly -nodefau=
lts
>> shouldn't add optional devices anyway.
>
> This isn't really adding a device though is it - it is just a well known
> location in fw_cfg to receive data.

Enabling the device on some configurations by default can be done as a
follow-up patch. Can we get this series reviewed & merged?

thanks

--=20
Marc-Andr=C3=A9 Lureau
