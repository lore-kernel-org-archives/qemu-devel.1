Received: from eggs.gnu.org ([2001:4830:134:3::10]:46524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSTxT-00028Q-1X
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSTxS-0006QN-D3
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:02:35 -0400
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c624efb-30d9-dd4c-281d-c7e9ee9f8336@redhat.com>
Date: Mon, 11 Jun 2018 16:02:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180611205203.2624-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/10] qapi: Formalize qcow encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

On 06/11/2018 03:51 PM, Max Reitz wrote:
> qcow only supports a single encryption (and there is no reason why that
> would change in the future), so we can make it the default.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 295ace42ae..98295ac30e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2647,8 +2647,9 @@
>   # Since: 2.10
>   ##
>   { 'union': 'BlockdevQcowEncryption',
> -  'base': { 'format': 'BlockdevQcowEncryptionFormat' },
> +  'base': { '*format': 'BlockdevQcowEncryptionFormat' },
>     'discriminator': 'format',
> +  'default-variant': 'aes',
>     'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
>   
>   ##
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
