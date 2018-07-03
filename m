Received: from eggs.gnu.org ([2001:4830:134:3::10]:35393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNPE-0004S5-HP
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNP9-0008E2-Tw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:39:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faNP9-0008Dl-NN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:39:47 -0400
References: <20180703085358.13941-1-armbru@redhat.com>
	<20180703085358.13941-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbeb5e54-0a99-81a7-5d7b-235e2a856a32@redhat.com>
Date: Tue, 3 Jul 2018 10:39:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180703085358.13941-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/32] qmp: Make "id" optional again
 even in "oob" monitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

On 07/03/2018 03:53 AM, Markus Armbruster wrote:
> Commit cf869d53172 "qmp: support out-of-band (oob) execution" made
> "id" mandatory for all commands when the client accepted capability
> "oob".  This is rather onerous when you play with QMP by hand, and
> unnecessarily so: only out-of-band commands need an ID for reliable
> matching of response to command.
> 
> Revert that part of commit cf869d53172 for now, but have documentation
> advise on the need to use "id" with out-of-band commands.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/interop/qmp-spec.txt | 13 +++++++------
>   monitor.c                 |  7 -------
>   2 files changed, 7 insertions(+), 13 deletions(-)
> 

> @@ -128,6 +125,10 @@ possibly overtaking prior in-band commands.  The client may therefore
>   receive such a command's response before responses from prior in-band
>   commands.
>   
> +To be able to match responses back to their commands, the client needs
> +to pass "id" with out-of-band commands.  Passing it with all commands
> +is recommended for clients that accept capability "oob".

Thanks.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
