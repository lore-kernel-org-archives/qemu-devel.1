Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7219BC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FAA2076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f9Qn1FTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FAA2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXvxf-0000yh-H2
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 20:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXvww-0000Co-J3; Wed, 28 Oct 2020 20:37:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:35627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXvwt-0000yg-1l; Wed, 28 Oct 2020 20:37:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CM63R0MW0z9sTr; Thu, 29 Oct 2020 11:37:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603931859;
 bh=azraLuprZ5AORMP7clpuyB6bLghQnLorCzcmGs/9tsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f9Qn1FTBJVWcbYh/WR0JA26qVjL7hHAPqaoyIAxfLaL1s4Vgdh9gt4Tb6UPZ43bLF
 qzdqKmDy16s9bBzfvl0Kt45xYGBFI50gMUq2JonA7wRTdlIAM09gFwcSVHQB2O874p
 9HJGZnPvTgnfUFhkTBOsZS1A/HBil2bO9G4oG+bA=
Date: Thu, 29 Oct 2020 10:38:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 7/9] ppc: silence the compiler warnings
Message-ID: <20201028233835.GG5604@yekko.fritz.box>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-8-kuhn.chenqun@huawei.com>
 <20201028042900.GC5604@yekko.fritz.box>
 <ddcb887d-42ec-2021-1785-a6fb0d13d6b9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <ddcb887d-42ec-2021-1785-a6fb0d13d6b9@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 03:42:31PM +0100, Thomas Huth wrote:
> On 28/10/2020 05.29, David Gibson wrote:
> > On Wed, Oct 28, 2020 at 12:18:17PM +0800, Chen Qun wrote:
> >> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed w=
arning:
> >> hw/ppc/ppc.c: In function =E2=80=98ppc6xx_set_irq=E2=80=99:
> >> hw/ppc/ppc.c:118:16: warning: this statement may fall through [-Wimpli=
cit-fallthrough=3D]
> >>   118 |             if (level) {
> >>       |                ^
> >> hw/ppc/ppc.c:123:9: note: here
> >>   123 |         case PPC6xx_INPUT_INT:
> >>       |         ^~~~
> >>
> >> Add the corresponding "fall through" comment to fix it.
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> >> ---
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >>  hw/ppc/ppc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> >> index 4a11fb1640..f9eb8f21b4 100644
> >> --- a/hw/ppc/ppc.c
> >> +++ b/hw/ppc/ppc.c
> >> @@ -120,6 +120,7 @@ static void ppc6xx_set_irq(void *opaque, int pin, =
int level)
> >>              } else {
> >>                  cpu_ppc_tb_stop(env);
> >>              }
> >> +            /* fall through */
> >>          case PPC6xx_INPUT_INT:
> >>              /* Level sensitive - active high */
> >>              LOG_IRQ("%s: set the external IRQ state to %d\n",
> >=20
>=20
> Is that fall through actually really the right thing to do here? I'd rath=
er
> expect to see a PPC_INTERRUPT_DECR instead of a PPC_INTERRUPT_EXT in case
> someone messes with the TBEN pin? So I assume this is likely rather bug a=
nd
> we should a "break" statement here instead?

Oh.. good catch, I think I misread this.  I thought the change was
correct, because DECRs look somewhat like external interrupts.  But
this is TBEN, not a DECR interrupt per se.  So, yes, I think this was
a bug and it should be a break instead.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+aAPgACgkQbDjKyiDZ
s5L0Zg/9H66EWh7BUIZMOR8b7po1ImYycuFZ+YZ/VBmSQU0G1qUZUnucFiFW9IxC
GgNIkI7INJ+F6900usbJ8NpYTg2vhf9HV3RJGf48FS29zuPfdOT1ywrB0Te4EBun
fjVxHBvKmYjf/iqcBIS3WHfItG6SZ/xBQWCmVEEQ2kjzOEJcjlTVBGzUNCsAocrK
mxwD9KTkBZzkbn0a81qdCXXzh0RfoUfN24ERroAlDUXuxXXMNG+kO7j3UnQLTker
r84vuU04J3xxGh1ZdzYzX839kPE0wCCjuuYIijEHeqB+pzea3w8Pq+DiKtMPC+q8
i8NK0oTA6x4dx9H6E4SGH9/7HzTEy5Iab16+xeRTZwaB60MkwByHlOEikIbP3Axa
lVO+3hjpzeGYKuy9f2lYcojfbiaODCTKjjVJeCfEnCoel6FneTFEoqLFShCVS9rH
3ACkfBQy+tGx6GrLQNhSPvm1gZymmhcRsCL0Cmfoja04JZ4ig+VK+aTHlHaF+6bC
BUrcNtjR93sSED5DULcZ50wY9tcWxCLv2FABtSLHdJ2hJc6v5QUlUhzasW2V5HTC
wfKQSMPgU0CkW8pQk8d/B+EGjswkdgyHTiPykxT/y9MvL6fQ4S9zGTwgKuQGuyo9
DMUGCR0HiANkVw+z3OqcFZ7XNXe1UAqZx8KL6zEDx/qgkh67msA=
=LH4S
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--

