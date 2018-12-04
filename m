Received: from eggs.gnu.org ([2001:4830:134:3::10]:36487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gU3On-0001Y0-Vh
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gU3Oi-0001J5-2v
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:37:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gU3Oc-0001CW-96
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:37:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-3-d.csapak@proxmox.com>
	<87bm624x0g.fsf@dusky.pond.sub.org>
	<dd3c54bf-24c3-20bc-b749-921353e08e94@redhat.com>
Date: Tue, 04 Dec 2018 06:37:18 +0100
In-Reply-To: <dd3c54bf-24c3-20bc-b749-921353e08e94@redhat.com> (Eric Blake's
	message of "Mon, 3 Dec 2018 15:30:11 -0600")
Message-ID: <875zw9lunl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: Dominik Csapak <d.csapak@proxmox.com>, kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 12/3/18 6:26 AM, Markus Armbruster wrote:
>> Dominik Csapak <d.csapak@proxmox.com> writes:
>>
>>> This makes it possible to determine what the exact reason was for
>>> a RESET or a SHUTDOWN. A management layer might need the specific reason
>>> of those events to determine which cleanups or other actions it needs to do.
>>>
>>> This patch also fixes the iotests to include the reason in the output.
>>
>> This sounds as if iotests were broken somehow before this patch.  I'd
>> simply drop the sentence.  Not worth a respin, but if you have to respin
>> for some other reason...
>
> Or maybe "This patch also updates iotests to the new expected output
> that includes the reaon"

Fine with me, as long as you spell reason correctly :)

[...]
