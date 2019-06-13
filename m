Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A06C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E772F20665
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E772F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVJ8-0005FK-00
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbTjM-0007Bn-FR
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbTjG-0001L2-27
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:41:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbTj8-0000SH-L5
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:41:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so11092187wmf.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 10:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tJ+9Rs7d80992mrXr7JJzTQq3kD/A7E1/jF9jpfblKw=;
 b=PU+mNXw2Hktcz7MRvP9jB505JWYTEQmjFTSNQj5lvW9ABbZ5xtrSY9MQ7snN9FBWcU
 Qme8SCFgq1lQpn9/LutJizYchXRC0VvqsDR53VdrM+VxhhXYVw9HIYP6x5pqyAU5zl5Z
 +pLERPtkPqs3oqHqgbyd4Sy/Q2kcpNtzukaNhCp5O1fHxBo5aGjNr5oMtBqKmfCnk03P
 VMy1vPY5SUXIZY9a3bQep4izVLdzYlUT5VCbK3bJZe4txOr5sm9Q3t0Ze/ElstAw0YjC
 7WxSEkvMcxk7A9erJoHhcZsQ8aXRM4tUo0P1Fq83pTTP3rFM4FiNXMdi+lM4HM2tyxlB
 sdUg==
X-Gm-Message-State: APjAAAXq6TKxlnRGFolutWYsLNDQ2pFSDF81mycUqrBVVLNB7/nNNLJo
 Lfqq8wlXQ3FBFEMc4xnE6hEPprkPw2MBqw==
X-Google-Smtp-Source: APXvYqyF7diO4mrjgJWUdM6qoO/zX+oM8174dAI5TC83upoYis4W3h0wh8omcQj3g/BGGmzvHvvYCg==
X-Received: by 2002:a1c:a648:: with SMTP id p69mr4553658wme.155.1560447672541; 
 Thu, 13 Jun 2019 10:41:12 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id d3sm513738wrs.8.2019.06.13.10.41.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 10:41:12 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>
References: <20190606133110.13754-1-lersek@redhat.com>
 <611d1efd-3052-c98d-e88a-294d07c822ab@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <50d3c5a3-9f7a-ab7d-7421-9608675f1bf0@redhat.com>
Date: Thu, 13 Jun 2019 19:41:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <611d1efd-3052-c98d-e88a-294d07c822ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 0/6] update edk2 submodule & binaries to
 edk2-stable201905
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
Cc: qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/19 5:12 PM, Laszlo Ersek wrote:
> On 06/06/19 15:31, Laszlo Ersek wrote:
>> Launchpad: https://bugs.launchpad.net/qemu/+bug/1831477
>> Repo:      https://github.com/lersek/qemu.git
>> Branch:    edk2-stable201905-lp-1831477
>>
>> edk2-stable201905 has been released today; let's update QEMU's
>> submodule, and the binaries built thereof. This should be the edk2
>> release that goes into QEMU 4.1.
>>
>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Thanks
>> Laszlo
>>
>> Laszlo Ersek (6):
>>   roms/Makefile.edk2: define edk2-stable201905 network feature test
>>     macros
>>   roms/edk2: update submodule from edk2-stable201903 to
>>     edk2-stable201905
>>   roms/Makefile.edk2: remove edk2-stable201903 network feature test
>>     macros
>>   roms/Makefile.edk2: update input file list for
>>     "pc-bios/edk2-licenses.txt"
>>   pc-bios: refresh edk2 build artifacts for edk2-stable201905
>>   pc-bios: update the README file with edk2-stable201905 information
>>
>>  pc-bios/README                         |  14 +-
>>  pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1177603 -> 1178070 bytes
>>  pc-bios/edk2-arm-code.fd.bz2           | Bin 1173662 -> 1172752 bytes
>>  pc-bios/edk2-i386-code.fd.bz2          | Bin 1688659 -> 1736199 bytes
>>  pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1881979 -> 1943949 bytes
>>  pc-bios/edk2-licenses.txt              | 752 ++++++++++++++++++--
>>  pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1669280 -> 1717094 bytes
>>  pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1901210 -> 1958037 bytes
>>  roms/Makefile.edk2                     |  22 +-
>>  roms/edk2                              |   2 +-
>>  10 files changed, 714 insertions(+), 76 deletions(-)
>>
> 
> Ping :)

Oops sorry ...

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

(Definitively not a series you want to test on your laptop...)

