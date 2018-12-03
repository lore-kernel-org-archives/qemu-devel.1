Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvnI-0005f0-5O
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvnD-0001FA-NH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:30:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTvnC-0001D3-Tl
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:30:15 -0500
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-3-d.csapak@proxmox.com>
	<87bm624x0g.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd3c54bf-24c3-20bc-b749-921353e08e94@redhat.com>
Date: Mon, 3 Dec 2018 15:30:11 -0600
MIME-Version: 1.0
In-Reply-To: <87bm624x0g.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: Add reason to SHUTDOWN and
 RESET events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 12/3/18 6:26 AM, Markus Armbruster wrote:
> Dominik Csapak <d.csapak@proxmox.com> writes:
> 
>> This makes it possible to determine what the exact reason was for
>> a RESET or a SHUTDOWN. A management layer might need the specific reason
>> of those events to determine which cleanups or other actions it needs to do.
>>
>> This patch also fixes the iotests to include the reason in the output.
> 
> This sounds as if iotests were broken somehow before this patch.  I'd
> simply drop the sentence.  Not worth a respin, but if you have to respin
> for some other reason...

Or maybe "This patch also updates iotests to the new expected output 
that includes the reaon"

> 
>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
