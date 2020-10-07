Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F2C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24C320789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lozlnULp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24C320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQC9v-0005bb-I5
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBpv-0003VA-IQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:58:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBpr-0000XK-Gu
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:58:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id l11so2896860wmh.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2drdNr/M1U24UH3JKKtdMLm6a3hL9FeW/33oM5mx0SE=;
 b=lozlnULpkc06EfM0cZx3HuvOvijJg09n1WmL4wUOp9C1FypkBya40TBQAroaG2pWZX
 z82FY9dmxMvTPG046KahebuEOcv8BSLuCGV1m/nkz+DIQUrwqogCB/0nhg2wZfxWht43
 Y38TVcofS8COPSb/tV6yJkroE+bzfdCJyIe+WvlyypmRMeqd/H8JMBKybqXSC2xSeybO
 jSCiS06bjdZL+yM1t17X8wKJTFFUBMr+3N3MbJdd5NDY67Va5FDQegOa+j3XBVR1d7Rw
 HWXyBPm7SiI/tZLzhRywnZ/b/SS5ZW/ghh4/wGgaBwa4ZkP1WBg+lMB34+sfpPzCUMW9
 taSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2drdNr/M1U24UH3JKKtdMLm6a3hL9FeW/33oM5mx0SE=;
 b=mQzf0Q9Wu5INEjsF43Q0VDvz4OJNPz619LVRiEUgQyo7Yfiwzy729H3v4EuZFV+3t9
 9o+5oMaAStqunW7patJNlVU+7NcNFiPyIHHhqWyRGscBNe62IJBhyd/V0WiO8+uBwzqc
 0WV3Da4UFwnACUt2PTuXpKkmGjGnE7AeCVNKZ4jOSytKiKBOJ0mifVuXtAtNV2QvQFaP
 inKw6egix3DUeZs3/3JX/pwcShXJ3544pZF0xpsBECcLqNLrQww7EIwwaLyTRyPeM1YZ
 LAIYy+xMxXUjhfedU4dVHoC9Tcja2pvwAtEN5eoPOidYLHLy8FZXWnYkX/I87pByYE7L
 lswA==
X-Gm-Message-State: AOAM5304f1j0B5Gv2pBrVtSoA0cyV+m+fpMMYe4P5rtcEguQVzrdGXuy
 ThpPHFgXPmiZoq3jE9FItlC0sA==
X-Google-Smtp-Source: ABdhPJwXNwYFQWjiX1GcAr7Nz7VrvmvQiSbJ8gFFU5M5cw1Po3jxOoP97adxK9vUC2m0sa/K2hQEBA==
X-Received: by 2002:a1c:ac88:: with SMTP id v130mr3959424wme.43.1602086312699; 
 Wed, 07 Oct 2020 08:58:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p67sm3258951wmp.11.2020.10.07.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 08:58:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D86851FF7E;
 Wed,  7 Oct 2020 16:58:30 +0100 (BST)
References: <20201007145300.1197-1-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v5 0/2] Improve cirrus msys2
In-reply-to: <20201007145300.1197-1-luoyonggang@gmail.com>
Date: Wed, 07 Oct 2020 16:58:30 +0100
Message-ID: <87imbmyqmx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> Fixes the broken msys2/mingw ci and speed it up.

Queued to prepr/misc-testing-gitdm-plugin-fixes, thanks. I renamed the
script to setup_script.

--=20
Alex Benn=C3=A9e

