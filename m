Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGqKc-0002Ng-05
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGqKY-0007KQ-33
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGqKX-0007KE-Ng
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:30:17 -0400
References: <1525855090-14384-1-git-send-email-jingqi.liu@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed89a89f-ae8d-3b3c-6daf-d5ca25b5141c@redhat.com>
Date: Thu, 10 May 2018 13:30:13 -0500
MIME-Version: 1.0
In-Reply-To: <1525855090-14384-1-git-send-email-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 6/7] numa: Extend the command-line to
 provide memory side cache information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 05/09/2018 03:38 AM, Liu Jingqi wrote:
> Add -numa hmat-cache option to provide Memory Side Cache Information.
> These memory attributes help to build Memory Side Cache Information
> Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> ---

> +++ b/qapi/misc.json
> @@ -2705,7 +2705,7 @@
>   # Since: 2.1
>   ##
>   { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }

Missing documentation.


>   ##
> +# @NumaHmatCacheOptions:
> +#
> +# Set the memory side cache information for a given memory domain.
> +#
> +# @node-id: the memory proximity domain to wich the memory belongs.

s/wich/which/

> +#
> +# @size: the size of memory side cache in bytes.
> +#
> +# @total: the total cache levels for this memory proximity domain.
> +#
> +# @level: the cache level described in this structure.
> +#
> +# @assoc: the cache associativity, none/direct(direct mapped)/complex(complex cache indexing).
> +
> +# @policy: the write policy, none/wb(write back)/wt(wirte through).

No need to abbreviate; machines are just fine spitting out legible words 
like 'write-back' or 'write-through'.

s/wirte/write/

> +#
> +# @line: the cache Line size in bytes.
> +#
> +# Since: 2.10

2.13

> +##
> +{ 'struct': 'NumaHmatCacheOptions',
> +  'data': {
> +   'node-id': 'uint32',
> +   'size': 'size',
> +   'total': 'uint8',
> +   'level': 'uint8',
> +   'assoc': 'str',

Make this an enum, not an open-coded string.

> +   'policy': 'str',

Ditto.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
