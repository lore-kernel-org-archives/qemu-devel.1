Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB51C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170C720665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKIEOlyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170C720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDhY9-0005sr-8U
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDhXY-0005Rt-Ti
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:12:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30575
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDhXV-0003ET-Pd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599109920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFhlIX/nSqzi9dgApFQkFa4dJI2zcjmtflOCLh2Uj6c=;
 b=HKIEOlypEAucNEtiLiUKaXNaFn0QvQtCyiJnSeq597tr2z8NPYPhAiummygfnhoZ5tum6T
 9Arp6gQqWk0E6AsSyq7kFaG9RhsQVq1mmkXM7F6fx1+6/qLMH73pd28F61Wg33IWgfs7Dy
 a5KVWYPoI7fdWxVKpVApNEIp6V7o40o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-NKov5f3-P9yEUgZ8UlPAqQ-1; Thu, 03 Sep 2020 01:11:56 -0400
X-MC-Unique: NKov5f3-P9yEUgZ8UlPAqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 842851005E66;
 Thu,  3 Sep 2020 05:11:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F29E7EB72;
 Thu,  3 Sep 2020 05:11:51 +0000 (UTC)
Subject: Re: [PULL v2 00/15] Cirrus-CI improvements, and other CI-related
 fixes, m68k
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200902154932.390595-1-thuth@redhat.com>
 <CAFEAcA89Pjp_k5pJh26juFDO1a3M8H_s0+5cGBoZq5v7=ZYing@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cd4a7bf7-c525-1aab-dab6-dcc0d22bf538@redhat.com>
Date: Thu, 3 Sep 2020 07:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89Pjp_k5pJh26juFDO1a3M8H_s0+5cGBoZq5v7=ZYing@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 22.19, Peter Maydell wrote:
> On Wed, 2 Sep 2020 at 16:49, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter,
>>
>> the following changes since commit 887adde81d1f1f3897f1688d37ec6851b4fdad86:
>>
>>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-09-01 22:50:23 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-02
>>
>> for you to fetch changes up to 5e560e07ca396e16150740ae3c46b35a85f59ba7:
>>
>>   gitlab-ci.yml: Set artifacts expiration time (2020-09-02 16:23:55 +0200)
>>
>> ----------------------------------------------------------------
>> * Cirrus-CI improvements and fixes (compile with -Werror & fix for 1h problem)
>> * Two build system fixes to fix some failures the CI
>> * One m68k QOMification patch
>> * Some trivial qtest patches
>> * Some small improvements for the Gitlab CI
>> ----------------------------------------------------------------
> 
> Failures on windows crossbuild and OSX:
> 
> Generating qemu-version.h with a meson_exe.py custom command
> Generating ar with a custom command
> cp: '../../pc-bios/keymaps/ar' and 'pc-bios/keymaps/ar' are the same file
> Generating bepo with a custom command
> cp: '../../pc-bios/keymaps/bepo' and 'pc-bios/keymaps/bepo' are the same file
> Makefile.ninja:5177: recipe for target 'pc-bios/keymaps/ar.stamp' failed
[...]
> This is the same set of errors I got from when Gerd put
> the "meson: fix keymaps witout qemu-keymap" patch in his UI pullreq:
>   https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00149.html
> so that seems like the problem.

Darn. I've added Gerd's patch since it is needed to fix the acceptance
tests in the Gitlab-CI. Could we maybe revert the patch that introduced
the regression instead, as long as no other proper fix is available? The
failing CI is really bugging me.

 Thomas


