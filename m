Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB33EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740E920665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="q2Pt0XuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740E920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZrZ-00009L-Lq
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kAZqw-0007lE-F9; Tue, 25 Aug 2020 10:23:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kAZqt-0003eP-MM; Tue, 25 Aug 2020 10:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=rVccVkWDO7akciBQuWAabiPjaTo3W3ig5RZFBnhCNpA=; 
 b=q2Pt0XuGWAKsayLWOql9mtoZDluJn/VDN8lWUcj71ttBN9DSWEPceAbYWQIy/sITLVNZ3mrsB5ngXdLUyE5nV8uc5B+MMeTUSiZqg3t+517jWeflREXr+gbGLHzlNMdIZeT0DkhagdkjSAjEYxTwpBnn9ItQ77Q+9TUOTI2qTIkXK9V/q3HlREPWTb5xzxZCwrBGEKI/oxxaZp30vYvWIONA+eEMZ5C6lg14rh9z48YBRfmh5SkdpGe7Bz59cCjWogO21Gr5D+YR2PzhjhJFJbhEHaLReJ70HW6nURXW5VsV9+N0t9U82VdPk2rbjf341/g799zBqEfO3JnG+ud0/g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kAZql-0001oe-CO; Tue, 25 Aug 2020 16:22:59 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kAZql-0008VK-2D; Tue, 25 Aug 2020 16:22:59 +0200
From: Alberto Garcia <berto@igalia.com>
To: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [PULL 00/34] Block patches
In-Reply-To: <CAFEAcA-4bgPq2_8c7wo9y_A5Mp1KZ7iLuye5jQMMesXfE+fNhw@mail.gmail.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
 <CAFEAcA-4bgPq2_8c7wo9y_A5Mp1KZ7iLuye5jQMMesXfE+fNhw@mail.gmail.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 25 Aug 2020 16:22:59 +0200
Message-ID: <w51pn7e24ak.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 08:25:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 25 Aug 2020 04:01:14 PM CEST, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 25 Aug 2020 at 09:33, Max Reitz <mreitz@redhat.com> wrote:
>>
>> The following changes since commit 30aa19446d82358a30eac3b556b4d6641e00b7c1:
>>
>>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200812' into staging (2020-08-24 16:39:53 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/XanClic/qemu.git tags/pull-block-2020-08-25
>>
>> for you to fetch changes up to c576fd97d4ca77b5a1a27728df11a61083dbfa98:
>>
>>   iotests: Add tests for qcow2 images with extended L2 entries (2020-08-25 10:20:18 +0200)
>>
>> ----------------------------------------------------------------
>> Block patches:
>> - qcow2 subclusters (extended L2 entries)
>
> This fails 'make check' on the BSDs because it assumes it has a bash
> in /bin/bash, which isn't necessarily true:

I guess it needs to be replaced by '#!/usr/bin/env bash', shall I send
the patches again, or can you fix it Max?

Berto

