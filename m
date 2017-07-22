Received: from eggs.gnu.org ([2001:4830:134:3::10]:45613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYjQu-00011i-Va
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYjQr-0001gZ-Sk
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:42:17 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dYjQr-0001gK-Ly
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:42:13 -0400
Received: by mail-io0-x242.google.com with SMTP id l7so4461553iof.5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:42:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170722023020-mutt-send-email-mst@kernel.org>
Date: Fri, 21 Jul 2017 21:42:09 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFA75B9E-8237-450A-A4F5-515D03622AC7@gmail.com>
References: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
	<20170721094955.GH17693@redhat.com>
	<20170721121048.44d617ea@nial.brq.redhat.com>
	<20170722023020-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: force FADT rev1 for old i440fx
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Phil Dennis-Jordan <lists@philjordan.eu>


> On Jul 21, 2017, at 7:40 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> On Fri, Jul 21, 2017 at 12:10:48PM +0200, Igor Mammedov wrote:
>> On Fri, 21 Jul 2017 10:49:55 +0100
>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>>=20
>>> On Fri, Jul 21, 2017 at 11:32:11AM +0200, Igor Mammedov wrote:
>>>> w2k used to boot on QEMU until we bumped revision of FADT to rev3
>>>> (commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 =
to improve guest OS support.)
>>>>=20
>>>> Considering that w2k is ancient and long time EOLed, leave default
>>>> rev3 but make pc-i440fx-2.9 and older machine types to force rev1
>>>> so old setups won't break (w2k could boot). =20
>>>=20
>>> There needs to be a machine type property added to control this
>>> feature. When provisioning new VMs, management apps need to be
>>> able to set the property explicitly - having them rely on picking
>>> particular machine type name+versions is not viable, because
>>> downstream vendors replace the machine types with their own
>>> names + versions.
>> having property doesn't really help here and we don't do it for every
>> compat tweak /ex: save_tsc_khz, linuxboot_dma_enabled/.
>>=20
>> Management would not benefit much from having property vs machine =
version
>> as it would have to encode somewhere that for w2k it should set
>> some machine property or pick a particular machine type.
>=20
> I think I'd disagree with that. If
> users might need this for compatibility with some guests,
> then it should be a property not just a machine type.
>=20
> But see below - I think we rushed it for the PC anyway.
>=20
>> Probably no one would worry about fixing virt-install or something
>> else for the sake of w2k and if they are going to fix it
>> it doesn't matter if they map machine type vs property.
>>=20
>> Also with new machine type deprecation policy we would be able
>> easily to phase out rev1 support along with 2.9 machine,
>> but if you expose property then removing it would break
>> CLI not only for 2.9 but possible later machines if it's set there.
>>=20
>> So I'm against adding properties/CLI options for unless we have to in =
this case,
>> and I'm not convinced that w2k deserves it.
>=20
> If I have to choose, I'd say Mac OSX is way less interesting than old
> windows versions. Lots of people have software that will only run on =
old
> windows and there's probably good money to be had running it on new
> hardware in VMs. And PC machine is all about compatibility - we have =
Q35
> for new stuff.  Besides OSX uses q35 anyway I think.
>=20
> So maybe the right thing to do is to
> - switch default for PC back to rev 1
> - keep default for Q35 at rev 3
>=20
> No machinetype hacks.

I agree with your ideas.
