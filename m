Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B47C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDA420888
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDA420888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPRB-0003yZ-Mb
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyPQ4-00035L-68; Wed, 22 Jul 2020 20:49:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42082
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyPQ1-0005rW-VA; Wed, 22 Jul 2020 20:49:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06N0WfnP077462; Wed, 22 Jul 2020 20:48:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vwd312-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 20:48:49 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N0fYmN104139;
 Wed, 22 Jul 2020 20:48:48 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vwd30q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 20:48:48 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N0k7CL020067;
 Thu, 23 Jul 2020 00:48:48 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 32d5dqg1mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 00:48:47 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06N0mkrV66650508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 00:48:46 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FAF8C6059;
 Thu, 23 Jul 2020 00:48:46 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77480C6057;
 Thu, 23 Jul 2020 00:48:42 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.93.190])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Jul 2020 00:48:42 +0000 (GMT)
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
 <20200722035016.469075-9-bauerman@linux.ibm.com>
 <21df06b3-725f-9bba-7e98-db8b74d97902@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 8/9] sparc/sun4m: Use one cpu_reset() function for
 main and secondary CPUs
In-reply-to: <21df06b3-725f-9bba-7e98-db8b74d97902@redhat.com>
Date: Wed, 22 Jul 2020 21:48:38 -0300
Message-ID: <87o8o7rr89.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_16:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007220151
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 18:08:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/22/20 5:50 AM, Thiago Jung Bauermann wrote:
>> If we rely on cpu_common_reset() setting CPUState::halted according to t=
he
>> start-powered-off property, both reset functions become equivalent and we
>> can use only one.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  hw/sparc/sun4m.c | 21 ++++-----------------
>>  1 file changed, 4 insertions(+), 17 deletions(-)
>>
>> NB: I was only able to test that this patch builds. I wasn't able to
>> run it.
>>
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 7b3042a801..deb5e9f027 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -218,16 +218,7 @@ static void dummy_cpu_set_irq(void *opaque, int irq=
, int level)
>>  {
>>  }
>>
>> -static void main_cpu_reset(void *opaque)
>> -{
>> -    SPARCCPU *cpu =3D opaque;
>> -    CPUState *cs =3D CPU(cpu);
>> -
>> -    cpu_reset(cs);
>> -    cs->halted =3D 0;
>> -}
>> -
>> -static void secondary_cpu_reset(void *opaque)
>> +static void sun4m_cpu_reset(void *opaque)
>>  {
>>      SPARCCPU *cpu =3D opaque;
>>      CPUState *cs =3D CPU(cpu);
>> @@ -818,7 +809,6 @@ static const TypeInfo ram_info =3D {
>>  static void cpu_devinit(const char *cpu_type, unsigned int id,
>>                          uint64_t prom_addr, qemu_irq **cpu_irqs)
>>  {
>> -    CPUState *cs;
>>      SPARCCPU *cpu;
>>      CPUSPARCState *env;
>>
>> @@ -826,12 +816,9 @@ static void cpu_devinit(const char *cpu_type, unsig=
ned int id,
>>      env =3D &cpu->env;
>>
>>      cpu_sparc_set_id(env, id);
>> -    if (id =3D=3D 0) {
>> -        qemu_register_reset(main_cpu_reset, cpu);
>
> IMO it is easier to review this patch in 2, first drop main_cpu_reset
> as it is pointless (we rely on cpu_common_reset), then set the
> "start-powered-off" property and drop secondary_cpu_reset().

That's a good idea. I made those patches for v3.

>> -    } else {
>> -        qemu_register_reset(secondary_cpu_reset, cpu);
>> -        cs =3D CPU(cpu);
>> -        object_property_set_bool(OBJECT(cs), "start-powered-off", true,
>> +    qemu_register_reset(sun4m_cpu_reset, cpu);
>
> Why do you still keep it?

I didn't know that not registering a reset function would cause
cpu_reset() to be caused.

>> +    if (id !=3D 0) {
>> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>>                                   &error_abort);
>
> At this point the CPU is realized, so this is correct.

Great. Thanks for confirming!

> I'd use directly:
>
>        object_property_set_bool(OBJECT(cpu), "start-powered-off", !!id,
>                                 &error_abort);

I used a slight variation of your suggestion, with `id !=3D 0` instead of
`!!id` because I think it makes the code easier to read.

--
Thiago Jung Bauermann
IBM Linux Technology Center

