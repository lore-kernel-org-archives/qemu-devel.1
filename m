Received: from eggs.gnu.org ([2001:4830:134:3::10]:35231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dk9mS-0000Xm-Ng
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dk9mP-0008L5-L5
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:03:44 -0400
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-14-git-send-email-armbru@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <525521a8-d1f8-0550-82db-c2bd5fa70a7e@redhat.com>
Date: Tue, 22 Aug 2017 17:03:17 +0300
MIME-Version: 1.0
In-Reply-To: <1502117160-24655-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/56] pci: Make PCI addresses and
 sizes unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Hi Markus,

On 07/08/2017 17:45, Markus Armbruster wrote:
> Sizes and addresses should use QAPI type 'size' (uint64_t).
> PciMemoryRegion members @address and @size are 'int' (int64_t).
> qmp_query_pci_regions() implicitly converts from pcibus_t,
> i.e. uint64_t.
> 
> Change these PciMemoryRegion members to 'size'.
> 
> query-pci now reports sizes and addresses above 2^63-1 correctly
> instead of their (negative) two's complement.
> 
> HMP's "info pci" already reported them correctly, because it
> implicitly converted back to uint64_t.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi-schema.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 6aa6be9..c8cceb9 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2062,7 +2062,7 @@
>   # Since: 0.14.0
>   ##
>   { 'struct': 'PciMemoryRegion',
> -  'data': {'bar': 'int', 'type': 'str', 'address': 'int', 'size': 'int',
> +  'data': {'bar': 'int', 'type': 'str', 'address': 'size', 'size': 'size',
>              '*prefetch': 'bool', '*mem_type_64': 'bool' } }
>   
>   ##
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
