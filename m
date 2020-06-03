Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15E420679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxR+tQ/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15E420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgX7i-0001Zg-2e
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 13:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgX70-00017Q-Ex
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:23:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgX6z-00014s-9q
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:23:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so2689811wml.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yhxeWLhEw2RsBVbhaf1RUvMUftInCkJbTY7N92c3cK4=;
 b=YxR+tQ/CjoeHrV/xvzDYuGu0jcuxOrdJHO86ju8kwilAkH1VImnoGAmAyBuX74yBhG
 QibQ1+F4fIId8pS698NlbD2zkPGpqULfwpm2BoQCsW6uHZoJmkkMwJNtJ8awOuA8NYU/
 Dy8UboYK2q1NRrwwNIeECSko3Sc7gAKeRBZNTWInZLnOnC5aJMH2VQ/x5G8+lXYlr57L
 GZ7Ar4PlTgojqV7O2AfBQUPFlxxRyl5S106dl08gkLdNmu30pROZggdtcLSys/3+1U8Q
 XLaTg4JOXzwNN64nitB9ltqv73yDa2rAllL2efVN4VzWzEom2i0XLR7fEvor6xFugpuN
 gnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yhxeWLhEw2RsBVbhaf1RUvMUftInCkJbTY7N92c3cK4=;
 b=kDO3LpUUpgvnQekUBxwvy9qfAk5dKAk8VAZaFrrRKKU6P4lIqFtX8HW8ftdKTnGHBu
 rjPHlH2MWdrhrdJMYhoGuSx7UzzBatnHjLLHdfr+XE1RMvHtxQAQ+b6W3MgqlEk+omSh
 if9j4kzcdShzan0iyXS3M5myEXvBgp5MkSyObXdbPueAqBlHI1wM3JZC1ksBWDrtItPu
 wSCWTAFplgOCiHZLiUw/Al4HMxuKZ0hBW2MVXk6G9n2YqjH0hqCoaL5Rzjj6FZrCdJYj
 SULQ4cwjEjmd++GioPwm9lTTINgFGp/gadj9ZmgZvDOnSgG+OTj63zl908jUYnoylFwg
 aWLA==
X-Gm-Message-State: AOAM5325oNWQPb3/7G8WAtYm0FoYvfBESF0RXzztHkUIX58/uuIyEHxs
 FHgY2PryXY/jBFhwJhTYrPrSeQ==
X-Google-Smtp-Source: ABdhPJyNF66LIVE5JdrIZ6S1+8zZMqaRaUh4qnIpEqdGcNSOMOdVfm6pLsGDadbW/8TTvlI0/Cyxeg==
X-Received: by 2002:a1c:bc0a:: with SMTP id m10mr176283wmf.173.1591205010289; 
 Wed, 03 Jun 2020 10:23:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q1sm3634662wmc.15.2020.06.03.10.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 10:23:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 265141FF7E;
 Wed,  3 Jun 2020 18:23:28 +0100 (BST)
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-9-alex.bennee@linaro.org>
 <CAFEAcA-kPZoumxfLgjxPfCPDmPgsAFCjB-zdicsiGeqSOPOH7Q@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 8/9] plugins: new hwprofile plugin
In-reply-to: <CAFEAcA-kPZoumxfLgjxPfCPDmPgsAFCjB-zdicsiGeqSOPOH7Q@mail.gmail.com>
Date: Wed, 03 Jun 2020 18:23:28 +0100
Message-ID: <87lfl45ai7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Robert Henry <robhenry@microsoft.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Peter Puhov <peter.puhov@linaro.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 2 Jun 2020 at 16:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> This is a plugin intended to help with profiling access to various
>> bits of system hardware. It only really makes sense for system
>> emulation.
>>
>> It takes advantage of the recently exposed helper API that allows us
>> to see the device name (memory region name) associated with a device.
>
> This feels like we've let the plugin API get slightly more
> access to QEMU's internals than is ideal. Whether an area
> of memory happens to be an IO memory region or a memory-backed
> one (or whether a device is implemented with one region or
> three, or what names we happened to assign them) is kind of
> a QEMU internal implementation detail.

I'm not so sure it's that much of an implementation detail.

The distinction is between plain RAM and everything else. The details of
the everything else is opaque but the name we pass is public information
(you can get it from "info mtree -o") and you can certainly infer useful
stuff from it. For example the virtio-pci-notify areas are regions of
access that will trap on a real hypervisor so allow us to measure how
many vmexits some software might cause.

At the moment I do make up names for regions that get re-generated due
to "reasons" (I never quite understood what the region code was doing
under the hood). Maybe we should only export names of devices the user
has explicitly tagged with -device foo,id=3Dbar?

What should we do about the offset? Most devices export several regions
and there is no reason why those regions should all be together in the
memory map. Does just exposing a physical address make sense here?

--=20
Alex Benn=C3=A9e

