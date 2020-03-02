Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A59AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708EA2084E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708EA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m00nbsd.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qkq-0007m9-Me
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <max@m00nbsd.net>) id 1j8qje-0006wm-EA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <max@m00nbsd.net>) id 1j8qjc-0005ZV-Es
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:28:14 -0500
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:49197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <max@m00nbsd.net>) id 1j8qjc-0005XF-5m
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:28:12 -0500
Received: from mxplan6.mail.ovh.net (unknown [10.108.1.72])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id A70A92A56CB4;
 Mon,  2 Mar 2020 20:28:09 +0100 (CET)
Received: from m00nbsd.net (37.59.142.105) by DAG3EX2.mxp6.local (172.16.2.22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 2 Mar 2020
 20:28:08 +0100
From: Maxime Villard <max@m00nbsd.net>
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <slp@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@redhat.com>, <jmcneill@invisible.ca>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
Autocrypt: addr=max@m00nbsd.net; keydata=
 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
Message-ID: <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
Date: Mon, 2 Mar 2020 20:28:04 +0100
MIME-Version: 1.0
In-Reply-To: <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG4EX1.mxp6.local (172.16.2.31) To DAG3EX2.mxp6.local
 (172.16.2.22)
X-Ovh-Tracer-GUID: fca76127-9d19-4db4-9db4-e0cc884d58f6
X-Ovh-Tracer-Id: 6793961515724377903
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddtgedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhuffvfhfkffggjggtgfhisehtkeertddttdejnecuhfhrohhmpeforgigihhmvgcugghilhhlrghrugcuoehmrgigsehmtddtnhgsshgurdhnvghtqeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnheirdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepmhgrgiesmhdttdhnsghsugdrnhgvthdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 79.137.123.220
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/03/2020 =C3=A0 19:13, Paolo Bonzini a =C3=A9crit=C2=A0:
> On 06/02/20 22:32, Kamil Rytarowski wrote:
>> +get_qemu_vcpu(CPUState *cpu)
>> +{
>> +    return (struct qemu_vcpu *)cpu->hax_vcpu;
>> +}
>=20
> Please make hax_vcpu a void * and rename it to "accel_data".

NVMM reproduces the existing logic in the other accelerators. I agree
that it should be "accel_data" with void *, but that should be done
in all accelerators in a separate commit, unrelated to NVMM.

>> +    nseg->attrib.g =3D __SHIFTOUT(attrib, DESC_G_MASK);
>=20
>> +        __SHIFTIN((uint32_t)nseg->attrib.g, DESC_G_MASK);
>=20
> What are __SHIFTOUT and __SHIFTIN?

They are macros in NetBSD.

>> +    if (qcpu->int_window_exit) {
>=20
> Should it assert the condition in the "if" below?

No, because if int_window_exit is set, then state->intr.int_window_exitin=
g
is set too, so there is no point doing get+set.

>> +        return false;
>> +    }
>> +
>> +    if (qcpu->int_shadow || !(env->eflags & IF_MASK)) {
>> +        struct nvmm_x64_state *state =3D vcpu->state;
>> +
>> +        /* Exit on interrupt window. */
>> +        nvmm_vcpu_getstate(mach, vcpu, NVMM_X64_STATE_INTR);
>> +        state->intr.int_window_exiting =3D 1;
>> +        nvmm_vcpu_setstate(mach, vcpu, NVMM_X64_STATE_INTR);
>=20
> ... and should this set qcpu->int_window_exit?

Mmh, maybe. Not a big problem though, because at worst it just means we
set int_window_exiting to one while it was already one. I'll think about
that for a future commit. (I'm not immediately able to test.)

>> +
>> +        return false;
>> +    }
>=20
> Have you tried running kvm-unit-tests?

I didn't know kvm-unit-tests (until now). I developed my own tests and
ran them in qemu-nvmm. But good to know, I'll try these tests.

>> +    /* Needed, otherwise infinite loop. */
>> +    current_cpu->vcpu_dirty =3D false;
>=20
> Can you explain this?

If vcpu_dirty remains true, we land here in the next iteration of the
loop:

        if (cpu->vcpu_dirty) {
            nvmm_set_registers(cpu);
            cpu->vcpu_dirty =3D false;
        }

And the (now updated) register values are lost. The guest stays on the
same instruction.

>> +        break;
>> +    default: /* More MSRs to add? */
>> +        val =3D 0;
>=20
> I would add at least MSR_IA32_TSC.

MSR_IA32_TSC is handled by the kernel, that's why it isn't there. The
values do get synced:

    state->msrs[NVMM_X64_MSR_TSC] =3D env->tsc;
    ...
    env->tsc =3D state->msrs[NVMM_X64_MSR_TSC];

>> +        if (qcpu->stop) {
>> +            cpu->exception_index =3D EXCP_INTERRUPT;
>> +            qcpu->stop =3D false;
>> +            ret =3D 1;
>> +            break;
>> +        }
>> +
>> +        nvmm_vcpu_pre_run(cpu);
>> +
>> +        if (atomic_read(&cpu->exit_request)) {
>> +            qemu_cpu_kick_self();
>> +        }
>> +
>=20
> This is racy without something like KVM's immediate_exit mechanism.
> This should be fixed in NVMM.

I don't immediately see how this is racy. It reproduces the existing
logic found in whpx-all.c, and if there is a real problem it can be
fixed in a future commit along with WHPX.

Maxime

