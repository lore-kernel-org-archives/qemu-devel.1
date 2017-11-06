Received: from eggs.gnu.org ([2001:4830:134:3::10]:33241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiLL-00073V-Pt
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiLI-0007ou-M6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:25:39 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:48359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiLI-0007od-Fn
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:25:36 -0500
Received: by mail-wm0-f53.google.com with SMTP id p75so14171275wmg.3
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:25:36 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-12-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6870bdc8-401f-7d96-ffd2-5667c39f8b30@redhat.com>
Date: Mon, 6 Nov 2017 15:25:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-12-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/18] Sete ctx->xops to null on Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On 29/09/2017 13:13, Michael Fritscher wrote:
>  
> +#ifdef _WIN32
> +    ctx->xops = 0;
> +#else
>      if (ctx->export_flags & V9FS_SM_PASSTHROUGH) {
>          ctx->xops = passthrough_xattr_ops;
>      } else if (ctx->export_flags & V9FS_SM_MAPPED) {
> @@ -1442,6 +1445,7 @@ static int local_init(FsContext *ctx)
>           */
>          ctx->xops = passthrough_xattr_ops;
>      }
> +#endif

Why not none_xattr_ops?

Paolo
