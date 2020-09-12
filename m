Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ED0C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 19:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCFC207C3
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 19:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCFC207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHAvN-0007ip-Qq
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 15:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kHAuL-00075G-S3; Sat, 12 Sep 2020 15:09:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kHAuK-0005hJ-3H; Sat, 12 Sep 2020 15:09:57 -0400
Received: by mail-io1-f68.google.com with SMTP id z25so14537849iol.10;
 Sat, 12 Sep 2020 12:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H3PuVkyaq8STT91gpAHe0+XPst1XNcG9Sdb03z0auds=;
 b=nA3r51+2D7oJz+hOJehBUmwqiLkt+NaDtIkothwLKvGRz75/bqxRiH5cGst6QxDIn7
 dSX/V/uDZmILFgrg/dp4TAW+XTWIUjjAb235jp0ZAY6XgoeDLIetCOX3DCha9DSLdl9T
 LyObIh+sMTmdY7/sUZ31iqFn4uTRb5O1Z6ZTJq8grj0vNEROrYonPTZRAfOAnROfd48d
 ou51FvkgwSMTjknLRVJ8jfSPpslrD1y3utEGJSL9BE89WkMw7hSINPyjERNoAa+1UI8J
 JnYJAmAXbKYoFEqY922dqzez161pWHtj5Yf0QhxKKq0qoxkUlN6+bDG83j/wVq1WMVzz
 Q7WA==
X-Gm-Message-State: AOAM530my1CxoWfi9h+Dz0RGke+gRUMyA745jK6dV0PGHXbp7bLy/Qqh
 cTRqg9u0hDLUiICF3rrgmhno0BWOOW/Pa2UTFE+xXuM5fO0=
X-Google-Smtp-Source: ABdhPJzhZVWPDbxYg07KBSJA0KOGdEYWGERGWQS6CW4SaFcHMaD8ZHFiQA0rdjhIGb3zKodefU9aYvv/TggpCWULDWU=
X-Received: by 2002:a02:a615:: with SMTP id c21mr6504223jam.106.1599937793862; 
 Sat, 12 Sep 2020 12:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200912114040.918464-1-f4bug@amsat.org>
 <159991113647.32613.1847386236215843361@66eaa9a8a123>
In-Reply-To: <159991113647.32613.1847386236215843361@66eaa9a8a123>
From: Ed Maste <emaste@freebsd.org>
Date: Sat, 12 Sep 2020 15:09:41 -0400
Message-ID: <CAPyFy2B5tfc+j9kw9YafBdNP6m80pG2cGRtUSQTLkeX1GxfGkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] hw/char/serial: Housekeeping
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.68; envelope-from=carpeddiem@gmail.com;
 helo=mail-io1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 15:09:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 12 Sep 2020 at 07:46, <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20200912114040.918464-1-f4bug@amsat.org/
>
> Hi,
>
> This series failed build test on FreeBSD host. Please find the details below.
>
> The full log is available at
> http://patchew.org/logs/20200912114040.918464-1-f4bug@amsat.org/testing.FreeBSD/?type=message.

Looks like a full disk:

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
From https://github.com/patchew-project/qemu
 - [tag update]      patchew/20200912114040.918464-1-f4bug@amsat.org
-> patchew/20200912114040.918464-1-f4bug@amsat.org
error: copy-fd: write returned No space left on device
fatal: failed to copy file to
'/var/tmp/patchew-tester-tmp-b6phottt/src/.git/objects/pack/pack-7bdf4f5a855cab7e92327c9c14876dca81c24a36.pack':
No space left on device
fatal: The remote end hung up unexpectedly

