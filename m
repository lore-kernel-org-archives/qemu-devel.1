Received: from eggs.gnu.org ([2001:4830:134:3::10]:38409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds7dl-0003UU-Fh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds7dk-0001e2-Gj
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:23:41 -0400
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-2-lvivier@redhat.com>
	<20170913053533.GF7550@umbus.fritz.box> <20170913124456.GB2096@work-vm>
	<770fc286-a566-920a-9aba-16c3b5264806@redhat.com>
	<20170913131948.GD2096@work-vm>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5accd02c-f116-22ef-99ef-1ddd9e58fc21@redhat.com>
Date: Wed, 13 Sep 2017 15:23:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170913131948.GD2096@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hmp: fix "dump-quest-memory"
 segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

On 13/09/2017 15:19, Dr. David Alan Gilbert wrote:
> * Laurent Vivier (lvivier@redhat.com) wrote:
>> On 13/09/2017 14:44, Dr. David Alan Gilbert wrote:
>>> * David Gibson (david@gibson.dropbear.id.au) wrote:
>>>> On Tue, Sep 12, 2017 at 04:01:47PM +0200, Laurent Vivier wrote:
>>>>> Running QEMU with
>>>>>     qemu-system-ppc64 -M none -nographic -m 256
>>>>> and executing
>>>>>     dump-guest-memory /dev/null 0 8192
>>>>> results in segfault
>>>>>
>>>>> Fix by checking if we have CPU, and exit with
>>>>> error if there is no CPU:
>>>>>
>>>>>     (qemu) dump-guest-memory /dev/null
>>>>>     this feature or command is not currently supported
>>>>>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>
>>>> Applied to ppc-for-2.11.  I'm not really sure what to do with the rest
>>>> of the series though.
>>>
>>> I can take the whole set through HMP.
>>
>> Could you update the comment in last patch as asked by Cornelia?
>> (PATCH v3 3/3] tests/hmp: test "none" machine with memory)
> 
> Sure, do we understand what the error that patchew caught was?

We need the fix from Cornelia, otherwise the new test fails.

Do you want I resend the series including the fix from Cornelia to be
sure patchew works?

Thanks,
Laurent
