Received: from eggs.gnu.org ([2001:4830:134:3::10]:55489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDBb5-0006LH-65
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDBb4-0000wh-BS
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:51:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
References: <20171109203025.27493-1-mreitz@redhat.com>
	<20171109203025.27493-5-mreitz@redhat.com>
	<w51375mv4by.fsf@maestria.local.igalia.com>
	<d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
Date: Fri, 10 Nov 2017 16:51:50 +0100
Message-ID: <w51tvy2t9m1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less
 flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Fri 10 Nov 2017 04:18:15 PM CET, Max Reitz wrote:
> On 2017-11-10 11:02, Alberto Garcia wrote:
>> On Thu 09 Nov 2017 09:30:24 PM CET, Max Reitz wrote:
>>> +        echo > "$TEST_DIR/nbd-fault-injector.out"
>>>  	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd-fault-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
>> 
>> It seems that in this patch you're indenting with spaces but this file
>> uses tabs.
>
> Yes, but tabs are wrong. :-)

I actually agree with you, but don't mix them in the file :-)

Berto
