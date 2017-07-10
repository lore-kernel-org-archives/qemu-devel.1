Received: from eggs.gnu.org ([2001:4830:134:3::10]:37950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUUw9-000724-3l
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUUw5-0000p5-WD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUUw5-0000oo-Pw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:24:57 -0400
References: <1499705121-71730-1-git-send-email-peng.hao2@zte.com.cn>
	<CAJ+F1CJqKTj4ChAy6C94EJFOjXU3Bmu=bWGvfTEBVA2AXhYTgQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c898452-9ce4-1790-b3d5-63f103897c04@redhat.com>
Date: Mon, 10 Jul 2017 11:24:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJqKTj4ChAy6C94EJFOjXU3Bmu=bWGvfTEBVA2AXhYTgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: fix parallel device can't be
 reconnect.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peng Hao <peng.hao2@zte.com.cn>
Cc: wang.yechao255@zte.com.cn, qemu-devel@nongnu.org



On 10/07/2017 11:17, Marc-Andr=C3=A9 Lureau wrote:
>     Parallel device don't register be->chr_can_read function, but remot=
e
>     disconnect event is handled in chr_read.
>     So connected parallel device can not detect remote disconnect event=
.
>=20
> What is it that you call a parallel device? you are modifying the socke=
t
> code here. Could you describe a test setup? even better would be to
> write a test in test-char.c.

If I understand the patch correctly, the parallel device is the parallel
port emulation.

It's still not clear to me what scenario the patch is fixing, and the
patch is wrong anyway:

1) because the backend is not supposed to know the details of the
frontend that is connected to it;

2) because the character device's label is not a reliable indicator for
the frontend type (there is no such indicator, because of point 1).

Paolo
