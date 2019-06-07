Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFABE20657
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFABE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFnW-0007x5-7p
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZFbd-0006rF-3C
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZFbb-0006O4-MV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:12:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZFbb-0006La-Ec
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:12:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so2327620wre.7
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o2axUgPQ7U4YVSrPLMIUbTmUDBGbOntWdk1ZUJzN/d4=;
 b=nJY5v/Vfs1IeQHZYfUT1MI5MX1X0WWdqZuWd/RmFbVBT071QyUkA0dfwSizGCg8fB3
 mazQotclv5OU8pZ60escCXKW3TeH10gnR8u+e6mNq1uBt5Lg/ejLhO0Ju3zfM+fm1fQG
 To5m3PgIflB2Tzz48WajnjqsC5XdrD2HER2Rh0o2DUdr2hdgLZX4AfGLaLA4+H2zS/1P
 3vx83PfhK6aDr2G+e8DGf1RqRn4szW8Z3GDmYyT5hlcUYHi1IxKVasz2Os/kfTjOV7eR
 rTc88491KqbV1muTmcVIMYjRARGifh9gTu/FHxeR81RfdgONADf5eqAr/JBzNYhC2XUs
 wdyQ==
X-Gm-Message-State: APjAAAW+d/SanaX+fqEOdiyl86TSqQZygGtlijWFfNq8W4HiiiPSX9xj
 /9u2NEVkF+6gHdBvy9qTUsgcTw==
X-Google-Smtp-Source: APXvYqxMUEKH4Amg0pT59fGGIwY+Lbenbr25B8ClRHfBeR4LL8Vf9tGMT2s/JjKRAnkYBAB5Cat24w==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr2165174wrm.87.1559916750341;
 Fri, 07 Jun 2019 07:12:30 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id v67sm2142139wme.24.2019.06.07.07.12.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:12:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
References: <20190516144733.32399-1-peter.maydell@linaro.org>
 <CAFEAcA-t=9+zuEOf2uoJAMnpnyAJtpCqe2biWzS6a8nZU0uQOA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3e786246-9d13-36fc-1d1d-e3f9e915d8b4@redhat.com>
Date: Fri, 7 Jun 2019 16:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-t=9+zuEOf2uoJAMnpnyAJtpCqe2biWzS6a8nZU0uQOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 0/4] hw/arm/boot: handle large Images
 more gracefully
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
Cc: Mark Rutland <mark.rutland@arm.com>, Auger Eric <eric.auger@redhat.com>,
 Andrew Jones <drjones@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Drew and Eric

On 6/7/19 3:07 PM, Peter Maydell wrote:
> Ping for code review, please?
> 
> thanks
> -- PMM
> 
> On Thu, 16 May 2019 at 15:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>
>> This patchset attempts to fix https://bugs.launchpad.net/qemu/+bug/1823998
>> which reports that we don't handle kernels larger than 128MB
>> correctly, because we allow the initrd to be placed over the
>> tail end of the kernel. AArch64 kernel Image files (since v3.17)
>> report the total size they require (including any BSS area that
>> isn't in the Image itself), so we can use that to be sure we
>> place the initrd sufficiently far into the RAM.
>>
>> Patches 1 and 2 are new since v1; patches 3 and 4 are the old
>> patches 1 and 2 (and are basically unchanged since v1).
>>
>> Patches 1 and 2 in this series are new. Patch 1 fixes bugs
>> in the existing code where we were assuming that we could
>> treat info->ram_size as the address of the end of RAM, which
>> isn't true if the RAM doesn't start at address 0. (This
>> generally went unnoticed thanks to the magic of unsigned integer
>> underflow turning end-start calculations into very large max_size
>> values for load_ramdisk_as() and friends.)
>> Patch 2 adds some explicit checks that we don't try to put things
>> entirely off the end of RAM (which avoids those accidental
>> underflows).
>> Patch 3 in this series adjusts our "where do we put the initrd"
>> heuristic so that it always places it at least after whatever
>> our best guess at the kernel size is. (This might still not
>> be right for images like self-decompressing 32-bit kernels, where
>> there's no way to know how big the kernel will be after
>> decompression.)
>> Patch 4 makes load_aarch64_image() return the
>> kernel size as indicated in the Image file header, so that for
>> the specific case of AArch64 Image files we will definitely not
>> put the initrd on top of them.
>>
>> thanks
>> -- PMM
>>
>> Peter Maydell (4):
>>   hw/arm/boot: Don't assume RAM starts at address zero
>>   hw/arm/boot: Diagnose layouts that put initrd or DTB off the end of
>>     RAM
>>   hw/arm/boot: Avoid placing the initrd on top of the kernel
>>   hw/arm/boot: Honour image size field in AArch64 Image format kernels
>>
>>  hw/arm/boot.c | 83 ++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 62 insertions(+), 21 deletions(-)
>>
>> --
>> 2.20.1
>>
> 

