Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5445FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2887B2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyTvk5+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2887B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFQh-0006sk-EY
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFP7-0005V5-7g
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:29:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFP5-0002gi-Nd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:29:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so21591855wru.12
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yPfDS6xGID1qMZnIa+ox51oDWDIA+6G4B8k/7Iwkk7s=;
 b=KyTvk5+zhcEFzDI+Jh6fA+C9WyRts66QK9YIQO1fSrYTk+SG/xBo2IuWK1Oqabr30R
 sc7+Zllcj8Dv15BeO+PLXHmQOzWZCtB46pzyu03DMZKcnfVW23b/xnaqZPe5OppZYjFT
 2MNnSMhMjI0/nxdkOhxgmWiG77QJq3zVRcD1kxjc8LHCU6lLGij1yEEUhOILN71ET5hH
 guuZq6daB5l20niVKDn0T7IKFX79f1lv0p+trtkMTqenGcFpF7nquhbvRqJc8HWnLkOB
 jbgWQHeSUvbBVpUN2l+1/rWLewF1BFVBO7hxu40A3r0eOrhVDCeKsXQH/7nNpcbU2g0+
 fVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yPfDS6xGID1qMZnIa+ox51oDWDIA+6G4B8k/7Iwkk7s=;
 b=prye+iJ00zIPP5tdxBu8weZyUhxqb+UoU/ahKbXq4NKyp2nl5RnEtmqlCl6CJQSe4q
 NRfW2qMb45DMgvqbteIJcJOXLZYsZj4XQkXF28r7uyb50Hce1urQCSoaR0ZDjU0XEgxf
 MMDHyvsEI5pNWHQr4FF+vvR1fp+G4sLxpcHtUz8lIQZ1WC7WpmrF/7VHDAb7TLbAFOya
 mVDcWpgLo3XOmllNOLBHAu6Z5bEN9TStZPfjJ4vUVET29dzVrPumvyiExpuQjDYbds0A
 xorDO3I11ZRFpDrtAXUTQL1+ASiElKw6H/NY/0LNYsrs/BIZd6ELTNDRGpmFQO8F/B2s
 9Xlw==
X-Gm-Message-State: AOAM533uH6Mr3fpbfNcBcZshWptGgj9xbvsbdtLm5hodAflpqo3zOG0w
 enP9c8ZI/p+GPROfX/Mg7ihrYQ==
X-Google-Smtp-Source: ABdhPJyM2RYth2LQ9s0NU3q28WZ7N6kR0K8hQsc9kCR4LUdKORusNyNtOddlD5AvjbgadJfYL1NmDA==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr3969871wrc.377.1592328581975; 
 Tue, 16 Jun 2020 10:29:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j18sm31802807wrn.59.2020.06.16.10.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:29:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 596F91FF7E;
 Tue, 16 Jun 2020 18:29:40 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 00/15] tests/tcg: Add TriCore tests
In-reply-to: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
Date: Tue, 16 Jun 2020 18:29:40 +0100
Message-ID: <87zh92yl4r.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> Hi Alex,
>
> I managed to update the series to successfully run make check-tcg. This r=
equired
> some changes to the makefiles. I tried running the riscv64 and arm tests =
and so
> far I didn't break anything.

You can have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for patches 6-15 although I have no idea if the results are correct ;-)

--=20
Alex Benn=C3=A9e

