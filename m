Received: from eggs.gnu.org ([2001:4830:134:3::10]:40967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e30xq-00050W-IO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e30xm-0000W4-KW
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:29:26 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:60074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1e30xm-0000V5-8E
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:29:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1506954812-6552-4-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-4-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 13 Oct 2017 16:29:08 +0200
Message-ID: <w51d15rjf4b.fsf@maestria.local.igalia.com>
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
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Mon 02 Oct 2017 04:33:29 PM CEST, Pradeep Jagadeesh wrote:

> -    if (arg->has_iops_rd_max_length) {
> -        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
> -    }
> -    if (arg->has_iops_wr_max_length) {
> -        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
> -    }
> -
> -    if (arg->has_iops_size) {
> -        cfg.op_size = arg->iops_size;
> -    }

The old code takes an empty ThrottleConfig, and initializes it using the
values from a BlockIOThrottle structure...

> +    tlimit = qapi_BlockIOThrottle_base(arg);
> +    throttle_config_to_limits(&cfg, tlimit);

...but the new code does the exact opposite (?).

Berto
