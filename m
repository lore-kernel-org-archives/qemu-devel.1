Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6615C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708A520637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKB1WwqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708A520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDThR-000072-Jc
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDTfB-0007O0-Kt
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDTf9-0007gG-P5
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:50:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40703
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDTf9-0007Z9-9D
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584280241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xq6BtBYBMYdnheXaoKNGDtR1jIXZUrWNeb4q5xAsoEU=;
 b=gKB1WwqLj1k6OvRyY4tK7CzKHlU4KqlSqjMuOOUvUSRgC3UNR9MX58rbtGYH5t9mOdlYjL
 5uYU3r+DoHGHpAIK1cw8wD7LHtX2XFhM25I5Mc69hwhvchM1g4FqE2oIU9BeDe+CdQpB0X
 BZDuJDtQvlHF0hwNmzfj5sh47p5gFhk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-X72YgVl6MW-yifhYSrZtzQ-1; Sun, 15 Mar 2020 09:50:40 -0400
X-MC-Unique: X72YgVl6MW-yifhYSrZtzQ-1
Received: by mail-ed1-f71.google.com with SMTP id w23so1624804edu.18
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4ZlOXeRerg3bOHgbFmZf+G2uckqR3/PQcxplnaEcC1I=;
 b=Yxafrti3JPzAutbu3fsEU9PdKYKj9KrhAyrbOhGh9ld8lRYV55TYYVYwVqbv7Beptq
 2YQtYI38A7/8kMtSL7483kLm+DAUKwYeO7ehTF1Jx3ICpp2rNcsIc4PuMQF7HpRhxT8V
 y11DFadm7QaolAOZF7IKHDF1TSA1s/gN4qqIwgArZrXGyy0jjhjzkQjtTJ+b7PvSgW/b
 qknpO0EBdLE/L/QNuDfHyyIlE05B+aByLBhACLCM3o4nURAbGLv/Jc2GN2lDQhmpu0dx
 FFTbVHCst+ai0cZkjDG7J4tn2B2hM81wZkFliUfJ7+XdGGizPrjL5bICsbBeEz5eoJ8U
 MqbA==
X-Gm-Message-State: ANhLgQ3iFkBSx384WJ+VkNlOOgZZQeSJ/gshzCxQY3lM/wu3ry57ub2A
 HwKTG9ZFveCzDBCrBHp9XNittbyl1dVusSII9Ece40jup7XidFBN9eBOrxltGq8ksA9M5kr5lme
 nRqYg7EVV5HIxqgM=
X-Received: by 2002:a17:906:4556:: with SMTP id
 s22mr19738160ejq.195.1584280238918; 
 Sun, 15 Mar 2020 06:50:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsVF9yK/1cO22zNcFtTn+khJtwJx1OF68Dz0v4q2i2qYBMQM/JjfPNz3DqXFFBbK2m7p2JY/w==
X-Received: by 2002:a17:906:4556:: with SMTP id
 s22mr19738131ejq.195.1584280238570; 
 Sun, 15 Mar 2020 06:50:38 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id a15sm2505625eds.79.2020.03.15.06.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 06:50:37 -0700 (PDT)
Subject: Re: [PATCH] target/rx/cpu: Use address_space_ldl() to read reset
 vector address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200315134859.9547-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5da342ea-82cb-ce19-d446-0d284dbb796c@redhat.com>
Date: Sun, 15 Mar 2020 14:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315134859.9547-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 2:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Hmm author email should be <f4bug@amsat.org>...

>=20
> The RX code flash is not a Masked ROM but a EEPROM (electrically
> erasable programmable flash memory).
> When implementing the flash hardware, the rom_ptr() returns NULL
> and the reset vector is not set.
> Instead, use the address_space ld/st API to fetch the reset vector
> address from the code flash.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Based-on: <20200315132810.7022-1-f4bug@amsat.org>
>=20
> Same issue might occurs in Cortex-M arm_cpu_reset()
> ---
>   target/rx/cpu.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 9c224a273c..d3bd09e753 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -26,6 +26,8 @@
>   #include "hw/loader.h"
>   #include "fpu/softfloat.h"
>  =20
> +#define CPU_RESET_VECTOR 0xfffffffc
> +
>   static void rx_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       RXCPU *cpu =3D RXCPU(cs);
> @@ -51,17 +53,13 @@ static void rx_cpu_reset(CPUState *s)
>       RXCPU *cpu =3D RXCPU(s);
>       RXCPUClass *rcc =3D RXCPU_GET_CLASS(cpu);
>       CPURXState *env =3D &cpu->env;
> -    uint32_t *resetvec;
>  =20
>       rcc->parent_reset(s);
>  =20
>       memset(env, 0, offsetof(CPURXState, end_reset_fields));
>  =20
> -    resetvec =3D rom_ptr(0xfffffffc, 4);
> -    if (resetvec) {
> -        /* In the case of kernel, it is ignored because it is not set. *=
/
> -        env->pc =3D ldl_p(resetvec);
> -    }
> +    env->pc =3D address_space_ldl(cpu_get_address_space(s, 0),
> +                                CPU_RESET_VECTOR, MEMTXATTRS_UNSPECIFIED=
, NULL);
>       rx_cpu_unpack_psw(env, 0, 1);
>       env->regs[0] =3D env->isp =3D env->usp =3D 0;
>       env->fpsw =3D 0;
>=20


