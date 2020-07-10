Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F784C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE93A20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEl+Av+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE93A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jts8b-00087L-7r
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jts7H-0006wo-UU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:27:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jts7F-0003MG-OC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:26:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so5773687wrw.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lZT61Offf3DWMlUhHXIHcDEA7gzMQqsih81rXDTrMMk=;
 b=OEl+Av+L88VsPrclIRaPEyadNDgbMvPxh27/TDZrQMTicYCesMdz5/3T4KCWl+QfWI
 vv0Kfv/UaDkvnKeg0FSEhSI4wRUIq4dmCoeo5zE1ZmhnhnYIbMaORJaouuH6eFAlfehU
 ATlHW02/15lDaJkp53viklZitekSaVaF5i7yWO5hPdBD/RExQCNP9hQDD71redJBNghY
 1Wh6xUsDkyLzKr4r0r1+jb5+TnlyUY69HV5++v6V7+frlGegvwklXxEq3cpY+xuRRpFn
 w82BTLpRQwuhoJhDTGLVtSRhAwUuhZihAqhMg3knWSTUv7Qk+LV7vK5ru48W7M+Q+/fK
 s13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lZT61Offf3DWMlUhHXIHcDEA7gzMQqsih81rXDTrMMk=;
 b=cnbTk4vjyox0z2jq07mm1DUBdOwCk7vw9vlcxPFMnFAATObOljeIhTClddWV5CArlX
 z903aGQG5PX1VISiq1ttNoeAud4yaDl+MCn299ZHimDRIsoQftV7vnI+RFbPOqtidFWF
 mbmt0R1VLZCwl5TlOyYtLZjTPlrp+VYyPeQ21k5CSU97+MxBR4PQSl6yvwMboNdiRssM
 Pnp06NMq7SzQPbeRJfxFbt/e4tCLHbytsCnfy7lGm3me//2QLhhRCtiTrebR0NgqpoMZ
 MH3mA0NYZypUIr8IUzcCn3iSyBGubEKF3hdAJfnLNd9HUU+Ml9GkvfUIHuEKaz99lenH
 8/Ag==
X-Gm-Message-State: AOAM532708HvRDQ1zTY4Qk/JhfMUrjKuFtKA4Fx6twvVIPOvGh+Ym+/+
 bavWLgLsNQDO+Soffohdqyd0Vg==
X-Google-Smtp-Source: ABdhPJyhwZkbH4E07QIPumHS5ZRO6KX3VuDaCTInXqU5Nia28NdAMYutfBr3jEj5eCSDR/zGG6eEdg==
X-Received: by 2002:adf:e884:: with SMTP id d4mr65190280wrm.176.1594384015840; 
 Fri, 10 Jul 2020 05:26:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm10536939wrj.8.2020.07.10.05.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 05:26:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 37C511FF7E;
 Fri, 10 Jul 2020 13:26:54 +0100 (BST)
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-64-frank.chang@sifive.com>
 <87eepjlfri.fsf@linaro.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: frank.chang@sifive.com
Subject: Re: [RFC 63/65] fpu: implement full set compare for fp16
In-reply-to: <87eepjlfri.fsf@linaro.org>
Date: Fri, 10 Jul 2020 13:26:54 +0100
Message-ID: <87blknlfn5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Chih-Min Chao <chihmin.chao@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> frank.chang@sifive.com writes:
>
>> From: Kito Cheng <kito.cheng@sifive.com>
>>
>> Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
>> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
>> Signed-off-by: Frank Chang <frank.chang@sifive.com>
>
> NACK I'm afraid. What's wrong with the exiting float_compare support?
>
> Even if you did want to bring in aliases for these functions within
> softfloat itself the correct way would be to use the decomposed
> float_compare support for a bunch of stubs and not restore the old style
> error prone bit masking code.

In fact see the example float32_eq inline function in the softfloat.h heade=
r.

--=20
Alex Benn=C3=A9e

