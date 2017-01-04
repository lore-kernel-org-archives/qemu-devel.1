Received: from eggs.gnu.org ([2001:4830:134:3::10]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOiKD-00078r-SA
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOiKA-000242-Ph
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:57:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOiKA-000238-K5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:57:38 -0500
Message-ID: <1483519059.5670.42.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 09:37:39 +0100
In-Reply-To: <D2287F42-8073-421D-9920-3048D63B41E3@gmail.com>
References: <376FE1EF-577A-4BE3-B398-99ACB7F280F4@gmail.com>
	<1483433944.24493.3.camel@redhat.com>
	<D2287F42-8073-421D-9920-3048D63B41E3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] Speed menu for GTK interfaace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

  Hi,

> It is quite simple, there would be a 100% to a 1% menu item. It would loo=
k like
> this:
>=20
> Speed
> -------
> 100%
> 90%
> 80%
> 70%
> 60%
> 50%
> 40%
> 30%
> 20%
> 10%
> 1%
>=20
>=20
> Each menu item would call cpu_throttle_set(). The value sent to this func=
tion would
> be determined like this:
> speed =3D -1 * menu_number + 100;

ok, that is the info I was looking for.

> speed would be sent to the cpu_throttle_set() function. This function wou=
ld reduce
> the CPU usage of QEMU on the host.=20
>=20
> Why would someone want to slow down QEMU?
> - The user is using a laptop and don't want it to heat up.

Sort-of makes sense, to keep the laptop quiet.

> - The user wants to slow down a video game that is a little too challengi=
ng.

Sure this would work?  Throttling isn't a smooth slowdown, the cpu
continues to run at full speed and is forced to pause now and then.

> - The user wants to save energy.

Pointless.  Laptop may run longer, but your job needs more time to
complete too.  And constant vcpu start/stop isn't good to save power,
the cpus can't enter deep sleep states then because of the frequent
wakeups.

> - The user wants to conduct some kind of stress test on a program and see=
 how
> it handles under low cpu resources.=20

Makes sense too.

We already have "pause" in gtk, adding a "throttle" item next to it
looks reasonable to me.  I don't think it is that useful to have 10%
steps in there, you probably never throttle 10% in practice.  It's
probably more useful to have something like "throttle -> off / 50% /
90% / 95% / 99%".

cheers,
  Gerd
