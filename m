Received: from eggs.gnu.org ([209.51.188.92]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkDLj-0000fb-V5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkDLj-0003sx-7N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:29:11 -0500
References: <20181221135803.9583-1-npes87184@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8736abeb-60b6-e077-b6ad-0f01da4f8c0a@redhat.com>
Date: Thu, 17 Jan 2019 14:29:05 -0500
MIME-Version: 1.0
In-Reply-To: <20181221135803.9583-1-npes87184@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com



On 12/21/18 8:58 AM, yuchenlin wrote:
> There is a possible hang in original binary searsh implemtation. That is
> if chunk1 = 4, chunk2 = 5, chunk3 = 4, and we go else case.
> 
> The chunk1 will be still 4, and so on.
> 
> Signed-off-by: yuchenlin <npes87184@gmail.com>

Generally we ask that people use their full names for their
Signed-off-by (for legal and copyright reasons) and not an alias.

If I am mistaken and your name is a mononym or written as a mononym,
please forgive me and disregard.

> ---
>  block/dmg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/dmg.c b/block/dmg.c
> index 50e91aef6d..0e05702f5d 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -572,14 +572,14 @@ static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
>  {
>      /* binary search */
>      uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
> -    while (chunk1 != chunk2) {
> +    while (chunk1 <= chunk2) {
>          chunk3 = (chunk1 + chunk2) / 2;
>          if (s->sectors[chunk3] > sector_num) {
> -            chunk2 = chunk3;
> +            chunk2 = chunk3 - 1;
>          } else if (s->sectors[chunk3] + s->sectorcounts[chunk3] > sector_num) {
>              return chunk3;
>          } else {
> -            chunk1 = chunk3;
> +            chunk1 = chunk3 + 1;
>          }
>      }
>      return s->n_chunks; /* error */
> 

yuchenlin, did you see Stefan's response to your patch? Do you have any
plans to send a follow-up?

--js
