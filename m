Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0411BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 06:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26B22065C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 06:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3eIZ3Vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26B22065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhpDw-0008Gn-1v
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 02:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhpDE-0007P9-H4
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 02:55:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhpDD-00041z-5O
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 02:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591512917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=6Wl1295Iuw8D9zbWj7u9ezJOVGmPby/nmBhpDJ9KVU0=;
 b=E3eIZ3Vnepod/ajTlhp4gC/+HFu4b+ZG+WRgngz7c4yiLkKjFiZ0GPr4RQsv5yyJBwhmlh
 nrUsYs+w/xWOCp7vr3Wt8Dy7YLX2rldVOqRt5FMJ3ukKlRVdCzLBCn+g5qechEPPh+Dye4
 cnDrzNNGZvMawO/4Tpz0P7IY3gGMmz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-WL2wV3ygO1ikLpztVQ3LcQ-1; Sun, 07 Jun 2020 02:55:16 -0400
X-MC-Unique: WL2wV3ygO1ikLpztVQ3LcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28F55107ACCD;
 Sun,  7 Jun 2020 06:55:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5AA385;
 Sun,  7 Jun 2020 06:55:14 +0000 (UTC)
Subject: Re: [PATCH v1 00/14] various fixes for next PR (testing, vhost,
 guest_base fixes)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200605154929.26910-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f6d93916-b950-4688-3826-5c4de4cc033d@redhat.com>
Date: Sun, 7 Jun 2020 08:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 02:36:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/2020 17.49, Alex Bennée wrote:
> Hi,
> 
> These are all the patches I've currently got which are ready for a
> pull request next week. I've included some patches which are destined
> to go in via other trees so I can keep the testing green on the CI.
> 
> In summary:
> 
>  Some simple plugin cleanups (the reset remain in plugins/next)
>  Reliability fixes for travis/shippable
>  iotest 194 fix (going in via block tree?)
>  docker updates (ubuntu and tricore fix)
>  vhost-user and TCG fix
>  more linux-user guest_base fixes
> 
> I'll certainly include the testing stuff in my PR but if others are
> happy for me to include bits touching their areas then shout and I'll
> include them in the PR.
> 
> The following need review:
> 
>  - linux-user: detect overflow of MAP_FIXED mmap
>  - linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
>  - linux-user: provide fallback pgd_find_hole for bare chroots
>  - tests/docker: fix pre-requisite for debian-tricore-cross
>  - hw/virtio/vhost: re-factor vhost-section and allow DIRTY_MEMORY_CODE
>  - .shippable: temporaily disable some cross builds
>  - exec: flush the whole TLB if a watchpoint crosses a page boundary
> 
> Alex Bennée (10):
>   tests/plugin: correctly honour io_count
>   exec: flush the whole TLB if a watchpoint crosses a page boundary
>   .travis.yml: allow failure for unreliable hosts
>   .shippable: temporaily disable some cross builds
>   tests/docker: fix pre-requisite for debian-tricore-cross
>   hw/virtio/vhost: re-factor vhost-section and allow DIRTY_MEMORY_CODE
>   linux-user: provide fallback pgd_find_hole for bare chroots
>   linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
>   tests/tcg: add simple commpage test case
>   linux-user: detect overflow of MAP_FIXED mmap
> 
> Emilio G. Cota (1):
>   qemu-plugin.h: add missing include <stddef.h> to define size_t
> 
> Paolo Bonzini (1):
>   docker: update Ubuntu to 20.04
> 
> Philippe Mathieu-Daudé (1):
>   scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as special header

What about Philippe's "tests: Remove unused bison/flex packages" v2
patch series from May 15th? I think you could include it here, too.

 Thomas


