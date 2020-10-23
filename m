Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890ACC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C753220BED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoG0piCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C753220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2N4-0006CH-Lv
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 15:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kW2Kk-0003Lz-3J
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kW2Ki-0004p1-An
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603479750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7vkEwvGVZ+ZOQAVDnVrCDpHlhkd9cUNXxZxH36hNKY=;
 b=OoG0piCDLJlRpQwyTPuCjqR61acvkqcR6bE1SxBQnwoUwHfk3XnikfzFxMxnB2HmRURiyJ
 9LPb76xKRXmwCpGAaeRGv7atrMElVfb78+LVhJc6oeMfp62MFxfZMc1MyG4nPgEJyHq330
 bEZL4ycgky1f8TbujGdQ1EJFABhki2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-2eY_WBCGP7GklX4qlz5WhA-1; Fri, 23 Oct 2020 15:02:27 -0400
X-MC-Unique: 2eY_WBCGP7GklX4qlz5WhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCE84804B7C;
 Fri, 23 Oct 2020 19:02:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5141160BFA;
 Fri, 23 Oct 2020 19:02:24 +0000 (UTC)
Subject: Re: [PATCH 18/30] arm tcg cpus: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201014134248.14146-1-chetan4windows@gmail.com>
 <20201023122913.19561-1-chetan4windows@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0084dc74-f512-c93e-f444-d7cabf820b79@redhat.com>
Date: Fri, 23 Oct 2020 21:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201023122913.19561-1-chetan4windows@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/2020 14.29, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  hw/intc/arm_gicv2m.c            | 2 +-
>  hw/intc/arm_gicv3_its_kvm.c     | 2 +-
>  target/arm/a32-uncond.decode    | 2 +-
>  target/arm/a32.decode           | 2 +-
>  target/arm/arm_ldst.h           | 2 +-
>  target/arm/cpu.h                | 2 +-
>  target/arm/crypto_helper.c      | 2 +-
>  target/arm/gdbstub.c            | 2 +-
>  target/arm/gdbstub64.c          | 2 +-
>  target/arm/helper-a64.c         | 2 +-
>  target/arm/helper-a64.h         | 2 +-
>  target/arm/helper-sve.h         | 2 +-
>  target/arm/iwmmxt_helper.c      | 2 +-
>  target/arm/neon-dp.decode       | 2 +-
>  target/arm/neon-ls.decode       | 2 +-
>  target/arm/neon-shared.decode   | 2 +-
>  target/arm/op_helper.c          | 2 +-
>  target/arm/pauth_helper.c       | 2 +-
>  target/arm/sve.decode           | 2 +-
>  target/arm/sve_helper.c         | 2 +-
>  target/arm/t16.decode           | 2 +-
>  target/arm/t32.decode           | 2 +-
>  target/arm/translate-a64.c      | 2 +-
>  target/arm/translate-a64.h      | 2 +-
>  target/arm/translate-neon.c.inc | 2 +-
>  target/arm/translate-sve.c      | 2 +-
>  target/arm/translate-vfp.c.inc  | 2 +-
>  target/arm/translate.c          | 2 +-
>  target/arm/vec_helper.c         | 2 +-
>  target/arm/vec_internal.h       | 2 +-
>  target/arm/vfp-uncond.decode    | 2 +-
>  target/arm/vfp.decode           | 2 +-
>  32 files changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



