Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5717EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2796D206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO7Opu88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2796D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2Q8-00029W-8S
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jz2Oi-0001Fw-Dc
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:26:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jz2Of-0001OS-Vr
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595615176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QY0R2nB7dwg28I3J1Yv5y0fK/rFcXAaX1duxLzMPUqo=;
 b=XO7Opu88H9XtWkOCv5qtVK/iWMiBYHjaQG0hxTpvLdym3w46baS0KRdPA8FCR/952ahTL0
 dAloinK3buPbO7CTJf6zks4tFKQdOygS6hrJ1GGVFjSrY1ns3dJar3ij0rtsipF5fjqaCG
 MXVnh3Bd4RagSTPFlSBaJGnRg2sHlB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-TJ_bwsvWOCilYMfmCvhFsQ-1; Fri, 24 Jul 2020 14:26:14 -0400
X-MC-Unique: TJ_bwsvWOCilYMfmCvhFsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E941F100AA21;
 Fri, 24 Jul 2020 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-96.gru2.redhat.com
 [10.97.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52D6B7620C;
 Fri, 24 Jul 2020 18:26:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] tests: Exclude 'boot_linux.py' from fetch-acceptance
 rule
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200724073524.26589-1-f4bug@amsat.org>
 <20200724073524.26589-3-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a6ef896a-2fd6-605b-eeda-20d679451306@redhat.com>
Date: Fri, 24 Jul 2020 15:26:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200724073524.26589-3-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wainersm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=wainersm@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 14:08:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Hi Philippe,

On 7/24/20 4:35 AM, Philippe Mathieu-Daudé wrote:
> The boot_linux.py file triggers an exception:
>
>    $ make fetch-acceptance
>    AVOCADO tests/acceptance
>    Fetching assets from tests/acceptance/empty_cpu_model.py.
>    Fetching assets from tests/acceptance/vnc.py.
>    Fetching assets from tests/acceptance/boot_linux_console.py.
>    Fetching assets from tests/acceptance/boot_linux.py.
>    Traceback (most recent call last):
>      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/__main__.py", line 11, in <module>
>        sys.exit(main.run())
>      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/core/app.py", line 91, in run
>        return method(self.parser.config)
>      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 291, in run
>        success, fail = fetch_assets(test_file)
>      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 200, in fetch_assets
>        handler = FetchAssetHandler(test_file, klass, method)
>      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 65, in __init__
>        self.visit(self.tree)
>      File "/usr/lib64/python3.7/ast.py", line 271, in visit
>        return visitor(node)
>      File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
>        self.visit(item)
>      File "/usr/lib64/python3.7/ast.py", line 271, in visit
>        return visitor(node)
>      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 139, in visit_ClassDef
>        self.generic_visit(node)
>      File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
>        self.visit(item)
>      File "/usr/lib64/python3.7/ast.py", line 271, in visit
>        return visitor(node)
>      File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 171, in visit_Assign
>        self.asgmts[cur_klass][cur_method][name] = node.value.s
>    KeyError: 'launch_and_wait'
>    make: *** [tests/Makefile.include:949: fetch-acceptance] Error 1

Currently the acceptance tests use Avocado 7.6. I bumped to 80.0 (latest 
released) here and that error is gone. Could you double check?

Regards,

Wainer

>
> Exclude it for now. We will revert this commit once the script is
> fixed.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   tests/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 238974d8da..7c9cf7a818 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -950,7 +950,7 @@ fetch-acceptance: check-venv
>               $(TESTS_VENV_DIR)/bin/python -m avocado \
>               $(if $(V),--show=$(AVOCADO_SHOW)) \
>               assets fetch \
> -            $(wildcard tests/acceptance/*.py), \
> +            $(filter-out tests/acceptance/boot_linux.py,$(wildcard tests/acceptance/*.py)), \
>               "AVOCADO", "tests/acceptance")
>   
>   check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images


