Received: from eggs.gnu.org ([2001:4830:134:3::10]:47451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlb8-00008a-L8
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlb2-0003lO-S0
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:27:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGlb2-0003lD-Nu
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:27:00 -0400
References: <20180510091518.28199-1-paul.durrant@citrix.com>
	<20180510091518.28199-3-paul.durrant@citrix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd5e2ec4-d809-3a06-0e06-21c88e5d5d7e@redhat.com>
Date: Thu, 10 May 2018 08:26:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180510091518.28199-3-paul.durrant@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] checkpatch: generalize xen handle
 matching in the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 05/10/2018 04:15 AM, Paul Durrant wrote:
> All the xen stable APIs define handle types of the form:
> 
> <name of API>_handle
> 
> and some define additional handle types of the form:
> 
> <name of API>_<purpose of handle>_handle

Maybe worth mentioning that <name of API> always has a 'xen' prefix, 
and/or spelling it:

xen<name of object>_handle
xen<name of object>_<purpose>_handle

> 
> Examples of these are xenforeignmemory_handle and
> xenforeignmemory_resource_handle.
> 
> Both of these types will be misparsed by checkpatch if they appear as the
> first token in a line since, as types defined by an external library, they
> do not conform to the QEMU CODING_STYLE, which suggests CamelCase.
> 
> A previous patch (5ac067a24a8) added xendevicemodel_handle to the list
> of types. This patch changes that to xen\w+_handle such that it will
> match all Xen stable API handles of the forms detailed above.

Nice use of a regex.

> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> 
> v2:
>   - New in this version

Reviewed-by: Eric Blake <eblake@redhat.com>

> ---
>   scripts/checkpatch.pl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5b8735defb..98ed799f29 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -266,7 +266,7 @@ our @typeList = (
>   	qr{target_(?:u)?long},
>   	qr{hwaddr},
>   	qr{xml${Ident}},
> -	qr{xendevicemodel_handle},
> +	qr{xen\w+_handle},
>   );
>   
>   # This can be modified by sub possible.  Since it can be empty, be careful
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
