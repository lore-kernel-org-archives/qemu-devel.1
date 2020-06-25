Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B8DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A9D206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FT70HuM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A9D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRC8-0002HX-Lg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRAS-0000RS-H8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:39:48 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:41031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRAQ-0004zJ-Lg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:39:48 -0400
Received: by mail-oi1-x22e.google.com with SMTP id a21so4792226oic.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0FciK1+sCRDz5881gAehpvhUcwMVOSku1r8KjtXPsTs=;
 b=FT70HuM4D8JyuA9nQxFIgoUpLZu9xyAN0P9tP51SFslQ2P5o9thGmAioZ6MYQfAr1O
 cgvZM6U1GLvP4ml7VGhnixiI8i08Q9E48ogFYU4zB5A1aF2GaEV0Z+JQSSiswmK4mAtF
 Ni5O54qLnlSbfYIVcMYNb8Ee7sCB5waQMjHpr72A7FwnYjItcVCj2I69G2reGJJyLWME
 M9Q2P1G6wkxDBNaBeD6xRTlkGZoFfyn0yMCHWqNaeODEGrh01YVlsJwp+/pdu+OpPj4H
 KLf5FrgLoYMbidUueUef8nbR+RdnWEc/WbtJt0g18ZYEiV3tqw09rixG3R+tYtVx+Mr5
 HtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0FciK1+sCRDz5881gAehpvhUcwMVOSku1r8KjtXPsTs=;
 b=W75s2gcbXBumfffaXEL9MEc33pcLzsGpQpEczWrfkDGR/ixdj8n+WSzIpGYQ1Y5h5T
 YRdlntTsNsE1mFJTQvRd4g6Jm/8IAmpzKQ/GK/Wn3+O9Mv+sH20xx+GhVZvE8bzQJMFL
 Ck4bbJnvOGJMshen381NABMcN1JlGU7KKYClM63+IzlRpymafdDDYaotlCx5/YvKodSp
 7RijGqcBOMNLmCdvF90OU01il7AmMUkF3w3/RmUdG/0w4vnRy2kbZ2iKOiznwR0mpmD+
 W6CZ+hwQ45ADxu/SOs+l0SobyNXSmKU93DQZ/sYaf5jVVS2M4voVuj1kxkup6XuwM6Zk
 /l5A==
X-Gm-Message-State: AOAM530KIdNDou0TNmXagWLG+gn2Lfc4LW9vbjgQmaCSV7CSJkHxjv5h
 eHDukv1z9SwKV+DqfzoD0eCjM9a5HTEaF19J847gr0Z73mk=
X-Google-Smtp-Source: ABdhPJyAhMhoEfFgI8yFaDs4M+W/ZcUv/5XmwENJHA6acoLGq7k7SzzDBChq9N6IPdX1qL2QIgOHNoyU+BJEATtekW8=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr1977776oia.163.1593088785588; 
 Thu, 25 Jun 2020 05:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142326.2349416-1-armbru@redhat.com>
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:39:34 +0100
Message-ID: <CAFEAcA9wN+LCcVUwYNxXvbH0ZRpCqCh8Gtb0pKYBB7NDEdNKpg@mail.gmail.com>
Subject: Re: [PULL 00/16] Qdev patches for 2020-06-23
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 23 Jun 2020 at 15:24, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 61fee7f45955cd0bf9b79be9fa9c7ebabb5e6a85:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-testing-20200622' into staging (2020-06-22 20:50:10 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qdev-2020-06-23
>
> for you to fetch changes up to 953cd66139b6e28fdc7cdbf28065a0a98ce7877c:
>
>   sd/milkymist-memcard: Fix error API violation (2020-06-23 16:07:21 +0200)
>
> ----------------------------------------------------------------
> Qdev patches for 2020-06-23
>
> * Reject clash between -drive if=floppy and -global isa-fdc
> * Deprecate configuring floppies with -global isa-fdc
> * Deprecate -drive with bogus interface type
> * Reject drive property override instead of screwing up
> * Reject chardev property override instead of screwing up
> * Various error handling improvements
> * Extend iotests/172
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

