Received: from eggs.gnu.org ([2001:4830:134:3::10]:33438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvO9c-0005A2-0P
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvO5z-00014F-Pq
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:38:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvO5z-00013f-Jq
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03D5E40241EE
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 14:38:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-2-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 16:38:47 +0200
In-Reply-To: <20180827222322.26009-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 28 Aug 2018 00:23:14 +0200")
Message-ID: <87ftyv2a2w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] char.h: fix gtk-doc comment style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Use the gtk-doc function comment style, as documented in:
> https://developer.gnome.org/gtk-doc-manual/stable/documenting_symbols.htm=
l.en

I'm no friend of this style, but these headers use it already, except
they get it wrong in places.  Your subject's "fix" expresses that, but
then your commit message body suggests a conversion to gtk-doc style.
Suggest to replace it by

  Fix up conformance to GTK-Doc function comment style, as documented in
  https://developer.gnome.org/gtk-doc-manual/stable/documenting_symbols.htm=
l.en

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char-fe.h | 81 ++++++++++++++++++---------------------
>  include/chardev/char.h    | 61 +++++++++++++----------------
>  2 files changed, 63 insertions(+), 79 deletions(-)
>
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index c67271f1ba..21071f1fb1 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -20,7 +20,7 @@ struct CharBackend {
>  };
>=20=20
>  /**
> - * @qemu_chr_fe_init:
> + * qemu_chr_fe_init:

Preexisting: fails to document parameters.  Leaving them undocumented is
acceptable for this style-fix patch.  More of the same below.

>   *
>   * Initializes a front end for the given CharBackend and
>   * Chardev. Call qemu_chr_fe_deinit() to remove the association and
> @@ -31,7 +31,7 @@ struct CharBackend {
>  bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
>=20=20
>  /**
> - * @qemu_chr_fe_deinit:
> + * qemu_chr_fe_deinit:
>   * @b: a CharBackend
>   * @del: if true, delete the chardev backend
>  *
> @@ -42,9 +42,9 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error=
 **errp);
>  void qemu_chr_fe_deinit(CharBackend *b, bool del);
>=20=20
>  /**
> - * @qemu_chr_fe_get_driver:
> + * qemu_chr_fe_get_driver:
>   *
> - * Returns the driver associated with a CharBackend or NULL if no
> + * Returns: the driver associated with a CharBackend or NULL if no
>   * associated Chardev.
>   * Note: avoid this function as the driver should never be accessed dire=
ctly,
>   *       especially by the frontends that support chardevice hotswap.
> @@ -53,21 +53,21 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del);
>  Chardev *qemu_chr_fe_get_driver(CharBackend *be);
>=20=20
>  /**
> - * @qemu_chr_fe_backend_connected:
> + * qemu_chr_fe_backend_connected:
>   *
> - * Returns true if there is a chardevice associated with @be.
> + * Returns: true if there is a chardevice associated with @be.
>   */
>  bool qemu_chr_fe_backend_connected(CharBackend *be);
>=20=20
>  /**
> - * @qemu_chr_fe_backend_open:
> + * qemu_chr_fe_backend_open:
>   *
> - * Returns true if chardevice associated with @be is open.
> + * Returns: true if chardevice associated with @be is open.
>   */
>  bool qemu_chr_fe_backend_open(CharBackend *be);
>=20=20
>  /**
> - * @qemu_chr_fe_set_handlers:
> + * qemu_chr_fe_set_handlers:
>   * @b: a CharBackend
>   * @fd_can_read: callback to get the amount of data the frontend may
>   *               receive
> @@ -95,7 +95,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>                                bool set_open);
>=20=20
>  /**
> - * @qemu_chr_fe_take_focus:
> + * qemu_chr_fe_take_focus:
>   *
>   * Take the focus (if the front end is muxed).
>   *
> @@ -104,14 +104,14 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>  void qemu_chr_fe_take_focus(CharBackend *b);
>=20=20
>  /**
> - * @qemu_chr_fe_accept_input:
> + * qemu_chr_fe_accept_input:
>   *
>   * Notify that the frontend is ready to receive data
>   */
>  void qemu_chr_fe_accept_input(CharBackend *be);
>=20=20
>  /**
> - * @qemu_chr_fe_disconnect:
> + * qemu_chr_fe_disconnect:
>   *
>   * Close a fd accepted by character backend.
>   * Without associated Chardev, do nothing.
> @@ -119,7 +119,7 @@ void qemu_chr_fe_accept_input(CharBackend *be);
>  void qemu_chr_fe_disconnect(CharBackend *be);
>=20=20
>  /**
> - * @qemu_chr_fe_wait_connected:
> + * qemu_chr_fe_wait_connected:
>   *
>   * Wait for characted backend to be connected, return < 0 on error or
>   * if no associated Chardev.

Preexisting: missing Returns:.  Again, leaving it that way is acceptable
for this style-fix patch.

> @@ -127,19 +127,18 @@ void qemu_chr_fe_disconnect(CharBackend *be);
>  int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
>=20=20
>  /**
> - * @qemu_chr_fe_set_echo:
> + * qemu_chr_fe_set_echo:
> + * @echo true to enable echo, false to disable echo

Colon after @echo, please.

>   *
>   * Ask the backend to override its normal echo setting.  This only really
>   * applies to the stdio backend and is used by the QMP server such that =
you
>   * can see what you type if you try to type QMP commands.
>   * Without associated Chardev, do nothing.
> - *
> - * @echo true to enable echo, false to disable echo
>   */
>  void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
>=20=20
>  /**
> - * @qemu_chr_fe_set_open:
> + * qemu_chr_fe_set_open:
>   *
>   * Set character frontend open status.  This is an indication that the
>   * front end is ready (or not) to begin doing I/O.
> @@ -148,83 +147,77 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool ech=
o);
>  void qemu_chr_fe_set_open(CharBackend *be, int fe_open);
>=20=20
>  /**
> - * @qemu_chr_fe_printf:
> + * qemu_chr_fe_printf:
> + * @fmt see #printf

Likewise.

>   *
>   * Write to a character backend using a printf style interface.  This
>   * function is thread-safe. It does nothing without associated
>   * Chardev.
> - *
> - * @fmt see #printf
>   */
>  void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
>=20=20
>  /**
> - * @qemu_chr_fe_add_watch:
> + * qemu_chr_fe_add_watch:
> + * @cond the condition to poll for
> + * @func the function to call when the condition happens
> + * @user_data the opaque pointer to pass to @func

Likewise.

>   *
>   * If the backend is connected, create and add a #GSource that fires
>   * when the given condition (typically G_IO_OUT|G_IO_HUP or G_IO_HUP)
>   * is active; return the #GSource's tag.  If it is disconnected,
>   * or without associated Chardev, return 0.
>   *
> - * @cond the condition to poll for
> - * @func the function to call when the condition happens
> - * @user_data the opaque pointer to pass to @func
> - *
>   * Returns: the source tag
>   */
>  guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
>                              GIOFunc func, void *user_data);
>=20=20
>  /**
> - * @qemu_chr_fe_write:
> + * qemu_chr_fe_write:
> + * @buf the data
> + * @len the number of bytes to send

Likewise.

>   *
>   * Write data to a character backend from the front end.  This function
>   * will send data from the front end to the back end.  This function
>   * is thread-safe.
>   *
> - * @buf the data
> - * @len the number of bytes to send
> - *
>   * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
>=20=20
>  /**
> - * @qemu_chr_fe_write_all:
> + * qemu_chr_fe_write_all:
> + * @buf the data
> + * @len the number of bytes to send

Likewise.

>   *
>   * Write data to a character backend from the front end.  This function =
will
>   * send data from the front end to the back end.  Unlike @qemu_chr_fe_wr=
ite,
>   * this function will block if the back end cannot consume all of the da=
ta
>   * attempted to be written.  This function is thread-safe.
>   *
> - * @buf the data
> - * @len the number of bytes to send
> - *
>   * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
[...]

With the missing colons fixed, and preferably with the commit message
clarified:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
