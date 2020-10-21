Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D9C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DD1221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvHLLpfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DD1221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVE8t-000838-PH
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVE6w-0005kl-6B
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVE6q-0003kC-Qb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603286694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9I26L2jWXERTtHkViQEI3YvwkjkBCv5Jhbl2UmrV6Hg=;
 b=RvHLLpfgbxKTr9lEaJvviuaergqW1n7vJA124zxz/Tlj+txYGxIcKfhjfDhOY1beP3UqjB
 q7MZku7YlJc2IuwVAFOVNfx63kFG6LEeXeKPZNFLVJs8Cvukqal9YBb+PbPEydZ0bR3ieh
 foSvwtHtgLVDjstEyUQyEjro3j8e3W4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183--koAV5JnNSS8pqbHx0CvVw-1; Wed, 21 Oct 2020 09:24:52 -0400
X-MC-Unique: -koAV5JnNSS8pqbHx0CvVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B01887952C;
 Wed, 21 Oct 2020 13:24:51 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1908455763;
 Wed, 21 Oct 2020 13:24:43 +0000 (UTC)
Subject: Re: [PATCH v5 00/16] Add a Generic Virtual Device Fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201021010752.973230-1-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb913353-1cf9-53e4-287e-54ab580a4984@redhat.com>
Date: Wed, 21 Oct 2020 15:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021010752.973230-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 03.07, Alexander Bulekov wrote:
> v5:
>     - Replace GArray-based predefined fuzzer configs with a static
>       struct array
>     - "General" -> "Generic"
>     - Fix bugs with wrong timeout denominator and skipping DMA memwrites
>       without QTEST_LOG
> v4:
>     - Replace yaml + c template-based oss-fuzz configs, with C code to
>       register a FuzzTarget for each config (as suggested by Paolo)
>     - Replicate the functionality of address_space_write_rom to ensure
>       matching behavior when QTEST_LOG is enabled
>     - Improve code documentation/comments
>     - Small formatting changes
> v3:
> 	- Use flatviews to help select regions for fuzzing 
> 	- Meson-related changes
>     - Add some documentation
> 	- Improve minimalization script to trim write{bwlq} commands
> v2:
> 	- Remove QOS dependency.
> 	- Add a custom crossover function
> 	- Fix broken minimization scripts
> 	- Fixes to the IO region and DMA handling code
> 
> This is a general virtual-device fuzzer, designed to fuzz devices over Port IO,
> MMIO, and DMA.

 Hi Alexander,

this fails to compile in the Gitlab-CI:

https://gitlab.com/huth/qemu/-/jobs/803091952#L2308

../softmmu/memory.c: In function 'flatview_for_each_range':
2309../softmmu/memory.c:663:24: error: incompatible type for argument 1 of 'cb'
2310         if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque))
2311                ~~~~~~~~^~~~~~
2312../softmmu/memory.c:663:24: note: expected 'ram_addr_t' {aka 'unsigned
int'} but argument is of type 'Int128' {aka 'struct Int128'}
2313../softmmu/memory.c:663:40: error: incompatible type for argument 2 of 'cb'
2314         if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque))
2315                                ~~~~~~~~^~~~~
2316../softmmu/memory.c:663:40: note: expected 'ram_addr_t' {aka 'unsigned
int'} but argument is of type 'Int128' {aka 'struct Int128'}

 Thomas


