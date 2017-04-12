Received: from eggs.gnu.org ([2001:4830:134:3::10]:40058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyKWv-0004Py-LI
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyKWu-00068k-Cx
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:50:01 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:35886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cyKWu-00068c-6Q
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:50:00 -0400
Received: by mail-lf0-x22d.google.com with SMTP id s141so16555291lfe.3
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 08:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
In-Reply-To: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Apr 2017 15:49:47 +0000
Message-ID: <CAJ+F1CKE9YDJbJEUSvxY2RjT_NQxM4+WDMwO9bJccWrVcvBfdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] WinDbg module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, pbonzini@redhat.com

Hi

On Wed, Apr 12, 2017 at 6:44 PM Mihail Abakumov <mikhail.abakumov@ispras.ru=
>
wrote:

> Hello.
>
> We made the debugger module WinDbg (like GDB) for QEMU. This is the
> replacement of the remote stub in Windows kernel. Used for remote
> Windows kernel debugging without debugging mode.
>
> The latest build and instructions for the launch can be found here:
> https://github.com/ispras/qemu/releases/tag/v2.7.50-windbg
>
> Currently only one ways to create a remote debugging connection is
> supported: using COM port with named pipe.
>
> Should I prepare patches for inclusion in the master branch? Or is it
> too specific module and it is not needed?
>

Great news! A few years ago, I looked into this with a colleague to speed
up debugging, but we were stuck (can't remember the blocking factor, but
the lack of documentation was not helping). I think some windows driver
developers would be quite happy with it, which makes it a good candidate
for inclusion. Please prepare patches!


--=20
Marc-Andr=C3=A9 Lureau
