Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE0DC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 19:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539322075E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 19:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyqFrG5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539322075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ZVa-00076n-I4
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 15:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1k9ZUt-0006gB-Mr
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 15:48:15 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:39704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1k9ZUr-0001BL-NC
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 15:48:15 -0400
Received: by mail-pj1-x1033.google.com with SMTP id j13so2249054pjd.4
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lumdvBBsp9QSV9iMinRLxcGgE25EBCLF25CJ0epkdWo=;
 b=VyqFrG5Vr6zULd7bKGzwCQtEQJuSZJ5dPsneDuGdr2bx3n3T3PoLvRCf6eGIUCc/Zx
 uXf8rRnqdSSDhZeAPYxkCAR9bpqE7+GTgzYYfgDZh19avwCuY6E7OeU1MTwn4CofKm+A
 MxnijzF7GOWJaR0xKiEXAatXHLhv87bUm89q9+P+4QT/Gjd9iPFt9OrEaKMzIlA2gQBk
 yE6MZ2PH8DjJZGqVAldRQC9y8hL5qBQhw42iuL9g2IamiaQgVLqnKlT3KZgaf4SGFJf0
 7VCllFLaiHBjBtpq32c5UyNYG8187uXmCvnzodLyRqaCXu3uF0snChlYHW5Zf9I5Yvny
 mk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lumdvBBsp9QSV9iMinRLxcGgE25EBCLF25CJ0epkdWo=;
 b=apnbCTNEjyciEe9WG9A6yUWop32rcknQIjlkio7/lNFZWXz06hDeFoM2mfQMKoiXIg
 DTQg7UJRnxg7ByJpzgg+5sLGA199FRvjMxutVcuow5dRW1IM3UCcxZIBotK6f286kugR
 7T7IBI48IjKRGTuivoXMksEP0ugPZPdv9Ifqpfx03O0mcL4mnunM1UjMldffb2CoBNfq
 0Bi/Rp6WYCsnmn0bXCQ6/aC0lMHLkaUL81Qk+2MXrVXv304xvxR9d+lkN2zF4jgHA/hJ
 scWijhKexOzTlNqc5/bBSI5G2M+oeHWxcqYu8l1IVjfHyONhNwr3J11cOlBXWV3TmVNr
 PfAw==
X-Gm-Message-State: AOAM531GwFUu/DuDIom/osEYzijKtLwx8k4oh8yMSVltmPnLLf0HbjkD
 +FIGyTASzjmGY9l00SEgnd+5fVr3o8xtpCTNUHM=
X-Google-Smtp-Source: ABdhPJzd50zXydDN8CPjvRtOS0h25uhKR1n9qwECIbI3FKQ5A5EJ743cWxR8vOzVb1kTkXRaj+y5ac1/4pEO8cn9NNQ=
X-Received: by 2002:a17:90a:8918:: with SMTP id
 u24mr6760665pjn.7.1598125691736; 
 Sat, 22 Aug 2020 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200821205050.29066-1-jcmvbkbc@gmail.com>
 <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
In-Reply-To: <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 22 Aug 2020 12:48:00 -0700
Message-ID: <CAMo8BfKnW7oEe76akdszPh46R1GVU2kuGfTg3T7ypVHQnzDzTQ@mail.gmail.com>
Subject: Re: [PULL v2 00/24] target/xtensa updates for 5.2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 Taylor Simpson <tsimpson@quicinc.com>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 3:20 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On 8/21/20 10:50 PM, Max Filippov wrote:
> > please pull the following batch of updates for target/xtensa.
>
> 3.12MiB of generated data...
>
> Where does that come from?

Generated by xtensa processor generator, as one of many output artifacts.

> Some submodule?

Are you suggesting to move it to a submodule? It sure can be done.

> Can't we regenerate?

Not at the moment. And probably not retroactively for older configurations.

> This seems very similar to what the decodetree.py script generates.

Yes.

--=20
Thanks.
-- Max

