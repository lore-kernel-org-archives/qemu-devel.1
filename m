Received: from eggs.gnu.org ([2001:4830:134:3::10]:42827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfs-0004HW-NN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfn-0000rz-4f
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:08 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgfn-0000rr-0S
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:03 -0400
Received: by mail-qk0-x244.google.com with SMTP id 17so732750qkq.5
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:13:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-3-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:13:02 +0200
Message-ID: <CAJ+F1CLPXMra-B5yM2AT-W5irDxKpKqh2_qRzyCiOqkbMQxQuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] qemu-options: Fix markup of -netdev
 l2tpv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On Mon, Oct 2, 2017 at 4:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> The table of option parameters lacks @table and @end table.  The
> parameters become items in the enclosing table of options.  Screwed up
> when l2tpv3 was added in commit 3fb69aa.  Fix the obvious way.
>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qemu-options.hx | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0fed2fc009..39f0e1b990 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2367,6 +2367,7 @@ two systems. It is present in routers, firewalls an=
d the Linux kernel
>
>  This transport allows a VM to communicate to another VM, router or firew=
all directly.
>
> +@table @option
>  @item src=3D@var{srcaddr}
>      source address (mandatory)
>  @item dst=3D@var{dstaddr}
> @@ -2394,6 +2395,7 @@ draft-mkonstan-l2tpext-keyed-ipv6-tunnel-00
>  networks which have packet reorder.
>  @item offset=3D@var{offset}
>      Add an extra offset between header and data
> +@end table
>
>  For example, to attach a VM running on host 4.3.2.1 via L2TPv3 to the br=
idge br-lan
>  on the remote Linux host 1.2.3.4:
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
