Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FEBC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF0024654
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXHhklXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF0024654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itoz4-00081L-8a
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itoyC-0007OI-Nx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itoy8-0007RW-Dj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:33:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itoy8-0007Qw-A9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579595583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gid7cAh5ebvOKVZm10w7tj/W/HZTCXSkcFS96JJyvYE=;
 b=dXHhklXN5cbSDV9ng895zOa83WDYWv4Uhlo2/GWTlXMVmtw1AilrTHtvFUgwK41w+iOUAo
 P9iO59RxUaiK3s7nvOUoKjPTIn6Q7h1tRm/Y4HPerdcEVc1RIeaAkYGF6/P1fQXBKFaavN
 YRwIcXweoHjOXNBQsPrxJURUBKxBQhc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-gT4UQ3G4Nw6cGchKEnSOqg-1; Tue, 21 Jan 2020 03:33:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id i9so993432wru.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 00:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UOaGuYWssLX2F/Uy5zHcYy0xRj3+BckKWZ7UWzhilPw=;
 b=Zf4OYwfITXv6a1YJ9a/F+Pjy58Zf2/S7sijMQwd5Fpvh21uQDOYf4jMewPiWHTR8Jf
 FhqWSTi5v1oyoPTbjm34CgAYmcp9/+G7nIIL+WIepLFOG6yr0plNZNby3fIxWUwdiuJD
 Kx/+RGXXp5oKAPt6JbG0SbfKJhriaqK4qGE5343NmueFKzYcuDbmQj5toyjG9R0Lvizr
 SapBq25M12uex5LiKQbCJ4AApoNDBnIWqQglb5mpD7P4zli4GmcJYE8gNAwqNmFct5rn
 9R2jtAji+OmUqZ/SDtQeudR4fsGU4K1kzHBwRPqZv9dECo/IvipJ1Wfkiw13g/kUAcvg
 O5qg==
X-Gm-Message-State: APjAAAXcgxkFxvlchLhF2wGETMkLuqefwO5PTV8kxWs0O0nV/ByxnhuK
 ES4mfYW4bPw+/I9CmpY3Rv1pouaF3BIovcAMe2A4lZzQnFd8OP624ypNSxGetgyPTWNChfarH0v
 Ef0w+wJynPpuezb4=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr3797876wrs.365.1579595581225; 
 Tue, 21 Jan 2020 00:33:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqznaEtzZ9sqNEPfvPVxKQm/47CgD806cfraQPCFbNfywAsMBFiVb+IvBXTxRYG8oHrROeOQEw==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr3797848wrs.365.1579595580848; 
 Tue, 21 Jan 2020 00:33:00 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id r6sm52609896wrq.92.2020.01.21.00.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 00:33:00 -0800 (PST)
Subject: Re: [PATCH v4 5/7] tests/boot_linux_console: Test booting U-Boot on
 the Raspberry Pi 2
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-6-f4bug@amsat.org>
 <20200121065726.ijnw3lwyrnrzanks@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf1f45a0-af53-c2ec-d9c6-098a9ac3465d@redhat.com>
Date: Tue, 21 Jan 2020 09:32:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121065726.ijnw3lwyrnrzanks@sirius.home.kraxel.org>
Content-Language: en-US
X-MC-Unique: gT4UQ3G4Nw6cGchKEnSOqg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 7:57 AM, Gerd Hoffmann wrote:
> On Tue, Jan 21, 2020 at 12:51:57AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> This test runs U-Boot on the Raspberry Pi 2.
>=20
>> U-Boot is built by the Debian project, see:
>> https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable=
_SD_Card_with_u-boot
>=20
> We already have a u-boot submodule in roms/
>=20
> I guess it makes sense to just build & ship our own binaries
> instead of downloading them from Debian?

Your comment made me realize I pasted the wrong link, I meant this one:
https://wiki.debian.org/U-boot/Status

Maybe the commit description is not clear enough. I don't want to test=20
U-Boot, I want to test all future QEMU releases with this particular=20
pre-built binary, which has been:
1/ built with the proper configuration for the board
2/ tested by someone from the Debian project on physical hardware.

(Goal: catch regressions in QEMU).

The source is available, with build scripts, and reproducible builds:
https://salsa.debian.org/debian/u-boot/blob/master/.gitlab-ci.yml


