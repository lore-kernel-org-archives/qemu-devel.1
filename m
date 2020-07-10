Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C9D2077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C9D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtzTJ-0003Ln-I3
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 16:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jtzSJ-0002Yz-OK; Fri, 10 Jul 2020 16:17:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jtzSH-0002Vg-OQ; Fri, 10 Jul 2020 16:17:11 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06AK3AM6089247; Fri, 10 Jul 2020 16:17:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 326b8yp7eu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2020 16:17:01 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AK3G7A089514;
 Fri, 10 Jul 2020 16:16:56 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 326b8yp7e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2020 16:16:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AK4tQM002709;
 Fri, 10 Jul 2020 20:16:55 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04dal.us.ibm.com with ESMTP id 326bce91tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2020 20:16:55 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06AKGsq737814578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2020 20:16:54 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE4A4AC05B;
 Fri, 10 Jul 2020 20:16:54 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A20BAC059;
 Fri, 10 Jul 2020 20:16:51 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.82.145])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Jul 2020 20:16:51 +0000 (GMT)
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
 <20200708213240.GC780932@habkost.net> <87k0zdz8ud.fsf@morokweng.localdomain>
 <87k0zdm63s.fsf@linaro.org>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] cpu: Add starts_halted() method
In-reply-to: <87k0zdm63s.fsf@linaro.org>
Date: Fri, 10 Jul 2020 17:16:46 -0300
Message-ID: <87imev15xt.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-10_14:2020-07-10,
 2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100134
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 16:17:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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
 Peter Maydell <peter.maydell@linaro.org>, Thomas
 Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>
>>> On Wed, Jul 08, 2020 at 09:11:55PM +0100, Peter Maydell wrote:
>>>> On Wed, 8 Jul 2020 at 18:36, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
>>>> >
>>>> > On Wed, Jul 08, 2020 at 06:09:49PM +0100, Peter Maydell wrote:
>>>> > > Exactly. It appears that there's a bug in our mechanisms,
>>>> > > which is why I'm suggesting that the right thing is
>>>> > > to fix that bug rather than marking the CPU as halted
>>>> > > earlier in the reset process so that the KVM_RUN happens
>>>> > > to do nothing...
>>>> >
>>>> > I agree this is necessary, but it doesn't seem sufficient.
>>>> >
>>>> > Having cpu_reset() set halted=3D0 on spapr (and probably other
>>>> > machines) is also a bug, as it could still trigger unwanted
>>>> > KVM_RUN when cpu_reset() returns (and before machine code sets
>>>> > halted=3D1).
>>>>
>>>> The Arm handling of starting-halted sets halted=3D1 within cpu_reset,
>>>> based on whether the CPU object was created with a
>>>> "start-powered-off" property.
>>>
>>> Making this mechanism generic sounds like a good idea.
>>
>> I'll take a stab at doing that and using it for the spapr machine.
>>
>>>> I'm not sure in practice that anything can get in asynchronously
>>>> and cause a KVM_RUN in between spapr_reset_vcpu() calling
>>>> cpu_reset() and it setting cs->halted (and the other stuff),
>>>> though. This function ought to be called with the iothread
>>>> lock held, so KVM_RUN will only happen if it calls some
>>>> other function which incorrectly lets the CPU run.
>>>
>>> Yeah, maybe it won't happen in practice.  It just seems fragile.
>>> The same way ppc_cpu_reset() kicked the CPU by accident, code
>>> outside cpu_reset() might one day kick the CPU by accident before
>>> setting halted=3D1.
>>
>> I'm seeing the vcpu being KVM_RUN'd too early twice during hotplug.
>> Both of them are before cpu_reset() and ppc_cpu_reset().
>>
>> Here's the backtrace for the first of them (redacted for clarity):
>>
>> #0  in cpu_resume ()
>> #1  in cpu_common_realizefn ()
>> #2  in ppc_cpu_realize ()
>> #3  in device_set_realized ()
>> #4  in property_set_bool ()
>> #5  in object_property_set ()
>> #6  in object_property_set_qobject ()
>> #7  in object_property_set_bool ()
>> #8  in qdev_realize ()
> <snip>
>> #18 in qmp_device_add ()
>
> Is this a hotplug event?

Yes, the way I reproduce the problem is starting a pseries guest with
`-smp 2,maxcpus=3D32,sockets=3D1,cores=3D16,threads=3D2` and then use qmp-s=
hell to
send the command:

device_add id=3Ddevice-2 driver=3Dhost-spapr-cpu-core core-id=3D2 node-id=
=3D0

>> Here's the second:
>>
>> #0  in qemu_cpu_kick_thread ()
>> #1  in qemu_cpu_kick ()
>> #2  in queue_work_on_cpu ()
>> #3  in async_run_on_cpu ()
>> #4  in tlb_flush_by_mmuidx ()
>> #5  in tlb_flush ()
>> #6  in ppc_tlb_invalidate_all ()
>
> FWIW tcg_flush_softmmu_tlb handles a tlb_flush in the common reset code.

Ok, maybe KVM should be doing that too? Or maybe it does but pseries
isn't relying on it. I'll dig further.

--
Thiago Jung Bauermann
IBM Linux Technology Center

