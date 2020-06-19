Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC69C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590EF20776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7GStb/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590EF20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFyo-0005Rr-Ix
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jmFwj-0003nr-5O; Fri, 19 Jun 2020 08:16:37 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jmFwh-0001CA-Gc; Fri, 19 Jun 2020 08:16:36 -0400
Received: by mail-qt1-x843.google.com with SMTP id c12so6929792qtq.11;
 Fri, 19 Jun 2020 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7LS/TugZnjYebNveEdNSU9Kvswcwc/EvpO4Z41+DyVw=;
 b=D7GStb/MTWKkgvYxnfSuwn+JmXTUoe+Mm8Yeyt2mFLMqi01IV51gamnKcz3++wjlXk
 YUtnMwehz22lEHbkmf38mnZGIJyq9S0VaLEX9VZKWYfGD6R6a6IhotjRK/3dCe6Egbtn
 XDmCG64fnIhAt6tLYdM9XhIfLnWNT3K/nhiq8bjeZTnfJ+RMNabQ72+awv+m/G0idZsA
 V1NolRQJhMJ2/XM2ZrukOfldJCHPA9MZYg1rEFxqUfAoYSd4HY+5eqoEb4b0nLdK4MlI
 h7ZonoW3Ly/A63QAHDpj+SRImhzoNlhzyo4wV+M3kZg8gQkyd/vQ9hkFNEuEX5vZtO48
 zlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7LS/TugZnjYebNveEdNSU9Kvswcwc/EvpO4Z41+DyVw=;
 b=lxdH6/4jZZG26vI+kTnrutFpt3/456BVPKg7BJIssQiok30Y3Uq9Si6LpQfjPHO4ej
 H0LNG3JYKCG4gbwgWIrwIs1Z/56KjDeNYpOQzCFc3ecf0VkS0+zv7OjBUY37AXKIAecP
 ClglibrRaPbbbEu1xqsc7o+QGzuwNppu36mvpJHqe54nADsDlGqPmJehg7b/ZS8EZGvb
 9jUBddMeUnxOZVd+Q+3IRAGtmEI7baAT1gQiAUpT2JQF8sjRDpbiJdK8KcC+5Da7MjAy
 iegwojlMpGbMcWCGIzSrQmLLjf1KF4XA8tbQLw0/5JR0+vkaPBIGA/slVyWquBqy5NvE
 uzSQ==
X-Gm-Message-State: AOAM533B8eMEwSFvcnqZe0K7OFPtEBf5uedg8KbSNtTWbKQt7+WRqNde
 5LfMDePJ3TxoJanu/VxMRlugPp/pY5w6NwGnxDND6xBv
X-Google-Smtp-Source: ABdhPJzl80Yw9ZaqyXTwgIyo9Ss+ggelUrwacJFWuoNtn6+ALUdAPwwRg4iVeXwGVVwPpVfnvVYVpD2mwblTnLczSI0=
X-Received: by 2002:ac8:4806:: with SMTP id g6mr2441184qtq.213.1592568992236; 
 Fri, 19 Jun 2020 05:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200619101132.2401756-1-stefanha@redhat.com>
 <159256530289.466.10137557982265811079@d1fd068a5071>
In-Reply-To: <159256530289.466.10137557982265811079@d1fd068a5071>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 19 Jun 2020 13:16:20 +0100
Message-ID: <CAJSP0QWT+a609WD0DaqriUYWfkTvFKKD8s5fgmN05pZpd0jYhA@mail.gmail.com>
Subject: Re: [PATCH 0/2] qemu-storage-daemon: memory leak and --object opts
 fixes
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=stefanha@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 12:15 PM <no-reply@patchew.org> wrote:
> /tmp/qemu-test/src/tests/qht-bench.c:287:29: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709551615 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>         *threshold = rate * UINT64_MAX;
>                           ~ ^~~~~~~~~~
> /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'

Unrelated failure.

Stefan

