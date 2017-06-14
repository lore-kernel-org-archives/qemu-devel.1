Received: from eggs.gnu.org ([2001:4830:134:3::10]:41746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL6Hf-0001Fw-Rn
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL6Hc-0004Bd-Id
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:16:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL6Hc-0004B8-Cc
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:16:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497421386.11748.1.camel@redhat.com> (Gerd Hoffmann's message of
	"Wed, 14 Jun 2017 08:23:06 +0200")
References: <1497411544-80213-1-git-send-email-liqiang6-s@360.cn>
	<149741206273.576.11299001383096762722@4a9a010726c0>
	<CAKXe6SLoc3XPMaSme-qWjQJOyrJLKZyMyX-zCiuHtiL4c2ZmVA@mail.gmail.com>
	<1497421386.11748.1.camel@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 13:16:12 +0200
Message-ID: <87o9tqes5f.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: xhci: fix info leak when writing
 event to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>, famz@redhat.com, P J P <ppandit@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>>=C2=A0> CC=C2=A0 =C2=A0 =C2=A0 hw/timer/a9gtimer.o
>> > In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
>> > /tmp/qemu-test/src/include/migration/register.h:18: error:
>> > redefinition of typedef =E2=80=98LoadStateHandler=E2=80=99
>> > /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous
>> > declaration of =E2=80=98LoadStateHandler=E2=80=99 was here
>>=20
>>=20
>> Seems not related with my patch.
>
> Indeed, master branch seems to be broken, I got a few more of these
> already ...

It was me.  New compliers work with a repeated typedef, so I didn't
noticed.  For a fast fix, look at the list for my last patch.  Going to
send the PULL request when everything finish compiling.

Sorry, Juan.
