Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B2C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F102084A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTf7Fy4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F102084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqrz-0007lK-5E
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:10:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQqrG-0007Uc-1C
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQqrF-0002ov-1c
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:09:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQqrE-0002me-T3
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:09:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id f23so1691697otl.9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Nt7yUNl+fxHHqXk3cUA7QSmgiFJwk1O7ULjATBXYI0Q=;
	b=rTf7Fy4v7QCwUW+OLirLMc7/8p2YwE+yW9Jin3WxKfIV6ug/O3+JUly4MGUnySmjXh
	qm8tbdY3eHfpjI3VrP6BiNkRHIeNkTc9j+LlGoGcS23caukk9BuybCpBwWL7bZgB+xjg
	1XefY1dczsv1TrdWROcN3+xgzVyHOHj5lTwFVSHllLI4S2ZtP5Lk3n7cZJwqbWk/ko+a
	av0tQsSuOfe0sKKGcuTwY9/DVNitf1r6AZUNJBnX1QS/CV3dN6FloQaM72DZPV9PQKva
	dI0z+J8zi9KGNm8BFEzfQJGfptkMsHBjd3XMkRS3TYfR0vjqQTEydeYj50cn14nuXcIT
	C88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Nt7yUNl+fxHHqXk3cUA7QSmgiFJwk1O7ULjATBXYI0Q=;
	b=L3+fq0L4D7g26mHnTGb+ZzlOwf9hnV6Bz5YkkzFwYYRdCbCkiW6uWqbPIcMJg6q1WP
	RxYJtdjtu0wNfmRx+jzXGwKMwN2ylvOw+m8k3MJ+rLMRCRgSmU8BLRuZEF6LMmjCn+yJ
	2YdGTRGM3ZEGWE0A04b0htNCbYERtcPdAP024+Cc6RVoaX6KmhImLLOswYVMtugwJgDt
	sHRcvzioBWxBn1a66plyac/Iin07L3zaiaP9J95s4zqbnPX+honDMuHPiZTjYVt+8dN5
	T9Fd0nfld6NQN+gRZZbf+My+pANivG0CpY8dq21nZxt/9eoHCBZzqkcaGCctpqyjeUT9
	VhIg==
X-Gm-Message-State: APjAAAVg9hGWG+q+75eg0qt+Lty5MAObxSJO7hVoWQwnShqW4YJK+GfF
	i+evekUJntOc2G9HLgpI19Yumam1DtExYGguteKr6Q==
X-Google-Smtp-Source: APXvYqyUdoSganr5JWqA4O7y7ZjVDMK82anLa4aVmLZc/OZgJYg727u6M+HEOVxZ1YmzukWbjAjJBZwbkYqQgdAhj7o=
X-Received: by 2002:a9d:61d5:: with SMTP id h21mr24907104otk.306.1557914995552;
	Wed, 15 May 2019 03:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfz88bva.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 May 2019 11:09:44 +0100
Message-ID: <CAFEAcA_6SC1PuzjjK=4p11Z2CVNziSkNU-Nz4=t9gf30ZmP4qw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 May 2019 at 07:34, Markus Armbruster <armbru@redhat.com> wrote:
>
> Jason Wang <jasowang@redhat.com> writes:
>
> > On 2019/5/14 =E4=B8=8B=E5=8D=888:18, Markus Armbruster wrote:
> >> -netdev's helper parameter is seriously underdocumented.  Document or
> >> deprecate?
> >
> >
> > I believe management should only use fd parameter of TAP. If we have
> > other, it should be a duplication. So I suggest to deprecate the
> > bridge helper and -netdev bridge.
>
> Objections, anyone?

Only the usual "only if we clearly document what the intended
new functionality is and how to convert your setup from an old
command line using the old thing to a new one using the new thing"...

thanks
-- PMM

