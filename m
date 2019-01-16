Received: from eggs.gnu.org ([209.51.188.92]:45564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjjUz-0005UB-8R
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjjUt-00007J-4X
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gjjUX-00083H-PG
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so6624861otr.10
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 03:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20190116041712.130183-1-aik@ozlabs.ru>
	<20190116041712.130183-2-aik@ozlabs.ru>
In-Reply-To: <20190116041712.130183-2-aik@ozlabs.ru>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 16 Jan 2019 12:36:04 +0100
Message-ID: <CAGxU2F43EjW1Z5KGLehkKF1Y75rGqV0uyOEA+=na+ASPs68k1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH qemu 1/2] update-linux-headers.sh: Copy new
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "open list:PowerPC" <qemu-ppc@nongnu.org>

On Wed, Jan 16, 2019 at 5:20 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> Since Linux'es ab66dcc76d "powerpc: generate uapi header and system call
> table files" there are 2 new files: unistd_32.h and unistd_64.h. These
> files content is moved from unistd.h so now we have to copy new files
> as well, just like we already do for other architectures; this does it
> for MIPS as well.
>
> Also, v5.0-rc2 moved vhost bits around in 4b86713236e4bd
> "vhost: split structs into a separate header file", add those too.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  scripts/update-linux-headers.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
