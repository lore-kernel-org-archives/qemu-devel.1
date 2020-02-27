Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86718C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5280524680
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7z5tfbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280524680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7EyM-0002Kd-G3
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7ExR-0001KM-OV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7ExQ-000745-Cy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:55:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7ExQ-00071k-9h
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582793747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFIoBLV8LN6KXnMOGR55IF/rKYy0/YvpI5E5W93PyrM=;
 b=e7z5tfblZ1svTqYE69Go3HpK4XkJBhOSAoPCN969rI56cXzpJzdEZeGf7Hm8h3IfyMT7Zm
 9R039+94sURKzMrzDjGQQA9atq2cFaLK3vzBYPUT3DGfvCaPTmWoposx3VXgIUF2NfcfcY
 P4FnDib4ir9CkeSWTjiIkGVzk4BuJ8g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-PVDWqYLSPYmB3lrqfgdGSg-1; Thu, 27 Feb 2020 03:55:41 -0500
X-MC-Unique: PVDWqYLSPYmB3lrqfgdGSg-1
Received: by mail-wr1-f70.google.com with SMTP id p8so1016944wrw.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 00:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kD8h6BKhPgPJsZKOsFIr7rx01I3aF95aVsYiWOV+iUw=;
 b=si/Lz3Rnhw6qLYVe4xxxlr/QyZsdAP6wnB6B+Ew8zooEgxTa2A/cnvpvAj3xk9b8BO
 xgTI/8TQW9kmeZr0SG+2TgyjcD62xbd2LFQLf4qs1CMgXwH9HyazK6x+llVyjoGbnjaG
 eNhiNANYX9ccUvbk0OdT9/SJMtY3fhorZJs14Z0y2/Ie1H0v4kXrWpPTTjQ1ZaFwwgTT
 CfqnIa7nHxTcO0LYGvEvjSFvSllsmoUjeEJ1HCWE/Sw7LSjHtthsgB1Bz/vK0Do5wfTR
 CCiMosqe1+FnLxYp4HpXyJagz1qvGpH6eWvMbEDq1RZcvBlrphJgc2TCLYK40rwnb+F0
 9+Jw==
X-Gm-Message-State: APjAAAVkyXPolYPADcj3k00BIyRxikcv2lf+q285PIWQdi7XEQXdPZKn
 B0rZFWX9TqkEvyDjKVPEPdAL4swlek7LkVdZWm8/mYvTged9ncuhHZ8SGHZV8RzTAtFhUSOc5G9
 IqzmLMsBx/EvV2C0=
X-Received: by 2002:a05:600c:54e:: with SMTP id
 k14mr3764662wmc.115.1582793740632; 
 Thu, 27 Feb 2020 00:55:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxK5k1tzIxCseOTXdx6BDCj+k/v0kectTb/ktLg24ybPU61jkaN49CjxXBx41ukVr9lTKKdgQ==
X-Received: by 2002:a05:600c:54e:: with SMTP id
 k14mr3764641wmc.115.1582793740359; 
 Thu, 27 Feb 2020 00:55:40 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r28sm7442074wra.16.2020.02.27.00.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 00:55:39 -0800 (PST)
Subject: Re: [PATCH v3 1/6] s390x: fix memleaks in cpu_finalize
To: David Hildenbrand <david@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, peter.maydell@linaro.org
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-2-pannengyuan@huawei.com>
 <59af1e29-8075-a25c-dd80-e93cc21bb328@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <399dfb54-62b7-945b-9f68-4818d419f079@redhat.com>
Date: Thu, 27 Feb 2020 09:55:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <59af1e29-8075-a25c-dd80-e93cc21bb328@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: zhang.zhanghailiang@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 euler.robot@huawei.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 9:41 AM, David Hildenbrand wrote:
> On 27.02.20 03:50, Pan Nengyuan wrote:
>> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390x.=
 The leak stack is as follow:
>>
>> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>>      #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef=
970)
>>      #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>>      #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include/=
qemu/timer.h:530
>>      #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu/=
timer.h:551
>>      #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/qe=
mu/timer.h:569
>>      #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target/=
s390x/cpu.c:285
>>      #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/q=
om/object.c:372
>>      #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new/=
qemu/qom/object.c:516
>>      #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/qo=
m/object.c:684
>>      #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x/=
s390-virtio-ccw.c:64
>>      #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/ma=
chine-hmp-cmds.c:57
>>      #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/mon=
itor/hmp.c:1082
>>      #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/q=
emu/monitor/misc.c:142
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: qemu-s390x@nongnu.org
>> ---
>> v2->v1:
>> - Similarly to other cleanups, move timer_new into realize(Suggested by =
Philippe Mathieu-Daud=C3=A9)
>> v3->v2:
>> - Also do the timer_free in unrealize, it seems more balance.
>> ---
>=20
>=20
> As I already said, I think this is init and not realize stuff. Do we
> have a convention now and documented that?

The clearer doc I read so far is this post:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg680187.html
(but see the thread for more helpful comments)

Another thread that you might find interesting is "how to handle QOM=20
'container' objects whose contents depend on QOM properties?"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg511703.html

>=20
> Anyhow, I don't really care
> [...]

Well, looking at the time spent on these series and their review, having=20
it better documented might save time the whole community.

>=20
>> @@ -453,6 +466,7 @@ static void s390_cpu_class_init(ObjectClass *oc, voi=
d *data)
>>  =20
>>       device_class_set_parent_realize(dc, s390_cpu_realizefn,
>>                                       &scc->parent_realize);
>> +    dc->unrealize =3D s390_cpu_unrealizefn;
>=20
> Shouldn't we use device_class_set_parent_unrealize?
>=20
>=20


