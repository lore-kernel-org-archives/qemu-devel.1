Received: from eggs.gnu.org ([209.51.188.92]:54663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyFDM-00006X-4e
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyFDF-0002Z3-Uw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:18:28 -0500
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aabc1531-98bb-e0fe-0b69-2b9e04a567bf@redhat.com>
Date: Mon, 25 Feb 2019 13:18:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/7] s390x/tcg: RXE has an optional M3
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 25/02/2019 12.55, David Hildenbrand wrote:
> Will be needed, so add it to the format description.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-format.def | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/insn-format.def b/target/s390x/insn-format.def
> index a412d90fb7..4297ff4165 100644
> --- a/target/s390x/insn-format.def
> +++ b/target/s390x/insn-format.def
> @@ -36,7 +36,7 @@ F3(RSY_a, R(1, 8),     BDL(2),      R(3,12))
>  F3(RSY_b, R(1, 8),     BDL(2),      M(3,12))
>  F2(RX_a,  R(1, 8),     BXD(2))
>  F2(RX_b,  M(1, 8),     BXD(2))
> -F2(RXE,   R(1, 8),     BXD(2))
> +F3(RXE,   R(1, 8),     BXD(2),      M(3,32))

Yes, according to the Principles of Operations, RXE has a M3 field.

Reviewed-by: Thomas Huth <thuth@redhat.com>
