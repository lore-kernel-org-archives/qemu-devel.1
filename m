Received: from eggs.gnu.org ([2001:4830:134:3::10]:36722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eldCV-0005sT-8i
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eldCS-0001Z6-H1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:12:59 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eldCS-0001Yv-Bl
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:12:56 -0500
Received: by mail-qk0-f194.google.com with SMTP id g2so2027911qkd.12
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:12:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-29-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-29-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 17:12:55 +0100
Message-ID: <CAMxuvazZT6G3A64ELXGVebLm8ks5cUYfj_H_9aV87-YV2Be-tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 28/29] Fix up dangling references to
 qmp-commands.* in comment and doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>

On Sun, Feb 11, 2018 at 10:36 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Fix up the reference to qmp-commands.hx in qmp.c.  Missed in commit
> 5032a16d1d.
>
> Fix up the reference to qmp-commands.txt in
> docs/xen-save-devices-state.txt.  Missed in commit 4d8bb958fa.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/xen-save-devices-state.txt |  3 +--
>  qmp.c                           | 14 +++++++-------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/docs/xen-save-devices-state.txt b/docs/xen-save-devices-stat=
e.txt
> index a72ecc8081..1912ecad25 100644
> --- a/docs/xen-save-devices-state.txt
> +++ b/docs/xen-save-devices-state.txt
> @@ -8,8 +8,7 @@ These operations are normally used with migration (see mi=
gration.txt),
>  however it is also possible to save the state of all devices to file,
>  without saving the RAM or the block devices of the VM.
>
> -This operation is called "xen-save-devices-state" (see
> -qmp-commands.txt)
> +The save operation is available as QMP command xen-save-devices-state.
>
>
>  The binary format used in the file is the following:
> diff --git a/qmp.c b/qmp.c
> index a8d4eba973..ba82e1df9f 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -147,13 +147,13 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
>
>  #ifndef CONFIG_SPICE
>  /*
> - * qmp-commands.hx ensures that QMP command query-spice exists only
> - * #ifdef CONFIG_SPICE.  Necessary for an accurate query-commands
> - * result.  However, the QAPI schema is blissfully unaware of that,
> - * and the QAPI code generator happily generates a dead
> - * qmp_marshal_query_spice() that calls qmp_query_spice().  Provide it
> - * one, or else linking fails.  FIXME Educate the QAPI schema on
> - * CONFIG_SPICE.
> + * qmp_unregister_commands_hack() ensures that QMP command query-spice
> + * exists only #ifdef CONFIG_SPICE.  Necessary for an accurate
> + * query-commands result.  However, the QAPI schema is blissfully
> + * unaware of that, and the QAPI code generator happily generates a
> + * dead qmp_marshal_query_spice() that calls qmp_query_spice().
> + * Provide it one, or else linking fails.  FIXME Educate the QAPI
> + * schema on CONFIG_SPICE.
>   */

I hope this comment will go away soon,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  SpiceInfo *qmp_query_spice(Error **errp)
>  {
> --
> 2.13.6
>
