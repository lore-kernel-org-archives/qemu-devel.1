Received: from eggs.gnu.org ([2001:4830:134:3::10]:45260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZcWk-0008LV-P1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZcWh-0005Dw-Ms
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:59:42 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZcWh-0005CV-Dc
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:59:39 -0500
References: <1486116298-25046-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486116298-25046-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51o9yjwody.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <5a25dd49-51bd-43b7-4fb9-bb68bd8cfc86@huawei.com>
Date: Fri, 3 Feb 2017 12:58:53 +0100
MIME-Version: 1.0
In-Reply-To: <w51o9yjwody.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2 v15] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On 2/3/2017 11:38 AM, Alberto Garcia wrote:
> On Fri 03 Feb 2017 11:04:58 AM CET, Pradeep Jagadeesh wrote:
>
>> This patch removes the redundant throttle code that was present in
>> block and fsdev device files. Now the common code is moved to a single
>> file.
>
> Here it says that this patch moves common code to a separate file,
> however:

Hmm, sorry. I just messed it up while merging.

Regards,
Pradeep
>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 920eb05..22a6a99 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -3532,7 +3532,6 @@ out:
>>          if (s->ops && s->ops->cleanup && s->ctx.private) {
>>              s->ops->cleanup(&s->ctx);
>>          }
>> -        fsdev_throttle_cleanup(s->ctx.fst);
>>          g_free(s->tag);
>>          g_free(s->ctx.fs_root);
>>          v9fs_path_free(&path);
>> @@ -3545,6 +3544,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
>>      if (s->ops->cleanup) {
>>          s->ops->cleanup(&s->ctx);
>>      }
>> +    fsdev_throttle_cleanup(s->ctx.fst);
>>      g_free(s->tag);
>>      g_free(s->ctx.fs_root);
>>  }
>
> This doesn't belong here. In patch 1 you add a fsdev_throttle_cleanup()
> in v9fs_device_realize_common(), and in patch 2 you remove it from there
> and put it in v9fs_device_unrealize_common().
>
> It looks like you wanted to fix patch 1 but added the fix to patch 2
> instead.
>
> Berto
>
