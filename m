Received: from eggs.gnu.org ([2001:4830:134:3::10]:44327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlOj-0008S9-GX
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlOi-0008Ou-HF
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:14:17 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d75794b-7ace-6f28-8991-840d1f3cf268@redhat.com>
Date: Thu, 10 May 2018 08:14:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/13] docs/qapi: Document optional
 discriminators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/09/2018 11:55 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   docs/devel/qapi-code-gen.txt | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 

I might have squashed this in with patch 1, but I can live with it separate.

> @@ -502,6 +502,23 @@ the enum).  In the resulting generated C data types, a flat union is
>   represented as a struct with the base members included directly, and
>   then a union of structures for each branch of the struct.
>   
> +If the discriminator points to an optional member of the base struct,
> +its default value must be specified as a 'default-variant'.  In the
> +following example, the above BlockDriver struct is changed so it
> +defaults to the 'file' driver if that field is omitted on the wire:
> +
> + { 'union': 'BlockdevOptions',
> +   'base': { '*driver': 'BlockdevDriver', '*read-only': 'bool' },
> +   'discriminator': 'driver',
> +   'default-variant': 'file',
> +   'data': { 'file': 'BlockdevOptionsFile',
> +             'qcow2': 'BlockdevOptionsQcow2' } }
> +
> +Now the 'file' JSON object can be abbreviated to:
> +
> + { "read-only": "true",
> +   "filename": "/some/place/my-image" }
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
