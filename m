Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C2C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA872067D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA872067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2uvF-0003Zc-Au
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 05:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j2uua-0002mo-Gb
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j2uuZ-0002td-6m
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:43:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34104 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j2uuY-0002n1-Na; Sat, 15 Feb 2020 05:42:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4817ACC7827C6A27B172;
 Sat, 15 Feb 2020 18:42:49 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 15 Feb
 2020 18:42:39 +0800
Subject: Re: [PATCH 1/2] s390x: fix memleaks in cpu_finalize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <cohuck@redhat.com>, <rth@twiddle.net>, <david@redhat.com>
References: <20200215083203.5064-1-pannengyuan@huawei.com>
 <0d92b8d7-907f-2969-55f3-2ee5746edf68@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <a8df69c7-eeae-5733-8eee-86ed7fe444fe@huawei.com>
Date: Sat, 15 Feb 2020 18:42:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0d92b8d7-907f-2969-55f3-2ee5746edf68@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: zhang.zhanghailiang@huawei.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/15/2020 6:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Pan,
>=20
> On 2/15/20 9:32 AM, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390=
x. The leak stack is as follow:
>>
>> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>> =C2=A0=C2=A0=C2=A0=C2=A0 #0 0x7fb43c7cd970 in __interceptor_calloc (/l=
ib64/libasan.so.5+0xef970)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #1 0x7fb43be2149d in g_malloc0 (/lib64/libgli=
b-2.0.so.0+0x5249d)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #2 0x558ba96da716 in timer_new_full /mnt/sdb/=
qemu-new/qemu/include/qemu/timer.h:530
>> =C2=A0=C2=A0=C2=A0=C2=A0 #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-=
new/qemu/include/qemu/timer.h:551
>> =C2=A0=C2=A0=C2=A0=C2=A0 #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qe=
mu-new/qemu/include/qemu/timer.h:569
>> =C2=A0=C2=A0=C2=A0=C2=A0 #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb=
/qemu-new/qemu/target/s390x/cpu.c:285
>> =C2=A0=C2=A0=C2=A0=C2=A0 #6 0x558ba9c969ab in object_init_with_type /m=
nt/sdb/qemu-new/qemu/qom/object.c:372
>> =C2=A0=C2=A0=C2=A0=C2=A0 #7 0x558ba9c9eb5f in object_initialize_with_t=
ype /mnt/sdb/qemu-new/qemu/qom/object.c:516
>> =C2=A0=C2=A0=C2=A0=C2=A0 #8 0x558ba9c9f053 in object_new_with_type /mn=
t/sdb/qemu-new/qemu/qom/object.c:684
>> =C2=A0=C2=A0=C2=A0=C2=A0 #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/q=
emu-new/qemu/hw/s390x/s390-virtio-ccw.c:64
>> =C2=A0=C2=A0=C2=A0=C2=A0 #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qe=
mu-new/qemu/hw/core/machine-hmp-cmds.c:57
>> =C2=A0=C2=A0=C2=A0=C2=A0 #11 0x558ba9b1c27f in handle_hmp_command /mnt=
/sdb/qemu-new/qemu/monitor/hmp.c:1082
>> =C2=A0=C2=A0=C2=A0=C2=A0 #12 0x558ba96c1b02 in qmp_human_monitor_comma=
nd /mnt/sdb/qemu-new/qemu/monitor/misc.c:142
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> =C2=A0 target/s390x/cpu.c | 4 ++++
>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index cf84d307c6..fff793a4eb 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -294,6 +294,10 @@ static void s390_cpu_finalize(Object *obj)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_unregister_reset(s390_cpu_m=
achine_reset_cb, cpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(cpu->irqstate);
>> +=C2=A0=C2=A0=C2=A0 timer_del(cpu->env.tod_timer);
>> +=C2=A0=C2=A0=C2=A0 timer_del(cpu->env.cpu_timer);
>=20
> Similarly to your other cleanups, shouldn't we move the timer_new_ns() =
into a realize() function, then do the timer_del() in unrealize()?

Sure, I have no problem with that. I will change and repost it.

Thanks.

>=20
>> +=C2=A0=C2=A0=C2=A0 timer_free(cpu->env.tod_timer);
>> +=C2=A0=C2=A0=C2=A0 timer_free(cpu->env.cpu_timer);
>=20
> The timer_free() is correct.
>=20
>> =C2=A0 #endif
>> =C2=A0 }
>> =C2=A0
>=20
> .

