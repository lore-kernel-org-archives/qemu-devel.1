Received: from eggs.gnu.org ([2001:4830:134:3::10]:57659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cOnjH-0007wk-94
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cOnjC-0000wB-D6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:43:55 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:36786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cOnjC-0000w0-8N
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:43:50 -0500
Received: by mail-io0-x22d.google.com with SMTP id p127so11129395iop.3
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 07:43:50 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1483519059.5670.42.camel@redhat.com>
Date: Wed, 4 Jan 2017 10:43:46 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <F241C3F2-6C7F-47EC-8D3F-6A51BCD8223B@gmail.com>
References: <376FE1EF-577A-4BE3-B398-99ACB7F280F4@gmail.com>
	<1483433944.24493.3.camel@redhat.com>
	<D2287F42-8073-421D-9920-3048D63B41E3@gmail.com>
	<1483519059.5670.42.camel@redhat.com>
Subject: Re: [Qemu-devel] Speed menu for GTK interfaace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Jan 4, 2017, at 3:37 AM, Gerd Hoffmann wrote:

>  Hi,
>=20
>> It is quite simple, there would be a 100% to a 1% menu item. It would =
look like
>> this:
>>=20
>> Speed
>> -------
>> 100%
>> 90%
>> 80%
>> 70%
>> 60%
>> 50%
>> 40%
>> 30%
>> 20%
>> 10%
>> 1%
>>=20
>>=20
>> Each menu item would call cpu_throttle_set(). The value sent to this =
function would
>> be determined like this:
>> speed =3D -1 * menu_number + 100;
>=20
> ok, that is the info I was looking for.
>=20
>> speed would be sent to the cpu_throttle_set() function. This function =
would reduce
>> the CPU usage of QEMU on the host.=20
>>=20
>> Why would someone want to slow down QEMU?
>> - The user is using a laptop and don't want it to heat up.
>=20
> Sort-of makes sense, to keep the laptop quiet.
>=20
>> - The user wants to slow down a video game that is a little too =
challenging.
>=20
> Sure this would work?  Throttling isn't a smooth slowdown, the cpu
> continues to run at full speed and is forced to pause now and then.
>=20
>> - The user wants to save energy.
>=20
> Pointless.  Laptop may run longer, but your job needs more time to
> complete too.  And constant vcpu start/stop isn't good to save power,
> the cpus can't enter deep sleep states then because of the frequent
> wakeups.
>=20
>> - The user wants to conduct some kind of stress test on a program and =
see how
>> it handles under low cpu resources.=20
>=20
> Makes sense too.
>=20
> We already have "pause" in gtk, adding a "throttle" item next to it
> looks reasonable to me.  I don't think it is that useful to have 10%
> steps in there, you probably never throttle 10% in practice.  It's
> probably more useful to have something like "throttle -> off / 50% /
> 90% / 95% / 99%".

Actually the 10% one is the one I use the most. I use it when I have to
test code in OpenBIOS. I wouldn't mind adding a 95% menu item.
