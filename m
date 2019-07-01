Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8143C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3027E21841
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3027E21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi75F-0000WN-5c
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 20:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41017)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi3n5-00016O-8Z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi3n3-0006DB-BR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:24:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hi3n1-00068N-81
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:24:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so15330191wru.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fs8IGHNa7msEoAlJK4vYEBi/dooGSe5l9rS7/sVbYTE=;
 b=CQh1QBWhcglABUn4pnJHEwSh0RkwGrZln8xbsXp2KrBV4XU3nixwcwwR/CWCi4TN4f
 1Mt0kU36BnCGXWi+tNpdmWO6P3ervyCnqn1t6BdLdsUp8P+dS0jB5vyM1uWDxNguHBoz
 OHcRpfwsKV/hXWNG4jPz86DlpKjbKu6J849KH8QZAioT7F89mqVz1uXwoY+m96cZqbds
 O1Q1KwLGJeuwonJZtaO1DjYt0Jsac2jprxcQzPao/79nFlPIKuZnU5q3tiC25+5C5CrQ
 GwLxQNCDh5E876tjYeaiyq6Vo3KkG+KpR/nUdKX6l55NOPtIFYKiqHiS2uFWdAnj9w9w
 9/Kg==
X-Gm-Message-State: APjAAAW/oXQy8okJpFXOFr9u47W1MD7lVSGZVHbQM1AkabzSK86WxmSE
 ddxOXWth6OW3yiSlqKsdjG1mtw==
X-Google-Smtp-Source: APXvYqzS9lXehrTTBoicGc1+6hCrLepb7FZVKVCxydfmKspAHsfT3nTDwDAdV1zeIm5kKVg35axXcg==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr4471015wrn.52.1562016271397;
 Mon, 01 Jul 2019 14:24:31 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x5sm611308wmf.33.2019.07.01.14.24.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 14:24:30 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20190701153436.16579-1-f4bug@amsat.org>
 <20190701153436.16579-2-f4bug@amsat.org>
 <20190701200856.GA9225@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a8e0f349-9f96-3cf5-9dea-c4cd74cf235f@redhat.com>
Date: Mon, 1 Jul 2019 23:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701200856.GA9225@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tests/acceptance: Add test of
 NeXTcube framebuffer using OCR
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 10:09 PM, Cleber Rosa wrote:
> On Mon, Jul 01, 2019 at 05:34:35PM +0200, Philippe Mathieu-Daudé wrote:
>> Add a test of the NeXTcube framebuffer using the Tesseract OCR
>> engine on a screenshot of the framebuffer device.
>>
>> The test is very quick:
>>
>>   $ avocado --show=app,ocr run tests/acceptance/machine_m68k_nextcube.py
> 
> Shouldn't we stick to "console" here?  I understand we're resorting to ocr
> but the content, for what it's worth, should be the same as in the console
> for other tests.  This allows a common expectation across tests too.
> 
>>   JOB ID     : f7d3c27976047036dc568183baf64c04863d9985
>>   JOB LOG    : ~/avocado/job-results/job-2019-06-29T16.18-f7d3c27/job.log
>>   (1/1) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer: |ocr:
>>   ue r pun Honl'ﬂx ; 5‘ 55‘
>>   avg ncaaaaa 25 MHZ, memary jag m
>>   Backplane slat «a
>>   Ethernet address a a r a r3 2
>>   Memgry sackets aea canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
>>   Memgry sackets a and 1 canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
>>   [...]
>>   Yestlnq the rpu, 5::
>>   system test raneg Errar egge 51
>>   Egg: cammand
>>   Default pggc devlce nut fauna
>>   NEXY>I
>>   PASS (3.59 s)
>>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>   JOB TIME   : 3.97 s
>>
>> Documentation on how to install tesseract:
>>   https://github.com/tesseract-ocr/tesseract/wiki#installation
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> v2:
>> - test fb sizes
>> - handle 2 versions of teseract
>> ---
>>  tests/acceptance/machine_m68k_nextcube.py | 102 ++++++++++++++++++++++
>>  1 file changed, 102 insertions(+)
>>  create mode 100644 tests/acceptance/machine_m68k_nextcube.py
>>
>> diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
>> new file mode 100644
>> index 0000000000..f8e514a058
>> --- /dev/null
>> +++ b/tests/acceptance/machine_m68k_nextcube.py
>> @@ -0,0 +1,102 @@
>> +# Functional test that boots a VM and run OCR on the framebuffer
>> +#
>> +# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import logging
>> +import time
>> +import distutils.spawn
>> +
>> +from avocado import skipUnless
>> +from avocado_qemu import Test
>> +from avocado.utils import process
> 
> Style nitpick:
> 
> from avocado_qemu import Test
> from avocado import skipUnless
> from avocado.utils import process

What is the logic here?

>> +
>> +try:
>> +    from PIL import Image
>> +    pil_available = True
> 
> Another style nitpick, but very minor issue is the use of ALL_CAPS
> variables if they are at the module level.  So that would become
> 
> PIL_AVAILABLE = True
> 
>> +except ImportError:
>> +    pil_available = False

OK.

>> +
>> +
>> +def tesseract_available(expected_version):
>> +    if not distutils.spawn.find_executable('tesseract'):
> 
> Just though of pointing out that there's a similar function in
> avocado.utils.path, called find_command:
> 
> https://avocado-framework.readthedocs.io/en/68.0/api/utils/avocado.utils.html#avocado.utils.path.find_command
> 
> Feel free to pick your poison! :)

OK.

>> +        return False
>> +    res = process.run('tesseract --version')
>> +    try:
>> +        version = res.stdout_text.split()[1]
>> +    except IndexError:
>> +        version = res.stderr_text.split()[1]
> 
> Do some versions write this to stdout and others to stderr?

Yes...

v3: stderr
v4: stdout

>> +    return int(version.split('.')[0]) == expected_version
> 
> This can raise an exception if some other sort of output is
> produced.  How about:
> 
>    import re
> 
>    match = re.match(r'tesseract\s(\d)', res)
>    if match is not None:
>       # now this is guaranteed to be a digit
>       if int(match.groups()[0]) == expected_version:
>          return True
>    return False

I wanted to avoid regex, but OK.

>> +
>> +
>> +class NextCubeMachine(Test):
>> +
>> +    timeout = 15
>> +
>> +    def check_bootrom_framebuffer(self, screenshot_path):
>> +        rom_url = ('http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/'
>> +                   '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
>> +        rom_hash = 'b3534796abae238a0111299fc406a9349f7fee24'
>> +        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
>> +
>> +        self.vm.set_machine('next-cube')
>> +        self.vm.add_args('-bios', rom_path)
>> +        self.vm.launch()
>> +
>> +        self.log.info('VM launched, waiting for display')
>> +        # FIXME how to catch the 'displaysurface_create 1120x832' trace-event?
>> +        time.sleep(2)
> 
> There's avocado.utils.wait.wait_for() to *help* with waiting, but I'm
> not sure about the trace-events.

trace-events can be logged into a file, so as with chardev I'd like to
use a pipe and monitor it in parallel.

>> +
>> +        self.vm.command('human-monitor-command',
>> +                        command_line='screendump %s' % screenshot_path)
>> +
>> +    @skipUnless(pil_available, 'Python PIL not installed')
>> +    def test_bootrom_framebuffer_size(self):
>> +        """
>> +        :avocado: tags=arch:m68k
>> +        :avocado: tags=machine:next-cube
> 
> Here we hit the syntax limitation of the Avocado tags regex again:
> 
> https://avocado-framework.readthedocs.io/en/68.0/api/core/avocado.core.html#avocado.core.safeloader.DOCSTRING_DIRECTIVE_RE_RAW
> 
> I'll look into raising that limitation on the next release, but,
> for the time being, this will need to be:
> 
>     :avocado: tags=machine:next_cube
> 
> The same applies to the other tests, of course.

OK, since there are no warnings, I did not notice.

>> +        :avocado: tags=device:framebuffer
>> +        """
>> +        screenshot_path = self.workdir + "dump"
> 
> Best practice is to use os.path.join() instead.

OK.

>> +        self.check_bootrom_framebuffer(screenshot_path)
>> +
>> +        width, height = Image.open(screenshot_path).size
>> +        self.assertEqual(width, 1120)
>> +        self.assertEqual(height, 832)
>> +
>> +    @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not available')
>> +    def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
>> +        """
>> +        :avocado: tags=arch:m68k
>> +        :avocado: tags=machine:next-cube
>> +        :avocado: tags=device:framebuffer
>> +        """
>> +        screenshot_path = self.workdir + "dump"
>> +        self.check_bootrom_framebuffer(screenshot_path)
>> +
>> +        console_logger = logging.getLogger('ocr')
>> +        text = process.run("tesseract %s stdout" % screenshot_path).stdout_text
>> +        console_logger.debug(text)
>> +        self.assertIn('Backplane', text)
>> +        self.assertIn('Ethernet address', text)
> 
> I haven't tried v3, but I'm curious... is this about the change in
> command line syntax only?  Or do v3 and v4 are able to recognize
> different characters?

Yes, they use different engine.

In short:
"Tesseract 4 adds a new OCR engine based on LSTM neural networks. The
new version is faster and more accurate than version 3. The drawback is
that it is still alpha-level software."
[https://stackoverflow.com/questions/48498465/difference-between-tesseract-3-and-tesseract-4]

Thanks for your review!

> - Cleber.
> 
>> +
>> +    @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not available')
>> +    def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
>> +        """
>> +        :avocado: tags=arch:m68k
>> +        :avocado: tags=machine:next-cube
>> +        :avocado: tags=device:framebuffer
>> +        """
>> +        screenshot_path = self.workdir + "dump"
>> +        self.check_bootrom_framebuffer(screenshot_path)
>> +
>> +        console_logger = logging.getLogger('ocr')
>> +        proc = process.run("tesseract --oem 1 %s stdout" % screenshot_path)
>> +        text = proc.stdout_text
>> +        console_logger.debug(text)
>> +        self.assertIn('Testing the FPU, SCC', text)
>> +        self.assertIn('System test failed. Error code 51', text)
>> +        self.assertIn('Boot command', text)
>> +        self.assertIn('Next>', text)
>> -- 
>> 2.19.1
>>

