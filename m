Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CC420748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 22:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="F0KTUWRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CC420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3o7J-0000tx-K2
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 18:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3o51-0000Fy-7d
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:09:43 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:46701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3o4y-0002Lu-UF
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 18:09:42 -0400
Received: by mail-ej1-x633.google.com with SMTP id l4so51898765ejd.13
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Hg4coPhuXckIiK0sEwveJdRIcl6wRNlB+PKJz2QH5pk=;
 b=F0KTUWRU025lT3Kozy9d/yJ8c55uZn1z1cwbu+mw1xoBpbc2JFyqdXeqwXHmgZTyk2
 VnTDjcqjYZpnwVpFxtnqgGnaM2bC/zonjP4x/GfSxGJkTfS7CuDTcdfszjxvSH/ITlMT
 gG/5kzwwI3vNWafikZudgZ8nH5Q8LsqA66Xs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Hg4coPhuXckIiK0sEwveJdRIcl6wRNlB+PKJz2QH5pk=;
 b=rydptcG+TYEKetOZI42BCTmi5M3WUZwwCicEC4fAFCOa9yidhhg05LOIbKlqsdiFG9
 2kz4jDJncS2RFLsYqRgI+X1D3ZVfBcJjo7kyc4HLgGQW4ZAlMCEuf9BWnmvxgDFH0y+i
 4YP2leWCSkeHRRgfmLOQffwfsL6NZ8akxE4wAOn7qpkZt8a8IcUGctyuZSW4k79m+U94
 Bkil+ycJhh1RjqYCRM+lKjVkkjDz9l+RtVaRlFw4UjMlNSC53wi/kVCYfA83rQ3brosN
 txQ9s4FpSQQQ0UGFK4SAvHIJfu6rI55dbgKVwwpPa6AXl7jaK5rZ6MK5swKyOeYa7q6A
 e9yA==
X-Gm-Message-State: AOAM53316c8WAwiln+7CNWlljyBoFsEEhLY6YIX+oMpR6XSqjwMxTc+P
 EDnvfWffNs28ZI9sw41mhtgDuHwomXGRLmUAF3U=
X-Google-Smtp-Source: ABdhPJwe+/yqBNnZl9qRisKY5QYOkfoNmv99Ws3CGeTdU2R+I7Pq+h3vBEdqWMugqc7G3BP+g5TTzNCjuiWgJVQBaMU=
X-Received: by 2002:a17:906:7790:: with SMTP id
 s16mr6867827ejm.254.1596751778423; 
 Thu, 06 Aug 2020 15:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <7c834989.1a25.173c17e115d.Coremail.ouyangxuan10@163.com>
 <1f2df783-caf0-a5da-11f2-bb99d006b961@kaod.org>
 <248a1877-66a6-9a4b-f1f0-92819aa9a072@redhat.com>
In-Reply-To: <248a1877-66a6-9a4b-f1f0-92819aa9a072@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 22:09:26 +0000
Message-ID: <CACPK8Xe0bCyksJ8wYA5oWrkZ6+COdQWxai5qHAV0nYxRhE7xqw@mail.gmail.com>
Subject: Re: [qemu]: How to use qemu to run 64MB bmc image?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, www <ouyangxuan10@163.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 15:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 8/6/20 3:54 PM, C=C3=A9dric Le Goater wrote:
> > Hello,
> >
> > On 8/6/20 3:58 AM, www wrote:
> >> Hi Joel Stanley, Andrew Jeffery, C=C3=A9dric Le Goater,
> >>
> >> How to modify it so that QEMU can run 64MB BMC image?
> >
> > You can increase the FW image file size with 'dd' or with :
> >
> >   cat foo foo > bar
> >
> > if the expected size is 128MB
>
> You can use 'truncate' from coreutils:
>
> $ truncate -s 128M image.bin

Nice tip!

(What an obvious name for a tool to extend files)

Cheers,

Joel

