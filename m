Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZTqk-0005Ak-GQ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 21:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZTqh-00073t-FS
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 21:43:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cZTqh-00073O-9c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 21:43:43 -0500
References: <20170126101010.6375-1-pbonzini@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f419ad0c-e4bb-0dcb-203d-944aeccc8c7f@redhat.com>
Date: Fri, 3 Feb 2017 10:43:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170126101010.6375-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: e1000e: fix dead code in
 e1000e_write_packet_to_guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dmitry@daynix.com



On 2017=E5=B9=B401=E6=9C=8826=E6=97=A5 18:10, Paolo Bonzini wrote:
> Because is_first is declared inside a loop, it is always true.  The sto=
re
> is dead, and so is the "else" branch of "if (is_first)".  is_last is
> okay though.
>
> Reported by Coverity.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/net/e1000e_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2b11499..c99e2fb 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -1507,6 +1507,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, st=
ruct NetRxPkt *pkt,
>       const E1000E_RingInfo *rxi;
>       size_t ps_hdr_len =3D 0;
>       bool do_ps =3D e1000e_do_ps(core, pkt, &ps_hdr_len);
> +    bool is_first =3D true;
>  =20
>       rxi =3D rxr->i;
>  =20
> @@ -1514,7 +1515,6 @@ e1000e_write_packet_to_guest(E1000ECore *core, st=
ruct NetRxPkt *pkt,
>           hwaddr ba[MAX_PS_BUFFERS];
>           e1000e_ba_state bastate =3D { { 0 } };
>           bool is_last =3D false;
> -        bool is_first =3D true;
>  =20
>           desc_size =3D total_size - desc_offset;
>  =20

Applied, thanks.
