Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EBFC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A7F20754
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 13:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A7F20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFe97-0005Xq-6R
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 09:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jFe8O-0004lG-Va
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jFe8N-0007mv-UZ
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 09:25:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:33896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jFe8J-0007gn-2x; Sat, 21 Mar 2020 09:25:47 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 458BA747DFB;
 Sat, 21 Mar 2020 14:25:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A10F274638A; Sat, 21 Mar 2020 14:25:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9837D746381;
 Sat, 21 Mar 2020 14:25:42 +0100 (CET)
Date: Sat, 21 Mar 2020 14:22:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 07/11] hw/gpio/aspeed_gpio: Remove dead assignment
In-Reply-To: <20200321114615.5360-8-philmd@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003211420450.82121@zero.eik.bme.hu>
References: <20200321114615.5360-1-philmd@redhat.com>
 <20200321114615.5360-8-philmd@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-224705287-1584797142=:82121"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-224705287-1584797142=:82121
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix warning reported by Clang static code analyzer:
>
>  hw/gpio/aspeed_gpio.c:717:18: warning: Value stored to 'g_idx' during =
its initialization is never read
>      int set_idx, g_idx =3D *group_idx;
>                   ^~~~~   ~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> hw/gpio/aspeed_gpio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index 41e11ea9b0..cc07ab9866 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -714,11 +714,11 @@ static void aspeed_gpio_write(void *opaque, hwadd=
r offset, uint64_t data,
> static int get_set_idx(AspeedGPIOState *s, const char *group, int *grou=
p_idx)
> {
>     AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
> -    int set_idx, g_idx =3D *group_idx;
> +    int set_idx;
>
>     for (set_idx =3D 0; set_idx < agc->nr_gpio_sets; set_idx++) {
>         const GPIOSetProperties *set_props =3D &agc->props[set_idx];
> -        for (g_idx =3D 0; g_idx < ASPEED_GROUPS_PER_SET; g_idx++) {
> +        for (int g_idx =3D 0; g_idx < ASPEED_GROUPS_PER_SET; g_idx++) =
{

Is declaring variables here allowed by coding style? Shouldn't you only=20
remove init value from above?

Regards,
BALATON Zoltan

>             if (!strncmp(group, set_props->group_label[g_idx], strlen(g=
roup))) {
>                 *group_idx =3D g_idx;
>                 return set_idx;
>
--3866299591-224705287-1584797142=:82121--

