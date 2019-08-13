Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD11C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60934205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60934205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYFz-0000RN-Na
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxYFT-0008Ol-FM
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxYFR-0002JM-OB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:58:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxYFN-0002HT-VQ; Tue, 13 Aug 2019 10:58:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 336603090FE1;
 Tue, 13 Aug 2019 14:58:01 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C70F860BE2;
 Tue, 13 Aug 2019 14:57:51 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
 <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
Date: Tue, 13 Aug 2019 16:57:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1dT8vhnjVYMCA0KIo4NtzppwW00ibhVQS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 13 Aug 2019 14:58:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1dT8vhnjVYMCA0KIo4NtzppwW00ibhVQS
Content-Type: multipart/mixed; boundary="XxiJGivbTKuyDNiDDmZdXVRckIJ75w6ut";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
Subject: Re: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
 <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
In-Reply-To: <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>

--XxiJGivbTKuyDNiDDmZdXVRckIJ75w6ut
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 16:39, Vladimir Sementsov-Ogievskiy wrote:
> 13.08.2019 17:23, Max Reitz wrote:
>> On 13.08.19 16:14, Vladimir Sementsov-Ogievskiy wrote:
>>> 12.08.2019 19:37, Vladimir Sementsov-Ogievskiy wrote:
>>>> 12.08.2019 19:11, Max Reitz wrote:
>>>>> On 12.08.19 17:47, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> 12.08.2019 18:10, Max Reitz wrote:
>>>>>>> On 10.08.19 21:31, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>> backup_cow_with_offload can transfer more than one cluster. Let
>>>>>>>> backup_cow_with_bounce_buffer behave similarly. It reduces the n=
umber
>>>>>>>> of IO requests, since there is no need to copy cluster by cluste=
r.
>>>>>>>>
>>>>>>>> Logic around bounce_buffer allocation changed: we can't just all=
ocate
>>>>>>>> one-cluster-sized buffer to share for all iterations. We can't a=
lso
>>>>>>>> allocate buffer of full-request length it may be too large, so
>>>>>>>> BACKUP_MAX_BOUNCE_BUFFER is introduced. And finally, allocation =
logic
>>>>>>>> is to allocate a buffer sufficient to handle all remaining itera=
tions
>>>>>>>> at the point where we need the buffer for the first time.
>>>>>>>>
>>>>>>>> Bonus: get rid of pointer-to-pointer.
>>>>>>>>
>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozz=
o.com>
>>>>>>>> ---
>>>>>>>>  =C2=A0=C2=A0 block/backup.c | 65 ++++++++++++++++++++++++++++++=
+-------------------
>>>>>>>>  =C2=A0=C2=A0 1 file changed, 41 insertions(+), 24 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/backup.c b/block/backup.c
>>>>>>>> index d482d93458..65f7212c85 100644
>>>>>>>> --- a/block/backup.c
>>>>>>>> +++ b/block/backup.c
>>>>>>>> @@ -27,6 +27,7 @@
>>>>>>>>  =C2=A0=C2=A0 #include "qemu/error-report.h"
>>>>>>>>  =C2=A0=C2=A0 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
>>>>>>>> +#define BACKUP_MAX_BOUNCE_BUFFER (64 * 1024 * 1024)
>>>>>>>>  =C2=A0=C2=A0 typedef struct CowRequest {
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t start_byte;
>>>>>>>> @@ -98,44 +99,55 @@ static void cow_request_end(CowRequest *req)=

>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_queue_restart_all(=
&req->wait_queue);
>>>>>>>>  =C2=A0=C2=A0 }
>>>>>>>> -/* Copy range to target with a bounce buffer and return the byt=
es copied. If
>>>>>>>> - * error occurred, return a negative error number */
>>>>>>>> +/*
>>>>>>>> + * Copy range to target with a bounce buffer and return the byt=
es copied. If
>>>>>>>> + * error occurred, return a negative error number
>>>>>>>> + *
>>>>>>>> + * @bounce_buffer is assumed to enough to store
>>>>>>>
>>>>>>> s/to/to be/
>>>>>>>
>>>>>>>> + * MIN(BACKUP_MAX_BOUNCE_BUFFER, @end - @start) bytes
>>>>>>>> + */
>>>>>>>>  =C2=A0=C2=A0 static int coroutine_fn backup_cow_with_bounce_buf=
fer(BackupBlockJob *job,
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t start,
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t end,
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_write_notifier,
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool *error_is_read,
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void **bounce_buffer)
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *bounce_buffer)
>>>>>>>>  =C2=A0=C2=A0 {
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *blk =3D job-=
>common.blk;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 int nbytes;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 int nbytes, remaining_bytes;
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int read_flags =3D is_writ=
e_notifier ? BDRV_REQ_NO_SERIALISING : 0;
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(sta=
rt, job->cluster_size));
>>>>>>>> -=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(job->copy_bitmap, st=
art, job->cluster_size);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 nbytes =3D MIN(job->cluster_size, job->len -=
 start);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (!*bounce_buffer) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *bounce_buffer =3D b=
lk_blockalign(blk, job->cluster_size);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +=C2=A0=C2=A0=C2=A0 bdrv_reset_dirty_bitmap(job->copy_bitmap, st=
art, end - start);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 nbytes =3D MIN(end - start, job->len - start=
);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D blk_co_pread(blk, start, nbytes, *bo=
unce_buffer, read_flags);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_backup_do_cow_=
read_fail(job, start, ret);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error_is_read) {=

>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *error_is_read =3D true;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 remaining_bytes =3D nbytes;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 while (remaining_bytes) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int chunk =3D MIN(BA=
CKUP_MAX_BOUNCE_BUFFER, remaining_bytes);
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_co_pread=
(blk, start, chunk, bounce_buffer, read_flags);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 trace_backup_do_cow_read_fail(job, start, ret);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (error_is_read) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *error_is_read =3D true;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto fail;
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D blk_co_pwrite(job->target, start, nb=
ytes, *bounce_buffer,
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 job->write_flags);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_backup_do_cow_=
write_fail(job, start, ret);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error_is_read) {=

>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *error_is_read =3D false;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_co_pwrit=
e(job->target, start, chunk, bounce_buffer,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 job->write_flags);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 trace_backup_do_cow_write_fail(job, start, ret);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (error_is_read) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *error_is_read =3D false;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto fail;
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start +=3D chunk;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remaining_bytes -=3D=
 chunk;
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbytes;
>>>>>>>> @@ -301,9 +313,14 @@ static int coroutine_fn backup_do_cow(Backu=
pBlockJob *job,
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!job->use_copy_range) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!bounce_buffer) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len =3D MIN(BACKUP_MAX_BOUNCE_BUFFER,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX(dirty_end - st=
art, end - dirty_end));
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 bounce_buffer =3D blk_try_blockalign(job->com=
mon.blk, len);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>>>>>>
>>>>>>> If you use _try_, you should probably also check whether it succe=
eded.
>>>>>>
>>>>>> Oops, you are right, of course.
>>>>>>
>>>>>>>
>>>>>>> Anyway, I wonder whether it=E2=80=99d be better to just allocate =
this buffer
>>>>>>> once per job (the first time we get here, probably) to be of size=

>>>>>>> BACKUP_MAX_BOUNCE_BUFFER and put it into BackupBlockJob.=C2=A0 (A=
nd maybe add
>>>>>>> a buf-size parameter similar to what the mirror jobs have.)
>>>>>>>
>>>>>>
>>>>>> Once per job will not work, as we may have several guest writes in=
 parallel and therefore
>>>>>> several parallel copy-before-write operations.
>>>>>
>>>>> Hm.=C2=A0 I=E2=80=99m not quite happy with that because if the gues=
t just issues many
>>>>> large discards in parallel, this means that qemu will allocate a la=
rge
>>>>> amount of memory.
>>>>>
>>>>> It would be nice if there was a simple way to keep track of the tot=
al
>>>>> memory usage and let requests yield if they would exceed it.
>>>>
>>>> Agree, it should be fixed anyway.
>>>>
>>>
>>>
>>> But still..
>>>
>>> Synchronous mirror allocates full-request buffers on guest write. Is =
it correct?
>>>
>>> If we assume that it is correct to double memory usage of guest opera=
tions, than for backup
>>> the problem is only in write_zero and discard where guest-assumed mem=
ory usage should be zero.
>>
>> Well, but that is the problem.  I didn=E2=80=99t say anything in v2, b=
ecause I
>> only thought of normal writes and I found it fine to double the memory=

>> usage there (a guest won=E2=80=99t issue huge write requests in parall=
el).  But
>> discard/write-zeroes are a different matter.
>>
>>> And if we should distinguish writes from write_zeroes and discard, it=
's better to postpone this
>>> improvement to be after backup-top filter merged.
>>
>> But do you need to distinguish it?  Why not just keep track of memory
>> usage and put the current I/O coroutine to sleep in a CoQueue or
>> something, and wake that up at the end of backup_do_cow()?
>>
>=20
> 1. Because if we _can_ allow doubling of memory, it's more effective to=
 not restrict allocations on
> guest writes. It's just seems to be more effective technique.

But the problem with backup and zero writes/discards is that the memory
is not doubled.  The request doesn=E2=80=99t need any memory, but the CBW=

operation does, and maybe lots of it.

So the guest may issue many zero writes/discards in parallel and thus
exhaust memory on the host.

> 2. Anyway, I'd allow some always-available size to allocate - let it be=
 one cluster, which will correspond
> to current behavior and prevent guest io hang in worst case.

The guest would only hang if it we have to copy more than e.g. 64 MB at
a time.  At which point I think it=E2=80=99s not unreasonable to sequenti=
alize
requests.

Max

> So I mean, if we have enough memory allow
> individual CBW operation to allocate the whole buffer, and if we have n=
o extra memory allow to allocate one
> cluster.
>=20



--XxiJGivbTKuyDNiDDmZdXVRckIJ75w6ut--

--1dT8vhnjVYMCA0KIo4NtzppwW00ibhVQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Sz+4ACgkQ9AfbAGHV
z0CNTQf/YIYSlxICCtL4ufHKswfAZs78weQf7cE8nYNUE19mt6SLgJ6Bk5i80eRY
GKn4Y68q/96/GNe0sWdpP5YMI0oPMUnjPqDONbnxIcpocnqyyQckQ19YWxYLJ2TF
KfKGJHfanUAaAM+nZQX2uPmBjPdC2KIUuF6Q0c4fgt5VI8NZZZgEnifMNQvQRQYJ
iR3tyX5SEyy9LYT7dCNOkrVnLelAqN0L01bXaffByX6UfWDhG3hT0HBrY56nEUBq
au4tg9fTd32y82uIL61ctWV3146+ijhkanoao9IbuMG+f2SNJ8mE06+nzL5n17lA
2Dc7o6EKzQjnBCTIgDusBdaEIMtS5w==
=37/o
-----END PGP SIGNATURE-----

--1dT8vhnjVYMCA0KIo4NtzppwW00ibhVQS--

