Received: from eggs.gnu.org ([209.51.188.92]:38883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hHXT0-0004CV-VL
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hHXSz-0007V9-NM
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:38:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:48271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hHXSx-0007Tp-51
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:38:25 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Fri, 19 Apr 2019 17:38:10 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060D262F@shsmsx102.ccr.corp.intel.com>
References: <20190419155605.5349857a@luklap>
In-Reply-To: <20190419155605.5349857a@luklap>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Fix a crash in COLO
 Primary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lukas Straub <lukasstraub2@web.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>




> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Friday, April 19, 2019 9:56 PM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH] net/colo-compare.c: Fix a crash in COLO Primary.
>=20
> From: Lukas Straub <lukasstraub2@web.de> Fixes the following bug:
> https://bugs.launchpad.net/qemu/+bug/1824622

It looks good for me, but I think you need add more comments in commit mess=
age,
For example what situation will trigger this bug and why it will occur.
After that, I think you can close the bug in Launchpad.

Thanks
Zhang Chen

>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> bf10526f05..fcb491121b 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
>          break;
>      }
>=20
> -    assert(event_unhandled_count > 0);
> -
>      qemu_mutex_lock(&event_mtx);
> +    assert(event_unhandled_count > 0);
>      event_unhandled_count--;
>      qemu_cond_broadcast(&event_complete_cond);
>      qemu_mutex_unlock(&event_mtx);
> --
> 2.20.1
