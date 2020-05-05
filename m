Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE2C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72671206CC
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72671206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVsOB-00085l-LS
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 03:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1jVsNW-0007OH-Lu; Tue, 05 May 2020 03:52:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1jVsNV-0001sG-JF; Tue, 05 May 2020 03:52:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E5B42AF2A;
 Tue,  5 May 2020 07:52:32 +0000 (UTC)
Subject: Re: [PATCH] tests/Makefile: Fix description of "make check"
To: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>
References: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <6e63336a-4457-ffde-b5ce-b9985d6a9c4b@suse.de>
Date: Tue, 5 May 2020 09:52:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:07:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 9:29 AM, Huacai Chen wrote:
> The description of "make check" is out-of-date, so fix it by adding
> block and softfloat.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 03a74b6..5d32239 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -4,7 +4,7 @@
>  check-help:
>  	@echo "Regression testing targets:"
>  	@echo
> -	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and decodetree"
> +	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfloat, qtest and decodetree"
>  	@echo
>  	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
>  	@echo " $(MAKE) check-qtest          Run qtest tests"
> 

added Cc: qemu-trivial@nongnu.org

Reviewed-by: Claudio Fontana <cfontana@suse.de>

