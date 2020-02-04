Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018CC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D01020730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8Wurt/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D01020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0kK-0004qT-CF
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz0j8-0002HY-NW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz0j7-0004xU-IW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23995
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz0j7-0004wh-Ea
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1rbepfpnFB843MKMZeXQJRPvzEKlKilYngw69oOnow=;
 b=U8Wurt/fKhwXnRwfOB0LUV94wRjAImDY5q1hSTFtNvUn2qgf18apnZJ8AuSgR1DEvA3Beu
 bQUg/RGgxT1zNa2Xaht2xlNBLtrZQGRu+cpLJguvj2TNfE72vClInwWZZ4E5BkeFOqa5oO
 LA2JEmqw3exWT8PTGlqHPkNr+7K+lLw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-P6wb8lbTO5aybSIOD0c5-A-1; Tue, 04 Feb 2020 11:06:33 -0500
Received: by mail-wm1-f70.google.com with SMTP id y125so1147935wmg.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LuHgfT7pF5Q4s3wHukhp5mOxAHRUKDKVtayFvCEnWhs=;
 b=sxNNyDA3hPILPSjAqoFz+btFIKiv5XeFgIsvGSb1Om9Lk7eVZZd3waAsfeEDPHzBN3
 iLl1i8nzHxI8hpKImKSMW/6pdAYHlrop8OZcDiETCzm1sWJeJPySR55l4m0AukzPjOfG
 LB8LyuJ/YGggXpnWU0gYiCNz+aFkR38/+Eol6RV5GeTQF5E4ScTJUUsINaMvt4AqYIuz
 Q1uJD0gw4iXY/DR6YpA98+dFwWwoawnVhmoQwa2Q8pxUaDTZinHpzRlRpvsmCuAHbR/p
 5kvAKrBG8n9qnEGVzo2yY5PQARwfeyCJ2LtNeFO+4vfPW45scm8Oh0ktB1ERPfbgijll
 XMUQ==
X-Gm-Message-State: APjAAAX/DbIrqES5T9aoIWec9xgeVv+tury0TnUhwxfCt3e0sWmY2So5
 oWbcNLvO6JHSzuHU2+91Xv0Wog+Mepv63SVIADrcJOd7aC0//JTbxXZw1sPAxGTkTRex3CelwHE
 sZcNJg58ys42J84c=
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr24200100wrr.73.1580832392073; 
 Tue, 04 Feb 2020 08:06:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMQ6iG98fAI5tqwmXPB9ZL6KhisdSA5yoB0gpw5EARPe6/i9YK7z5Q+c4ZdDnnD/ftqDsiDQ==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr24200083wrr.73.1580832391884; 
 Tue, 04 Feb 2020 08:06:31 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id x11sm4301863wmg.46.2020.02.04.08.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:06:31 -0800 (PST)
Subject: Re: [PATCH 3/4] virtiofsd: load_capng missing unlock
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200204110501.10731-1-dgilbert@redhat.com>
 <20200204110501.10731-4-dgilbert@redhat.com>
 <fd996682-b280-c872-93cf-5147b52ab097@redhat.com>
 <20200204154404.GE3504@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <45f090c8-2ffc-6a47-39d6-54df6672b9f3@redhat.com>
Date: Tue, 4 Feb 2020 17:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204154404.GE3504@work-vm>
Content-Language: en-US
X-MC-Unique: P6wb8lbTO5aybSIOD0c5-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 4:44 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> Hi David,
>>
>> On 2/4/20 12:05 PM, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> Missing unlock in error path.
>>>
>>> Fixes: Covertiy CID 1413123
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>    tools/virtiofsd/passthrough_ll.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
>>> index e6f2399efc..c635fc8820 100644
>>> --- a/tools/virtiofsd/passthrough_ll.c
>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>> @@ -232,6 +232,7 @@ static int load_capng(void)
>>>             */
>>>            cap.saved =3D capng_save_state();
>>>            if (!cap.saved) {
>>> +            pthread_mutex_unlock(&cap.mutex);
>>>                fuse_log(FUSE_LOG_ERR, "capng_save_state (thread)\n");
>>>                return -EINVAL;
>>>            }
>>>
>>
>> What about moving the unlock call?
>>
>> -- >8 --
>> --- a/tools/virtiofsd/passthrough_ll.c
>> +++ b/tools/virtiofsd/passthrough_ll.c
>> @@ -231,11 +231,11 @@ static int load_capng(void)
>>            * so make another.
>>            */
>>           cap.saved =3D capng_save_state();
>> +        pthread_mutex_unlock(&cap.mutex);
>>           if (!cap.saved) {
>=20
> I don't think I can legally check cap.saved there if I've already
> unlocked

Sorry I was with low sugar... I read it as a copy.

The patch is fine:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>>               fuse_log(FUSE_LOG_ERR, "capng_save_state (thread)\n");
>>               return -EINVAL;
>>           }
>> -        pthread_mutex_unlock(&cap.mutex);
>>
>>           /*
>>            * We want to use the loaded state for our pid,
>> ---
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20


