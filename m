Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15E5C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9C722276
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9C722276
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUS9e-00039p-9F
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kUS8d-0002cL-Ij
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:11:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kUS8a-0005Jp-Jm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:11:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C45B2B1A6;
 Mon, 19 Oct 2020 10:11:27 +0000 (UTC)
Subject: Re: [PATCH v4 0/3] unbreak non-tcg builds
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201013192123.22632-1-cfontana@suse.de>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <6dc61a89-6173-099d-c813-cb8266a7d485@suse.de>
Date: Mon, 19 Oct 2020 12:11:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013192123.22632-1-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 16:52:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

anything more for me to do here?

On 10/13/20 9:21 PM, Claudio Fontana wrote:
> This series now unbreaks current non-tcg builds
> (!CONFIG_TCG).
> 
> tests Makefiles need to avoid relying on all non-native
> archs binaries to be present,
> 
> bios-tables-test needs to skip tests that are tcg-only,
> 
> and notably the replay framework needs to consider that
> it might not be functional (or its code present at all)
> without TCG.
> 
> Tested ok target x86_64-softmmu on x86_64 host with:
> 
> ./configure --enable-tcg --disable-kvm
> ./configure --enable-kvm --disable-tcg
> ./configure --enable-tcg --enable-kvm
> 
> running make check-qtest
> 
> v3 => v4:
> * abandon attempts to avoid the code duplication and functional code
> in stubs, just providing the minimal changes to get things working.

Paolo, is the latest respin ok for you?

Thanks,

Claudio

> 
> v2 => v3:
> 
> * do not alter the replay api, provide a block wrapper
> instead to call into replay events handling
> or the normal call flow depending on whether replay events are enabled.
> 
> v1: initial RFC
> 
> Claudio Fontana (2):
>   qtest: unbreak non-TCG builds in bios-tables-test
>   replay: do not build if TCG is not available
> 
> Paolo Bonzini (1):
>   tests/Makefile.include: unbreak non-tcg builds
> 
>  block/meson.build              |  3 +-
>  migration/savevm.c             | 11 ++--
>  net/meson.build                |  3 +-
>  replay/meson.build             |  2 +-
>  replay/replay-input.c          |  4 +-
>  stubs/meson.build              |  1 -
>  stubs/replay-user.c            |  9 ----
>  stubs/replay.c                 | 98 ++++++++++++++++++++++++++++++++++
>  tests/Makefile.include         |  2 +-
>  tests/ptimer-test-stubs.c      |  5 --
>  tests/qtest/bios-tables-test.c | 10 ++++
>  tests/qtest/qmp-cmd-test.c     |  3 ++
>  ui/input.c                     | 12 ++++-
>  13 files changed, 136 insertions(+), 27 deletions(-)
>  delete mode 100644 stubs/replay-user.c
> 


