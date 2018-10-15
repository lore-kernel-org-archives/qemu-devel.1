Received: from eggs.gnu.org ([2001:4830:134:3::10]:44844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRGB-0004ZA-PL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRG9-0006QK-H8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCRG9-0006PX-9C
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:49 -0400
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66bcdf04-74e6-34c5-b34c-6fc06a5c6a7d@redhat.com>
Date: Mon, 15 Oct 2018 13:49:33 -0500
MIME-Version: 1.0
In-Reply-To: <20181015115309.17089-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/35] error: Fix use of error_prepend()
 with &error_fatal, &error_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Fei Li <fli@suse.com>

On 10/15/18 6:52 AM, Markus Armbruster wrote:
>>From include/qapi/error.h:
> 
>    * Pass an existing error to the caller with the message modified:
>    *     error_propagate(errp, err);
>    *     error_prepend(errp, "Could not frobnicate '%s': ", name);
> 
> Fei Li pointed out that doing error_propagate() first doesn't work
> well when @errp is &error_fatal or &error_abort: the error_prepend()
> is never reached.
> 
> Since I doubt fixing the documentation will stop people from getting
> it wrong, introduce error_propagate_prepend(), in the hope that it
> lures people away from using its constituents in the wrong order.
> Update the instructions in error.h accordingly.
> 
> Convert existing error_prepend() next to error_propagate to
> error_propagate_prepend().  If any of these get reached with
> &error_fatal or &error_abort, the error messages improve.  I didn't
> check whether that's the case anywhere.
> 
> Cc: Fei Li <fli@suse.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
