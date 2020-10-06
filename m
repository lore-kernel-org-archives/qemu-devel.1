Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D3DC4727D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1095E20674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROOOEp7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1095E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjm4-0005Ah-SQ
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPjkC-000443-Uz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:58:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPjkA-0004HQ-EH
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:58:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id e17so4025548wru.12
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3376gvfx72qTvLrPkueMPO8jMQTkKeQ7SFEjXQOmKdM=;
 b=ROOOEp7p44lZSISCPCTRsTTcciS5tBP4oj4WGwonLb+YF88TZnOD49QGAS7PLQ5aAC
 yS7tcI8DeXGqOUiRnuzVao4cRdx8zsJ1iO46Ma8FlgnIPHZ4dpev2xEwK2bHrGwGkP3R
 2BfYkKRtZn7sjDNpcJnbl7PdLor4RN7t9jgN3UrBbDFcEpxH75rIzr1AyQg/Gqx26YZQ
 sWVxDZEI20N6inC5li1XYaIizGd3qAyVSadacaAhLgf6Sk8Y6W7rXuLrUgOwoF+Q6kWY
 /MmRFjyLUU8ofyF4+q2zzSaQvmaZx5j0T6HfijZZ5usc2a884g+YvJP+SJtUQSvoJja3
 /plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3376gvfx72qTvLrPkueMPO8jMQTkKeQ7SFEjXQOmKdM=;
 b=huNfJZ0IPbbN6xCcbbnmpOztk6gjxA5KzfhvzGDfNZVuATWfGBf/fYmdX1XHIQW1uU
 4ElpJ0p54ezkbncdARoI7eWzpOFpvs0Q6M+IB9E+ZoAQYQZkpvwZmMwIlM1Oux/CMCNh
 VGUEq5sY3IQbQY1kouNUeLv2MMQsgwikojBQigCsPIXpd5pOjze9W/QaaccjHuKJXXuu
 8xKpbAN+FKoFufGyDJYq/nuQ3NjWIVRM0tJrBkw5aTsmAxj9y8x9/N59da+wGx6M2vsH
 U6obuF+l/3nTyD9E969VdQhSG3qh50q28h+L7+ObuS2P7UR2CEQ1Ry0yVcQWLw2Y+Rwv
 sUAw==
X-Gm-Message-State: AOAM532eE+2FEejUflHXWYljz68r4NugKbgJDgrlICLEcRENoPk7urfT
 +LIsU6r22s8WTBqMgcerZqNSBA==
X-Google-Smtp-Source: ABdhPJwJp0lUfXt1SKxdUNX0pk0doP0Q8Fwa+hn0ka+mijuoClu0vfi6hdAVWT7UjJvpyeTw1VvQ4g==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr4244651wrn.229.1601978328733; 
 Tue, 06 Oct 2020 02:58:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n66sm3254254wmb.35.2020.10.06.02.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 02:58:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FCFB1FF7E;
 Tue,  6 Oct 2020 10:58:46 +0100 (BST)
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org>
 <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Schneider <74cmonty@gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
In-reply-to: <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com>
Date: Tue, 06 Oct 2020 10:58:46 +0100
Message-ID: <87362r3cbt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Schneider <74cmonty@gmail.com> writes:

> Hello Paul,
>
> many thanks for sharing this info.
>
> Can you confirm that the emulated RPi with your command will use=20
> "internal QEMU" network, means the client cannot be accessed from any=20
> other device in LAN?

The support for user-mode and TAP networking is orthogonal to the
emulated device. However if you only want a few ports it's quite easy to
use port forwarding, e.g:

  -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22

which forwards 2222 to port 22 on the device. I have an alias in
.ssh/config for accessing my QEMU devices.

> If yes, what is required to setup a TAP connected to host's network
> bridge?

I'll defer to others for this but generally when I want proper bridged
networking for a VM I use virt-manager/libvirt to configure it because
it can be quite fiddly to do by hand.

--=20
Alex Benn=C3=A9e

