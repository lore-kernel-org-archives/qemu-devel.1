Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2971BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA1C204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3hUEpU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA1C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc53f-0007w4-VO
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 06:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc538-0006rI-2W
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:37:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc537-0008Qm-6m
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:37:09 -0400
Received: by mail-ot1-x343.google.com with SMTP id g25so7837840otp.13
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x2PTjx8hW/DIUa4S409o0EafHN0ZMV+K/bqPSGgFspk=;
 b=C3hUEpU1t9xfQJZmnokwzRab3/FM/Xf4d5+RS7BZK+gJ7fwFdltfXdl5zW5nvjV04J
 qv20p64x6aEpxyqdyUydrRK+3PSsW6rErGmRx/hYfCS6xoQCfZJJjCpVC4/wCfbdMMPE
 00Y8lqOCpkAVxs/YqhIC4k+3Oxuop0uQQjOADKzUUqgBIyD4ts7cxtYm8WanX1t1delw
 ValEJhJ8JJiBQb/uwnW03on0onXF2aHTdFXPW1yIv1xoLVu0Osy28aKbVMtvxD6gNHyu
 ASN15/5xbBxUwHo60DsQKISNHXNkQJwcQMig/vKgOdppuZFXruAUt037mmBcFuUxMsWK
 h7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x2PTjx8hW/DIUa4S409o0EafHN0ZMV+K/bqPSGgFspk=;
 b=rHyMy84GXCPENo2SxWgY91qj1Oj8R1R0QoQmzEsYHK3qX/apBl+ouvdc6Rs0s1c4rf
 fRybHroYka7WpX93Fm4izDx31wF/WPrJ1IqQ3a3ywVAI0cYt01swWw6R/O+YCDpfbniH
 Lmp98GUcA8z2WABo7FL0j9Wf6enVpKvvr0nvzgle0QhjgDBPvRYdSrYGxG/+6z/m3dTM
 k4H3OI0C0E3gkkfvGmM336UWtOvKO10tYqNbOqggfoi6IQec4FkGzBnHzNrht3+7Ey+U
 u993TOavEQs0wQ174ti5Twy/dj9NdUTm2BhQxKaizLxTIIqF6+eBMGd70/iuNekzz4pU
 kuVA==
X-Gm-Message-State: AOAM530wU+pzJvCGJiLlQZUHteZmZjlC3mNwqGgKRWg2z6E6NleqlsZc
 upl+KBf8KfPLzUavPPEYOcGD3TaaoX5MSfRov8idUg==
X-Google-Smtp-Source: ABdhPJyWVEoVRCKLoxgWwnflbwggCKcghD9iEFynIJmB/VKIt8cUoimuCIHWbdUVPs9Sub6Xy6b+Wz3QVLl3Ry+kDmQ=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr10279428otb.91.1590143828047; 
 Fri, 22 May 2020 03:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200513175134.19619-1-alex.bennee@linaro.org>
 <20200513175134.19619-5-alex.bennee@linaro.org>
 <958a1d7e-305d-96f5-2e0c-f8a2dd53e1c0@redhat.com>
 <87eerdg0kx.fsf@linaro.org> <0fcdef39-2e6f-11db-121b-874805ff2518@linaro.org>
 <87tv08e08j.fsf@linaro.org>
In-Reply-To: <87tv08e08j.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 May 2020 11:36:57 +0100
Message-ID: <CAFEAcA9s7AP=nwPma5yV-45HW9hjixMt-4L6QB+SNfh2x-G_bQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] linux-user: completely re-write init_guest_space
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 11:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Examples:
>
>   /tmp/qemu-test/src/fpu/softfloat.c:3365:13: error: bitwise negation of =
a boolean expression; did you mean logical negation? [-Werror,-Wbool-operat=
ion]
>       absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven =
);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>               !
>   /tmp/qemu-test/src/fpu/softfloat.c:3423:18: error: bitwise negation of =
a boolean expression; did you mean logical negation? [-Werror,-Wbool-operat=
ion]
>           absZ0 &=3D ~ ( ( (uint64_t) ( absZ1<<1 ) =3D=3D 0 ) & roundNear=
estEven );
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>                    !

These warnings as printed seem like compiler bugs -- '&' is a bitwise
operator, not a boolean one. (Probably the compiler intends to warn
about use of the bitwise & on the boolean =3D=3D result, though.)

thanks
-- PMM

