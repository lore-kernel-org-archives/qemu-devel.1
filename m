Received: from eggs.gnu.org ([2001:4830:134:3::10]:48474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cXq2F-0004QQ-SO
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 09:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cXq2E-0000RI-4z
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 09:00:51 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cXq2D-0000RD-Vm
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 09:00:50 -0500
Received: by mail-yw0-x242.google.com with SMTP id u68so27738551ywg.0
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 06:00:48 -0800 (PST)
MIME-Version: 1.0
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<874m0peu50.fsf@dusky.pond.sub.org>
	<533e0b17-4d60-a584-5680-559834013c68@web.de>
	<87inp05m8m.fsf@dusky.pond.sub.org>
	<4504afce-c62e-c54f-33a3-483f16dc4530@web.de>
In-Reply-To: <4504afce-c62e-c54f-33a3-483f16dc4530@web.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 29 Jan 2017 14:00:36 +0000
Message-ID: <CAJ+F1C+UmEz_On1cGSrYDL0FZXqqeURV93nAvbnLA71WpNoL4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Wei Wang <wei.w.wang@intel.com>

Hi

On Sun, Jan 29, 2017 at 12:44 PM Jan Kiszka <jan.kiszka@web.de> wrote:

> >> Of course, I'm careful with investing much time into expanding the
> >> existing, for Jailhouse possibly sufficient design if there no real
> >> interest in continuing the ivshmem support in QEMU - because of
> >> vhost-pci or other reasons. But if that interest exists, it would be
> >> beneficial for us to have QEMU supporting a compatible version and usi=
ng
> >> the same guest drivers. Then I would start looking into concrete patch=
es
> >> for it as well.
> >
> > Interest is difficult for me to gauge, not least because alternatives
> > are still being worked on.
>
> I'm considering to suggest this as GSoC project now.
>

It's better for a student and for the community if the work get accepted in
the end.

So, I think that could be an intersting GSoC (implementing your ivshmem 2
proposal). However, if the qemu community isn't ready to accept a new
ivshmem, and would rather have vhost-pci based solution, I would suggest a
different project (hopefully Wei Wang can help define it and mentor): work
on a vhost-pci using dedicated shared PCI BARs (and kernel support to avoid
extra copy - if I understand the extra copy situation correctly).
--=20
Marc-Andr=C3=A9 Lureau
