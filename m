Received: from eggs.gnu.org ([2001:4830:134:3::10]:55016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ezS9p-0006mE-Ik
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 15:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ezS9o-0003WW-P3
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 15:15:21 -0400
References: <20180323143202.28879-1-lvivier@redhat.com>
	<20180323143202.28879-4-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0a6bdc26-5380-e1e7-bf85-f124b4b3f9de@redhat.com>
Date: Fri, 23 Mar 2018 20:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180323143202.28879-4-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/5] error: Remove NULL
 checks on error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 23.03.2018 15:32, Laurent Vivier wrote:
> Re-run Coccinelle patch
> scripts/coccinelle/error_propagate_null.cocci
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  io/channel-websock.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index ec48a305f0..e6608b969d 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -586,9 +586,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
>          return TRUE;
>      }
>  
> -    if (err) {
> -        error_propagate(&wioc->io_err, err);
> -    }
> +    error_propagate(&wioc->io_err, err);
>  
>      trace_qio_channel_websock_handshake_reply(ioc);
>      qio_channel_add_watch(

Reviewed-by: Thomas Huth <thuth@redhat.com>
