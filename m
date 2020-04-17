Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623DBC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E77A20936
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDVKmx7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E77A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPSAN-0002UA-Cz
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 10:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPS9f-0001rI-Bi
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPS9d-00068i-U8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:39:42 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPS9d-00068M-PJ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:39:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id k21so1587884otl.5
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uxlKud17Uh/JE1mXX5DzuYbWjTMgUf6k6sjjaPtZFQA=;
 b=pDVKmx7CzzuK3velurjFZ7qL7BVAltivJG+weNzQqZG6yusty55C08F2PanVZc412V
 4xw8b43K/W5B2ZwmnD/BfSdXw9w/g2XgC9SGMn6omMyvPYrS36mXQUL6zFqb9tFwLFEn
 9EQHYtyWq9MnfqVWAcg/QfbgJ7kt8cx+I1LpwP3w/cUZ5nX9VNNFd5AXw1g1Uo0RQGWx
 5PXUHiznIEhKwgD7f88quS6mcPqy8XP1ZLBitvlgXwBjaxvj2l1vfCj+3tTXweATbNIj
 u4TnZPsM8wjKxla1SEW3wVDl7ock7RxfDWRrUBf6uSUNiM1msFZtHyoFDYBVQttQ2y22
 5qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uxlKud17Uh/JE1mXX5DzuYbWjTMgUf6k6sjjaPtZFQA=;
 b=qUtQgCdVRr/yZCErlVPEAatd6wp+4vpN4lnjwi2WHJzqnqtNvZQV+Pxilp665BXZGo
 jLSMXvfA7XhGXg3LLtKfoUpkKoK15KymBVIt/YDKgdHMZEEmdrEiKVREbDu99vL5u67i
 DQbS3ZUdr5G63vLh8C42J9lOyNyATSUnI8pX4x5PDaCRGb4CNDHCNbiDdTiN6pFzXtwC
 CpHR+egcFQubXy1Bq56nHaAl0AMSZP3lKJ0+Py95U9DMG10fDh38K10Tht1TDWXjCcZ6
 PuSF5e0jA0nJ3A8EOiL0wCKDR2olgP53A6voY5rK0IoY/G/lQBVwb1nyh2V5OQTXePn1
 nxBQ==
X-Gm-Message-State: AGi0PubAHxOxix/dH1MtPCJlMc3VWnvPzMjv9diy9Xf+uknTgsTcwLr7
 LfyrHuiQEZUQoQt4gMYjIZmuj1jLUnhq5om1eZyxBw==
X-Google-Smtp-Source: APiQypIXtOnyIRMLdc2SUfGcx2e2IOTHbCs2+fMuzfNlTtc0sEdVWllrot6e5F3W9afSPI3WDu7MnqcgNHav2plG3BM=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr2837226otb.135.1587134380882; 
 Fri, 17 Apr 2020 07:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
 <20200406135251.157596-2-damien.hedde@greensocs.com>
In-Reply-To: <20200406135251.157596-2-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 15:39:29 +0100
Message-ID: <CAFEAcA8bA_WoNsT8GEO8ivpmywUPr68XWPHSEK5rXw5LS9Hk8A@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] hw/core/clock: introduce clock object
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 at 14:53, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> This object may be used to represent a clock inside a clock tree.
>
> A clock may be connected to another clock so that it receives update,
> through a callback, whenever the source/parent clock is updated.

> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -27,3 +27,10 @@ resettable_phase_exit_begin(void *obj, const char *objtype, unsigned count, int
>  resettable_phase_exit_exec(void *obj, const char *objtype, int has_method) "obj=%p(%s) method=%d"
>  resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
>  resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
> +
> +# clock.c
> +clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
> +clock_disconnect(const char *clk) "'%s'"
> +clock_set(const char *clk, unsigned long long old, unsigned long long new) "'%s', ns=%llu->%llu"
> +clock_propagate(const char *clk) "'%s'"
> +clock_update(const char *clk, const char *src, unsigned long long val, int cb) "'%s', src='%s', ns=%llu, cb=%d"

"unsigned long long" isn't a valid type to use in a trace event,
it seems: a build with --enable-trace-backends=dtrace will
produce the following warning:

Warning: /usr/bin/dtrace:hw/core/trace-dtrace.dtrace:54: syntax error near:
probe clock_disconnect

Warning: Proceeding as if --no-pyparsing was given.

Using fixed-width types is preferable anyway; squashing in
this fixes it:

diff --git a/hw/core/trace-events b/hw/core/trace-events
index 39301621ce8..1ac60ede6b7 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -31,6 +31,6 @@ resettable_transitional_function(void *obj, const
char *objtype) "obj=%p(%s)"
 # clock.c
 clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
 clock_disconnect(const char *clk) "'%s'"
-clock_set(const char *clk, unsigned long long old, unsigned long long
new) "'%s', ns=%llu->%llu"
+clock_set(const char *clk, uint64_t old, uint64_t new) "'%s',
ns=%"PRIu64"->%"PRIu64
 clock_propagate(const char *clk) "'%s'"
-clock_update(const char *clk, const char *src, unsigned long long
val, int cb) "'%s', src='%s', ns=%llu, cb=%d"
+clock_update(const char *clk, const char *src, uint64_t val, int cb)
"'%s', src='%s', ns=%"PRIu64", cb=%d"

thanks
-- PMM

