Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F4FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 19:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80861206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW9idxut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80861206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2xZ-0006Dh-Ku
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 15:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jz2w4-00059v-VI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 15:00:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jz2w1-0006IT-K1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 15:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595617244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrrIpOSrPaTAvMK0yz2wxOBzlS9ORsR9xO5ziNaN/qk=;
 b=FW9idxut1VBkXbbAOOYeE8N1OHtVyD00i3lOIGGJFihgBLUNS1hM0pEJdD2+lN34gex6Qd
 wglz+jRgC+NXbklBKARNvB5kiwDTKSMDQJBbE1swN+C1krRl6f6RC0eb4CcvAwmYqDOgME
 AiOa09iu8iMcbTBeaLxeKOYPkfjg6ZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-J24eXQV-PR2Mtca75gVzaw-1; Fri, 24 Jul 2020 15:00:42 -0400
X-MC-Unique: J24eXQV-PR2Mtca75gVzaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88DD1801A03;
 Fri, 24 Jul 2020 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-96.gru2.redhat.com
 [10.97.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AB267621F;
 Fri, 24 Jul 2020 19:00:34 +0000 (UTC)
Subject: Re: [PATCH 1/2] tests: Add 'fetch-acceptance' rule
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200724073524.26589-1-f4bug@amsat.org>
 <20200724073524.26589-2-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cf93f6be-c25b-7ba3-96ee-0ab8f6b4b9e7@redhat.com>
Date: Fri, 24 Jul 2020 16:00:32 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200724073524.26589-2-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=wainersm@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Willian Rampazzo <willianr@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 7/24/20 4:35 AM, Philippe Mathieu-Daudé wrote:
> Add a rule to fetch acceptance test assets.
>
> This is particularly useful in a CI context, when a single job
> can fetch and save the cache so other jobs reuse it directly.
>
> It is also useful to measure the time spent downloading the
> assets versus the time spent running the tests.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   tests/Makefile.include | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index c7e4646ded..238974d8da 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -944,6 +944,15 @@ get-vm-image-fedora-31-%: check-venv
>   # download all vm images, according to defined targets
>   get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_31_DOWNLOAD))
>   
> +# fetch acceptance test assets
> +fetch-acceptance: check-venv

This new target misses an entry on check-help.

> +	$(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/python -m avocado \
> +            $(if $(V),--show=$(AVOCADO_SHOW)) \
> +            assets fetch \

Perhaps pass '--ignore-errors' so that intermittent network failurse 
won't disturb the execution (the test will have a second chance to 
download the asset later when it executes).

> +            $(wildcard tests/acceptance/*.py), \
> +            "AVOCADO", "tests/acceptance")

nit: print "Downloading acceptance tests assets" (similar to 
get-vm-image-fedora-32-% target).

Talking about get-vm-images...that target is pre-req of 
check-acceptance, which makes me think that fetch-acceptance should be 
either (for the sake of consistency.) The downside is that - as a 
developer running it on my machine - `avocado assets fetch` will attempt 
to download artifacts even for those tests which I'm not going to run 
anyway. Any opinion?

Regards,

Wainer

> +
>   check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>   	$(call quiet-command, \
>               $(TESTS_VENV_DIR)/bin/python -m avocado \


