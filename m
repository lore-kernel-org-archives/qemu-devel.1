Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FDFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7EA20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7EA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Qx-0002nr-FW
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k02Q7-00029B-T3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:39:55 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:58344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k02Q2-0008QT-8Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:39:55 -0400
Received: from player746.ha.ovh.net (unknown [10.108.54.72])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 886C4287AD9
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:39:47 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id 1DC8714CBA9FA;
 Mon, 27 Jul 2020 12:39:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0054f66621d-bfbe-4f88-83ce-bb5e27d65248,
 B7B50C960922AB26A7D550ED897AF9E452A9EBFF) smtp.auth=groug@kaod.org
Date: Mon, 27 Jul 2020 14:39:23 +0200
From: Greg Kurz <groug@kaod.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] target/arm: Move setting of CPU halted state to
 generic code
Message-ID: <20200727143923.20c23f09@bahia.lan>
In-Reply-To: <20200723025657.644724-3-bauerman@linux.ibm.com>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-3-bauerman@linux.ibm.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14632758139787057454
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedriedtgdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeukeejkeeiffeftdevueekvdetjeegieevhffgjefgtdeluddvgfefleekueevueenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeegiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.47.167; envelope-from=groug@kaod.org;
 helo=11.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 08:39:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jul 2020 23:56:51 -0300
Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:

> This change is in a separate patch because it's not so obvious that it
> won't cause a regression.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/core/cpu.c    | 2 +-
>  target/arm/cpu.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> NB: I wasn't able to run this patch on an ARM machine. I did run it on
> a ppc64le pseries KVM guest.
>=20
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 594441a150..71bb7859f1 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -258,7 +258,7 @@ static void cpu_common_reset(DeviceState *dev)
>      }
> =20
>      cpu->interrupt_request =3D 0;
> -    cpu->halted =3D 0;
> +    cpu->halted =3D cpu->start_powered_off;
>      cpu->mem_io_pc =3D 0;
>      cpu->icount_extra =3D 0;
>      atomic_set(&cpu->icount_decr_ptr->u32, 0);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ec65c7653f..b6c65e4df6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -175,7 +175,6 @@ static void arm_cpu_reset(DeviceState *dev)
>      env->vfp.xregs[ARM_VFP_MVFR2] =3D cpu->isar.mvfr2;
> =20
>      cpu->power_state =3D s->start_powered_off ? PSCI_OFF : PSCI_ON;
> -    s->halted =3D s->start_powered_off;
> =20
>      if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
>          env->iwmmxt.cregs[ARM_IWMMXT_wCID] =3D 0x69051000 | 'Q';


