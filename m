Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFD9C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC1E206CC
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uh0mg/F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC1E206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVue4-0001yq-J7
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVuXG-0005w3-Th
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:10:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVuXE-0001wa-OH
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:10:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id i27so1149608ota.7
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k2E1BANozowIuRLwzQhWAkc5j3kkcoUCFJeH+kJb5Uc=;
 b=uh0mg/F57LfyLKGl4gKQ3i0zq5ozIDmsn8qKb11GOhDcpbjfHr6hB/rEzY3yh2CGKb
 +Md45jf9/FnbjvrtBj7/rM+nf2v0VpJlYDBqpaSJ9qo8tNTfiwQuLKmxTQ4XRzb7G/ZK
 9iqO0kHqLIMJLVs1WW2HrWEqlkwYay64rQ7uxgN2q/Y0a98WvVmA99YdQc8EYYoHymic
 srIq5b5/XodbyjHh/f92tScv2wjQiO3QG+YKAx8REtKosdjTNoNcTAVJlxl1a+1mgfDF
 yfQx6aZvM+q4lWvHt8VrBOsGFHL8fLVh0CIVSTcBnbaTdpwvk7I81fbPbe1UMNWRRArK
 1XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k2E1BANozowIuRLwzQhWAkc5j3kkcoUCFJeH+kJb5Uc=;
 b=MaizxJPxt6/TsMex29qd49rgUyX9I3a8cT9s957Xn97vtJCAVimUrOM633Hlk8fUGy
 ipuxDFn6n9jDKxwp8V61bWjixWjcHKIqNkGZqsymggPaP1mfkPYCZ65rVYbsk0wTnkUJ
 UmqvRgyV2gxLfAOYq+XSfrczv/eBn2YYqZw/zydnDRqWsEZxOwkUVoWMdwV5YwgNpOOJ
 K88uIPTrcvICm9LOsA79rRblLBhZYGrvMuogAgiuFR/uL93ISAWMh19q0509ls1ENI0J
 SHmovfwp9mz6gp9iYn+P3bm9roiHIlISnXY35/mMBC7XmuXbdjtEQbcI1ADre0l4sebe
 uwdQ==
X-Gm-Message-State: AGi0Pub0Acp8QajbsQvTfGIT2JI4LAFPSrT0z385WiG3RBy6Bh5WP4GL
 DxFW9S+0NYOxOCrzZp0hsm/u9ktwPkiBGOW7a0ru/A==
X-Google-Smtp-Source: APiQypKIz+/6r5BxIdWv5d82lj7PFK3reoqhsmCv0YU0m63wT+DpqE4O3aogEg86yuPuswJQAerbSq21v+PJ6qTwjRY=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr1591546otb.135.1588673443251; 
 Tue, 05 May 2020 03:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200505095945.23146-1-f4bug@amsat.org>
 <bc8d1213-5578-52f2-7a86-f45dfa8b33be@web.de>
In-Reply-To: <bc8d1213-5578-52f2-7a86-f45dfa8b33be@web.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2020 11:10:32 +0100
Message-ID: <CAFEAcA_Ci7ymqWV2tvnJX-Me5D0QQhaKaBkJVaL7KxeixCZJ_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/musicpal: Map the UART devices unconditionally
To: Jan Kiszka <jan.kiszka@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 at 11:09, Jan Kiszka <jan.kiszka@web.de> wrote:
>
> On 05.05.20 11:59, Philippe Mathieu-Daud=C3=A9 wrote:
> I don't recall details anymore either (more than 10 year ago now...),
> but this looks reasonable.

My guess is that it dates back to when the serial code would
crash if passed a NULL pointer for the backend rather than
treating it as "same as if connected to a /dev/null backend".

thanks
-- PMM

