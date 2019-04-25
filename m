Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD2C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7927620644
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7927620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJdjp-0005Ya-SP
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 08:44:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdix-0005Ba-6r
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdiu-00076Z-Va
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:43:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJdiu-000757-Iy
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:43:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so3599308wmb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 05:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GMl96XeLZuYf4X6ftrz+G2VzLs6faWMiGWEkBUtNJxI=;
	b=NQp61YY5g5i77CJOu5d/GIJXgxuE3btwtNQULfrR+G8Ce150oJ4V7m935s4Ws1Wz1o
	+bHKjbq4esO9IYNebW0Kza9UF+UO8Tnk6QW/OA6tAnkHQzFnZwZS/e33bwdd5+C8Ogjr
	EDOs14O30bR48lWQ3WDOIi5W2rmMuTnaz1wWe9MI00pZBBrNOSfGVGqZjw1Q3yvuXKNU
	mcBwAMdLO3QPUxZ38Ovh6zZAC61TSpNEqGwzxAU7YVV2e5oI33lmAMWBoqubhKxG2fiL
	yG21r6MnEQyTbnfEqVQCWGhnoqeVK39YN+yzzsRiiAnoyxROqsaR5hPnZjiT9mK29rNf
	zbxw==
X-Gm-Message-State: APjAAAXY/RqcB2IlBkDPAV6CFbLtGPkaJGQ5zPNAyagW6HSeT5KGOnEh
	Y/6Xh+0+4IM982zJKDvfVs8c3w==
X-Google-Smtp-Source: APXvYqxbozEU+/mUHBgJ4y+Hkd3PhVCi0SQbTUyXE9URxv9Cz4/JTOhLu/GsSnDqtDvu19EobmlzSQ==
X-Received: by 2002:a1c:be0e:: with SMTP id o14mr3285286wmf.11.1556196211077; 
	Thu, 25 Apr 2019 05:43:31 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	m8sm11172646wrx.48.2019.04.25.05.43.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 05:43:30 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20190425104326.12835-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0fdbbd5b-0ed3-0f45-8b9d-d5f5f2c76a89@redhat.com>
Date: Thu, 25 Apr 2019 14:43:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425104326.12835-1-lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 0/2] tests/uefi-test-tools: report the
 SMBIOS entry point structures
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425124329.Op2n_Z5ovkYXhxiYNy0ik9vDkEs3GEwMCYp0z15BgZI@z>

On 4/25/19 12:43 PM, Laszlo Ersek wrote:
> Repo:      https://github.com/lersek/qemu.git
> Branch:    smbios_lp_1821884
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
> 
> In
> 
>   [Qemu-devel] [PATCH for 4.1 v2 09/13]
>   tests: acpi: ignore SMBIOS tests when UEFI firmware is used
> 
> at
> 
>   http://mid.mail-archive.com/1553605799-168605-10-git-send-email-imammedo@redhat.com
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07037.html
> 
> Igor had to temporarily exclude SMBIOS unit testing with UEFI guests.
> 
> Let the BiosTablesTest guest UEFI app report the SMBIOS entry point(s),
> so that SMBIOS unit tests can cover UEFI guests.
> 
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> 
> Thanks
> Laszlo
> 
> Laszlo Ersek (2):
>   tests/uefi-test-tools: report the SMBIOS entry point structures
>   tests/uefi-boot-images: report the SMBIOS entry point structures
> 
>  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h     |  25 +++++++++++++++-----
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf |   2 ++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c   |  23 ++++++++++++++----
>  tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2           | Bin 11776 -> 12288 bytes
>  tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2               | Bin 11776 -> 11776 bytes
>  tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2              | Bin 12800 -> 13312 bytes
>  tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2            | Bin 13312 -> 13312 bytes
>  7 files changed, 40 insertions(+), 10 deletions(-)
> 

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

