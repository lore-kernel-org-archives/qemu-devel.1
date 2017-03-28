Received: from eggs.gnu.org ([2001:4830:134:3::10]:58612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csvr4-0001lJ-1d
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csvr0-0004JF-Uj
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:28:30 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:40372
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1csvr0-0004IV-Mz
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:28:26 -0400
References: <20170324234646.15264-1-Andrew.Baumann@microsoft.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <5b6dc1d9-996a-66fe-7142-2c9be4670540@weilnetz.de>
Date: Tue, 28 Mar 2017 20:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170324234646.15264-1-Andrew.Baumann@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.9?] tap-win32: don't abort in
 tap_enable(); enables -netdev tap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Am 25.03.2017 um 00:46 schrieb Andrew Baumann:
> The docs generally steer users away from using the legacy -net
> parameter, however on win32 attempting to enable a tap device using
> -netdev tap fails at an abort() in tap_enable(). Removing the abort()s
> seems to be enough to get everything working, so do that.
>
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
>  net/tap-win32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 662f9b6..3620843 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -811,10 +811,10 @@ int net_init_tap(const Netdev *netdev, const char=
 *name,
>
>  int tap_enable(NetClientState *nc)
>  {
> -    abort();
> +    return 0;
>  }
>
>  int tap_disable(NetClientState *nc)
>  {
> -    abort();
> +    return 0;
>  }

As I never worked with TAP on Windows, I cannot say much to this fix.

Jason, what is the use of tap_enable, tap_disable? Is it fine
to simply do nothing on Windows here?

And is this something for QEMU=E2=80=8C 2.9 (I added question to subject =
line)?

Stefan
