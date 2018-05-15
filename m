Received: from eggs.gnu.org ([2001:4830:134:3::10]:33817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fId2U-0007k5-A4
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fId2Q-0008Np-C6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:43:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fId2Q-0008Na-7n
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:42:58 -0400
References: <20180510091518.28199-1-paul.durrant@citrix.com>
	<20180510091518.28199-4-paul.durrant@citrix.com>
	<20180515153821.GD2057@perard.uk.xensource.com>
	<d3dff46e447b4a18bead5bf6ae36f3ba@AMSPEX02CL03.citrite.net>
	<20180515161641.GE2057@perard.uk.xensource.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <298c911d-21df-33bc-1185-f52165fd8d21@redhat.com>
Date: Tue, 15 May 2018 11:42:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180515161641.GE2057@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen-hvm: try to use
 xenforeignmemory_map_resource() to map ioreq pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, Paul Durrant <Paul.Durrant@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 05/15/2018 11:16 AM, Anthony PERARD wrote:

>>>> +    errno = EOPNOTSUPP;
>>>
>>> I think ENOSYS would be better. EOPNOTSUPP seems to be for sockets.
>>>
>>
>> No, EOPNOTSUPP is more general than that and is convention for unimplemented API operations elsewhere. ENOSYS is supposed to strictly mean 'system call not implemented' but we use it for hypercalls in Xen, leading to occasional fun with Linux checkpatch.pl.
> 
> In man errno, I have:
> ENOTSUP         Operation not supported (POSIX.1-2001)
> EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).

POSIX allows (and Linux exploits) ENOTSUP and EOPNOTSUPP to be synonyms 
for the same error value.  I somewhat prefer the ENOTSUP spelling; and 
it's probably a bit nicer between the two when porting to platforms 
where the two spellings are not synonyms.

> ENOSYS          Function not implemented (POSIX.1-2001).
> 
> But I guess any of these would work.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
