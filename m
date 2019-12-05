Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB68C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 05:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7812077B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 05:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="OX+hWXUV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EOZvZyXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7812077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icjJ5-0007yM-4V
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 00:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1icjHw-00078I-CC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1icjHv-0004Mp-0i
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 00:02:52 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1icjHo-0004AQ-FD; Thu, 05 Dec 2019 00:02:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 1402A227B8;
 Thu,  5 Dec 2019 00:02:41 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Thu, 05 Dec 2019 00:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=Gm0Bu
 76qnev5eR0jj9tPedHTPd0qyliUowe7Q0H39aI=; b=OX+hWXUVlXljYh73YbpVX
 uk67rYXN4fsOD5l+nVQ1fdHNEAop0/CPM39xmLBfZCWpPndnxWbIpnF2hydvMVXu
 iDLt86pWkUR4+XTb5sGDbDi3q40LVMZ/Lf/CHuFFdVXi42UNTN/m8f1U8SxSIt9/
 9PPlsF37mTXaayfyTjrp0sDf8DyrzAGUpMfYYIJL+f1D3ALYZMPMAMSltN4w5Rnx
 pDeFqhq0IZo+1lRh6zxP7npx5a39XOZvvpw8FnFYjTelyrZks9p3L3HIMSMb8veJ
 bVRJJHuyYYPSjq7xlgxE7mxtkFcAWXCvYzeGyMJRncJnE+6usaFxpopFsfYYZuya
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=Gm0Bu76qnev5eR0jj9tPedHTPd0qyliUowe7Q0H39
 aI=; b=EOZvZyXLmz0TaFvn8tufEc/zPRTBUr6dclFE1VBO73z426qsNWf01DoCe
 dXCgMPH3kEujC61WF/4DZ4S7ZZ0LCOG2r6zUenehQ5ne+JyWmBv9Lqv6tz3FvpLg
 If5wj/K9SO0MOcK4+L95nuQGpzAZvEXmUCu95qh3TdvjI/MJInfG+WjbYQUCfuM4
 qWib4AfeEzJuy7UC0cUz8Q/t7UELUMqe/i0TUa3bGhI+NooEfqxQeBrwQjVfaItU
 FM+TQkHDu8hhbm5CxBqwaj8pq5RPbr1fjKRQRbuKCcMt+9T6klV3Omfu/YFTdOEZ
 SauWSGyR9RAkp2KjHup2K0CPhUkMQ==
X-ME-Sender: <xms:cI_oXaX3jlb25omEAYtzXsQQUePA4rxoBtw4Ow302Ve9cwgE_hCWZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudektddgjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
 ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
 hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
 vghrufhiiigvpedt
X-ME-Proxy: <xmx:cI_oXa2knlD6TnwXA42kGk-bxpS64sIHNJ4BIN3P8dq9cB_LfbUPUQ>
 <xmx:cI_oXZZ4pnIn3c37bcw2UgmrDU4VGkOsCbWbcDHrH6aSuIbQH4rv7g>
 <xmx:cI_oXVolf65iVtdkqbv_AJNZnMB_qK2QzAKjaBX-E1Nt6c3BHYAn2g>
 <xmx:cY_oXStJPN0fIE_l7k3y3IhX5YCfwgxM-Ty25801dspTkHqXRArDDg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 63050E00A2; Thu,  5 Dec 2019 00:02:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <ef0aab28-093c-41ef-9a2c-925de97145b2@www.fastmail.com>
In-Reply-To: <87bf3c1d-9e77-f4a1-1163-548a3cfee3bc@redhat.com>
References: <20191203041440.6275-1-andrew@aj.id.au>
 <20191203041440.6275-3-andrew@aj.id.au>
 <283c152b-b1c7-551e-bec0-c087b14de996@redhat.com>
 <4e90d36d-aa13-441f-9298-56f83a5bff6a@www.fastmail.com>
 <87bf3c1d-9e77-f4a1-1163-548a3cfee3bc@redhat.com>
Date: Thu, 05 Dec 2019 15:34:15 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/4] target/arm: Abstract the generic timer frequency
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.28
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
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wed, 4 Dec 2019, at 03:57, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/3/19 1:48 PM, Andrew Jeffery wrote:
> > On Tue, 3 Dec 2019, at 16:39, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 12/3/19 5:14 AM, Andrew Jeffery wrote:
> >>> Prepare for SoCs such as the ASPEED AST2600 whose firmware configu=
res
> >>> CNTFRQ to values significantly larger than the static 62.5MHz valu=
e
> >>> currently derived from GTIMER_SCALE. As the OS potentially derives=
 its
> >>> timer periods from the CNTFRQ value the lack of support for runnin=
g
> >>> QEMUTimers at the appropriate rate leads to sticky behaviour in th=
e
> >>> guest.
> >>>
> >>> Substitute the GTIMER_SCALE constant with use of a helper to deriv=
e the
> >>> period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cn=
tfrq
> >>> to the frequency associated with GTIMER_SCALE so current behaviour=
 is
> >>> maintained.
> >>>
> >>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >>> ---
> >>>    target/arm/cpu.c    |  2 ++
> >>>    target/arm/cpu.h    | 10 ++++++++++
> >>>    target/arm/helper.c | 10 +++++++---
> >>>    3 files changed, 19 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> >>> index 7a4ac9339bf9..5698a74061bb 100644
> >>> --- a/target/arm/cpu.c
> >>> +++ b/target/arm/cpu.c
> >>> @@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
> >>>        if (tcg_enabled()) {
> >>>            cpu->psci_version =3D 2; /* TCG implements PSCI 0.2 */
> >>>        }
> >>> +
> >>> +    cpu->gt_cntfrq =3D NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> >>>    }
> >>>   =20
> >>>    static Property arm_cpu_reset_cbar_property =3D
> >>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> >>> index 83a809d4bac4..666c03871fdf 100644
> >>> --- a/target/arm/cpu.h
> >>> +++ b/target/arm/cpu.h
> >>> @@ -932,8 +932,18 @@ struct ARMCPU {
> >>>         */
> >>>        DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
> >>>        DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
> >>> +
> >>> +    /* Generic timer counter frequency, in Hz */
> >>> +    uint64_t gt_cntfrq;
> >>
> >> You can also explicit the unit by calling it 'gt_cntfrq_hz'.
> >=20
> > Fair call, I'll fix that.
> >=20
> >>
> >>>    };
> >>>   =20
> >>> +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> >>> +{
> >>> +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SEC=
OND? */
> >>
> >> Why inline this call? I doubt there is a significant performance ga=
in.
> >=20
> > It wasn't so much performance. It started out as a macro for a simpl=
e calculation
> > because I didn't want to duplicate it across a number of places, the=
n I wanted type
> > safety for the pointer so  I switched the macro in the header to an =
inline function. So
> > it is an evolution of the patch rather than something that came from=
 an explicit goal
> > of e.g. performance.
>=20
> OK. Eventually NANOSECONDS_PER_SECOND will move to "qemu/units.h".
>=20
> Should the XXX comment stay? I'm not sure, it is confusing.

I'll remove that.=20

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks. However, did you still want your comment on 4/4 addressed (move
the comment to this patch)?

Andrew

