Received: from eggs.gnu.org ([2001:4830:134:3::10]:37556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxm0l-0002kj-TX
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxm0h-00089G-BZ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:58:32 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxm0h-00088j-70
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:58:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id p68so22505105qke.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 19:58:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
	<20170316092121.25672-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <858d9225-7e85-c90c-272e-92584430db37@amsat.org>
Date: Mon, 10 Apr 2017 23:58:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170316092121.25672-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/21] char-socket: add 'connected'
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 03/16/2017 06:21 AM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-socket.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 81021c5863..06389393fa 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1015,6 +1015,14 @@ char_socket_get_addr(Object *obj, Visitor *v, const char *name,
>      visit_type_SocketAddress(v, name, &s->addr, errp);
>  }
>
> +static bool
> +char_socket_get_connected(Object *obj, Error **errp)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(obj);
> +
> +    return s->connected;
> +}
> +
>  static void char_socket_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc = CHARDEV_CLASS(oc);
> @@ -1034,6 +1042,9 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
>      object_class_property_add(oc, "addr", "SocketAddress",
>                                char_socket_get_addr, NULL,
>                                NULL, NULL, &error_abort);
> +
> +    object_class_property_add_bool(oc, "connected", char_socket_get_connected,
> +                                   NULL, &error_abort);
>  }
>
>  static const TypeInfo char_socket_type_info = {
>
