Received: from eggs.gnu.org ([2001:4830:134:3::10]:36475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evla5-000167-Lx
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evla1-0000dg-87
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:11:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evla1-0000dM-37
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:11:09 -0400
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-2-git-send-email-ian.jackson@eu.citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2f1cee4-8dad-d901-ae2f-51495a855b4e@redhat.com>
Date: Tue, 13 Mar 2018 16:11:00 +0100
MIME-Version: 1.0
In-Reply-To: <1520535787-6223-2-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] checkpatch: Add
 xendevicemodel_handle to the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 08/03/2018 20:02, Ian Jackson wrote:
> This avoids checkpatch misparsing (as statements) long function
> definitions or declarations, which sometimes start with constructs
> like this:
> 
>   static inline int xendevicemodel_relocate_memory(
>       xendevicemodel_handle *dmod, domid_t domid, ...
> 
> CC: Eric Blake <eblake@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
> v6.1: New patch
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d1fe79b..3e488f7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -266,6 +266,7 @@ our @typeList = (
>  	qr{target_(?:u)?long},
>  	qr{hwaddr},
>  	qr{xml${Ident}},
> +	qr{xendevicemodel_handle},
>  );
>  
>  # This can be modified by sub possible.  Since it can be empty, be careful
> -- 

Or just rename it so that it is CamelCase.  Then checkpatch will be happy.

Paolo
