Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D07C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A009206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOb/Iug+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A009206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip97e-0003gO-IA
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ip94Z-0000fa-FS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ip94Y-0004Hf-EF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:00:23 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:35953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ip94Y-0004Gm-7s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:00:22 -0500
Received: by mail-oi1-x22a.google.com with SMTP id c16so2263719oic.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RwHSkWa6/xrSNv/MiGXZkw/kbOa+UDC70JgFa+Hkz1s=;
 b=hOb/Iug+hzF6bmk0eXSY8X2niBtDAGpC8uWUxTyqpGPavejvTAOnzJzNy+T5N+YxXG
 XUDk8BT4Xs/XH7xEKqLpRLHIeZ6ATK0VvMXV3v6mQ+uPs5G+QKzJJyK/nxgyiohUlRYs
 IbD/qIIELPfiYsv6yqPCcK77N3z1zo1oYItLIEFqeldMIBwXqPQrvIrhGnb8OH+6z2Gr
 OIkLSFjJtyEkSxZW6HBCixre8DDf7hKZ3rmWgQWchBcHevIX4xM9cUdO5l2N8n79Sw5k
 3PBpZ1fLgNeL1vPQFF/U7IMdjN2Jnmv73Dr0tRaEPe9dkVTo2F93eGp8WFx6nfYNgzzh
 F4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RwHSkWa6/xrSNv/MiGXZkw/kbOa+UDC70JgFa+Hkz1s=;
 b=n9V+6unB29u0kHdhyntx17NnHRQEZHJfpxda4YejExFe/EnzyFvOY+WKVhsn2git9z
 C+Yc1ma7185cvJVxLA6qxKkWIvFq2U3dBoQyBjSl3d8pbvJcDFSuKhszf+aTTStOwJFN
 wXwLXDPiN4whifvEamcmtA32Bj+Z2P/0KvXdwxXplxcpr/rZTYcz5y+Nwjjzcx3jIgJQ
 yVTZZjNMw4J7rxMYRdHrYmfv51uWkpNPoND6GetPqn3ollVwuztwnyyN/5ntEQBi8MXl
 PByozYLXfjj//Gu2Yo20VqHUxhX6zgOdiHGiOXgAMlKQvCZfpOb4SP3/rldW3jsy6gRB
 cBmg==
X-Gm-Message-State: APjAAAXJPTuMotgedXMN/wO0LNGYElQjvH5p5//afpdB/OPbDBFSW0O+
 uciGeKoyaPMrgNKCcrnJHS+PS7EEIKKe5iP57tonfQ==
X-Google-Smtp-Source: APXvYqwaOItTMgQ1R0hlB3F04f9ladQsHcK7kXe7zaffdqMvdaorQURne5oibsG2z3hmSi0CdkWlQeUxvMkve9ASte0=
X-Received: by 2002:aca:f484:: with SMTP id s126mr2463961oih.48.1578481221111; 
 Wed, 08 Jan 2020 03:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com> <87d0bujkpe.fsf@linaro.org>
In-Reply-To: <87d0bujkpe.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jan 2020 11:00:10 +0000
Message-ID: <CAFEAcA-AEKKL-0c4jpV5bMeAWszWndYWbqoaOqJBnDqn82N_AA@mail.gmail.com>
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 10:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Thomas Huth <thuth@redhat.com> writes:
> > What about "-accel any" or "-accel fastest" or something similar?
>
> "any" is just ambiguous, "fastest" is just begging for me to find a
> micro-benchmark that TCG outperforms on ;-)
>
> "-accel default" could be considered to have vibes of Do The Right
> Thing (tm) and could in time actually become so!

That would be a weird choice, because it's not actually the default!

The obvious analogy here is with -cpu best, -machine gic-version=3Dbest,
etc -- use "best". You can argue that it's maybe not got the ideal
set of connotations, but I think that trying to be consistent about
the name we use for "do the thing that seems to be the most
sensible for the host/etc that we've got" is worthwhile.

thanks
-- PMM

