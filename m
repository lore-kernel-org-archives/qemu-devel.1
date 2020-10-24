Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2652A2225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwVsSsZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2652A2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWDBD-0003hF-41
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 02:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWD9P-0002sp-Rg
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWD9N-0004S3-Rl
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603521336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySEmJLHWeSKU42XS9iIzCsUHGI2AzPbb/NUjB/VvY7A=;
 b=AwVsSsZFGDm6NHVKaensO1VizfG54w6h/JDW5LGs7/iZSVZHoFxfnzbYSfHgcMtW+KbvpO
 CO56zHa3LdEQUYATLQoq+grH1BfsSjyeSHOK/0Umt6tM3uleVVUsodMn2B2iApx8dNgc6y
 YFcu63bv+YHeRkynw59C3aCKUNIeAzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-i6wFv2RXPKG2JAY10RqjqA-1; Sat, 24 Oct 2020 02:35:32 -0400
X-MC-Unique: i6wFv2RXPKG2JAY10RqjqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DF7B185A0C3;
 Sat, 24 Oct 2020 06:35:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEBFC9CBA1;
 Sat, 24 Oct 2020 06:35:24 +0000 (UTC)
Subject: Re: [PATCH 4/6] tests/acceptance: Introduce tesseract_ocr() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
 <20201021105035.2477784-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0b31c367-f054-ce03-c1f8-d6fb6cbffc28@redhat.com>
Date: Sat, 24 Oct 2020 08:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021105035.2477784-5-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:26:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 12.50, Philippe Mathieu-Daudé wrote:
> We are going to reuse the tesseract OCR code.
> Create a new tesseract_ocr() helper and use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/acceptance/machine_m68k_nextcube.py | 21 +++++----------------
>  tests/acceptance/tesseract_utils.py       | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
> index 3c7400c43e4..09e2745cc52 100644
> --- a/tests/acceptance/machine_m68k_nextcube.py
> +++ b/tests/acceptance/machine_m68k_nextcube.py
> @@ -7,13 +7,11 @@
>  
>  import os
>  import time
> -import logging
>  
>  from avocado_qemu import Test
>  from avocado import skipUnless
> -from avocado.utils import process
>  
> -from tesseract_utils import tesseract_available
> +from tesseract_utils import tesseract_available, tesseract_ocr
>  
>  PIL_AVAILABLE = True
>  try:
> @@ -61,12 +59,8 @@ def test_bootrom_framebuffer_size(self):
>      def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
>          screenshot_path = os.path.join(self.workdir, "dump.ppm")
>          self.check_bootrom_framebuffer(screenshot_path)
> -
> -        console_logger = logging.getLogger('console')
> -        text = process.run("tesseract %s stdout" % screenshot_path).stdout_text
> -        for line in text.split('\n'):
> -            if len(line):
> -                console_logger.debug(line)
> +        lines = tesseract_ocr(screenshot_path, tesseract_version=3)
> +        text = '\n'.join(lines)
>          self.assertIn('Backplane', text)
>          self.assertIn('Ethernet address', text)
>  
> @@ -77,13 +71,8 @@ def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
>      def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
>          screenshot_path = os.path.join(self.workdir, "dump.ppm")
>          self.check_bootrom_framebuffer(screenshot_path)
> -
> -        console_logger = logging.getLogger('console')
> -        proc = process.run("tesseract --oem 1 %s stdout" % screenshot_path)
> -        text = proc.stdout_text
> -        for line in text.split('\n'):
> -            if len(line):
> -                console_logger.debug(line)
> +        lines = tesseract_ocr(screenshot_path, tesseract_version=4)
> +        text = '\n'.join(lines)
>          self.assertIn('Testing the FPU, SCC', text)
>          self.assertIn('System test failed. Error code', text)
>          self.assertIn('Boot command', text)
> diff --git a/tests/acceptance/tesseract_utils.py b/tests/acceptance/tesseract_utils.py
> index acd6e8c2faa..72cd9ab7989 100644
> --- a/tests/acceptance/tesseract_utils.py
> +++ b/tests/acceptance/tesseract_utils.py
> @@ -6,7 +6,9 @@
>  # later. See the COPYING file in the top-level directory.
>  
>  import re
> +import logging
>  
> +from avocado.utils import process
>  from avocado.utils.path import find_command, CmdNotFoundError
>  
>  def tesseract_available(expected_version):
> @@ -26,3 +28,19 @@ def tesseract_available(expected_version):
>          return False
>      # now this is guaranteed to be a digit
>      return int(match.groups()[0]) == expected_version
> +
> +
> +def tesseract_ocr(image_path, tesseract_args='', tesseract_version=3):
> +    console_logger = logging.getLogger('tesseract')
> +    console_logger.debug(image_path)
> +    if tesseract_version == 4:
> +        tesseract_args += ' --oem 1'
> +    proc = process.run("tesseract {} {} stdout".format(tesseract_args,
> +                                                       image_path))
> +    lines = []
> +    for line in proc.stdout_text.split('\n'):
> +        sline = line.strip()
> +        if len(sline):
> +            console_logger.debug(sline)
> +            lines += [sline]
> +    return lines

Would it make sense to completely hide the tesseract version handling in
this new tesseract_utils.py file now, so that the tests themselves do not
have to worry about this anymore (i.e. would it be possible to merge
test_bootrom_framebuffer_ocr_with_tesseract_v3 and
test_bootrom_framebuffer_ocr_with_tesseract_v4 into one single test that way?)

 Thomas


