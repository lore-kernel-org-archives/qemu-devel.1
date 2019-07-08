Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED8AC606A1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9A720651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/EI+C9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9A720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkPw2-0008Na-H2
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkPug-0007OD-6S
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkPue-0001dd-G4
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:26:22 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:41215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkPud-0001cP-T9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:26:20 -0400
Received: by mail-ot1-x333.google.com with SMTP id o101so15492576ota.8
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X8q78jn6JanoTAhsBQyowuRiRowJqQ9lzD7506F5mx8=;
 b=U/EI+C9VnD/7+fP3PpoU+tu1Ci3lSJkcPrRYdKPQJVwNPSQwnpsh+2wKhB9O+C1y5E
 tQaKPMGFAy4y+5ARR95RJy6Vq6OnC66FGVtWxo9h8yhCy7S0btFIQFxWxebyzZlz0T/8
 yyqlxqSunioZRXfy5CAHBijLIg0iHE0Ylb/3UY/Yq3x2DJ88Vm0BJBqTAqJHzQKzWHgv
 uqZ7nEl3VHNXXNP6sKyWmqitPQ6+nvV0WFS9JqJZqtlnRUDkOINq/KQLsY6zRSABlvw9
 WwPuK7s214sl46nVZoXD39ze1vw3Pt5DYpvzE7BP3LUBclA8XUizciqG3PGbdmQ94eou
 ZtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X8q78jn6JanoTAhsBQyowuRiRowJqQ9lzD7506F5mx8=;
 b=T5piAeU6L8X6bAZcDuz/hSZ+Cj/KY9hfPiGtPaTA/I88taNRFPK/F2QAlwKaciKzw8
 /xm9MINj6GPlTw9JrD0j9343lHdo06xncPQ4WT0wc/9MkGMqle7hixyH4RJiuydi3+p6
 u9TwpZHXJoUdRNLAO5dxPoZwoxyX91K1ZJQg8t5z5rpqIJ7RKpJw8eZg7EBi0+wpSh1Y
 cYchYMAXXGTR07H3gX84nxMwZdbgl1/bNxC6zuoHZkPuMIBPIOWePr2bEn7ihVlHi9C7
 MeOg28zL/RivEuOfcBTmGIZvltH3su6k8M/jsWjujeJJLbKqCW6JEC/J4HlZVij1S52V
 erpw==
X-Gm-Message-State: APjAAAWrm45xm5zW743n7lz4e8Q4nzkw3FmiEQ6R5+lH/PO6+VRQhigM
 mayAe6Rpn0UwBVmU8BEND3WEv8OrOCBQ/ru9pXPqKg==
X-Google-Smtp-Source: APXvYqzyaAD6/YjAwUZaVCZtqaKxfteH1ub2EYUgSm00DLy0CG9c3nzlR+Mn4SjEt/ICoLFL+xao1RBi9/F1AfEw8Xc=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr13123122otk.221.1562577976631; 
 Mon, 08 Jul 2019 02:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190705221504.25166-1-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2019 10:26:05 +0100
Message-ID: <CAFEAcA-sJ0VDvxUgWO6H6E1kgCU8RVrygcJYpbk_341wwW+H2A@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL v6 00/42] Machine and x86 queue, 2019-07-05
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 23:15, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Changes v5 -> v6:
> * Rebase and solve conflicts with other pull requests
>   (for the 4th time)
> * Included Cascadelake-Server-v2 update
>
> Changes v4 -> v5:
> * Rebase and solve conflicts with commit 374f63f6810a ("Merge remote-tracking
>   branch 'remotes/armbru/tags/pull-monitor-2019-07-02-v2' into staging")
>
> Changes v3 -> v4:
> * Fix ppc64 "make check" failure
>
> Changes v2 -> v3:
> * Fix "make check" warnings (Igor Mammedov)
> * Fix conflicts of "hw/arm: Replace global smp variables with
>   machine smp properties" with recent arm changes (Eduardo Habkost)
> * x86 versioned CPU models (Eduardo Habkost)
> * SnowRidge CPU model (Paul Lai)
> * Add deprecation information to query-machines (Eduardo Habkost)
>
> Changes v1 -> v2:
> * Fix s390x build failure
>
> The following changes since commit d2c5f91ca944aaade642624397e1853801bbc744:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-07-05 16:16:15 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to af135030e3405af5ce234a9f92cf8cc4e55fec96:
>
>   tests: use -numa memdev option in tests instead of legacy 'mem' option (2019-07-05 17:12:45 -0300)
>
> ----------------------------------------------------------------
> Machine and x86 queue, 2019-07-05
>
> * CPU die topology support (Like Xu)
> * Deprecation of features (Igor Mammedov):
>   * 'mem' parameter of '-numa node' option
>   * implict memory distribution between NUMA nodes
>   * deprecate -mem-path fallback to anonymous RAM
> * x86 versioned CPU models (Eduardo Habkost)
> * SnowRidge CPU model (Paul Lai)
> * Add deprecation information to query-machines (Eduardo Habkost)
> * Other i386 fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

