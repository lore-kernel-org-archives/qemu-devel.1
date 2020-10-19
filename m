Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1DEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B8921D81
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQUFf6yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B8921D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUPj-0000ua-NN
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUUO0-0007o8-SB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUUNx-00073A-Tq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603110933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMopuLzZHzHEq6LtOVYoJDSWVOgRxf+tChtT3N/02UI=;
 b=WQUFf6yuccFRFjKjqRthFam3GC8rSebjesINr+z8SnML2alX1p82UWDHzu4bBLW94Z3kAq
 HuQ5khEKpTFSXFeKfHFDHctH0Fma0p/rvgWWeImL4cRS8XHXABuKSVhsZ3/85EjL+jMKbj
 7PSsfdt37KjfElwRkOH2R21MoaoBNBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-CUSKuxwQPR-ntJ77ZWiUoQ-1; Mon, 19 Oct 2020 08:35:29 -0400
X-MC-Unique: CUSKuxwQPR-ntJ77ZWiUoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F7E318A0724;
 Mon, 19 Oct 2020 12:35:28 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CE360DA0;
 Mon, 19 Oct 2020 12:35:26 +0000 (UTC)
Subject: Re: [PATCH 8/30] powerpc tcg: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201016145346.27167-1-chetan4windows@gmail.com>
 <20201019061126.3102-1-chetan4windows@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d2a82c0-7c50-938b-c8af-0d24dbd7ebf2@redhat.com>
Date: Mon, 19 Oct 2020 14:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019061126.3102-1-chetan4windows@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 08.11, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  hw/ppc/ppce500_spin.c           | 2 +-
>  target/ppc/compat.c             | 2 +-
>  target/ppc/cpu-models.c         | 2 +-
>  target/ppc/cpu-models.h         | 2 +-
>  target/ppc/cpu.c                | 2 +-
>  target/ppc/cpu.h                | 2 +-
>  target/ppc/dfp_helper.c         | 2 +-
>  target/ppc/excp_helper.c        | 2 +-
>  target/ppc/fpu_helper.c         | 2 +-
>  target/ppc/gdbstub.c            | 2 +-
>  target/ppc/helper_regs.h        | 2 +-
>  target/ppc/int_helper.c         | 2 +-
>  target/ppc/internal.h           | 2 +-
>  target/ppc/mem_helper.c         | 2 +-
>  target/ppc/misc_helper.c        | 2 +-
>  target/ppc/mmu-book3s-v3.c      | 2 +-
>  target/ppc/mmu-book3s-v3.h      | 2 +-
>  target/ppc/mmu-hash32.c         | 2 +-
>  target/ppc/mmu-hash64.c         | 2 +-
>  target/ppc/mmu-radix64.c        | 2 +-
>  target/ppc/mmu_helper.c         | 2 +-
>  target/ppc/timebase_helper.c    | 2 +-
>  target/ppc/translate.c          | 2 +-
>  target/ppc/translate_init.c.inc | 2 +-
>  target/ppc/user_only_helper.c   | 2 +-
>  25 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
> index 25c9ce7..d57b199 100644
> --- a/hw/ppc/ppce500_spin.c
> +++ b/hw/ppc/ppce500_spin.c
> @@ -8,7 +8,7 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
[...]

Reviewed-by: Thomas Huth <thuth@redhat.com>


