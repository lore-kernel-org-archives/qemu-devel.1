Received: from eggs.gnu.org ([2001:4830:134:3::10]:47454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1f8Pq4-0000x6-EV
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1f8Ppy-0004i7-PE
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:36:00 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com
	([40.107.2.129]:46976
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1f8Ppx-0004he-Tv
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:35:54 -0400
Date: Tue, 17 Apr 2018 15:35:48 +0300
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Message-ID: <20180417153548.53b08fa1@vp-pc>
In-Reply-To: <CAJ+F1CKf=GCJBOqAc5mTs1G7V7+KsPSukcCYjQAnUFdFa-dhEw@mail.gmail.com>
References: <20180416194011.11969-1-viktor.prutyanov@virtuozzo.com>
	<CAJ+F1CKf=GCJBOqAc5mTs1G7V7+KsPSukcCYjQAnUFdFa-dhEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

On Tue, 17 Apr 2018 14:03:18 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Mon, Apr 16, 2018 at 9:40 PM, Viktor Prutyanov
> <viktor.prutyanov@virtuozzo.com> wrote:
> > This patch adds Windows crashdumping feature. Now QEMU can produce
> > crashdump file understandable for WinDbg. The crashdump will be
> > obtained by joining physical memory dump and 8K header exposed
> > through vmcoreinfo/fw_cfg device by guest driver at BSOD time.
> > Option '-w' was added to dump-guest-memory command. At the moment,
> > only x64 configuration is supported. Suitable driver can be found at
> > https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fwc=
fg64
> >
> > Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com> =20
>=20
> Why do you reuse VMCOREINFO_FORMAT_ELF ? It looks like a hack to me. I
> can imagine there is some code similarity for new format support, like
> the cpu_physical_memory_read(addr, s->guest_note, size), but what else
> do you gain from reusing VMCOREINFO_FORMAT_ELF instead of introducing
> explicitely a new windows dump specific format ? This could really
> help avoiding some confusion imho

Reuse of VMCOREINFO_FORMAT_ELF makes possible to produce valid ELF-dump
which can be converted to Windows dump format later with another tool.=20
