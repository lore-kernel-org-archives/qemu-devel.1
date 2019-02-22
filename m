Received: from eggs.gnu.org ([209.51.188.92]:38607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gx5pd-0007IW-KU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gx5pc-0002Av-Fj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:05:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gx5pc-00027t-4F
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:05:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id e74so1065819wmg.3
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 00:05:15 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Feb 2019 09:04:53 +0100
Message-ID: <CAJ+F1CL8Hzns+ffZYGDmk=LjaLeaALyooUaVcQhCWcGz-qbizA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] seccomp raises on mesa pthread_setaffinity_np()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Otubo <otubo@redhat.com>

Hi,

We have another seccomp issue with mesa, leading to SIGSYS bad system
call (when running a virgl VM with libvirt for example)

Since commit :
https://gitlab.freedesktop.org/mesa/mesa/commit/d877451b48a59ab0f9a4210fc73=
6f51da5851c9a
(unfortunately, already in f29)

mesa wants to set its thread affinity on all CPU, but I am not sure
how we can limit the rule to the mesa threads yet... any ideas?

Another reason to consider vhost-user-gpu, to simplify the seccomp rules!

--=20
Marc-Andr=C3=A9 Lureau
