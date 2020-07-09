Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5CBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 03:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE37206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 03:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE37206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtMtK-00057b-0c
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 23:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jtMsh-0004cV-0y; Wed, 08 Jul 2020 23:05:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jtMse-0001vP-P6; Wed, 08 Jul 2020 23:05:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06931b10132721; Wed, 8 Jul 2020 23:05:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 325s23tpd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2020 23:05:40 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06932YoY140172;
 Wed, 8 Jul 2020 23:05:39 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 325s23tpd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2020 23:05:39 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06934isk017474;
 Thu, 9 Jul 2020 03:05:38 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01wdc.us.ibm.com with ESMTP id 325k27k1bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2020 03:05:38 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06935c7W40173882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2020 03:05:38 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24E03112064;
 Thu,  9 Jul 2020 03:05:38 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32D6A112061;
 Thu,  9 Jul 2020 03:05:35 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.128.84])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Jul 2020 03:05:34 +0000 (GMT)
References: <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
 <20200708160316.GA7276@habkost.net>
 <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
 <20200708173620.GB780932@habkost.net>
 <CAFEAcA_bLs+PzjfmCaHQQ3z1BrQ9Uack_Qj7Za-dJwtHWu=8kw@mail.gmail.com>
 <20200708213240.GC780932@habkost.net>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
In-reply-to: <20200708213240.GC780932@habkost.net>
Date: Thu, 09 Jul 2020 00:05:30 -0300
Message-ID: <87k0zdz8ud.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-08_19:2020-07-08,
 2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090019
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 23:05:46
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Jul 08, 2020 at 09:11:55PM +0100, Peter Maydell wrote:
>> On Wed, 8 Jul 2020 at 18:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> >
>> > On Wed, Jul 08, 2020 at 06:09:49PM +0100, Peter Maydell wrote:
>> > > Exactly. It appears that there's a bug in our mechanisms,
>> > > which is why I'm suggesting that the right thing is
>> > > to fix that bug rather than marking the CPU as halted
>> > > earlier in the reset process so that the KVM_RUN happens
>> > > to do nothing...
>> >
>> > I agree this is necessary, but it doesn't seem sufficient.
>> >
>> > Having cpu_reset() set halted=0 on spapr (and probably other
>> > machines) is also a bug, as it could still trigger unwanted
>> > KVM_RUN when cpu_reset() returns (and before machine code sets
>> > halted=1).
>>
>> The Arm handling of starting-halted sets halted=1 within cpu_reset,
>> based on whether the CPU object was created with a
>> "start-powered-off" property.
>
> Making this mechanism generic sounds like a good idea.

I'll take a stab at doing that and using it for the spapr machine.

>> I'm not sure in practice that anything can get in asynchronously
>> and cause a KVM_RUN in between spapr_reset_vcpu() calling
>> cpu_reset() and it setting cs->halted (and the other stuff),
>> though. This function ought to be called with the iothread
>> lock held, so KVM_RUN will only happen if it calls some
>> other function which incorrectly lets the CPU run.
>
> Yeah, maybe it won't happen in practice.  It just seems fragile.
> The same way ppc_cpu_reset() kicked the CPU by accident, code
> outside cpu_reset() might one day kick the CPU by accident before
> setting halted=1.

I'm seeing the vcpu being KVM_RUN'd too early twice during hotplug.
Both of them are before cpu_reset() and ppc_cpu_reset().

Here's the backtrace for the first of them (redacted for clarity):

#0  in cpu_resume ()
#1  in cpu_common_realizefn ()
#2  in ppc_cpu_realize ()
#3  in device_set_realized ()
#4  in property_set_bool ()
#5  in object_property_set ()
#6  in object_property_set_qobject ()
#7  in object_property_set_bool ()
#8  in qdev_realize ()
#9  in spapr_realize_vcpu ()
#10 in spapr_cpu_core_realize ()
#11 in device_set_realized ()
#12 in property_set_bool ()
#13 in object_property_set ()
#14 in object_property_set_qobject ()
#15 in object_property_set_bool ()
#16 in qdev_realize ()
#17 in qdev_device_add ()
#18 in qmp_device_add ()

Here's the second:

#0  in qemu_cpu_kick_thread ()
#1  in qemu_cpu_kick ()
#2  in queue_work_on_cpu ()
#3  in async_run_on_cpu ()
#4  in tlb_flush_by_mmuidx ()
#5  in tlb_flush ()
#6  in ppc_tlb_invalidate_all ()
#7  in ppc_cpu_reset ()
#8  in device_transitional_reset ()
#9  in resettable_phase_hold ()
#10 in resettable_assert_reset ()
#11 in device_set_realized ()
#12 in property_set_bool ()
#13 in object_property_set ()
#14 in object_property_set_qobject ()
#15 in object_property_set_bool ()
#16 in qdev_realize ()
#17 in spapr_realize_vcpu ()
#18 in spapr_cpu_core_realize ()
#19 in device_set_realized ()
#20 in property_set_bool ()
#21 in object_property_set ()
#22 in object_property_set_qobject ()
#23 in object_property_set_bool ()
#24 in qdev_realize ()
#25 in qdev_device_add ()
#26 in qmp_device_add ()

Looking closely, both of them ultimately stem from the
qdev_realize(DEVICE(cpu), ...) call in spapr_realize_vcpu(). Is there
something wrong with that? I don't know anything about the QEMU device
model to be able to tell.

One other way I found to avoid the spurious KVM_RUN calls is to remove
the cpu_resume() call in cpu_common_realizefn(), which to me seems to
be placed way too early in the CPU hotplug path. Simply removing it
makes CPU hotplug stop working though. :-)  I still have to see if I can
find a better place for it...

--
Thiago Jung Bauermann
IBM Linux Technology Center

