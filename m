Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A50C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783B2225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TasBjEUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783B2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbJR-000736-Qv
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVbHs-000648-8Z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:09:52 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:46166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVbHo-0000wB-Pv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:09:51 -0400
Received: by mail-ed1-x542.google.com with SMTP id 33so1891038edq.13
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=A6RnPKD5nrsulx6Wyij+u5vuV+2r8ZeZyI6XfMsqmLk=;
 b=TasBjEUZmk+xrRBEJ3XRYHRFWapaPFyzj7KlOakSw9vW75lMoxesBAJ+Q3eA/Kg2YZ
 mlkBEfLRtCWQRNaAFWcFRHlhcWBW8StmNm4WLPohye+S7Jb87CPRaQLsKIBZ5gky5NGu
 ZUV641F53KcIN4LP1NBdtxOygg2snCcyN5RNVmlcNfK4v2c7asUcjeU1Xw/PUGCHoW3k
 uhQhSGjgh+7vC88oGvP3gcj2HAd9hVb5pDb9XeDaHI4G5VLEwKhFd2H08O2mKsa5vW3c
 woXQ41cMXENXUujZNf1bq2gJt10AGStEGlo+CB42Cz8WhIRKxhwaxK4LCoLTL2K4rp7U
 g01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A6RnPKD5nrsulx6Wyij+u5vuV+2r8ZeZyI6XfMsqmLk=;
 b=If4RwnJ5y5om1fJiy1YSP0h3s/7hxNGMZ8OjMfvcHNdf5xkKhW7ydIGDE9bmHLA/NW
 ZpEP9ZydCy2VLlC54B6fH3YqSUUyGtc1ZvhPf7bVQ+xMM3tP8xWTmzWz2Wo04O6hDVNu
 IFTYKJxxbtRIK3tHFLXkbxZxYzenXtQ1TMewBrYUAMT6xq/VeoYihAKK4RkuTwLSdndX
 V3QgaWL4Xk/SNzEFXtWywMTvNS8hpwNljDZTdlY3aYMNIkqxvtCTk37W2jJFU6sqF1Rt
 hpIq3VjukEk0mDmYbzJ5mmBw+6VvvcSzTfwtTIdVMYsNpnb4oSyPZudQbbcu57tXFHhy
 FwZA==
X-Gm-Message-State: AOAM533Seg6EPEXMIWLd8AvyjLIckxjRSTiCK1voLI+y1Agu+868Ka3S
 h3EEOM3+8qXLYPTpmFVbzYMongqoEUVqzf/zlcEbxA==
X-Google-Smtp-Source: ABdhPJzFtTkf19zNA0OUOLmb5Eecpr186setuYKuElr+mlXe0cb478qPnJMXLofHvVyEtwsnEzL7qpH5QEUe2gi7Mes=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr1169661edw.204.1603375787017; 
 Thu, 22 Oct 2020 07:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201022112726.736757-1-stefanha@redhat.com>
In-Reply-To: <20201022112726.736757-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2020 15:09:34 +0100
Message-ID: <CAFEAcA9WzoaXp9Q8NWNhDT=v-spR2P=U=F0FV2baOZM89O5BtA@mail.gmail.com>
Subject: Re: [PULL v2 00/28] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Coiby Xu <Coiby.Xu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 at 12:27, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit ac793156f650ae2d77834932d72224175ee690=
86:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
01020-1' into staging (2020-10-20 21:11:35 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 32a3fd65e7e3551337fd26bfc0e2f899d70c028c:
>
>   iotests: add commit top->base cases to 274 (2020-10-22 09:55:39 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Fix format string issues on 32-bit hosts [Peter]
>  * Fix qemu-nbd.c CONFIG_POSIX ifdef issue [Eric]
>  * Fix missing eventfd.h header on macOS [Peter]
>  * Drop unreliable vhost-user-blk test (will send a new patch when ready)=
 [Peter]
>
> This pull request contains the vhost-user-blk server by Coiby Xu along wi=
th my
> additions, block/nvme.c alignment and hardware error statistics by Philip=
pe
> Mathieu-Daud=C3=A9, and bdrv_co_block_status_above() fixes by Vladimir
> Sementsov-Ogievskiy.

Fails to link on FreeBSD, NetBSD, OpenBSD, OSX:

ld: error: undefined symbol: blk_exp_vhost_user_blk
>>> referenced by export.c:58 (../src/block/export/export.c:58)
>>>               block_export_export.c.o:(blk_exp_add) in archive libblock=
dev.fa
c++: error: linker command failed with exit code 1 (use -v to see invocatio=
n)

thanks
-- PMM

