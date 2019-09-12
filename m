Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838E1C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE042075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5AnKbYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE042075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8NrS-0003PD-F1
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8Nqi-0002ja-V6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8Nqh-0004YQ-FU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:05:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8Nqh-0004WZ-5C
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:05:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id q17so23450900wrx.10
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cNC/anTCSpUuBe5oh9cBVMof/FJSpg4mcNvbY2fykeA=;
 b=O5AnKbYupNAM7m8dqK0j7AI/Yaf+yZsmQ4xCGSYwRSMswTvZ21ZXhuc+GCM6vG0ihy
 D9RtdjFLu4JUpYQhNLK//O2C+phlzxpD2OoSV2/8zaIIR5Vusezb9miStXYHRJvvQ/Il
 6warSZABBX0lJX8weJxGbJENs4payLKL9JI1vof+Ib/vg35zqIoYzzU5PhECL4/+/g42
 aKaLGY7rT7h/xmbw5gTFTRAwfBx0SeTsfmQJ2k1hTOGLfGiyZZRoFeQwelOmhVH+TJHv
 iqWq6dJ15kfD5hucGSZQlDxbbVDHZfHaF1xNXajQd+59lRuNk7SwL8Mk+vSPHXS++x1q
 WK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cNC/anTCSpUuBe5oh9cBVMof/FJSpg4mcNvbY2fykeA=;
 b=NTVy5lXdpssa5cDBIm+DHFTdKzPfkvhNClfDcs5x/TDdykibPHH6iQ6KIkNMHrjU9U
 DPlLYe+8WBR2fSbdOdFgK6gJ6mKZ9CRgTz1nFPe3+Ec9W0WMBtL3+MTCXmHIZ6kauPQ5
 N5Eqb2LcxJ+q87EAXs1FmSgsqU7UU5QYjsV6xYGTQo2dHDJp3gGsDoQb9vzQc8TY8wo4
 IdgNpD6Skrp/E7Dluk9lJcaiKi+gKrzJ7w6o40UUiOANs0ZnSFjaZIdKMZfqZlOTRg+C
 mtvHCBQYXKH84XO7sgfsZbSapT1oPCFyTvNi/RUpU8tNpGRTtWUzK/4xbDWoE3sgUrPZ
 toLA==
X-Gm-Message-State: APjAAAVlL2a+qFd3eY9HOrXPGJqIVeXbGkdhIPhcbrRwHvBDa8EueKfr
 0aZ1IIPSV5se7EyNEXpR4ofuZg==
X-Google-Smtp-Source: APXvYqyhFNuKKNEDqrKBSJMjr6hJaZ+bAUcC92nmOeE7M8W/lgFKHxlTWEEY5Oe/xTIYp05iojB+Bg==
X-Received: by 2002:a05:6000:108e:: with SMTP id
 y14mr34353457wrw.344.1568289917697; 
 Thu, 12 Sep 2019 05:05:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 207sm9205025wme.17.2019.09.12.05.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 05:05:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5DF2C1FF87;
 Thu, 12 Sep 2019 13:05:16 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-13-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190910144428.32597-13-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 13:05:16 +0100
Message-ID: <87a7b9zpmr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 12/13] target/arm/arm-semi: Implement
 SH_EXT_STDOUT_STDERR extension
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> SH_EXT_STDOUT_STDERR is a v2.0 semihosting extension: the guest
> can open ":tt" with a file mode requesting append access in
> order to open stderr, in addition to the existing "open for
> read for stdin or write for stdout". Implement this and
> report it via the :semihosting-features data.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/arm-semi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 531084b7799..0df8d4d69d6 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -476,12 +476,16 @@ static uint32_t gdb_flenfn(TaskState *ts, ARMCPU *c=
pu, GuestFD *gf)
>  #define SHFB_MAGIC_2 0x46
>  #define SHFB_MAGIC_3 0x42
>
> +/* Feature bits reportable in feature byte 0 */
> +#define SH_EXT_EXIT_EXTENDED (1 << 0)

If you swap 12/13 this could be kept with the related feature. I don't
think one implies the other right?

> +#define SH_EXT_STDOUT_STDERR (1 << 1)
> +
>  static const uint8_t featurefile_data[] =3D {
>      SHFB_MAGIC_0,
>      SHFB_MAGIC_1,
>      SHFB_MAGIC_2,
>      SHFB_MAGIC_3,
> -    0, /* Feature byte 0 */
> +    SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
>  };
>
>  static void init_featurefile_guestfd(int guestfd)
> @@ -674,7 +678,21 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          }
>
>          if (strcmp(s, ":tt") =3D=3D 0) {
> -            int result_fileno =3D arg1 < 4 ? STDIN_FILENO : STDOUT_FILEN=
O;
> +            int result_fileno;
> +
> +            /*
> +             * We implement SH_EXT_STDOUT_STDERR, so:
> +             *  open for read =3D=3D stdin
> +             *  open for write =3D=3D stdout
> +             *  open for append =3D=3D stderr
> +             */

I love the way the spec documents field2 as an ISO C fopen() mode and
then an extension literally subverts the meaning to be something else.
Where the designers worried about adding a SYS_OPEN_TTY function to the
interface?

Anyway it meets the spec however weird it might be:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +            if (arg1 < 4) {
> +                result_fileno =3D STDIN_FILENO;
> +            } else if (arg1 < 8) {
> +                result_fileno =3D STDOUT_FILENO;
> +            } else {
> +                result_fileno =3D STDERR_FILENO;
> +            }
>              associate_guestfd(guestfd, result_fileno);
>              unlock_user(s, arg0, 0);
>              return guestfd;


--
Alex Benn=C3=A9e

