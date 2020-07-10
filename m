Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F303C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6BE2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPECvT4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6BE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoTs-0006La-6C
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoSY-0004gJ-Tj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:32:42 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:46472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoSW-0005bq-Op
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:32:42 -0400
Received: by mail-oi1-x22a.google.com with SMTP id l63so4138229oih.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mdzC964z+4Ad4YzDmQH4Zyrz9jFLy/gooZR07QC3hSA=;
 b=sPECvT4qduZLbi8ZgnQo4b6wD7pxNDhcOhJHv2GlD0UdNuDwsAYejXKkJiRFYVJady
 fyef3y4X5ndQD8biZCFogE6m/a5AmZnSsS5T9QgQOfl6M/Mi/RXfU/Z9ukpJB7t4pnGZ
 J4B6eHP8q5jQxYx+gfCEQCmljpR1xAQ34jB5FMAUzghhJAHDMwhT81gsXWgc6RZL/zMn
 /4luABSXCimHSymXaeQ2CeXNVYbrcAqPxDEmVrgo6jA7zszMaOF7WReX2PiTDcysFEPo
 N6k/FEpGAXIK2wZLXu1jX7HZWm8PQcXN2SV+LtR1eJ7opMXtx8obXP7nQNnc5whSy9G7
 evww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mdzC964z+4Ad4YzDmQH4Zyrz9jFLy/gooZR07QC3hSA=;
 b=gQmyErA4qJijTsm8rFHvk5mUsS8DzLWLo85eHXZaM8DoyTAMxX9Ukovez2CGaZhuzt
 ZEWf3c2nr/8JsiN7fzi8mNIMDmn6X5xbYAujNK7UIpHu/FgC12agF/x7APDx8vmw6gr/
 cmESpESS2QKc2SRd9ezjXfnZWylGxw5LkLR/F2X8T/QsayjC5S/dtuXcLAYv0jAn4LVD
 clu++0ShCDd2YzyDkuDohkHlcN/Uchsna8aqTylyadab56n5ihlIjAcfcbTmDfhoaGrf
 pc15Lzrce9to7yWo2Qr8ViHldPsGKIwoEMf6OgL6ZNVUUHSneKhG3zQisxjmZOoj1aM/
 8Viw==
X-Gm-Message-State: AOAM530pBBoeLw54lfBAMWYNVKhmVqRdzTuWjxwM4NBtQvfnj4QzMK+1
 XyRwLJ9jGKHK3jvxXyF9KLkLoieSQZZUHsjztBIV/w==
X-Google-Smtp-Source: ABdhPJxZX14Ma1QMNdDpiqU2MKwIg5Ln0KNaHCRhna5oZ42xnTmTRDlOwSEVrqqXohbqxpMc3ouEhV82I+YFQWPjKXg=
X-Received: by 2002:aca:1706:: with SMTP id j6mr3238762oii.146.1594369959167; 
 Fri, 10 Jul 2020 01:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
In-Reply-To: <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 09:32:28 +0100
Message-ID: <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
Subject: Re: Separate notifications from list messages?
To: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 09:25, Liviu Ionescu <ilg@livius.net> wrote:
>
>
>
> > On 10 Jul 2020, at 11:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > What sort of notifications are we talking about here ?
>
> For example:
>
> ...
> Received: from mg.gitlab.com (74.90.74.34.bc.googleusercontent.com
>  [34.74.90.74]) by smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
>  5f074fb9a33b1a3dd4571072 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
>  Thu, 09 Jul 2020 17:11:21 GMT
> Date: Thu, 09 Jul 2020 17:11:20 +0000
> Message-ID: <5f074fb827f26_7cd93fa34d371dbc1570d@sidekiq-catchall-02-sv-gprd.mail>
> Subject: QEMU | Pipeline #164899134 has failed for master | 3d7cad3c
> Reply-to: GitLab <noreply@gitlab.com>, GitLab <gitlab@mg.gitlab.com>
> From: GitLab via <qemu-devel@nongnu.org>
> ...

Thanks; yeah, I've seen those go past. Do we expect any other
kinds to appear as we make more use of gitlab?

-- PMM

