Received: from eggs.gnu.org ([2001:4830:134:3::10]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2a6I-0002Ic-Sc
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2a6E-0003hk-8z
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:16:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d2a6E-0003ha-2A
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:16:02 -0400
References: <20170420204301.154912-1-lepton@google.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <42f99074-9330-c974-e884-f0a62e63c697@redhat.com>
Date: Mon, 24 Apr 2017 11:15:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170420204301.154912-1-lepton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: don't zero ti_i since we
 acccess it later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <ytht.net@gmail.com>, qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 20.04.2017 22:43, Tao Wu wrote:
> The current code looks buggy, we zero ti_i while we access
> ti_dst/ti_src later.
> 
> Signed-off-by: Tao Wu <lepton@google.com>
> ---
>  slirp/tcp_subr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index dc8b4bbb50..398d6b30d3 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -148,7 +148,6 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, struct mbuf *m,
>  		m->m_data += IF_MAXLINKHDR;
>  		*mtod(m, struct tcpiphdr *) = *ti;
>  		ti = mtod(m, struct tcpiphdr *);
> -		memset(&ti->ti, 0, sizeof(ti->ti));
>  		flags = TH_ACK;
>  	} else {
>  		/*

When providing patches, please make sure to put the subsystem maintainer
on CC: (see MAINTAINERS file) - or your patch will likely be lost in the
high traffic of the qemu-devel mailing list.

 Thanks,
  Thomas
