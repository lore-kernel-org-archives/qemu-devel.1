Received: from eggs.gnu.org ([2001:4830:134:3::10]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eADFG-0005lA-2e
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eADFA-0005vU-J7
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:01:10 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:37895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1eADFA-0005Tn-8F
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:01:04 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <fc73cb3e-cc3a-2673-d57d-b08f3b04e6aa@huawei.com>
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-4-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51d15rjf4b.fsf@maestria.local.igalia.com>
	<fc73cb3e-cc3a-2673-d57d-b08f3b04e6aa@huawei.com>
Date: Thu, 02 Nov 2017 12:00:10 +0100
Message-ID: <w51vaitvtc5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Thu 02 Nov 2017 11:55:26 AM CET, Pradeep Jagadeesh wrote:

>>> -    if (arg->has_iops_rd_max_length) {
>>> -        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
>>> -    }
>>> -    if (arg->has_iops_wr_max_length) {
>>> -        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
>>> -    }
>>> -
>>> -    if (arg->has_iops_size) {
>>> -        cfg.op_size = arg->iops_size;
>>> -    }
>>
>> The old code takes an empty ThrottleConfig, and initializes it using the
>> values from a BlockIOThrottle structure...
>>
>>> +    tlimit = qapi_BlockIOThrottle_base(arg);
>>> +    throttle_config_to_limits(&cfg, tlimit);
>>
>> ...but the new code does the exact opposite (?).
>
> Its a mistake of a call. It should be throttle_limits_to_config()
> I will change it.

Thanks! It would be nice if the series had a few tests to verify that
this all is working as expected :-)

Berto
