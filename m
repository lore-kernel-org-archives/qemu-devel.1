Received: from eggs.gnu.org ([2001:4830:134:3::10]:38040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dABw0-0000qm-OD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dABw0-0004jr-0Z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:04:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dABvz-0004il-RU
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:04:55 -0400
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<1494838260-30439-4-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ed64684-6594-6533-491f-ccb4ea398d08@redhat.com>
Date: Mon, 15 May 2017 11:04:52 +0200
MIME-Version: 1.0
In-Reply-To: <1494838260-30439-4-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] exec: further use is_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>



On 15/05/2017 10:50, Peter Xu wrote:
> This is MMIO-specific tunes on the size. Let's skip it for non-MMIO
> translations.

Can you explain this better?  This is not specific to MMIO, in fact it's
for RAM...

Paolo

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index 0adae94..32e5394 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -455,7 +455,7 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
>       * everything works fine.  If the incoming length is large, however,
>       * the caller really has to do the clamping through memory_access_size.
>       */
> -    if (memory_region_is_ram(mr)) {
> +    if (is_mmio && memory_region_is_ram(mr)) {
>          diff = int128_sub(section->size, int128_make64(addr));
>          *plen = int128_get64(int128_min(diff, int128_make64(*plen)));
