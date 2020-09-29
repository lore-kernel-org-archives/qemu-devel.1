Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1A7C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51C520848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghM2tjTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51C520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFEt-0003ri-0H
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNFAd-0006tD-A3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:51 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNFAb-00032y-DM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:55:50 -0400
Received: by mail-ed1-x542.google.com with SMTP id j2so6202257eds.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hFiQ1IrKPc/BeaEYsp9+YmLWAPi+EAYPi87IdGvuqQk=;
 b=ghM2tjTv4cjzmMOv/AeQDiMBOhMQhqLvKwaamv9ocrmi+WMeZvba0JlazvZJSCBNEi
 Wc/4LCSxqAa1txYDmLmUKVr2GKtN5dh1ehs5ZtWB8+cXejvIyryJwujfnIb/U+7H6iHD
 WNUxK8/+/Gfj57+a0OSZk9Bs2dSjFcn0eUaq0bfH2XixfqV9L6+FpEWDLNU1IBQMDq8I
 lOFOJjtzHruVWlSGOHYfOLJOsSHHoSpB5bN90RV7ZiFhZrhLAGArHY/pjmiUFSrMdJxY
 yLB6o5ZfaUcFnJ+onZkrTKCAfi/L7KuHOJbPEt8bQoHYMhLEa50Yb1o7DaJedHnWPc/w
 JgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hFiQ1IrKPc/BeaEYsp9+YmLWAPi+EAYPi87IdGvuqQk=;
 b=Kw7BW1DUbqYkO3O/JOhZ7gHTFBZvrPvWPwahPF5OnMzOVUrl7przPf5oRhFCv0AK8i
 CWsLjVnA8Rq8VFmdoeHyHCFqgbO+FbnJBwzIt50O0SGRwz6riuX+ZipJUHoOEsb86iNC
 46CW3v/9xvJUGE6ldV3NOpJPVCg7dev4jBIxpPzmXXXyvOGdWSsFmKMZxGM5IK+T5Gwh
 vxn0TWLNUJqLpOM/aEeO31uUjSLi0QjXXoUqI9VubGOKr14DztygmWx9PEf+MJFnxkf2
 UK0VS1wKcnwne8YnLDLl4+8rHdul9jNJ4crcXV37M23nvK7YADMjxoHQG8IvabXjdnpC
 HVPQ==
X-Gm-Message-State: AOAM530lGUM7U97ZSS601kTM5OUKHIQfK+12jKOo++a138/t132Yp6Wq
 WBQyMY4SZlRp+Hcvx/oFrQVR1RV3PqcgFavO40VlLw==
X-Google-Smtp-Source: ABdhPJyBp84IeI6myo8wcKekOpQW2bDLdhWx7Auk1C51HFpEKlYokb2Dc8qz3tmt44t2GcSs+hlGe/2YdMLfQKTVf+s=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr3169838edb.36.1601384146852; 
 Tue, 29 Sep 2020 05:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200927134609.2358960-1-alistair.francis@wdc.com>
 <20200927134609.2358960-3-alistair.francis@wdc.com>
In-Reply-To: <20200927134609.2358960-3-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 13:55:35 +0100
Message-ID: <CAFEAcA9Rduz5RB4oUD_wR41_oEfdRSbB8O=99pb+AjXM8gLG6A@mail.gmail.com>
Subject: Re: [PULL 2/2] core/register: Specify instance_size in the TypeInfo
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 27 Sep 2020 at 15:00, Alistair Francis <alistair.francis@wdc.com> w=
rote:
>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alis=
tair.francis@wdc.com>
> ---
> @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(Devic=
eState *owner,
>          int index =3D rae[i].addr / data_size;
>          RegisterInfo *r =3D &ri[index];
>
> -        *r =3D (RegisterInfo) {
> -            .data =3D data + data_size * index,
> -            .data_size =3D data_size,
> -            .access =3D &rae[i],
> -            .opaque =3D owner,
> -        };
> -        register_init(r);
> +        if (data + data_size * index =3D=3D 0 || !&rae[i]) {
> +            continue;

Coverity thinks (CID 1432800) that this is dead code, because
"data + data_size * index" can never be NULL[*]. What was this
intending to test for ? (maybe data =3D=3D NULL? Missing dereference
operator ?)

[*] The C spec is quite strict about what valid pointer arithmetic
is; in particular adding to a NULL pointer is undefined behaviour,
and pointer arithmetic that overflows and wraps around is
undefined behaviour, so there's no way to get a 0 result from
"ptr + offset" without the expression being UB.

thanks
-- PMM

