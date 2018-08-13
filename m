Received: from eggs.gnu.org ([2001:4830:134:3::10]:46046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpC0o-0004GC-Tx
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpC0k-0005GK-TA
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 08:31:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1534161104-8253-1-git-send-email-thuth@redhat.com>
Date: Mon, 13 Aug 2018 14:31:48 +0200
In-Reply-To: <1534161104-8253-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Mon, 13 Aug 2018 13:51:44 +0200")
Message-ID: <87y3da5txn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Fix bad "macaddr" property
 in the documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Harald Hoyer <harald@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> When using the "-device" option, the property is called "mac".
> "macaddr" is only used for the legacy "-net nic" option.

Indeed:

    #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
--->    DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
        DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)

> Reported-by: Harald Hoyer <harald@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b1bf0f4..3495531 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2345,7 +2345,7 @@ qemu-system-i386 linux.img \
>                   -netdev socket,id=n2,mcast=230.0.0.1:1234
>  # launch yet another QEMU instance on same "bus"
>  qemu-system-i386 linux.img \
> -                 -device e1000,netdev=n3,macaddr=52:54:00:12:34:58 \
> +                 -device e1000,netdev=n3,mac=52:54:00:12:34:58 \
>                   -netdev socket,id=n3,mcast=230.0.0.1:1234
>  @end example

Reviewed-by: Markus Armbruster <armbru@redhat.com>
