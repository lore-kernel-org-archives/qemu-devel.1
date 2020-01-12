Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88246C33CA2
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 20:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576322080D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSfZ6d+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576322080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqjyO-0001iY-G7
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 15:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iqjxj-0001Ij-3d
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 15:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iqjxh-0000rY-UZ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 15:35:54 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:41715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iqjxh-0000oV-Nx
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 15:35:53 -0500
Received: by mail-ot1-x32c.google.com with SMTP id r27so7117533otc.8
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2020 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q2V9JEl+l6ofGPy1t30FHDeQifCM0NqXX+iejn07oTo=;
 b=fSfZ6d+Kgut/smHxjghnhLcpBc9waETkshT0gJmduhw+bp5D5JCV5haEtZzrGnKkEb
 iBv7d8AKlOH/Qcbgy3KsyjtCzM/DlJUdc9F6fKLvQykZ5Xn/XjaQaCNe49kD2BQWXMZp
 kzE+V/oZ4MZuBK3ymzELmS9ip254ZWl1F0ftBMW7ktC43q02ic4cMZR7zXTc4ALRQGnc
 T/kBcAsppI8M4py9TCX+artvP1DjOog1gYBWbvdpuH0HHU01PoMpzNjl21yP+VtFItsN
 KtMkaOiktOsgURfN1fq94yBRDiCfmOuS7b6XcjBV9IuhLaKtejN3XptlreSvgPRARwiU
 A3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q2V9JEl+l6ofGPy1t30FHDeQifCM0NqXX+iejn07oTo=;
 b=QBnaiLW7KRno5sLDrGEWVvteAiTbUu+rcAtkDSlKNgUA/626bUA1WV+4FmHbMCE+tn
 DoZUJzWRINGpwtO9iMXLKLZknYlfRaBHc4hJDoMkHA56br8e1U08Zy3s5rDYiRId7TqI
 IvqycqWUqNs+tdUYaeeeQrBpNNmbzNhuI8FFnHWLq64TV1+M0aDXVPUUEzLnXvQoMyHz
 mYkshktGFBDUZkJgSf98sQ8clGvFVU+aqGqAjtXq0/qeGKEMMsV0ZOx2bOPctkJ+z2Od
 CpEmJnb+7wKlSLhH+6ca564E9a3xD6wwTOqxiLWKY5WrGG60fWkhC/T6hqhBoU85EZKs
 t9UA==
X-Gm-Message-State: APjAAAWh+vWYem87zFihWtRwB35lc2rXjZYNS6t/u2H/pwXcRozXPtHS
 QdYGTtrLAqyFvv3H0+0EYEknNDPdl37NvcvcFnjGoA==
X-Google-Smtp-Source: APXvYqwxHlBhAmu2hLP2ObzdRAK+Uum2pRB0U0YFn/MLGGAjgWdQDi1tjADBKXqLt/tWvEhvgN3BUSkZ/Q91Rnf0vEo=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr9952849otq.97.1578861352511; 
 Sun, 12 Jan 2020 12:35:52 -0800 (PST)
MIME-Version: 1.0
References: <MW2PR2101MB1035A21608E50D68EE1CF890D63C0@MW2PR2101MB1035.namprd21.prod.outlook.com>
 <87eew7ik47.fsf@linaro.org>
In-Reply-To: <87eew7ik47.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Jan 2020 20:35:41 +0000
Message-ID: <CAFEAcA_zebKVd9FUHM9vhAkh_8_1aCUjh_2XTQuErz8X8gQVHA@mail.gmail.com>
Subject: Re: plugin order of registration and order of callback
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 12:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> With that in mind we should say instruction callbacks are always before
> the instruction executes. The reason being is some instructions can
> fault and exit the run loop so any instrumentation inserted afterwards
> will never execute.

I suppose in theory we could also have an "instruction retired
successfully" event (by analogy with the h/w perf events that
some architectures have), if it's generally useful; it sounds
like it wouldn't solve the problem here though.

thanks
-- PMM

