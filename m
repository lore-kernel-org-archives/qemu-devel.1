Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB95C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D27921744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaIM52k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D27921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k404k-0003Xz-A2
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k403d-0002pF-KY
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:57:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k403c-0004ty-0y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:57:05 -0400
Received: by mail-ot1-x343.google.com with SMTP id x24so1278846otp.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xCGLiaZSZiKCHhuzR6N+Hj1RCxhrm3UwSkzxuZotQB4=;
 b=yaIM52k3EO5FGVKiNXWDZRBsV6ZJA9ZwMjIWHy+QAlt1syG7nEeRw2jzc2FwCUEEF7
 Kk45Bu9P/XR27hyDRK2xgX6Gqfn8bMCshf9IA+pL4P4+itRcR2/MGNDHzwNInPyYHWNw
 rICmaR/2V//a2/tDFIVhvA2UW5AibcnCdMlBo4q6hhp9aizwdjE1/Tj14hI9AFGQqnkh
 IOpJumRUpvNsFQtWua/HESIRw+jVzCp4HIZdA5NDzY25a8fjzoZpd9b2zVFFskMQDw1o
 lUWQ3inzwyAJqX2OM5yBQEsxkDF4mi2Kj54Ho878X4+mKaabw5nP5rxQ8ydTBeQI1wjj
 jZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xCGLiaZSZiKCHhuzR6N+Hj1RCxhrm3UwSkzxuZotQB4=;
 b=IaF14PEcmTBIrrFD3dGOd4IMTw6xDEU8LjHxcmiRIX5gcghqTqc+XmvKVT3fGNepkE
 esbupIbDa40LZgsHOegKHfThPo18tpKyIN+IOcGrsOD+lByE4dj+976VzUKbECNSHMDl
 scV1g1vucjFtyFPC9rh+0ubJ+ioJITmXuZDMGqtJ5wwV/6ayQxqQoRbOBoQ6vKnhMm+K
 UCDi/NeRruXafCC8PgeOMxcvWj7ubduZNRwiaTnadKAngyr3w2F1mecoTWOSoduTMXrO
 V4uCF6ckaJpWf+2eBhUhAlEA2s4wGUULUZYAT1zFC2PlXLzOJwI91ydBeQjJbyGRr86T
 U8TQ==
X-Gm-Message-State: AOAM532ua+21XmSMRu2/SgJn1ZYiRO3UOBYuzsAWODWSSam02D8vfHzZ
 cSwUJl60oDlpJFzFIjNTGCpAczSSjei0SbqhA/uEbA==
X-Google-Smtp-Source: ABdhPJy8KwST3skN250IwUrtGjnyfDj+ueCj0OSpiqVkgPooY0XENinFMop7jPjd9F+iVQqGqChTsob9aBTavVko8JQ=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr11060396otb.91.1596797822115; 
 Fri, 07 Aug 2020 03:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org> <20200807082206.GC120942@redhat.com>
 <CAFEAcA8U=Wxx8Z7E2gcwYEhyV_EiCBX3o+FxdxTa9-bvS7rM-Q@mail.gmail.com>
 <87pn82k9r7.fsf@linaro.org>
In-Reply-To: <87pn82k9r7.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 11:56:50 +0100
Message-ID: <CAFEAcA8T6nCLsjSBQ7Lq=rq-s-S2wJ91K67HDpJrcTmFneHKPQ@mail.gmail.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 at 11:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> I note all the CI jobs have failed on building as well. I think maybe we
> should auto-default to --meson=3Dgit unless the user makes an explicit
> choice.

Our usual approach with other submodules is "system version if
it's good enough, otherwise use the submodule copy".

-- PMM

