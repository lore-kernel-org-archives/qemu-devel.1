Received: from eggs.gnu.org ([2001:4830:134:3::10]:33510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cdOy6-00078e-0D
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cdOy2-0000jF-PA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:19:33 -0500
Received: from mail-db5eur01on0110.outbound.protection.outlook.com
	([104.47.2.110]:3417
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cdOy2-0000j7-5X
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 17:19:30 -0500
References: <1486134413-19988-1-git-send-email-den@openvz.org>
	<5909b505-fecb-fa98-6ae7-190b846add4c@openvz.org>
	<169f96e8-0ca5-264d-350a-7f085905bd5b@virtuozzo.com>
	<a1049fab-1880-3b03-63bb-6b898ee55b40@redhat.com>
	<20170213191327.GO27752@localhost.localdomain>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <f58d806b-b17d-8e9a-3fb9-da547a0ade0e@virtuozzo.com>
Date: Mon, 13 Feb 2017 22:45:44 +0300
MIME-Version: 1.0
In-Reply-To: <20170213191327.GO27752@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] mirror: do not increase offset during
 initial zero_or_discard phase - pls consider this as V3 patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>

On 02/13/2017 10:13 PM, Jeff Cody wrote:
> On Mon, Feb 13, 2017 at 06:16:36PM +0100, Max Reitz wrote:
>> On 13.02.2017 08:10, Denis V. Lunev wrote:
>>> On 02/03/2017 06:08 PM, Denis V. Lunev wrote:
>>>> On 02/03/2017 06:06 PM, Denis V. Lunev wrote:
>>>>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>>>
>>>>> If explicit zeroing out before mirroring is required for the target image,
>>>>> it moves the block job offset counter to EOF, then offset and len counters
>>>>> count the image size twice. There is no harm but stats are confusing,
>>>>> specifically the progress of the operation is always reported as 99% by
>>>>> management tools.
>>>>>
>>>>> The patch skips offset increase for the first "technical" pass over the
>>>>> image. This should not cause any further harm.
>>>>>
>>>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> CC: Jeff Cody <jcody@redhat.com>
>>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>>> CC: Max Reitz <mreitz@redhat.com>
>>>> actually this is V3 patch. Sorry for broken subject.
>>>>
>>>> Den
>>> ping
>> Didn't Jeff merge v2?
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01319.html
>>
>> Max
>>
>
> Yes, I did.
thank you very much for clarification

Den
