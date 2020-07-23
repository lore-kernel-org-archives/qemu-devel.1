Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AB1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7472F20825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7472F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPSD-0005Dk-Pd
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyPRT-0004Oq-Ud; Wed, 22 Jul 2020 20:50:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyPRS-0005zz-7R; Wed, 22 Jul 2020 20:50:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06N0WEpM072945; Wed, 22 Jul 2020 20:50:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32ecpb2y4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 20:50:13 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N0akbp084374;
 Wed, 22 Jul 2020 20:50:12 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32ecpb2y4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 20:50:12 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N0j0p7010503;
 Thu, 23 Jul 2020 00:50:11 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 32brq92a8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 00:50:11 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06N0oA7c20578774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 00:50:10 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DBC8AE05F;
 Thu, 23 Jul 2020 00:50:10 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 283EEAE063;
 Thu, 23 Jul 2020 00:50:05 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.93.190])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Jul 2020 00:50:04 +0000 (GMT)
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
 <20200722035016.469075-10-bauerman@linux.ibm.com>
 <366d7ab3-cc45-5d47-4317-080c2d594462@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 9/9] target/s390x: Use start-powered-off CPUState
 property
In-reply-to: <366d7ab3-cc45-5d47-4317-080c2d594462@redhat.com>
Date: Wed, 22 Jul 2020 21:50:00 -0300
Message-ID: <87mu3rrr5z.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_16:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220151
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 20:39:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
>> Instead of setting CPUState::halted to 1 in s390_cpu_initfn(), use the
>> start-powered-off property which makes cpu_common_reset() initialize it =
to
>> 1 in common code.
>>=20
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  target/s390x/cpu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> NB: I was only able to test that this patch builds. I wasn't able to
>> run it.
>>=20
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 08eb674d22..d3a14af1d9 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -291,7 +291,8 @@ static void s390_cpu_initfn(Object *obj)
>>      S390CPU *cpu =3D S390_CPU(obj);
>>=20=20
>>      cpu_set_cpustate_pointers(cpu);
>> -    cs->halted =3D 1;
>> +    object_property_set_bool(OBJECT(cs), "start-powered-off", true,
>> +                             &error_abort);
>
> Here this seems overkill since this is the same object, so you can
> directly do:
>
>   +    cs->start_powered_off =3D true;

I adopted your suggestion.

--=20
Thiago Jung Bauermann
IBM Linux Technology Center

