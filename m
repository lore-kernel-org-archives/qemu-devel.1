Received: from eggs.gnu.org ([2001:4830:134:3::10]:50785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCpEb-0001IK-SA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCpEX-0005vM-A7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCpEW-0005uO-RH
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:03:45 -0400
References: <CAEkmjvWv=CCf-Y4kDqG=Z-Fb2jPBUBVzHzy69rTxDinPZQ72YQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc2c7265-193c-257f-6594-6d538133b8b2@redhat.com>
Date: Wed, 17 Oct 2018 19:03:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAEkmjvWv=CCf-Y4kDqG=Z-Fb2jPBUBVzHzy69rTxDinPZQ72YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU hangs in main_loop_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frank Yang <lfy@google.com>, qemu-devel <qemu-devel@nongnu.org>

On 17/10/2018 17:44, Frank Yang wrote:
>=20
> we are not seeing hangs in flatview_do_translate, but are still getting
> hangs in main-loop:
>=20
> =C2=A0 =C2=A0 qemu_mutex_unlock_iothread();
> =C2=A0 =C2=A0 replay_mutex_unlock();
>=20
> =C2=A0 =C2=A0 ret =3D qemu_poll_ns((GPollFD *)gpollfds->data, gpollfds-=
>len,
> timeout); <-------------this seems to be the hanging part
>=20
> =C2=A0 =C2=A0 replay_mutex_lock();
> =C2=A0 =C2=A0 qemu_mutex_lock_iothread();
>=20
> Any idea how to diagnose the cause of taking too much time in g_poll in
> qemu_poll_ns?

Is there any event (timer or file descriptor) that you know should be
ready, but is not causing a wakeup?

Paolo
