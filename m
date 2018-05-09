Received: from eggs.gnu.org ([2001:4830:134:3::10]:39095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSr6-0004Ha-NW
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSr2-00049S-Po
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGSr2-00048g-KF
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:26:16 -0400
References: <20180509154604.25530-1-paul.durrant@citrix.com>
	<152588171396.2703.471985236583323449@71c20359a636>
	<82906d30c1854e13bd7986af99eb1d98@AMSPEX02CL03.citrite.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c96c8b0-4736-d1fe-8145-bf14d2a24a97@redhat.com>
Date: Wed, 9 May 2018 12:26:06 -0500
MIME-Version: 1.0
In-Reply-To: <82906d30c1854e13bd7986af99eb1d98@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] xen-hvm: use new resource mapping API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "famz@redhat.com" <famz@redhat.com>

On 05/09/2018 11:05 AM, Paul Durrant wrote:

>> xenforeignmemory_map_resource() to map ioreq pages...
>> ERROR: spaces required around that '*' (ctx:WxV)
>> #164: FILE: include/hw/xen/xen_common.h:128:
>> +    xenforeignmemory_handle *fmem, domid_t domid, unsigned int type,
>>                               ^
>>
>> total: 1 errors, 0 warnings, 138 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
> 
> This style warning appears to be spurious.

Yep, and it's because xenforeignmemory_handle doesn't follow our usual 
conventions for a type name.  See commit 5ac067a if you want to add it 
to the list of whitelisted exception type names, to silence messages 
like this.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
