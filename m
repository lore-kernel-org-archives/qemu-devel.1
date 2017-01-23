Received: from eggs.gnu.org ([2001:4830:134:3::10]:45344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVhVl-000708-9k
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVhVi-00083h-5o
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:30:29 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVhVh-000835-RJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:30:26 -0500
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<148518739693.56.12407051583748682941@b042e9bf0dd0>
	<20170123172254.345fbecb@bahia.lan>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <3478b86e-7a32-5e92-58cc-1cfe7ccecb41@huawei.com>
Date: Mon, 23 Jan 2017 17:30:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170123172254.345fbecb@bahia.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2 V13] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, pradeepkiruvale@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, aneesh.kumar@linux.vnet.ibm.com, berto@igalia.com

On 1/23/2017 5:22 PM, Greg Kurz wrote:
> On Mon, 23 Jan 2017 08:03:18 -0800 (PST)
> no-reply@patchew.org wrote:
>> Hi,
>>
>> Your series seems to have some coding style problems. See output below for
>> more information:
>>
>
Ya, I observed signoff issue. I have created next version files.
I will send them tomorrow.

But, I do not know how to solve the second warning.
i.e multi line macro issue.

-Pradeep

> Pradeep,
>
> One should usually take patchew's findings into account. See below.
>
>> Type: series
>> Subject: [Qemu-devel] [PATCH 0/2 V13] fsdev: add IO throttle support to fsdev devices
>> Message-id: 1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>>
>> BASE=base
>> n=1
>> total=$(git log --oneline $BASE.. | wc -l)
>> failed=0
>>
>> # Useful git options
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>>
>> commits="$(git log --format=%H --reverse $BASE..)"
>> for c in $commits; do
>>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>>         failed=1
>>         echo
>>     fi
>>     n=$((n+1))
>> done
>>
>> exit $failed
>> === TEST SCRIPT END ===
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> Switched to a new branch 'test'
>> 7686dc8 throttle: factor out duplicate code
>> 7568614 fsdev: add IO throttle support to fsdev devices
>>
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/2: fsdev: add IO throttle support to fsdev devices...
>> Checking PATCH 2/2: throttle: factor out duplicate code...
>> ERROR: Macros with multiple statements should be enclosed in a do - while loop
>
> I guess your patch is ok here: checkpatch.pl is simply not smart enough to
> parse this.
>
>> #228: FILE: include/qemu/throttle-options.h:13:
>> +#define THROTTLE_OPTS \
>> +          { \
>> +            .name = "throttling.iops-total",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "limit total I/O operations per second",\
>> +        },{ \
>> +            .name = "throttling.iops-read",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "limit read operations per second",\
>> +        },{ \
>> +            .name = "throttling.iops-write",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "limit write operations per second",\
>> +        },{ \
>> +            .name = "throttling.bps-total",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "limit total bytes per second",\
>> +        },{ \
>> +            .name = "throttling.bps-read",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "limit read bytes per second",\
>> +        },{ \
>> +            .name = "throttling.bps-write",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "limit write bytes per second",\
>> +        },{ \
>> +            .name = "throttling.iops-total-max",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "I/O operations burst",\
>> +        },{ \
>> +            .name = "throttling.iops-read-max",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "I/O operations read burst",\
>> +        },{ \
>> +            .name = "throttling.iops-write-max",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "I/O operations write burst",\
>> +        },{ \
>> +            .name = "throttling.bps-total-max",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "total bytes burst",\
>> +        },{ \
>> +            .name = "throttling.bps-read-max",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "total bytes read burst",\
>> +        },{ \
>> +            .name = "throttling.bps-write-max",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "total bytes write burst",\
>> +        },{ \
>> +            .name = "throttling.iops-total-max-length",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "length of the iops-total-max burst period, in seconds",\
>> +        },{ \
>> +            .name = "throttling.iops-read-max-length",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "length of the iops-read-max burst period, in seconds",\
>> +        },{ \
>> +            .name = "throttling.iops-write-max-length",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "length of the iops-write-max burst period, in seconds",\
>> +        },{ \
>> +            .name = "throttling.bps-total-max-length",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "length of the bps-total-max burst period, in seconds",\
>> +        },{ \
>> +            .name = "throttling.bps-read-max-length",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "length of the bps-read-max burst period, in seconds",\
>> +        },{ \
>> +            .name = "throttling.bps-write-max-length",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "length of the bps-write-max burst period, in seconds",\
>> +        },{ \
>> +            .name = "throttling.iops-size",\
>> +            .type = QEMU_OPT_NUMBER,\
>> +            .help = "when limiting by iops max size of an I/O in bytes",\
>> +        }
>>
>> ERROR: Missing Signed-off-by: line(s)
>>
>
> As Eric pointed out in another mail, all patches you send must have your
> Signed-off-by line.
>
>> total: 2 errors, 0 warnings, 278 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> === OUTPUT END ===
>>
>> Test command exited with code: 1
>>
>>
>> ---
>> Email generated automatically by Patchew [http://patchew.org/].
>> Please send your feedback to patchew-devel@freelists.org
