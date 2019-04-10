Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F9C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B492206DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B492206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEF0Q-0005fB-H1
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:19:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEEw6-0002Bq-CL
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEEra-0002Pm-Bm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:10:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEEra-0002NS-1u
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:10:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so3426093wrd.3
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 08:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VWCdYuIv8A8sotIdH42gPUWzgFmGL7v+5Ac3ulYJ28E=;
	b=j4l1GcprRM0iURvwPy6eiQz3pM5JXHY+XfBdJCj7hkCHptKK/7IHhcH3kD0kUA2dVk
	0+CIf83XpFELMG36KzcNnZroeFetRUkcqa+a9jfd0FFJU+7oE/I2J4hl1vZg9C79aGuE
	8YBIN127WsrcUgaIviSAk2QBTN9fG/8NrQlXGyVNEjhRB5PlPH0lgoyOPTWv6BJHenDu
	VrXIUR+w7N2Wq5tQ+5ne5j7V7pChpbD0eu9ieVy6qkAZm9Ws2+YTXA9TcfSggR4KVQYK
	V4N4LsiSNl+MHHOHHU9PR+zemAbebT7D/1IUT/IsHH0HrW4zOc94z9NO8NasOUcMa2H/
	+2HQ==
X-Gm-Message-State: APjAAAVRs9hyeiZ7MWgudrd01WtBgt2MxvmfNzCTPFST7mhF1cStTOVl
	RYwLv5B6pw0TKhxNFqj+ktClvsPSJes=
X-Google-Smtp-Source: APXvYqxgPicNvyJbC6lzKwFGvIUv6X0jKndBsxpgjaGTUi5cTys8u2ce98GOPhoULpGdZiY4uYDETw==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr22626188wrs.256.1554909008364; 
	Wed, 10 Apr 2019 08:10:08 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	j9sm43143556wrr.93.2019.04.10.08.10.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 08:10:07 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
References: <20190410045707.16923-1-philmd@redhat.com>
	<e52ff725-a297-5b3c-af7a-1df30baf464f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <94d17504-2366-c5c9-59ee-a958e9dc0b82@redhat.com>
Date: Wed, 10 Apr 2019 17:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e52ff725-a297-5b3c-af7a-1df30baf464f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-4.1] roms: Correct the
 EDK2_BASETOOLS_OPTFLAGS variable description
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410151006.3K34AdbEm8u6q62Zoujr0Gz6a-CWGOA0DrSMx2W16_A@z>

On 4/10/19 4:58 PM, Laszlo Ersek wrote:
> On 04/10/19 06:57, Philippe Mathieu-Daudé wrote:
>> In commit 1cab464136b4 we incorrectly described the
>> EDK2_BASETOOLS_OPTFLAGS can pass CPPFLAGS and CFLAGS
>> options to the EDK2 build tools, but it only expands
>> the CFLAGS (not to the CPPFLAGS).
>> Update the description to be more accurate.
>>
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  roms/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/roms/Makefile b/roms/Makefile
>> index 1ff78b63bb3..d7fd6025e7c 100644
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
>> @@ -120,8 +120,8 @@ build-efi-roms: build-pxe-roms
>>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>>  
>> -# Build scripts can pass compiler/linker flags to the EDK2 build tools
>> -# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
>> +# Build scripts can pass compiler/linker flags to the EDK2
>> +# build  tools via the EDK2_BASETOOLS_OPTFLAGS (CFLAGS) and
>>  # EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
>>  #
>>  # Example:
>>
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Please noone submit a pull request with this patch (for 4.1) until my
> edk2 bundling series is merged; as this one will likely introduce
> another contextual conflict, and I'd *really* like to avoid another
> rebase on my end, due to such an issue.

Thanks for the review. I'll rebase it on top of your 'bundle edk2
platform firmware with QEMU' v4 and resend (later). Feel free to include
it on top of your pullreq.

Regards,

Phil.

