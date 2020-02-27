Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47879C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153B224691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153B224691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HKH-0004Gd-9M
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j7HJJ-0003Vz-0k
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j7HJH-00013y-KI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:26:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36082 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j7HJD-0000ls-9E; Thu, 27 Feb 2020 06:26:27 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6BA24523E58475D09CEE;
 Thu, 27 Feb 2020 19:26:18 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Feb
 2020 19:26:10 +0800
Subject: Re: [PATCH v3 1/6] s390x: fix memleaks in cpu_finalize
To: Cornelia Huck <cohuck@redhat.com>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-2-pannengyuan@huawei.com>
 <20200227120649.50e6ea68.cohuck@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <50512b17-856b-f509-adb6-46015e86e000@huawei.com>
Date: Thu, 27 Feb 2020 19:25:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200227120649.50e6ea68.cohuck@redhat.com>
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, David
 Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, euler.robot@huawei.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/27/2020 7:06 PM, Cornelia Huck wrote:
> On Thu, 27 Feb 2020 10:50:50 +0800
> Pan Nengyuan <pannengyuan@huawei.com> wrote:
>=20
>> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390=
x. The leak stack is as follow:
>>
>> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>>     #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xe=
f970)
>>     #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>>     #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include=
/qemu/timer.h:530
>>     #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu=
/timer.h:551
>>     #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/q=
emu/timer.h:569
>>     #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target=
/s390x/cpu.c:285
>>     #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/=
qom/object.c:372
>>     #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new=
/qemu/qom/object.c:516
>>     #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/q=
om/object.c:684
>>     #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x=
/s390-virtio-ccw.c:64
>>     #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/m=
achine-hmp-cmds.c:57
>>     #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/mo=
nitor/hmp.c:1082
>>     #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/=
qemu/monitor/misc.c:142
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
>> - Similarly to other cleanups, move timer_new into realize(Suggested b=
y Philippe Mathieu-Daud=C3=83=C2=A9)
>> v3->v2:
>> - Also do the timer_free in unrealize, it seems more balance.
>> ---
>>  target/s390x/cpu.c | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index cf84d307c6..cc63c9db22 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -170,7 +170,12 @@ static void s390_cpu_realizefn(DeviceState *dev, =
Error **errp)
>>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(dev);
>>  #if !defined(CONFIG_USER_ONLY)
>>      S390CPU *cpu =3D S390_CPU(dev);
>> +    cpu->env.tod_timer =3D
>> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
>> +    cpu->env.cpu_timer =3D
>> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>>  #endif
>=20
> It does not seem you addressed the comments I had last time, namely
> - memory leak on error (we do not go through unrealize if the device
>   was never completely realized)
> - coding style (initialization in middle of declaration section)

I am sorry, I misread the peter's reply and miss the codeing style too.

Apologies for you. I will change it.

Thanks.

>=20
>> +
>>      Error *err =3D NULL;
>> =20
>>      /* the model has to be realized before qemu_init_vcpu() due to kv=
m */
>=20
> .
>=20

