Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909ADC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6644F20674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6644F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m00nbsd.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izPTX-0000PC-Ej
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 13:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <max@m00nbsd.net>) id 1izOls-0005JZ-HM
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <max@m00nbsd.net>) id 1izOlr-0005tR-As
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:47:28 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:44803)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <max@m00nbsd.net>) id 1izOlr-0005MI-2T
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:47:27 -0500
Received: from mxplan6.mail.ovh.net (unknown [10.108.1.10])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 42D551E19341;
 Wed,  5 Feb 2020 18:47:17 +0100 (CET)
Received: from m00nbsd.net (37.59.142.100) by DAG3EX2.mxp6.local (172.16.2.22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 5 Feb 2020
 18:47:16 +0100
Subject: Re: [PATCH v2 3/4] Introduce the NVMM impl
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kamil
 Rytarowski <n54@gmx.com>, <rth@twiddle.net>, <ehabkost@redhat.com>,
 <slp@redhat.com>, <pbonzini@redhat.com>, <peter.maydell@linaro.org>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-4-n54@gmx.com>
 <c0b0fcb2-c370-52f9-b3ee-adc15455b902@redhat.com>
From: Maxime Villard <max@m00nbsd.net>
Message-ID: <60390e82-6168-b2e3-7e5d-149af82c726a@m00nbsd.net>
Date: Wed, 5 Feb 2020 18:47:11 +0100
MIME-Version: 1.0
In-Reply-To: <c0b0fcb2-c370-52f9-b3ee-adc15455b902@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX1.mxp6.local (172.16.2.21) To DAG3EX2.mxp6.local
 (172.16.2.22)
X-Ovh-Tracer-GUID: 73df9b9c-1fc2-4210-94cb-5c15d5b68d83
X-Ovh-Tracer-Id: 18420848379673644908
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrhedugddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkfffgggjtgfgihesthekredttddtjeenucfhrhhomhepofgrgihimhgvucggihhllhgrrhguuceomhgrgiesmhdttdhnsghsugdrnhgvtheqnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghniedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmrgigsehmtddtnhgsshgurdhnvghtpdhrtghpthhtohepphhhihhlmhgusehrvgguhhgrthdrtghomh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.125.2
X-Mailman-Approved-At: Wed, 05 Feb 2020 13:31:59 -0500
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

Hi

Le 03/02/2020 =C3=A0 12:51, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
>> +static void
>> +nvmm_io_callback(struct nvmm_io *io)
>> +{
>> +=C2=A0=C2=A0=C2=A0 MemTxAttrs attrs =3D { 0 };
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D address_space_rw(&address_space_io, io->po=
rt, attrs, io->data,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io->size, !io->in);
>> +=C2=A0=C2=A0=C2=A0 if (ret !=3D MEMTX_OK) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("NVMM: I/O Tr=
ansaction Failed "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "[=
%s, port=3D%u, size=3D%zu]", (io->in ? "in" : "out"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io=
->port, io->size);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* XXX Needed, otherwise infinite loop. */
>=20
> This seems OK, why the XXX in comment?
>=20
>> +=C2=A0=C2=A0=C2=A0 current_cpu->vcpu_dirty =3D false;
>> +}

Because the other implementations don't do that and avoid the infinite lo=
op
somehow. I didn't completely understand why, so I left an XXX.

>> +static int
>> +nvmm_vcpu_loop(CPUState *cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct CPUX86State *env =3D (CPUArchState *)cpu->e=
nv_ptr;
>> +=C2=A0=C2=A0=C2=A0 struct nvmm_machine *mach =3D get_nvmm_mach();
>> +=C2=A0=C2=A0=C2=A0 struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
>> +=C2=A0=C2=A0=C2=A0 struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
>> +=C2=A0=C2=A0=C2=A0 X86CPU *x86_cpu =3D X86_CPU(cpu);
>> +=C2=A0=C2=A0=C2=A0 struct nvmm_vcpu_exit *exit =3D vcpu->exit;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Some asynchronous events must be handled o=
utside of the inner
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * VCPU loop. They are handled here.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvmm_cpu_synchronize_state=
(cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_cpu_init(x86_cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX: reset the INT/NMI =
windows */
>=20
> What is the problem?

The int/nmi windows are not set back to the reset state. Not complicated
to do but I never got around to doing it. This can easily be addressed
in a future patch.

Maxime

