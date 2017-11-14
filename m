Received: from eggs.gnu.org ([2001:4830:134:3::10]:50901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEVnF-0006jU-Gw
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEVnC-0007qZ-D5
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:38:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eEVnC-0007pt-7K
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:37:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-4-lprosek@redhat.com>
	<878tfaytq9.fsf@dusky.pond.sub.org>
	<546207b7d08628804461a97728ad1c06@hostfission.com>
Date: Tue, 14 Nov 2017 08:37:53 +0100
In-Reply-To: <546207b7d08628804461a97728ad1c06@hostfission.com> (geoff's
	message of "Tue, 14 Nov 2017 04:47:23 +1100")
Message-ID: <871sl1wbse.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: geoff--- via Qemu-devel <qemu-devel@nongnu.org>
Cc: geoff@hostfission.com, pbonzini@redhat.com, Ladi Prosek <lprosek@redhat.com>, marcandre.lureau@redhat.com

geoff--- via Qemu-devel <qemu-devel@nongnu.org> writes:

> On 2017-11-14 04:27, Markus Armbruster wrote:
>> Ladi Prosek <lprosek@redhat.com> writes:
>>
>>> Adds a rollback path to ivshmem_enable_irqfd() and fixes
>>> ivshmem_disable_irqfd() to bail if irqfd has not been enabled.
>>>
>>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>>
>> Is this a theoretical bug, or can you trigger it?
>
> It is reproducible, I can trigger it by simply unloading the windows
> driver and then attempting to re-load it.

Adding that to the commit message would be nice.  You then can add my

Reviewed-by: Markus Armbruster <armbru@redhat.com>
