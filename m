Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB4C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408A4208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408A4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPQS3-00044A-Cj
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 08:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jPQOG-000284-Be
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jPQOF-0005uo-0u
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:46:40 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:36817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jPQOE-0005mx-RD
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:46:38 -0400
Received: from player797.ha.ovh.net (unknown [10.108.42.192])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id B97929AE71
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:46:29 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player797.ha.ovh.net (Postfix) with ESMTPSA id 5F0A5D747FBF;
 Fri, 17 Apr 2020 12:46:17 +0000 (UTC)
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200417090749.14310-1-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c1abbe1a-8ad9-1b1b-c45e-734773a3a314@kaod.org>
Date: Fri, 17 Apr 2020 14:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417090749.14310-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11899917593337891701
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrfeejgdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehmrghilhdqrghrtghhihhvvgdrtghomhenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.45
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Dennis Clarke <dclarke@blastwave.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 11:07 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> This fixes:
>=20
>   $ qemu-system-ppc64 \
>   -machine pseries-4.1 -cpu power9 \
>   -smp 4 -m 12G -accel tcg ...
>   ...
>   Quiescing Open Firmware ...
>   Booting Linux via __start() @ 0x0000000002000000 ...
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>=20
> [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
>=20
> Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
> Reported-by: Dennis Clarke <dclarke@blastwave.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  target/ppc/translate.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b207fb5386..0136c7e3ff 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -5003,6 +5003,7 @@ static void gen_slbia(DisasContext *ctx)
>      CHK_SV;
> =20
>      gen_helper_slbia(cpu_env, t0);
> +    tcg_temp_free_i32(t0);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
>=20


