Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB4DC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 06:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D002173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 06:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeIhW/XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D002173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwKl4-0001c9-QN
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 01:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwKkS-000168-Ue
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 01:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwKkR-0008RS-H9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 01:53:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwKkR-0008Qn-E1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 01:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580194399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKL9132Az6p0nZnR1vq/tcC+AZJv4+lL3MEYYl/rqbo=;
 b=JeIhW/XXNIUueCoQzhet7zDNFCjxlcWOrSjaUez0JYMOXE7MrPFDHvXuVFq3nqePdSSJUs
 1/6O5/wi0Vl6oHz1UZ3OFC+BGUa02UXQxeRdXgvgTcc3nXisfTdwQLZVzVHjDCFl/AxThT
 JBLXT9vw4AkrHp6pRMyhuRBSKfpWfus=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-ZwRf8A90OP24IBFA54ULjg-1; Tue, 28 Jan 2020 01:53:14 -0500
Received: by mail-wm1-f70.google.com with SMTP id o193so512013wme.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 22:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Obb92N5U1ZdbHAQBGBc5mrueWUHclkw6B/w11+y5W8=;
 b=rgcX7RTpgiqPkFPHpd2dZbcRO+Gz+Dd40YKuDgd/6KGFgGc7nzlW3XDCb4tw3Z2NGK
 eVQUlDIDN6zmMsPLrC4jg2XleoBaA6KGH3N8WdULX6/mxfC2oi1OqYw3uOOysfNU53IF
 57nrAfmKgIw5OsMTwpyJ78drMlBVITlZqBIfatRg+I/SwRSdSZAqUTKvQRlzA6VCwDAZ
 UpOgcG3nOoUktpx1cNtRJrK9vZtiP9Aq0tpjhPexGG57wTG198sWBM4aJoo4dfm+F4pX
 zi3rboue3SQoJ7//l7u4bp1iqe3kPr51YE7Abb3nPd+QzzNK8iCMZjwCMgk51MuzlnxB
 SEyA==
X-Gm-Message-State: APjAAAXDoUsmk33Y6DC6fo5bNICeD49nd4fwRTUSugFn/vOylKseI9BC
 HalCTyJNvm9UDdjd8pqIaSm0tCxDmgr9EOG6r10hqJWoovd3+FHAPGo/+AFQETiL3CYnrCbU8Kb
 a1VNd9P0qJSNZ0UU=
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr2960142wmc.162.1580194393092; 
 Mon, 27 Jan 2020 22:53:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyajVfpIfEHs3BdAjUFRafQrX8B9u0FZNCML5MnRobE1XU9Pp5lSyvUoDezm1esN1zXShnclg==
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr2960093wmc.162.1580194392655; 
 Mon, 27 Jan 2020 22:53:12 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q6sm26172070wrx.72.2020.01.27.22.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 22:53:12 -0800 (PST)
Subject: Re: [PATCH v4 0/7] hw/arm/raspi: Run U-Boot on the raspi machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <773d1201-17fc-40b1-fa9a-06ed03732e89@redhat.com>
Date: Tue, 28 Jan 2020 07:53:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
Content-Language: en-US
X-MC-Unique: ZwRf8A90OP24IBFA54ULjg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

(Cc'ed Wainer from the Python part).

On 1/21/20 12:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Following Laurent report:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg639950.html
>=20
> The SYS_timer is already merged, see:
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dd05be883fc
> "hw/timer/bcm2835: Add the BCM2835 SYS_timer"
>=20
> The first patch should fix Laurent other issue.
> Then few python patches are require to break into U-Boot console,
> and the last patches add U-Boot tests for Raspi2 and Raspi3.
>=20
> Laurent, if you successfully test U-Boot with this patchset again,
> do you mind replying with a "Tested-by:" tag?
>=20
> Regards,
>=20
> Phil.
>=20
> Since v3:
> - rewrote '-smp' fix.
> - tests use Debian 'trustable' u-boot.elf
>=20
> previous feedbacks from Peter on v3:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg655415.html
>=20
> v3: https://www.mail-archive.com/qemu-devel@nongnu.org/msg653807.html
> Supersedes: <20191019234715.25750-1-f4bug@amsat.org>
>=20
> Philippe Mathieu-Daud=C3=A9 (7):
>    hw/arm/raspi: Remove obsolete use of -smp to set the soc 'enabled-cpus=
'

While the first patch is reviewed by Alistair, the rest (acceptance=20
tests) still requires an eye from Cleber/Eduardo.

Can you queue the first patch via your qemu-arm tree?

Thanks,

Phil.

>    Acceptance tests: Extract _console_interaction()
>    Acceptance tests: Add interrupt_interactive_console_until_pattern()
>    python/qemu/machine: Allow to use other serial consoles than default
>    tests/boot_linux_console: Test booting U-Boot on the Raspberry Pi 2
>    tests/boot_linux_console: Test booting U-Boot on the Raspberry Pi 3
>    tests/boot_linux_console: Tag Emcraft Smartfusion2 as running 'u-boot'
>=20
>   hw/arm/raspi.c                            |  2 -
>   python/qemu/machine.py                    |  9 +++-
>   tests/acceptance/avocado_qemu/__init__.py | 59 +++++++++++++++++------
>   tests/acceptance/boot_linux_console.py    | 54 +++++++++++++++++++++
>   4 files changed, 107 insertions(+), 17 deletions(-)
>=20


