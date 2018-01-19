Received: from eggs.gnu.org ([2001:4830:134:3::10]:51373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eccBI-0000fO-PO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eccBE-0000Ir-MI
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:18:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eccBE-0000IA-Fl
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:18:24 -0500
References: <20180119162554.27270-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0bf279e2-0f90-06ee-2779-1a3f67665ecf@redhat.com>
Date: Fri, 19 Jan 2018 20:18:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180119162554.27270-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix python 2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, eblake@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 01/19/18 17:25, Marc-Andr=C3=A9 Lureau wrote:
> Python GDB support may use Python 2 or 3.
>=20
> Inferior.read_memory() may return a 'buffer' with Python 2 or a
> 'memoryview' with Python 3 (see also
> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>=20
> The elf.add_vmcoreinfo_note() method expects a "bytes" object. Wrap
> the returned memory with bytes(), which works with both 'memoryview'
> and 'buffer'.
>=20
> Fixes a regression introduced with commit
> d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 09bec92b50..03fbf69f8a 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -564,7 +564,7 @@ shape and this command should mostly work."""
> =20
>          vmcoreinfo =3D self.phys_memory_read(addr, size)
>          if vmcoreinfo:
> -            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
> +            self.elf.add_vmcoreinfo_note(bytes(vmcoreinfo))
> =20
>      def invoke(self, args, from_tty):
>          """Handles command invocation from gdb."""
>=20

Ugh, can you please point me to the v1->v2 difference?

Thanks
Laszlo
