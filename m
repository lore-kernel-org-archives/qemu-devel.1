Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ABEC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119BD20A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjQX4jD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119BD20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWfy-0004Ev-SD
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYWeo-0003Zf-5D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:49:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:39801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYWem-0003M6-6z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:49:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id bn26so9251221ejb.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lbwiXabgS/xZTH7WYhHmXi1q0VlqxcwZjYfNrLvZgCg=;
 b=UjQX4jD3EViQIjIehqb9a4mrDMYBRh3DRVY+lMyX5IMFjRlCM3nKREp8bca3AmHh9d
 s1FeoqBnHOmNLVZPK5UiMCxwczMrWzAgOAro1MmS8UOy27ofYUOadwuuTP7uczgU8Agz
 PXzRLwYWhpc2a/ojX1sH0j0AjOZS3AcGjdRJ/CB+1uqOGkDvfwisuv/hbna2h7wM6a5R
 Qe0xdmkIbTPUgUSf6UNdtrRWw4IHhD9bLMJTeiYSnVBjlJ2YJKrgam99MjG7YbXgqCpy
 oIo8IEhjt+ACAjxfDBFlOWi64BOycbAXV4B0ygcGqZM5YXbwTjcaLfisst30qbK+sinO
 3Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lbwiXabgS/xZTH7WYhHmXi1q0VlqxcwZjYfNrLvZgCg=;
 b=IZ65ZhRK8S93Fn8k43DPXfhmr2fjqZ8v+wgZLvy7Ii8J5up3E2hWAvgtJPt4r8AbgN
 1++csvpaolcxvxULI+eKuZpZchb5+pKZMDFJTZMkg/Ao0NEZxyDP4Ro8YUY7DtLFQvAh
 sNrwr6mYHutJDKViQ04Ytwz+U0KhNdtdyV/Sy3jI1DEcxIGGYOE/Fq3Vnof/3tA0AghX
 KSet4ljxMQnWjr6/2pUXsZSBBlFgcBuDUeSa9Fv/xryexN5E0Che/iJA965V4H43z/2g
 vMHJTWXbjE+XYZA+QlXbuxmWyiDC3INLuDMxuBmtkd/rUktoV8Hrypr8DDfnnNKjFQM1
 uPAA==
X-Gm-Message-State: AOAM531Vj3wO6v2ANx06ZVNP4TE8soFS9rpBklRN0G3VRsgQGmgquQ6G
 Kldj4NLAvgVo4ClYeLdd3WrmcfcnRAHq/5iZrb48rw==
X-Google-Smtp-Source: ABdhPJxwNqFCCxI6X08bEagka8oGJGRLJALZhlpOCQBTxD9miutIIlfzWF3HnbPbxaFnj54HykGStzwwd1dZv3lCwE8=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr3038426ejk.407.1604072974496; 
 Fri, 30 Oct 2020 08:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201027151515.213565-1-kwolf@redhat.com>
In-Reply-To: <20201027151515.213565-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 15:49:22 +0000
Message-ID: <CAFEAcA8TDd-in0=OD+JkBJaWJbWvnPbxJ6Af3uCx=6BXB4RoUA@mail.gmail.com>
Subject: Re: [PULL 0/5] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 15:15, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit d55450df995d6223486db11c66491cbf6c131523:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201026a' into staging (2020-10-27 10:25:42 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1a6d3bd229d429879a85a9105fb84cae049d083c:
>
>   block: End quiescent sections when a BDS is deleted (2020-10-27 15:26:20 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Skip copy-on-write when allocating a zero cluster
> - qemu-img: add support for rate limit in qemu-img convert/commit
> - Fix deadlock when deleting a block node during drain_all


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

