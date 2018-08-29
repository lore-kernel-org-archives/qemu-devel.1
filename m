Received: from eggs.gnu.org ([2001:4830:134:3::10]:45860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fv3aK-0000vs-AJ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fv3aG-0002zp-AL
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:44:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fv3aG-0002z3-0i
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:44:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62CC84070489
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 16:44:43 +0000 (UTC)
Date: Wed, 29 Aug 2018 17:44:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180829164437.GO4199@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827222322.26009-2-marcandre.lureau@redhat.com>
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com

On Tue, Aug 28, 2018 at 12:23:14AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Use the gtk-doc function comment style, as documented in:
> https://developer.gnome.org/gtk-doc-manual/stable/documenting_symbols.h=
tml.en

I don't think we ever agreed what syntax we are supposed to be using
for inline API docs in QEMU.

I vaguely recall a suggestion that we use the same syntax  that the
kernel uses since they had created some tools that to turn them into
a markup format that was appealing to QEMU for docs integration. I
can't remember the details though.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char-fe.h | 81 ++++++++++++++++++---------------------
>  include/chardev/char.h    | 61 +++++++++++++----------------
>  2 files changed, 63 insertions(+), 79 deletions(-)

Despite the above caveat, I think this change is better than
what is here already, so

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index c67271f1ba..21071f1fb1 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -20,7 +20,7 @@ struct CharBackend {
>  };
> =20
>  /**
> - * @qemu_chr_fe_init:
> + * qemu_chr_fe_init:
>   *
>   * Initializes a front end for the given CharBackend and
>   * Chardev. Call qemu_chr_fe_deinit() to remove the association and
> @@ -31,7 +31,7 @@ struct CharBackend {
>  bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
> =20
>  /**
> - * @qemu_chr_fe_deinit:
> + * qemu_chr_fe_deinit:
>   * @b: a CharBackend
>   * @del: if true, delete the chardev backend
>  *
> @@ -42,9 +42,9 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Err=
or **errp);
>  void qemu_chr_fe_deinit(CharBackend *b, bool del);
> =20
>  /**
> - * @qemu_chr_fe_get_driver:
> + * qemu_chr_fe_get_driver:
>   *
> - * Returns the driver associated with a CharBackend or NULL if no
> + * Returns: the driver associated with a CharBackend or NULL if no
>   * associated Chardev.
>   * Note: avoid this function as the driver should never be accessed di=
rectly,
>   *       especially by the frontends that support chardevice hotswap.
> @@ -53,21 +53,21 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del);
>  Chardev *qemu_chr_fe_get_driver(CharBackend *be);
> =20
>  /**
> - * @qemu_chr_fe_backend_connected:
> + * qemu_chr_fe_backend_connected:
>   *
> - * Returns true if there is a chardevice associated with @be.
> + * Returns: true if there is a chardevice associated with @be.
>   */
>  bool qemu_chr_fe_backend_connected(CharBackend *be);
> =20
>  /**
> - * @qemu_chr_fe_backend_open:
> + * qemu_chr_fe_backend_open:
>   *
> - * Returns true if chardevice associated with @be is open.
> + * Returns: true if chardevice associated with @be is open.
>   */
>  bool qemu_chr_fe_backend_open(CharBackend *be);
> =20
>  /**
> - * @qemu_chr_fe_set_handlers:
> + * qemu_chr_fe_set_handlers:
>   * @b: a CharBackend
>   * @fd_can_read: callback to get the amount of data the frontend may
>   *               receive
> @@ -95,7 +95,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>                                bool set_open);
> =20
>  /**
> - * @qemu_chr_fe_take_focus:
> + * qemu_chr_fe_take_focus:
>   *
>   * Take the focus (if the front end is muxed).
>   *
> @@ -104,14 +104,14 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>  void qemu_chr_fe_take_focus(CharBackend *b);
> =20
>  /**
> - * @qemu_chr_fe_accept_input:
> + * qemu_chr_fe_accept_input:
>   *
>   * Notify that the frontend is ready to receive data
>   */
>  void qemu_chr_fe_accept_input(CharBackend *be);
> =20
>  /**
> - * @qemu_chr_fe_disconnect:
> + * qemu_chr_fe_disconnect:
>   *
>   * Close a fd accepted by character backend.
>   * Without associated Chardev, do nothing.
> @@ -119,7 +119,7 @@ void qemu_chr_fe_accept_input(CharBackend *be);
>  void qemu_chr_fe_disconnect(CharBackend *be);
> =20
>  /**
> - * @qemu_chr_fe_wait_connected:
> + * qemu_chr_fe_wait_connected:
>   *
>   * Wait for characted backend to be connected, return < 0 on error or
>   * if no associated Chardev.
> @@ -127,19 +127,18 @@ void qemu_chr_fe_disconnect(CharBackend *be);
>  int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
> =20
>  /**
> - * @qemu_chr_fe_set_echo:
> + * qemu_chr_fe_set_echo:
> + * @echo true to enable echo, false to disable echo
>   *
>   * Ask the backend to override its normal echo setting.  This only rea=
lly
>   * applies to the stdio backend and is used by the QMP server such tha=
t you
>   * can see what you type if you try to type QMP commands.
>   * Without associated Chardev, do nothing.
> - *
> - * @echo true to enable echo, false to disable echo
>   */
>  void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
> =20
>  /**
> - * @qemu_chr_fe_set_open:
> + * qemu_chr_fe_set_open:
>   *
>   * Set character frontend open status.  This is an indication that the
>   * front end is ready (or not) to begin doing I/O.
> @@ -148,83 +147,77 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool e=
cho);
>  void qemu_chr_fe_set_open(CharBackend *be, int fe_open);
> =20
>  /**
> - * @qemu_chr_fe_printf:
> + * qemu_chr_fe_printf:
> + * @fmt see #printf
>   *
>   * Write to a character backend using a printf style interface.  This
>   * function is thread-safe. It does nothing without associated
>   * Chardev.
> - *
> - * @fmt see #printf
>   */
>  void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
> =20
>  /**
> - * @qemu_chr_fe_add_watch:
> + * qemu_chr_fe_add_watch:
> + * @cond the condition to poll for
> + * @func the function to call when the condition happens
> + * @user_data the opaque pointer to pass to @func
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
> =20
>  /**
> - * @qemu_chr_fe_write:
> + * qemu_chr_fe_write:
> + * @buf the data
> + * @len the number of bytes to send
>   *
>   * Write data to a character backend from the front end.  This functio=
n
>   * will send data from the front end to the back end.  This function
>   * is thread-safe.
>   *
> - * @buf the data
> - * @len the number of bytes to send
> - *
>   * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
> =20
>  /**
> - * @qemu_chr_fe_write_all:
> + * qemu_chr_fe_write_all:
> + * @buf the data
> + * @len the number of bytes to send
>   *
>   * Write data to a character backend from the front end.  This functio=
n will
>   * send data from the front end to the back end.  Unlike @qemu_chr_fe_=
write,
>   * this function will block if the back end cannot consume all of the =
data
>   * attempted to be written.  This function is thread-safe.
>   *
> - * @buf the data
> - * @len the number of bytes to send
> - *
>   * Returns: the number of bytes consumed (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len=
);
> =20
>  /**
> - * @qemu_chr_fe_read_all:
> - *
> - * Read data to a buffer from the back end.
> - *
> + * qemu_chr_fe_read_all:
>   * @buf the data buffer
>   * @len the number of bytes to read
>   *
> + * Read data to a buffer from the back end.
> + *
>   * Returns: the number of bytes read (0 if no associated Chardev)
>   */
>  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
> =20
>  /**
> - * @qemu_chr_fe_ioctl:
> - *
> - * Issue a device specific ioctl to a backend.  This function is threa=
d-safe.
> - *
> + * qemu_chr_fe_ioctl:
>   * @cmd see CHR_IOCTL_*
>   * @arg the data associated with @cmd
>   *
> + * Issue a device specific ioctl to a backend.  This function is threa=
d-safe.
> + *
>   * Returns: if @cmd is not supported by the backend or there is no
>   *          associated Chardev, -ENOTSUP, otherwise the return
>   *          value depends on the semantics of @cmd
> @@ -232,7 +225,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *=
buf, int len);
>  int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg);
> =20
>  /**
> - * @qemu_chr_fe_get_msgfd:
> + * qemu_chr_fe_get_msgfd:
>   *
>   * For backends capable of fd passing, return the latest file descript=
or passed
>   * by a client.
> @@ -245,7 +238,7 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, voi=
d *arg);
>  int qemu_chr_fe_get_msgfd(CharBackend *be);
> =20
>  /**
> - * @qemu_chr_fe_get_msgfds:
> + * qemu_chr_fe_get_msgfds:
>   *
>   * For backends capable of fd passing, return the number of file recei=
ved
>   * descriptors and fills the fds array up to num elements
> @@ -258,7 +251,7 @@ int qemu_chr_fe_get_msgfd(CharBackend *be);
>  int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int num);
> =20
>  /**
> - * @qemu_chr_fe_set_msgfds:
> + * qemu_chr_fe_set_msgfds:
>   *
>   * For backends capable of fd passing, set an array of fds to be passe=
d with
>   * the next send operation.
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 6f0576e214..3e4fe6dad0 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -68,12 +68,11 @@ struct Chardev {
>  };
> =20
>  /**
> - * @qemu_chr_new_from_opts:
> + * qemu_chr_new_from_opts:
> + * @opts: see qemu-config.c for a list of valid options
>   *
>   * Create a new character backend from a QemuOpts list.
>   *
> - * @opts see qemu-config.c for a list of valid options
> - *
>   * Returns: on success: a new character backend
>   *          otherwise:  NULL; @errp specifies the error
>   *                            or left untouched in case of help option
> @@ -82,17 +81,16 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>                                  Error **errp);
> =20
>  /**
> - * @qemu_chr_parse_common:
> + * qemu_chr_parse_common:
> + * @opts: the options that still need parsing
> + * @backend: a new backend
>   *
>   * Parse the common options available to all character backends.
> - *
> - * @opts the options that still need parsing
> - * @backend a new backend
>   */
>  void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
> =20
>  /**
> - * @qemu_chr_parse_opts:
> + * qemu_chr_parse_opts:
>   *
>   * Parse the options to the ChardevBackend struct.
>   *
> @@ -102,49 +100,46 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opt=
s,
>                                      Error **errp);
> =20
>  /**
> - * @qemu_chr_new:
> + * qemu_chr_new:
> + * @label: the name of the backend
> + * @filename: the URI
>   *
>   * Create a new character backend from a URI.
>   *
> - * @label the name of the backend
> - * @filename the URI
> - *
>   * Returns: a new character backend
>   */
>  Chardev *qemu_chr_new(const char *label, const char *filename);
> =20
>  /**
> - * @qemu_chr_change:
> + * qemu_chr_change:
> + * @opts: the new backend options
>   *
>   * Change an existing character backend
> - *
> - * @opts the new backend options
>   */
>  void qemu_chr_change(QemuOpts *opts, Error **errp);
> =20
>  /**
> - * @qemu_chr_cleanup:
> + * qemu_chr_cleanup:
>   *
>   * Delete all chardevs (when leaving qemu)
>   */
>  void qemu_chr_cleanup(void);
> =20
>  /**
> - * @qemu_chr_new_noreplay:
> + * qemu_chr_new_noreplay:
> + * @label: the name of the backend
> + * @filename: the URI
>   *
>   * Create a new character backend from a URI.
>   * Character device communications are not written
>   * into the replay log.
>   *
> - * @label the name of the backend
> - * @filename the URI
> - *
>   * Returns: a new character backend
>   */
>  Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
);
> =20
>  /**
> - * @qemu_chr_be_can_write:
> + * qemu_chr_be_can_write:
>   *
>   * Determine how much data the front end can currently accept.  This f=
unction
>   * returns the number of bytes the front end can accept.  If it return=
s 0, the
> @@ -156,43 +151,39 @@ Chardev *qemu_chr_new_noreplay(const char *label,=
 const char *filename);
>  int qemu_chr_be_can_write(Chardev *s);
> =20
>  /**
> - * @qemu_chr_be_write:
> + * qemu_chr_be_write:
> + * @buf: a buffer to receive data from the front end
> + * @len: the number of bytes to receive from the front end
>   *
>   * Write data from the back end to the front end.  Before issuing this=
 call,
>   * the caller should call @qemu_chr_be_can_write to determine how much=
 data
>   * the front end can currently accept.
> - *
> - * @buf a buffer to receive data from the front end
> - * @len the number of bytes to receive from the front end
>   */
>  void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len);
> =20
>  /**
> - * @qemu_chr_be_write_impl:
> + * qemu_chr_be_write_impl:
> + * @buf: a buffer to receive data from the front end
> + * @len: the number of bytes to receive from the front end
>   *
>   * Implementation of back end writing. Used by replay module.
> - *
> - * @buf a buffer to receive data from the front end
> - * @len the number of bytes to receive from the front end
>   */
>  void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len);
> =20
>  /**
> - * @qemu_chr_be_update_read_handlers:
> + * qemu_chr_be_update_read_handlers:
> + * @context: the gcontext that will be used to attach the watch source=
s
>   *
>   * Invoked when frontend read handlers are setup
> - *
> - * @context the gcontext that will be used to attach the watch sources
>   */
>  void qemu_chr_be_update_read_handlers(Chardev *s,
>                                        GMainContext *context);
> =20
>  /**
> - * @qemu_chr_be_event:
> + * qemu_chr_be_event:
> + * @event: the event to send
>   *
>   * Send an event from the back end to the front end.
> - *
> - * @event the event to send
>   */
>  void qemu_chr_be_event(Chardev *s, int event);
> =20
> --=20
> 2.18.0.547.g1d89318c48
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
