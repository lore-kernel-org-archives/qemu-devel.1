Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F0CC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883F6218AC
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSgQhyu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883F6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4zw-0005AA-Kg
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jX4nw-0001bw-Vh
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:20:49 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:32977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jX4nv-0004ON-UG
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:20:48 -0400
Received: by mail-il1-x143.google.com with SMTP id q10so1764229ile.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1PQ1zQ4t+iMGhM0XL17e3vyoRaws04JFW++AeBDNqMA=;
 b=oSgQhyu/QAnOpJuhTk9AOSr8lfLjk8RBSpy/OTg+dvC4swQut2oye5lJgspvl0y9Et
 99RnTdsZo3RSVDZafJqxzChG8YsqoboYEFXFMfZZ6jBnK5bzthYeFeaUR2fmwQhGbUgl
 N2PFjqODsalxHJ9e2D3Wd2yWUG1ZmAPp8VLruvEL9K+3wuOvodG3e7ZDbVHKcdZJv7T2
 xx1ESm4LLzs3wym64mfFcTmdH1PbsVjpG0T3AKpxnZB/Ompu8o9bkyydRQ7yhZET9k+H
 aUY5J0O88u4hKGurpuTTpFUN4HrNi3BWOw5s6auW1rejcPIZx0PkFbakG0I7GqftR66B
 JC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1PQ1zQ4t+iMGhM0XL17e3vyoRaws04JFW++AeBDNqMA=;
 b=LCHorRJtixsJQVKRuM3DOsaEJk/stnyUnDOCwbZi2UhJx53boMm75qBTeWyWtATIcH
 3R9e9q4j/Y80IM8zxU5hp80dDZpGwb+s78Vo2Cv5nA7JP35ZM0h7vC7ip7Tm36/XngTl
 NRNRHCTWH4F0jfgRYUAXz02+88dKWlC+Eli7CutL/f7UyErY5SxdYMn+E536BGXtHlbO
 yBsCwqEgqhcL6dfmAGU0cscv6mg/CrMwuyKKy+U0U0ejBB+ZMRPT3jHOnR+ZkZkHxWFz
 ey9c6Ach7fGSnAtdeCU+xL5S7a00Zlmh1qGfD0NzqALw+MEQsPznD0dxmtg9EKO6NW5+
 ZouA==
X-Gm-Message-State: AGi0PuaPQ1m1QUduAklKrkeCNnLS6U7ZiN34lsVWui/6c9dk6x9sHgqF
 zOpMjy+zMjXYNA0kvvIO6GEqxCDoep0EpLXU4OWcGg==
X-Google-Smtp-Source: APiQypKHw2oomnx3Wp8QXKu05d8p+V31JXcgw4ZDrLaYf5MxnTMYj2NNz4JdUVu3aKrOBiP0OURAlsJasQefP4dTRr8=
X-Received: by 2002:a92:cb42:: with SMTP id f2mr3447717ilq.101.1588951246491; 
 Fri, 08 May 2020 08:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200508062456.23344-1-philmd@redhat.com>
 <9396e0cb-388a-e08e-c066-82a60708ecdc@redhat.com>
In-Reply-To: <9396e0cb-388a-e08e-c066-82a60708ecdc@redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Fri, 8 May 2020 16:20:35 +0100
Message-ID: <CADSWDzvECqOXzusk=tj8r4z-E5CDZn4TNG8PJ5pxLHAn3saOzA@mail.gmail.com>
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=beata.michalska@linaro.org; helo=mail-il1-x143.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 07:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 08/05/20 08:24, Philippe Mathieu-Daud=C3=A9 wrote:
> > It is not clear if dccvap_writefn() really needs
> > memory_region_writeback() or could use memory_region_msync().
>
> Indeed, I don't understand the code and why it matters that
> mr->dirty_log_mask is nonzero.
>
> mr->dirty_log_mask tells if dirty tracking has been enabled, not if the
> page is dirty.  It would always be true during live migration and when
> running on TCG, but otherwise it would always be false.
>
> Beata, can you explain what you had in mind? :)
>
It has been a while ... , but the intention there was to skip the sync
if there is nothing to be synced in the first place - so for performance
reasons. I honestly do not recall why I went for the dirty_log_mask,
as that seems not  to be the right choice .

BR
Beata
> Paolo
>

