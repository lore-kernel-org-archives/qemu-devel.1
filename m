Received: from eggs.gnu.org ([2001:4830:134:3::10]:40209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esYrx-0001qr-Hb
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 14:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esYrw-0000ol-E3
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 14:00:25 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esYrw-0000mZ-5d
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 14:00:24 -0500
Received: by mail-ot0-x242.google.com with SMTP id f11so13057929otj.12
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 11:00:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <96ce9600-c1e3-c3d6-5c3d-7d30cf799e04@fransdb.nl>
References: <96ce9600-c1e3-c3d6-5c3d-7d30cf799e04@fransdb.nl>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 4 Mar 2018 19:00:02 +0000
Message-ID: <CAFEAcA9z87FbNr4JUZcuTz7BJ=AC1kE1SSZ+PLybscMDnJZqDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Problem compiling qemu-2.1.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frans de Boer <frans@fransdb.nl>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 March 2018 at 11:15, Frans de Boer <frans@fransdb.nl> wrote:
> LS,
>
> I try to compile qemu and get the next error message:
>
> mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/util/memfd=
.c:40:12:
> error: static declaration of =E2=80=98memfd_create=E2=80=99 follows non-s=
tatic declaration
>  static int memfd_create(const char *name, unsigned int flags)
>             ^~~~~~~~~~~~
> In file included from /usr/include/bits/mman-linux.h:115:0,
>                  from /usr/include/bits/mman.h:45,
>                  from /usr/include/sys/mman.h:41,
>                  from
> /mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/include/s=
ysemu/os-posix.h:29,
>                  from
> /mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/include/q=
emu/osdep.h:104,
>                  from
> /mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/util/memf=
d.c:28:
> /usr/include/bits/mman-shared.h:46:5: note: previous declaration of
> =E2=80=98memfd_create=E2=80=99 was here
>  int memfd_create (const char *__name, unsigned int __flags) __THROW;
>
> I use the newest Tumbleweed of openSuse with the gcc 7.3.0 compiler suite=
.

Hi -- this looks like a QEMU incompatibility with newer glibc that
we fixed in QEMU commit 75e5b70e6b5dcc4. That didn't quite make
the 2.11.0 release, but will be in 2.12.0.

thanks
-- PMM
