Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790ADC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565282173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565282173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVAI-0007Zb-L2
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58717)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbT49-000587-ST
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbT48-0002FB-EI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:59:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbT48-00028a-7R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:59:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so21561089wrs.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gFOqdrZd47041/Q02yi0KtBOf5WklkdzwQJQebdxAxc=;
 b=Q+yEn32dxmvIpWn7TP06Qgj9KJJrY2Q0Qovgm1OreI0FTN6zg38vnY0+d1G4ayunDD
 zaRw3Cj3OvM02nx1PYq/s0OcpVA/q8A2X+bS2SQIen6CQKn5dJelghVkcbuybz3cq9S3
 V7nyBoy4K5EdrdjLrLONZtejG9eaNHbdJa7RX5+8ITJX/AhwuGgo9CV3Nzpj0TvicNfI
 pd7xaSLZqIm+6ai3ZayLrQzA7BJCKcuEPcMpgDFfNvOBu4oVNuSPyR2BJL+Zm1YKCgO/
 UyWGdHhoCikNAKjW7VIiFgc3+cv2585SFnqBO+wL0hXXUw63slPnQfGXJCZx2hKdUj+i
 qb0Q==
X-Gm-Message-State: APjAAAX9QoHTvCfqeANM6haz2Hx7+AZoEsJUP9G6XgqmVYC6eOaswxaV
 ydlWnjLUlrBd11dQrfwag9RDXA==
X-Google-Smtp-Source: APXvYqz2ff4EnNb0wlJPh25F6JPC147q7jlWU8GeVZLokygvhYFUbPNlGkXwpeNDrALuYjSuS34b8A==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr50662799wrq.331.1560445147143; 
 Thu, 13 Jun 2019 09:59:07 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t6sm569195wmb.29.2019.06.13.09.59.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:59:06 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20190311003052.13778-1-philmd@redhat.com>
 <20190311003052.13778-6-philmd@redhat.com>
 <ecd8aaf1-f75e-abd0-48b1-e80a227f01c3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <19958c32-2df9-cccf-3f05-c2fa0fe3dec2@redhat.com>
Date: Thu, 13 Jun 2019 18:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ecd8aaf1-f75e-abd0-48b1-e80a227f01c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 5/5] .travis.yml: Build and install EDK2
 roms
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 3/12/19 5:29 PM, Laszlo Ersek wrote:
> On 03/11/19 01:30, Philippe Mathieu-Daudé wrote:
>> Add a job to build and install the EDK2 platform firmware binaries.
>>
>> This job is only triggered if the last commit matches the EDK2
>> name (case insensitive), or when tag are created (such releases
>> or release candidates).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  .travis.yml | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index e942175dd3..628cc52c99 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -258,3 +258,24 @@ matrix:
>>      - env:
>>          - CONFIG="--disable-system"
>>          - TEST_CMD="make -j3 check-tcg V=1"
>> +
>> +
>> +    # EDK2 roms builds
>> +    - if: tag IS present OR commit_message =~ /(edk2|EDK2)/
>> +      env:
>> +        - CONFIG="--disable-system --disable-user --prefix=$PWD/dist"
>> +        - EDK2_BUILD_OPTIONS="--quiet --silent"
>> +      script:
>> +        - git submodule update --init roms/edk2
>> +        - make -j3
>> +        - make -C roms efi -j2
>> +        - make install
>> +      addons:
>> +        apt:
>> +          packages:
>> +            - dos2unix
>> +            - gcc-aarch64-linux-gnu
>> +            - gcc-arm-linux-gnueabihf
>> +            - iasl
>> +            - nasm
>> +            - uuid-dev
>>
> 
> Regardless of what problem we're trying to address with "--quiet
> --silent", those options are wrong. You certainly want detailed build
> logs for the case a CI job fails (at build time or at runtime).

On Travis we get:

The job exceeded the maximum log length, and has been terminated.
(https://travis-ci.org/philmd/qemu/jobs/545329905)

So I moved to GitLab, but we still get:

"Job's log exceeded limit of 4194304 bytes."
(https://gitlab.com/philmd/qemu/-/jobs/230772314)

Regarding the options to pass to edk2-build.sh,

$ build --help
  -j LOGFILE, --log=LOGFILE
                   Put log in specified file as well as on console.
  -s, --silent     Make use of silent mode of (n)make.
  -q, --quiet      Disable all messages except FATAL ERRORS.
  -v, --verbose    Turn on verbose output with informational messages
                   printed, including library instances selected, final
                   dependency expression, and warning messages, etc.

'--log' duplicate the output, and I don't want to reduce the log
details, so I understand I should use:

  ./edk2-build.sh [...] --log=build.log >/dev/null || cat build.log

Is that correct? But then I'd need to modify Makefile.edk2 to redirect
stdout.

> The reason why I only include DEBUG firmware builds in the edk2 bundling
> series is similar -- RELEASE builds lack DEBUG messages and ASSERT()s,
> and as such they are 100% unsupportable in my book. Bugs in software are
> the norm, not the exception, so we should allow (even force) the user
> (and remote systems) to provide as much information as they can.

Sure, we have the same book here ;)

Regards,

Phil.

