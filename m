Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BC7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C744B20731
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDJkIP2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C744B20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3E3-000868-IO
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc36N-00082R-TS
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc36M-0005Ix-0G
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UiU4+vOqQRdeShxxCCByY9nDzcomRRGqCeZkheSqEU=;
 b=PDJkIP2VC9U7rWHEeiIeHQatuz1EOEQ+lBPUWoL8AP26BCNG+2u6NdqNlvcw+HyWJnm4XV
 vznPSrw6yll00MJDEnaojFT7VCyx16sHSajOaI+NPD9BFhhBHIPbpIpd/q4cgl8kg6ncZQ
 Qm+t592lkpUFT2nXxhJNjk+4wyvLsCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-mkVvFqkfNC6-ATUYjJDWUA-1; Mon, 09 Nov 2020 04:04:34 -0500
X-MC-Unique: mkVvFqkfNC6-ATUYjJDWUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434001868425;
 Mon,  9 Nov 2020 09:04:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE6CA10023A5;
 Mon,  9 Nov 2020 09:04:24 +0000 (UTC)
Subject: Re: [RFC PATCH-for-5.2] tests/acceptance: Disable Spartan-3A DSP
 1800A test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201109080747.2408489-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a991b796-0d03-6a2a-1008-6e7d2edc9e54@redhat.com>
Date: Mon, 9 Nov 2020 10:04:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201109080747.2408489-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/2020 09.07, Philippe Mathieu-Daudé wrote:
> This test is regularly failing on CI :( Do not run it automatically.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 1 +
>  tests/acceptance/replay_kernel.py      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 8f433a67f84..010e8790c0f 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -1025,6 +1025,7 @@ def test_m68k_mcf5208evb(self):
>          tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
>          self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
>  
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>      def test_microblaze_s3adsp1800(self):
>          """
>          :avocado: tags=arch:microblaze
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index 00c228382bd..c1f5fa4de71 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -280,6 +280,7 @@ def test_m68k_mcf5208evb(self):
>          file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
>          self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
>  
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>      def test_microblaze_s3adsp1800(self):
>          """
>          :avocado: tags=arch:microblaze

I think this is a recent regression - it hasn't been failing in the past. We
should first try to find out why it is failing now before sending it to the
@skipUnless nirvana... could you maybe add it to the "Known issues" at
https://wiki.qemu.org/Planning/5.2 instead?

 Thomas


