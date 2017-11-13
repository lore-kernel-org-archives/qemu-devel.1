Received: from eggs.gnu.org ([2001:4830:134:3::10]:35711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eEIpZ-0004ol-Ei
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eEIpV-0001kj-9y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:47:33 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:58852)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eEIpU-0001iS-US
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:47:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Nov 2017 04:47:23 +1100
From: geoff@hostfission.com
In-Reply-To: <878tfaytq9.fsf@dusky.pond.sub.org>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-4-lprosek@redhat.com>
	<878tfaytq9.fsf@dusky.pond.sub.org>
Message-ID: <546207b7d08628804461a97728ad1c06@hostfission.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] ivshmem: Improve MSI irqfd error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com

On 2017-11-14 04:27, Markus Armbruster wrote:
> Ladi Prosek <lprosek@redhat.com> writes:
> 
>> Adds a rollback path to ivshmem_enable_irqfd() and fixes
>> ivshmem_disable_irqfd() to bail if irqfd has not been enabled.
>> 
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> 
> Is this a theoretical bug, or can you trigger it?

It is reproducible, I can trigger it by simply unloading the windows 
driver and then attempting to re-load it.

-Geoff
