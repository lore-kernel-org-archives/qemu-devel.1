Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9083F2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mLGbdNuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9083F2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4FW-0007kL-HO
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1kL4Es-00071X-Lz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:51:14 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f]:32795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chirantan@google.com>)
 id 1kL4Eq-000882-Mk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:51:14 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id c17so15366882ybe.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yrw24KSUKB5un7ypzoyzMi3gtuBjd4drCZP05BGVyRE=;
 b=mLGbdNuQuUo9/i9Io2a5XDaSipZG1M5EjNQ3i3ZQihTvTEcDGTI4dunkRY2zas7b1n
 3mN1GwTwS6MONmC9hjS1wol02Zy7s4WPqCaBkXh70pVBBy1Et/sZ+tdYCoiARYdrkogK
 cXfnGucEeAPmI8BehP2PDLQS8Qp4jTEcQXH3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yrw24KSUKB5un7ypzoyzMi3gtuBjd4drCZP05BGVyRE=;
 b=qyssh95xhMTwpIgCWiGjyVlM9anQLWdnYzMmvGXlHnDf5cVLS57iN83cbhaElJnqiw
 5uSBJijd2S854DHFB4QREDpAHtPI3VVAfh5uBygsHUf015wyGk+rJILRR7RdEZpG+x7E
 SM3ISFw86yaJSR1S8RAmDskHwkSRD9fgcuBy213ZPwAt5JsDqVY/PQcSvRJpLGFOGpBD
 qdeyJlcMerMsn63Xx499+kKWJeGKRitvr2J1VTfApmzZJGV/DUy13a8LufgpRe3/ivTo
 gHpN1DlJuOtrZLQVVCeXM+0J3r18jtxUUzLn3gWh8Q8gGqQA7BxdXG6CtsfA6T/Ez0eq
 Nerw==
X-Gm-Message-State: AOAM530CCZvO5lrVrFAmrXTsKbM+vL0urqw4Vw3yE3VtF6N/BfPd0Qoa
 g9OTxTQw9xbib/7SrRpk9zrd69msHxlI4W72oSKs3A==
X-Google-Smtp-Source: ABdhPJw3ozvdMOJ+kqoR0SZs9QNMq9zfLTo6P6aUSUvbZj+aSJGxo81sKqxKnC8iWkj12INSuXOOaEXVVYBG9usPVb4=
X-Received: by 2002:a25:16c4:: with SMTP id 187mr14481211ybw.496.1600865470183; 
 Wed, 23 Sep 2020 05:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200918213436.GA3520@redhat.com>
In-Reply-To: <20200918213436.GA3520@redhat.com>
From: Chirantan Ekbote <chirantan@chromium.org>
Date: Wed, 23 Sep 2020 21:50:59 +0900
Message-ID: <CAJFHJroSeg=Zk1VaHBzwurNTkziFzupiiVf_Y-2TDQ7nmdAERg@mail.gmail.com>
Subject: Re: [Virtio-fs] tools/virtiofs: Multi threading seems to hurt
 performance
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=chirantan@google.com; helo=mail-yb1-xb2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -104
X-Spam_score: -10.5
X-Spam_bar: ----------
X-Spam_report: (-10.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 19, 2020 at 6:36 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi All,
>
> virtiofsd default thread pool size is 64. To me it feels that in most of
> the cases thread pool size 1 performs better than thread pool size 64.
>
> I ran virtiofs-tests.
>
> https://github.com/rhvgoyal/virtiofs-tests
>
> And here are the comparision results. To me it seems that by default
> we should switch to 1 thread (Till we can figure out how to make
> multi thread performance better even when single process is doing
> I/O in client).
>

FWIW, we've observed the same behavior in crosvm. Using a thread pool
for the virtiofs server consistently gave us worse performance than
using a single thread.

Chirantan

