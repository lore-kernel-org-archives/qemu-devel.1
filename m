Received: from eggs.gnu.org ([2001:4830:134:3::10]:52871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gUYtJ-0002lz-Lt
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gUYl7-0003ZS-OT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:06:45 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:26120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gUYl5-0003Sm-Iy
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:06:39 -0500
References: <20181205110131.23049-1-d.csapak@proxmox.com>
	<87a7lkuptr.fsf@dusky.pond.sub.org>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <5592d444-4527-89b8-4a0a-f32c6b5beb69@proxmox.com>
Date: Wed, 5 Dec 2018 16:06:22 +0100
MIME-Version: 1.0
In-Reply-To: <87a7lkuptr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] qapi: return ShutdownCause for
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 12/5/18 1:21 PM, Markus Armbruster wrote:
> Dominik Csapak <d.csapak@proxmox.com> writes:
> 
>> This series improves the QMP SHUTDOWN and RESET events by adding
>> the ShutdownCause as additional parameter and splitting
>> the HOST_QMP reason into HOST_QMP_QUIT and HOST_QMP_SYSTEM_RESET
>> to be able to detect the difference between them when using '--no-reboot'
>>
>> this is an alternative to my previous patches[1][2] which
>> added an exit-script/added a 'reset' argument to the events
>>
>>   1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00697.html
>>   2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01271.html
> 
> Next time, please add the Reviewed-bys you got for the previous version
> to your commit messages, unless the commits changed enough to warrant
> another round of review.

Yes of course, sorry for that.

Thank you again for the review.

> 
> For the record, series again
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> 
