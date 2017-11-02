Received: from eggs.gnu.org ([2001:4830:134:3::10]:58578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eADBI-0004Ln-6r
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eADBF-0002hr-50
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:57:04 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:28702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eADBE-0002hA-R2
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:57:01 -0400
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-4-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51d15rjf4b.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <fc73cb3e-cc3a-2673-d57d-b08f3b04e6aa@huawei.com>
Date: Thu, 2 Nov 2017 11:55:26 +0100
MIME-Version: 1.0
In-Reply-To: <w51d15rjf4b.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v13 3/6] qmp: factor out throttle code to
 reuse code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On 10/13/2017 4:29 PM, Alberto Garcia wrote:
> On Mon 02 Oct 2017 04:33:29 PM CEST, Pradeep Jagadeesh wrote:
>
>> -    if (arg->has_iops_rd_max_length) {
>> -        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
>> -    }
>> -    if (arg->has_iops_wr_max_length) {
>> -        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
>> -    }
>> -
>> -    if (arg->has_iops_size) {
>> -        cfg.op_size = arg->iops_size;
>> -    }
>
> The old code takes an empty ThrottleConfig, and initializes it using the
> values from a BlockIOThrottle structure...
>
>> +    tlimit = qapi_BlockIOThrottle_base(arg);
>> +    throttle_config_to_limits(&cfg, tlimit);
>
> ...but the new code does the exact opposite (?).

Its a mistake of a call. It should be throttle_limits_to_config()
I will change it.

Regards,
Pradeep

>
> Berto
>
