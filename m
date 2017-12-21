Received: from eggs.gnu.org ([2001:4830:134:3::10]:48378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS1uP-0002nZ-T7
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS1uM-0000Lo-E7
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:33:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eS1uM-0000JG-8Q
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:33:14 -0500
References: <D9DE8DBB19F2A24080482022C1DE758302C51F05@dggemm509-mbx.china.huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c878389-ab69-dfda-8ad3-d5826a24f9f1@redhat.com>
Date: Thu, 21 Dec 2017 08:33:11 -0600
MIME-Version: 1.0
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302C51F05@dggemm509-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 02/46] qemu-thread: fix races on threads
 that exit very quickly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>

On 12/20/2017 09:40 PM, linzhecheng wrote:

>>> If qemu_thread_args is freed here, start_routine(arg) will lead to use
>>> after free because arg equals to qemu_thread_args
>>
>> No, we explicitly copied qemu_thread_args->arg into a local variable prior to
>> freeing qemu_thread_args, so that we do not have to dereference the freed
>> variable.
> OK, that's true.

By the way, your mailer is breaking threading; it is omitting 
'In-Reply-To:' and 'References:' headers, which makes every mail from 
you show up as a new top-level thread, rather than properly threaded to 
what you are responding to.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
