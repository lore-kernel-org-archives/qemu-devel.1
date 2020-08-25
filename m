Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C65C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EBB2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CS5Ab7FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EBB2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAfGd-0006yM-7u
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 16:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAevx-0006Vd-5v
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:48:41 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAevv-0001FE-1c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:48:40 -0400
Received: by mail-ed1-x543.google.com with SMTP id l63so9270643edl.9
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dsi0k3LiXq1wdbsEyjkW1xBGD+Z9JUm69f3Wd3VNb0M=;
 b=CS5Ab7FJ8/U8rJnquFMYWtvYOq0zzmcCrS27PjhcsBxyZSo5e9QfTab+FwLkpuAibw
 i6o76o+IrLnAON3tSzUYoqLXMvzgq/I949Vvd6dgSp1l3jW11041p0wopYUXILNkoNPL
 deQwgdHIpjJ6BHtPckTDTJWlmI8otAEUoJgKV0UJ5PpJmSXit41sDg1470LwV+s40xf6
 dJvfoAqCurVfzizUzHsoUDmP7GnNRyEAiOa90R8mvyMKhYFh6YrX6unA5M20Qy/9op+T
 3sTg6Z0dOf0oKMK2+f4Z9mtsMyjaMmwxWlMF/L6VfnwEnBNatf2mcfC/WWT+6HOZqKmv
 68Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dsi0k3LiXq1wdbsEyjkW1xBGD+Z9JUm69f3Wd3VNb0M=;
 b=HPhAUuUzfIxhDViM7Ba01hKxnVn4JaLa5QvYpRj/WGYPqje+3TTav8XD0kzwYZnV0g
 4u6mintVWTkBGeiZB6YAVvWa4bi04QyjYO0Nvaczt6LC3vVFKDEt3LGVlXdF6MvochBK
 fhVQjR+AZL7Nxd1czRdRn1u771HqpKuAH+qsCh+WCsBrNxrRBkCAb5G0688jWuTY7gAx
 CTa59FfUM1k8FFMXpnZhKhX16QkzmBm8mwCB/3KgRs9TxLNZxXzlI/u1IxtFiJQ0Xafe
 hqdnNR58Hqhghvzk+NPLCGmUueNHfv9uHzpP/pD/r21+7hN1L3PpL9bjGbITtE80C5Lp
 rRmw==
X-Gm-Message-State: AOAM530EbJhv6KDKgQdHy7M9vtA+VL+BzUxtTzun2/kCrjVFd2I3b+5K
 oMc5PQZCF6DaXNXK6P6nvRsrDOXYMPRYW/OH2T7iPA==
X-Google-Smtp-Source: ABdhPJxGkhPbGTdvjIs95s1LOPwxhl4d1GnpATJvAasbsbCvvbi8Kyv9GV5P6zibZgQ6N7B3+c7qoihwBUvJChRqlY4=
X-Received: by 2002:aa7:de0e:: with SMTP id h14mr11516307edv.146.1598384917425; 
 Tue, 25 Aug 2020 12:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200825105234.634767-1-berrange@redhat.com>
In-Reply-To: <20200825105234.634767-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 20:48:26 +0100
Message-ID: <CAFEAcA95M_ODTOCteGR4zybLYQxNtpCPX6j_SUgZMM13a8OwOw@mail.gmail.com>
Subject: Re: [PULL 0/1] Socket next patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 11:53, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 44423107e7b5731ef40c5c8632a5bad8b49d08=
38:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20200821-xtensa' into=
 staging (2020-08-24 19:55:23 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/socket-next-pull-request
>
> for you to fetch changes up to 74a57ddc02c41f8f4bb549cedb107c1086daba58:
>
>   tests: fix a memory in test_socket_unix_abstract_good (2020-08-25 11:49=
:49 +0100)
>
> ----------------------------------------------------------------
> Add support for UNIX sockets in the abstract namespace
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

