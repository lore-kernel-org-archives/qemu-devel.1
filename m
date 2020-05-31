Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA3C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC7E206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WskSRgSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC7E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfTsb-0001r1-2S
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTrk-0001Dz-TJ
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:43:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTrj-0005Xu-Rq
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:43:28 -0400
Received: by mail-ot1-x343.google.com with SMTP id b18so6295741oti.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x+y3DLpMJNh4pXLmnD12TABCn5pXlI+Hr6tlZBko3sU=;
 b=WskSRgSoQT/z+On2pSMAE5RnK+Kf2p1q4hSJXPaWBZPWNgrNmkqR13LyIQUbcIgBKU
 lQfZiwylfY9cucgbKI3MkYoP3CKSmtlJyfh2zr5RV+0txwtEoqV4eXiji3BAAZyBxXuq
 6/Isw7GqXbwHqDBk71IPgI0nA02npfQF3t38wSIGXKIRYi9BpRoDAV4qLoQrjZYZ3Rcl
 XQAf12+ooyVMBnV9GzXn2DPRP+eF0ZfSonbzlAnIHDXwR74P/HSlUwtxWjw5/CykQVA5
 E4MLymxW6G1fFHZLZbNsAcRDUEa7ZQ4mAQjB1w2PVukN6QNaK2Hia6/mdPZnUUcI2maw
 RpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x+y3DLpMJNh4pXLmnD12TABCn5pXlI+Hr6tlZBko3sU=;
 b=flghBx/SWGLSyCUv7SB97Dkup1o+A3h+48PaZDpcAJHXTVZZbzN7aSjzAqEvbQn52T
 eSLPk4JOA06YrZL0xrYaUJhRHVk2ZwCMGbZVtV36MExGm5HvNHAmG4HArbN1+36gsKgQ
 nJAfKMgUR8PQSQRHw4foaVwEAvukzeR9Lt6yN/ElMENOmfeUt5F4dLSRlDvp/KU9t5s8
 GOglofUw49RIHJyIiZDTjViO5EX2PeQGU3rZw2ce6MQLHQ0RI9liNheW8wJtGjfXHCKS
 9NArKhL73GTpI/45Qpf11xCF2Q5oY2BuWKsLycdCqdOg2iSpVId1Te8ToOiFVfMz5Bc4
 w0kQ==
X-Gm-Message-State: AOAM5306TsakfWBOa1nsmblWh1zpvWEmvqizq7XkIAKrtOLYWUJIuFsa
 CpvnqSxGthTipdweJMKef76NR84zkU/LPdjFsS+B3Q==
X-Google-Smtp-Source: ABdhPJyCFBh75DW3ozvS0vwCt8J8R8QlRo7lOwNxWcnUP7FagVy8oeAcS8SdZ6mtpBV/981D1H/ik6m4Wiepc4zMC8c=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr13436625oth.221.1590954206459;
 Sun, 31 May 2020 12:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200528181849.1823820-1-eblake@redhat.com>
In-Reply-To: <20200528181849.1823820-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 May 2020 20:43:15 +0100
Message-ID: <CAFEAcA-PwUiy5Fxu2YzXprzVC4U8c2bGSDfds=3iKU62yJ3d0A@mail.gmail.com>
Subject: Re: [PULL v3 00/11] bitmaps patches for 2020-05-26
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 19:19, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit a20ab81d22300cca80325c284f21eefee99aa740:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-05-28' into staging (2020-05-28 16:18:06 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-26-v3
>
> for you to fetch changes up to cf2d1203dcfc2bf964453d83a2302231ce77f2dc:
>
>   iotests: Add test 291 to for qemu-img bitmap coverage (2020-05-28 13:16:30 -0500)
>
> v3: port sed expression to BSD sed
> v2: fix iotest 190 to not be as sensitive to different sparseness of
> qcow2 file on various filesystems, such as FreeBSD (sending only the
> changed patch)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-05-26
>
> - fix non-blockdev migration of bitmaps when mirror job is in use
> - add bitmap sizing to 'qemu-img measure'
> - add 'qemu-img convert --bitmaps'
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

