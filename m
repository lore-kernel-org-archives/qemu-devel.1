Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ABCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1246520866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKdC4hWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1246520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4011-0007S1-8R
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k4002-00067o-Fi
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:53:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k4000-0004Lo-Ky
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:53:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so1274232wrw.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EcuxzxynhJwL07asSwWpkdz5NoWLR/MWQ85EN2KvyX8=;
 b=lKdC4hWCKK/obhDpK+xJlo7nMxX1fm//WKA2EmpExko+Ghl9iC5FgWQW9ShEEZ/3aT
 wIHKveeQJ3yMR47zVzDe3y1be1r2ya2e8qJmGmAt5U2SKaq9DSkthfEtbXgbLjGJDLNi
 5xi5erjF4ZPCJHsoP8MNrAletN0/j/neIMDO72LmHcXSk3PHzNVVwvNo4SWjxYHlB84D
 MIbhIAPBstiqEEyfKOKJU8o+q4p+Y2cw9LjAFLNVCB42yFFT049dzeor397GC21SB+Sk
 XMU6C/1AosIc/KrLvyEKnYKvsg5Us/ZgG4ifpWomwrM5BA/pZGe9USvdgUvRih4ols1U
 MmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EcuxzxynhJwL07asSwWpkdz5NoWLR/MWQ85EN2KvyX8=;
 b=SmyP0rWs0T2A56ahZBcLF+8ENoEsI0dnL9+B0/0o+w2DRkzV+zCwLoYnTDMN4e4ncp
 9P6ao7gU1wHLSVO6BjDPghdqGeeXAHNIOUlANOHFElZp/TCK54O16WuP0M37GDputG+l
 jnsGa6dpWs3JF3slY8BmTOOua2XckdxRZdl2q5mBRB184S8pz0seZBapgjl+Iz+Ky0DC
 jY8B6qtGTXkSYAfaRovSStlOvartTfd6qwyUotZ/Xh5b4nVweGrfatWVqZZAF3yXySQ5
 yDdO6q7lPEF6xhcZNzho+BQvTr4G6BP05xvDnesss9fpXcf7TUd5T9dMbD76WTi2H6Q5
 Pv2g==
X-Gm-Message-State: AOAM531m0ybJfE96Mj8a+EmUOPpef7tdC7+6dOk55VwEdgYBJUMz3Pjp
 C655jnG56CQ7rTJHMq+1iDh0kg==
X-Google-Smtp-Source: ABdhPJxrzDk7zlFn3zoMckQHjgasDN3BIgjS8F75/RN5VhPK/Ju3pKIxwKElVauZSPXnRYn5oKUZwA==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr12032677wrs.27.1596797598755; 
 Fri, 07 Aug 2020 03:53:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v29sm9880900wrv.51.2020.08.07.03.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 03:53:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A4BCF1FF7E;
 Fri,  7 Aug 2020 11:53:16 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org> <20200807082206.GC120942@redhat.com>
 <CAFEAcA8U=Wxx8Z7E2gcwYEhyV_EiCBX3o+FxdxTa9-bvS7rM-Q@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
In-reply-to: <CAFEAcA8U=Wxx8Z7E2gcwYEhyV_EiCBX3o+FxdxTa9-bvS7rM-Q@mail.gmail.com>
Date: Fri, 07 Aug 2020 11:53:16 +0100
Message-ID: <87pn82k9r7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Aug 2020 at 09:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>> In terms of testing I'd suggest the minimium bar is likely the GitLab CI
>> and Peter's merge scripts.
>
> I tried running it through a build test. Fails to build, all hosts:
>
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all=
dbg'
> config-host.mak is out-of-date, running configure
>
> ERROR: Meson not found. Use --meson=3D/path/to/meson|git|internal
>
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alld=
bg'
> make: *** No rule to make target 'config-host.mak', needed by
> 'meson-private/coredata.dat'. Stop.

I note all the CI jobs have failed on building as well. I think maybe we
should auto-default to --meson=3Dgit unless the user makes an explicit
choice.

>
>
> Can we make this Just Work ?
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

