Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77721207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77721207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPJW-0007hw-QE
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyPIV-00074V-Nl; Wed, 22 Jul 2020 20:41:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32250
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyPIU-0004vr-1K; Wed, 22 Jul 2020 20:41:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06N0VUXb060289; Wed, 22 Jul 2020 20:40:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32erjx4504-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 20:40:57 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N0aQeu077235;
 Wed, 22 Jul 2020 20:40:57 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32erjx4500-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 20:40:57 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N0ZYgW004681;
 Thu, 23 Jul 2020 00:40:56 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04wdc.us.ibm.com with ESMTP id 32brq9g6ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 00:40:56 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06N0erKm27132452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 00:40:53 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54EDFC6059;
 Thu, 23 Jul 2020 00:40:55 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B002C6055;
 Thu, 23 Jul 2020 00:40:51 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.93.190])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Jul 2020 00:40:50 +0000 (GMT)
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
 <20200722035016.469075-4-bauerman@linux.ibm.com>
 <d0f25f95-039e-d150-9369-7a1334ff3e12@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 3/9] ppc/spapr: Use start-powered-off CPUState property
In-reply-to: <d0f25f95-039e-d150-9369-7a1334ff3e12@redhat.com>
Date: Wed, 22 Jul 2020 21:40:47 -0300
Message-ID: <87sgdjrrlc.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_16:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220151
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
>> PowerPC sPAPR CPUs start in the halted state, and spapr_reset_vcpu()
>> attempts to implement this by setting CPUState::halted to 1. But that's =
too
>> late for the case of hotplugged CPUs in a machine configure with 2 or mo=
re
>> threads per core.
>>=20
>> By then, other parts of QEMU have already caused the vCPU to run in an
>> unitialized state a couple of times. For example, ppc_cpu_reset() calls
>> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
>> kicks the new vCPU while it has CPUState::halted =3D 0, causing QEMU to =
issue
>> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
>> start-cpu RTAS call to initialize its register state.
>>=20
>> This problem doesn't seem to cause visible issues for regular guests, but
>> on a secure guest running under the Ultravisor it does. The Ultravisor
>> relies on being able to snoop on the start-cpu RTAS call to map vCPUs to
>> guests, and this issue causes it to see a stray vCPU that doesn't belong=
 to
>> any guest.
>>=20
>> Fix by setting the start-powered-off CPUState property in
>> spapr_create_vcpu(), which makes cpu_common_reset() initialize
>> CPUState::halted to 1 at an earlier moment.
>>=20
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  hw/ppc/spapr_cpu_core.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>=20
>> NB: Tested on ppc64le pseries KVM guest with two threads per core.=20
>> Hot-plugging additional cores doesn't cause the bug described above
>> anymore.
>>=20
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index c4f47dcc04..09feeb5f8f 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -36,11 +36,6 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>>=20=20
>>      cpu_reset(cs);
>>=20=20
>> -    /* All CPUs start halted.  CPU0 is unhalted from the machine level
>> -     * reset code and the rest are explicitly started up by the guest
>> -     * using an RTAS call */
>> -    cs->halted =3D 1;
>> -
>>      env->spr[SPR_HIOR] =3D 0;
>>=20=20
>>      lpcr =3D env->spr[SPR_LPCR];
>> @@ -288,6 +283,13 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *=
sc, int i, Error **errp)
>>=20=20
>>      cpu->machine_data =3D g_new0(SpaprCpuState, 1);
>>=20=20
>> +    /*
>> +     * All CPUs start halted. CPU0 is unhalted from the machine level r=
eset code
>> +     * and the rest are explicitly started up by the guest using an RTA=
S call.
>> +     */
>> +    object_property_set_bool(OBJECT(cs), "start-powered-off", true,
>> +                             &error_abort);
>
> Since here object_new() is used, it is simpler to set the field before
> the object is realized, similarly to cs->cpu_index:
>
> -- >8 --
> @@ -275,6 +275,11 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore
> *sc, int i, Error **errp)
>      cs =3D CPU(obj);
>      cpu =3D POWERPC_CPU(obj);
>      cs->cpu_index =3D cc->core_id + i;
> +    /*
> +     * All CPUs start halted. CPU0 is unhalted from the machine level
> reset code
> +     * and the rest are explicitly started up by the guest using an
> RTAS call.
> +     */
> +    cs->start_powered_off =3D true;
>      spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
>      if (local_err) {
>          goto err;
> ---

Good point. I adopted your suggestion.

--=20
Thiago Jung Bauermann
IBM Linux Technology Center

