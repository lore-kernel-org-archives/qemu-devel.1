Received: from eggs.gnu.org ([2001:4830:134:3::10]:56493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOWZ-00028q-15
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOWV-00086h-TL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:48:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOWV-00085j-OY
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:48:47 -0400
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
	<e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
	<20180508103704.GK5967@redhat.com>
	<08334b5d-7bc3-befc-65af-0aae6d134e6d@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5f32951-97c5-bac7-7294-70d185abeb45@redhat.com>
Date: Wed, 9 May 2018 07:48:46 -0500
MIME-Version: 1.0
In-Reply-To: <08334b5d-7bc3-befc-65af-0aae6d134e6d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org

On 05/08/2018 11:40 PM, Yi Min Zhao wrote:

>> If seccomp is disabled, we should really disable the entire -sandbox
>> argument, not merly the options to it.
> I think it would bring a lot of changes if disable the entire -sandbox 
> argument.
> Looking from current code, sandbox is a default qemu option group, and 
> sandbox.enable is false by default unless you obviously define it with 
> true.
> So, this patch is an easier way to fixup.

If the only thing you can do with -sandbox is turn it off (which is its 
default state), it's better to not advertise it at all in the first 
place.  I agree with Daniel that it's better to cripple -sandbox from 
even being usable as a command-line argument if it isn't going to work, 
as that's easier to introspect.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
