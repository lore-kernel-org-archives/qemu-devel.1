Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD5BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C29720708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQOsBkn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C29720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWyY-0006pA-MN
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtWxd-0006Dg-At
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:51:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtWxb-000620-Bk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:51:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id f2so2438524wrp.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=y+bVLnS6oBhp/NEDTw2sL3QeOkr612rrOy3X55FoDaw=;
 b=oQOsBkn9wQQXxBy0hvZzkiMDUUe+4tKsgJNc5+w+VXoMBFaihr/GzYYnuUEWMXiEnF
 jRhD2/CXMfZtZfsLdHcro40/leqoDW8oX36XznTtnBo1bSRUSptfRTh7pQqqnaRiPTZK
 3XZN+fqrinfsWkGnd/JwS0Y7iZCta2awnwfAeLMItqwTjA+2GZSjp7LcPRjfkqRvV8WG
 kfbAdD7bvG0fW4YdruR9rhOzdNCg11CoPRNxlTne4s32ZYC+pJm9/DLvZ6fW/JKGJ3r6
 RaWP3KRsXLaMmr14UKBX5l230z185TyGIc+OxeZnx9Oqz5M0DN/b8/4WPIYf0fXK77X0
 /liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=y+bVLnS6oBhp/NEDTw2sL3QeOkr612rrOy3X55FoDaw=;
 b=kK7RiDQoRJs3ynqg0BYmSHac02kWX51zLN0zXvXOt7g3lkdv9OOu7DMWi3p4VgX4G9
 fy5t+yr7yUPTchk4OmETvbIc5FUJ8lwWmRE97odmiHhYYgbAK2r8QKr5cJLPl9Gq+iF1
 cDxG4hcglJu0Ou4aHL2lAYAK8mcwPYWw2iEU1T0pSTe3VOjIDt24WGklhy+aVl5Q/4nd
 80TctRKzzymSkPs60wUZiDMYjiwOxI4DUFwz0e/Q8HHnNlA/H1wyNbqjoFsmqjpdFO1O
 J195tEkCRdmJU6ZQV1zPpi44/3BiNm1umXh047lHd3y//Q/8PlpEHs/5XD5/GQ2TmQpG
 V6PQ==
X-Gm-Message-State: AOAM531IxAAeDg47BCjtmIOxgZsz+rNyf4np3r/3dkROLZDii9DRqOOg
 RoMYRRTKC0a1R///fKI9GjhjRg==
X-Google-Smtp-Source: ABdhPJyxur4OKWBzO1LV4UsrweH2lNAWxzmpW9uWenZLNgI9RM+bhr6bkH5l5PZYb2hef3zjN44TUg==
X-Received: by 2002:adf:8462:: with SMTP id 89mr62380946wrf.420.1594302693492; 
 Thu, 09 Jul 2020 06:51:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n16sm4844096wmc.40.2020.07.09.06.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 06:51:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C8601FF7E;
 Thu,  9 Jul 2020 14:51:31 +0100 (BST)
References: <159357217483.1717.4076077243388027502.malonedeb@chaenomeles.canonical.com>
 <159426310588.27029.9451813776430828516.malone@gac.canonical.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1885827 <1885827@bugs.launchpad.net>
Subject: Re: [Bug 1885827] Re: building plugin failed on Windows with mingw
In-reply-to: <159426310588.27029.9451813776430828516.malone@gac.canonical.com>
Date: Thu, 09 Jul 2020 14:51:31 +0100
Message-ID: <87h7ugn6e4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <1885827@bugs.launchpad.net> writes:

> You should then find out why libqemu_plugin.dll.a is not working. It is
> possible though that your linked is calling the import library something
> else, for instance adding a .dll extension to it.
>
> You will have to run a few tests with your linker (I'd just use the
> examples from the stackoverflow links I posted above) to see the name of
> the import library that gets created. My assumption is that some library
> gets created, otherwise the linked should give you an error and AFAICT
> it does not.
>
> Once you find what the import library us, you should be in good shape to
> adapt the above for QEMU. Let us know how it goes!

I did have a go but couldn't get far with the mingw docker images. I got
somewhat distracted yesterday solving the mysterious regenerating
syscall_nr.h problem so I've run out of bandwidth to look at this any
longer. If the two of you find an eventual solution please send me a
patch.

Thanks.

--=20
Alex Benn=C3=A9e

