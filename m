Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC66C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0FA2074D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0FA2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m00nbsd.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC8o2-0002Ho-Bq
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 17:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <max@m00nbsd.net>) id 1jC8nU-0001tK-MG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <max@m00nbsd.net>) id 1jC8nT-00063V-Fb
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:21:48 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:46965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <max@m00nbsd.net>) id 1jC8nT-00061I-A5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:21:47 -0400
Received: from mxplan6.mail.ovh.net (unknown [10.108.1.214])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 9FE1C26430DB;
 Wed, 11 Mar 2020 22:21:44 +0100 (CET)
Received: from m00nbsd.net (37.59.142.95) by DAG3EX2.mxp6.local (172.16.2.22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Mar
 2020 22:21:43 +0100
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
 <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
 <CABgObfZjnFFV3hosrP+sf5d3KmPPGuFJZo-oY5=u340wtxLYGg@mail.gmail.com>
 <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
 <24fe7b93-8a34-e5d7-18b5-0f7607221ad3@redhat.com>
 <85e4202d-91dd-0d31-373a-febe566353ab@m00nbsd.net>
 <93e2e198-26ed-c8c7-b47e-977915156a17@redhat.com>
 <f48f9c36-5104-1346-cb91-d52c2887097b@m00nbsd.net>
 <050cacce-41fc-db89-ded9-5cdf6c20a2de@redhat.com>
From: Maxime Villard <max@m00nbsd.net>
Autocrypt: addr=max@m00nbsd.net; keydata=
 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
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
Message-ID: <cad16d05-13db-cb80-a049-84bb048def23@m00nbsd.net>
Date: Wed, 11 Mar 2020 22:21:28 +0100
MIME-Version: 1.0
In-Reply-To: <050cacce-41fc-db89-ded9-5cdf6c20a2de@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG5EX2.mxp6.local (172.16.2.42) To DAG3EX2.mxp6.local
 (172.16.2.22)
X-Ovh-Tracer-GUID: 20876c10-5238-446f-ab0c-9fbbf0019623
X-Ovh-Tracer-Id: 6226226488003792687
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvfedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepvfhfhffukfffgggjtgfgihesthekredttddtjeenucfhrhhomhepofgrgihimhgvucggihhllhgrrhguuceomhgrgiesmhdttdhnsghsugdrnhgvtheqnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnheirdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepmhgrgiesmhdttdhnsghsugdrnhgvthdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.125.2
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, jmcneill@invisible.ca, Kamil Rytarowski <n54@gmx.com>,
 philmd@redhat.com, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/03/2020 =C3=A0 21:42, Paolo Bonzini a =C3=A9crit=C2=A0:
> On 11/03/20 21:14, Maxime Villard wrote:
>>> The problem is that qcpu->stop is checked _before_ entering the
>>> hypervisor and not after, so there is a small race window.
>> Ok. I don't understand what's supposed to be the race here. If we get =
an
>> IPI between the check and the call to nvmm_vcpu_run() then we'll just =
do
>> one run and stop in the next iteration, because the IPI will have set
>> qcpu->stop. Is this extra iteration undesired?
>=20
> Yes, you don't know how long that run would take.  I don't know about
> NVMM but for KVM it may even never leave if the guest is in HLT state.

Ok, I see, thanks.

In NVMM the runs are short, the syscalls are fast, and pending signals
cause returns to userland. Therefore, in practice, it's not a big problem=
,
because (1) the window is small and (2) if we have a miss it's not going
to take long to come back to Qemu.

I see a quick kernel change I can make to reduce 95% of the window
already in the current state. The remaining 5% will need a new
nvmm_vcpu_kick() function.

For now this issue is unimportant and no Qemu change is required.

Kamil, please also drop the XXX in
    /* XXX Needed, otherwise infinite loop. */
It's not a bug.

Thanks,
Maxime

