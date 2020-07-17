Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C132065F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dM/e69ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C132065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRmV-0007Z4-Pn
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwRlj-0006Tt-Ep
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:55:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwRlg-0007Tr-SX
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:55:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id o11so11473021wrv.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fpH98eGmha9+BdK5pRwrIqi06Yz/FKaSVxczydejrKw=;
 b=dM/e69lnE7rr78Wh9CNAJUT9ACRkrrGoDiEPocsAXnr2zSc3nc9mYeKjWFfA7frlqf
 dTgnMgkG9kipl52sQrYMJ4LDTRdMdUf9xbfm20zzXxzIz6F3aADc7nfhF0TjMXP1eajG
 EOofep7hN70TSZnecGcYjWX2/yujelvOeLkyUevihHikUiJc+7o5DKfBeg8i8YMJwRTt
 Z++IuH1WbDUeW2BeU+pWG7c9LRDQj5U+TwFQ+w1znmx+A0LADtYF6n8m87jA/+J4ygvT
 7Oec2PBcQjhCBHtsByUSLcbNqt4oM6oQJpf51tARTAxu7Cri5ISnFnjKMvGUTpAm/tnq
 /6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fpH98eGmha9+BdK5pRwrIqi06Yz/FKaSVxczydejrKw=;
 b=SYUR2U85KejX6kQ92V+Gua6+gEQHUbTNUcm58C0C2nlUBSFINMCOcpxM53mGDxVR8b
 aruAuOh+yyMTupnhXfxAcgDbRojvwvINiiZanvyNLlj0Jpz6hmHVl3FNliNaHyV1sTcw
 hnUkrp0KtFh0CZg8IXEwf0T6oZ4E1C800CX4/1PhG8IJITQQy/g3wuucbgunF2d62de2
 9DKhMRW7yNdFJyN/kIhDO/LWlONX4CcAHg8ZbbdPQX3tx7OM6iji+fdSyW70o4AiPuou
 eS99Usy/XOmMmrTkCAjuo4K0f5WV3xPCug/jjCZAdusi774tFZ7GX7oQ7v68VCtFkkdJ
 mzyg==
X-Gm-Message-State: AOAM532LmQl3knWEK7zYBJK4zLsRgSqxPi0TDTWbVgjFFMHhEYTOqHGe
 ePcQl6UrUAWj0gwSkvDrUs58AA==
X-Google-Smtp-Source: ABdhPJxQ/Srvrl1H/qgEKjXfyDUXOK+cPTo1k1RZzCVsEbOfuacktNl0eQ6PnGNKGAl8+uOkfqMa5A==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr11036576wrl.246.1594997719066; 
 Fri, 17 Jul 2020 07:55:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m4sm13904382wmi.48.2020.07.17.07.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 07:55:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF80B1FF7E;
 Fri, 17 Jul 2020 15:55:15 +0100 (BST)
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-6-alex.bennee@linaro.org>
 <20200717143908.GI244185@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH  v1 5/5] accel/tcg: better handle memory constrained
 systems
In-reply-to: <20200717143908.GI244185@redhat.com>
Date: Fri, 17 Jul 2020 15:55:15 +0100
Message-ID: <87h7u6ur70.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, f4bug@amsat.org,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jul 17, 2020 at 11:51:39AM +0100, Alex Benn=C3=A9e wrote:
>> It turns out there are some 64 bit systems that have relatively low
>> amounts of physical memory available to them (typically CI system).
>> Even with swapping available a 1GB translation buffer that fills up
>> can put the machine under increased memory pressure. Detect these low
>> memory situations and reduce tb_size appropriately.
>>=20
>> Fixes: 600e17b261
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>> ---
>>  accel/tcg/translate-all.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> index 2afa46bd2b1..2ff0ba6d19b 100644
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb=
_size)
>>  {
>>      /* Size the buffer.  */
>>      if (tb_size =3D=3D 0) {
>> -        tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
>> +        size_t phys_mem =3D qemu_get_host_physmem();
>> +        if (phys_mem > 0 && phys_mem < (2 * DEFAULT_CODE_GEN_BUFFER_SIZ=
E)) {
>> +            tb_size =3D phys_mem / 4;
>> +        } else {
>> +            tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
>> +        }
>
> I'm not convinced this is going to work when running QEMU inside a
> container environment with RAM cap, because the physmem level is
> completely unrelated to the RAM the container is permitted to actually
> use in practice. ie host has 32 GB of RAM, but the container QEMU is
> in only has 1 GB permitted.

What will happen when the mmap happens? Will a capped container limit
the attempted mmap? I would hope the container case at least gave
different feedback than a "silent" OOM.

> I don't have much of a better suggestion, as I don't think we want
> to get into reading the cgroups memory limits. It does feel like the
> assumption we can blindly use a 1GB cache though is invalid even
> with this patch applied.
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

