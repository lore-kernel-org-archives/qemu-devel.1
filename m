Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A1C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470F62145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/iwS32/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470F62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFD67-0007Ks-9r
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFD5Y-0006mC-VY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:05:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFD5X-00018m-4N
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:05:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id c15so14912741wrs.11
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0LtdfdwVNGUM4kMXLYeo8eZbTFSGOBCWmXRhP6es5pg=;
 b=y/iwS32/E0Sqam0qn6S6DhmJpGDtMEuq2RNPU9IfgqWbt0deXES6wwbLHfU7zXxVUH
 eZxWD4X/Y5sL62PpOvdqMF53NY9HWKKd+9sNhfjXN1/A326Nf6scwCSrVgv0rqs7CFBt
 SdxjJNg/+8zbxqcEyJepf4OUUFkHsRr/j1SbhBNTFVBPtkDw0L8C+ac06KO6Hx9qbpAu
 T7UmavVjFQnJLhuwxk5KkgRlVbD4EOPcrZtLSv1cmsSjINFjGZFLcpRih3chyr4whLxE
 DOLIgdAVySWKJMTIyX2CMKVoh2gl5MeQYfkkd/u0olyR5FPVcSVFzsiSfV/fRoez/Spx
 5kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0LtdfdwVNGUM4kMXLYeo8eZbTFSGOBCWmXRhP6es5pg=;
 b=kf2f1QdlisNDp3gWJKgngVaySVSHeIGTbfTt+FwpCCXZrE0ycLrrspVjc+UcqE7Q5y
 x5k9V6FQrq17rQh3f7Aogv+XroyS4ibd1pb3ORt7iWmOnaS2haaELSdnG/0zanpaMN8U
 vNOOV1tSpsmyO97dlcbiyk34BXA6ZIM4np7SxFJC8BuGQl3vb0NJYHzMe9dmLkv7P1sB
 F/i3FkoTp8WVllEaKoKiVp96Z5oDboyUCaxW2afN7iF7HtqFhQlqfLM/pi458c72bMWa
 /0icmpTwe/ThOJaTtELq/e1yhBkLBSonIXaE2MXtAjVDqjElWtmaUyao0rbmeavp0jkc
 0FsQ==
X-Gm-Message-State: AOAM530F4mlXsdntOEceqRjKv+jdItGZio+JzBtyfZ+qF3fwXZ7S1g9f
 z7rRoURSuGqLvxusXKltMVWTOw==
X-Google-Smtp-Source: ABdhPJx8DE5V0k5nrKMJfUPI0yd7Opu6K7v9Ouzx8cZfwlkXI0j4zNyKRT46bvmlLk1rRYbseldsfw==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr20661236wrp.6.1599469521109; 
 Mon, 07 Sep 2020 02:05:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h8sm27156374wrw.68.2020.09.07.02.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 02:05:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2D3441FF7E;
 Mon,  7 Sep 2020 10:05:19 +0100 (BST)
References: <20200904165140.10962-1-alex.bennee@linaro.org>
 <CAFEAcA9+hoPrkDNg21b03CT=YmTXuOLwKrornYn6J12bZ=B+OQ@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] docs/system/deprecated: mark ppc64abi32-linux-user
 for deprecation
In-reply-to: <CAFEAcA9+hoPrkDNg21b03CT=YmTXuOLwKrornYn6J12bZ=B+OQ@mail.gmail.com>
Date: Mon, 07 Sep 2020 10:05:18 +0100
Message-ID: <87d02yrm7l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 4 Sep 2020 at 17:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> It's buggy and we are not sure anyone uses it.
>
>> +``ppc64abi32`` CPUs (since 5.2.0)
>> +'''''''''''''''''''''''''''''''''
>> +
>> +The ``ppc64abi32`` architecture has a number of issues which regularly
>> +trip up our CI testing and is suspected to be quite broken.
>> +Furthermore the maintainers are unsure what the correct behaviour
>> +should be and strongly suspect no one actually uses it.
>
> IRC discussion suggests we do know what the correct behaviour
> is -- it should be "what the compat32 interface of a 64-bit
> PPC kernel gives you", it's just that the code doesn't do that
> (and never has?). It's like the mipsn32, mipsn32el, sparc32plus
> ABIs which we also implement (hopefully correctly...)
>
> But "this has always been broken and nobody complained" is
> a good reason to deprecate anyway.

What about tweaking configure? Or should I just manually squash it in
all our CI configs?


--=20
Alex Benn=C3=A9e

