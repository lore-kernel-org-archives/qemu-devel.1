Received: from eggs.gnu.org ([2001:4830:134:3::10]:34430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1UWA-0005Zy-6Z
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1UW5-0002SS-Hy
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:38:34 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:46183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e1UW5-0002Ri-CO
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:38:29 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m72so20772210wmc.1
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 02:38:28 -0700 (PDT)
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-79-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171006235023.11952-79-f4bug@amsat.org>
Date: Mon, 09 Oct 2017 10:38:26 +0100
Message-ID: <877ew4bqzx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 78/88] gdb: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 2a94030d3b..5f0d8af1c0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1786,7 +1786,7 @@ static void gdb_accept(void)
>      /* set short latency */
>      socket_set_nodelay(fd);
>
> -    s =3D g_malloc0(sizeof(GDBState));
> +    s =3D g_new0(GDBState, 1);
>      s->c_cpu =3D first_cpu;
>      s->g_cpu =3D first_cpu;
>      s->fd =3D fd;
> @@ -1980,7 +1980,7 @@ int gdbserver_start(const char *device)
>
>      s =3D gdbserver_state;
>      if (!s) {
> -        s =3D g_malloc0(sizeof(GDBState));
> +        s =3D g_new0(GDBState, 1);
>          gdbserver_state =3D s;
>
>          qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);


--
Alex Benn=C3=A9e
