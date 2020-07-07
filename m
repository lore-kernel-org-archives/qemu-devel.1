Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3437206E9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szc0qydu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3437206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jst7v-00019x-0A
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jst7M-0000k1-L5
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:19:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jst7K-0003y2-Jv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:19:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id f2so18444866wrp.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9ehTrMhdPlCU7/C/yHyZrsODUPOMWOMebo9mGikcBYs=;
 b=szc0qydugkI5eIdmXfM+nrHQVK1Vtp1gHXx6er4PhsFj2LTUDx0kbXYcLHs2OVH7wa
 lnnJaCqCu6v262oaqUpbLlRmg8qRayA9ZrKkFstm5iCu/rU0+eEhSz8/sW0pYDfIx3Vx
 ryfinA1clxgXLiO3gZap1k6ZKoJTYKyfQ5oRbl86HHwXDG/y/NukaxUQFonPY4IZ5NOU
 eViPn5xjfE3S2mXjoSiYwBxVoo3sN7pV18gy3Vn5dGnmYXcEkdk0EVgyZ+LTZ6qRy8eM
 twkv6E1FH9YCzwjO3/MplrbUqF5hzF+23kiP8EX4/lac4cGeBYwV9QQUW4IW+uB8b11f
 aM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9ehTrMhdPlCU7/C/yHyZrsODUPOMWOMebo9mGikcBYs=;
 b=m7DFwlXxZ7LPcZKGr4vjGXIztadNu8OWpwcUY+zun4bWE4rKLEYT2fS5s1C6+5Holt
 zBSpraX4WV1G5RLhrOIMtu7dtTii+hKNKpLF/BbTnwp4ioiEv7xNzcZfPm1bW8SFiQtI
 GaWPgvQr8thn19VZgZdisy3Ldvb3Kmh+YLzRe+jAPRu/l52YR41FnMXT+UT81m8Oisrk
 4fv34cvnPLR0Y7pJ7v9oPvFsJcT82OvTg3xAUBZuhctGgOg3NDyIxVNSqG/fbyLxcBAe
 K0ubWI+kte786qD/hHKKqJy1hbwxmKc++lC2CN0R2y5amN27/7uJDHeGu58BuuPdGZ0X
 wVHg==
X-Gm-Message-State: AOAM532DOtT9xWg3KmYbAznHJgFoj7QvQ/+GV86kgPwnmkvGtr0vjOEV
 XbqCxiTG5BLdcEP1bMPtr9rYjA==
X-Google-Smtp-Source: ABdhPJwuIFsPjiEH5PSEU+1gb6pHROlaMHK54/+narcxxbNs9se7NnL+l6+vB8qGi7rTjAC46cGtFw==
X-Received: by 2002:adf:e801:: with SMTP id o1mr56205420wrm.54.1594149536318; 
 Tue, 07 Jul 2020 12:18:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r3sm2699338wrg.70.2020.07.07.12.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 12:18:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 49BB91FF7E;
 Tue,  7 Jul 2020 20:18:54 +0100 (BST)
References: <20200707164642.18612-1-jcmvbkbc@gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 01/21] softfloat: make NO_SIGNALING_NANS runtime
 property
In-reply-to: <20200707164642.18612-1-jcmvbkbc@gmail.com>
Date: Tue, 07 Jul 2020 20:18:54 +0100
Message-ID: <875zaznnfl.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> target/xtensa, the only user of NO_SIGNALING_NANS macro has FPU
> implementations with and without the corresponding property. With
> NO_SIGNALING_NANS being a macro they cannot be a part of the same QEMU
> executable.
> Replace macro with new property in float_status to allow cores with
> different FPU implementations coexist.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

