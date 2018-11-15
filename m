Received: from eggs.gnu.org ([2001:4830:134:3::10]:59452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNPOB-0003bG-Pn
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNPO8-0005DA-GU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:41:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNPO6-0005CX-MI
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:41:22 -0500
References: <cover.1542301855.git.xiezhide@huawei.com>
	<37e2a76b4020a5f9e48fe3b7c36d8e4bfb111569.1542301855.git.xiezhide@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df1afb51-f027-d5f8-d5e2-b9869cf104f7@redhat.com>
Date: Thu, 15 Nov 2018 15:41:17 -0600
MIME-Version: 1.0
In-Reply-To: <37e2a76b4020a5f9e48fe3b7c36d8e4bfb111569.1542301855.git.xiezhide@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/4] fsdev-throttle-qmp: move struct
 ThrottleLimits to new file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>, qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

On 11/15/18 2:55 AM, xiezhide wrote:
> this patch move ThrottleLimits to new file and rename struct
> field with common format

As written, you need s/move/moves/ and s/rename/renames/ to match the 
singular actor 'this patch'.  Or, if you stick with my preference for 
imperative sense, s/this patch move/Move/

s/to new/to a new/

> 
> Signed-off-by: xiezhide <xiezhide@huawei.com>
> ---

> +++ b/Makefile
> @@ -106,6 +106,7 @@ GENERATED_FILES += qapi/qapi-types-sockets.h qapi/qapi-types-sockets.c
>   GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
>   GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
>   GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
> +GENERATED_FILES += qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c

tlimits comes before tpm, not after transaction.  (Multiple times in 
this file)

> +++ b/Makefile.objs
> @@ -20,6 +20,7 @@ util-obj-y += qapi/qapi-types-sockets.o
>   util-obj-y += qapi/qapi-types-tpm.o
>   util-obj-y += qapi/qapi-types-trace.o
>   util-obj-y += qapi/qapi-types-transaction.o
> +util-obj-y += qapi/qapi-types-tlimits.o

Here too.


>   { 'struct': 'BlockIOThrottle',
> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
> -            '*bps_max': 'int', '*bps_rd_max': 'int',
> -            '*bps_wr_max': 'int', '*iops_max': 'int',
> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> -            '*iops_size': 'int', '*group': 'str' } }
> -

> -{ 'struct': 'ThrottleLimits',
> -  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
> -            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
> -            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
> -            '*iops-write' : 'int', '*iops-write-max' : 'int',
> -            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
> -            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
> -            '*bps-read' : 'int', '*bps-read-max' : 'int',
> -            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
> -            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
> -            '*iops-size' : 'int' } }
> +  'base': 'ThrottleLimits',
> +  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }

The old code has QMP using 'bps_wr' for BlockIOThrottle, but 'bps-write' 
for ThrottleLimits. The new code...

> +++ b/qapi/tlimits.json

> +{ 'struct': 'ThrottleLimits',
> +  'data': { '*bps': 'int', '*bps_rd': 'int',
> +            '*bps_wr': 'int', '*iops': 'int', '*iops_rd': 'int', '*iops_wr': 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> +            '*iops_size': 'int' } }

...is sticking with the BlockIOThrottle naming.  I don't see any use of 
ThrottleLimits in QAPI code (quick check: grep bps-wr 
qapi/qapi-introspect.c comes up empty), so we SHOULD be okay with 
regards to back-compat.  But I'd still split this patch into multiple 
pieces: 1. Rename the ThrottleLimits member names (and give 
justification why such rename doesn't break back-compat). 2. Rewrite 
BlockIOThrottle with ThrottleLimits as its base class. 3. Move 
ThrottleLimits into a new file for future reuse.  (Maybe 2 and 3 can be 
squashed into a single patch)

> diff --git a/util/throttle.c b/util/throttle.c
> index e7db2ad..b421e33 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -496,98 +496,97 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
>   void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
>                                  Error **errp)
>   {
> -    if (arg->has_bps_total) {
> -        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps_total;
> +    if (arg->has_bps) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;

Otherwise, the churn from renaming members (part 1) makes it hard to see 
if the code was properly moved into a new file.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
