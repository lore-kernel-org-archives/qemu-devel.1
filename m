Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F7DC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45E02070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmZ8KZXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45E02070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhKg-0002I2-0f
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwhK6-0001sw-CH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwhK4-0002F3-TY
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:59:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwhK4-0002E0-Pv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580281175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHn4wiUPb9eJxW7rqJZOgEp2R1ghE5FF+cWj2A4VnG0=;
 b=fmZ8KZXgfMFzh2CyGKSzd8tPyZuHcvCHbe/llWoYqy6VDpfTnqEKIeYozmOUbOiOOj6s1D
 1JgDOihGi2XWE7G/xetUf4zbO8Gd9gPo7RSDiulssAcnknYXAg6UkqpwRmGke8OqedD+Q4
 FJZ4Buw9wafNWGKOrQUreOY+8d2pTGM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-seyHrzN-PNKasOCEbWRF4w-1; Wed, 29 Jan 2020 01:59:32 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so9597910wrp.10
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 22:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eULU0BQzbS1WpX+6Yglzb5LNtjgt0KQDqng1sFcoC9g=;
 b=ZnvPFBUfTxGuf7FtFMbn71AYV9sV2WbIt2YHCSKpdZxpY83GjQo1Xp9x60dybUIhoU
 ZVWMuIngnHLe0MyGAHDpnRpuuzF+OYZExfL4KM1urgaQFeOQG+YRvTF1TKhwbxjykVJ6
 nyR30ml/FUiWKwQmmp49NjqEfeOS4chDNVrl7+WEulsfvzL+g4syrZlu6qryOskORyLa
 gd8R1yQewhT0Tibk9I+FJzl75rToxEXMLGh6FGpt5g6NGS/3JVd8xRbe6cHAoY/0+6JF
 RQ2V9fbDtF23v9vxL09tkXMOeq+bAc/43ul5ddyKzGhWH1yrSvKIpP810Xh0spgl5mmh
 5oHQ==
X-Gm-Message-State: APjAAAWOJpWEaVVkcDocjazfxkoeOwTOK4SfgRUH0oiEZHiWAzJ9IjAL
 07dpFHcLRzaGMMu5TrXdtiIGWu4i2iuNUnElB8B7r6k67hHMJrTpHkiItjmdolbq1akvAhakouT
 F3e/7TaCTmWPOGD8=
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr10165648wma.177.1580281171773; 
 Tue, 28 Jan 2020 22:59:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHqNJqpClRdX78AmA2FZ/NYh0hgQTxSki+9CHLrZCGoV0f0izV4xHswPcygpCa8sux5gGAHQ==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr10165616wma.177.1580281171527; 
 Tue, 28 Jan 2020 22:59:31 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c141sm1139774wme.41.2020.01.28.22.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 22:59:30 -0800 (PST)
Subject: Re: [PULL 0/6] MIPS queue for January 28th, 2020
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6798c5ba-a747-9943-9ed6-df476a44ced0@redhat.com>
Date: Wed, 29 Jan 2020 07:59:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: seyHrzN-PNKasOCEbWRF4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 1/28/20 9:09 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> The following changes since commit 4c60e3289875ae6c516a37523bcecb87f68ce6=
7c:
>=20
>    Merge remote-tracking branch 'remotes/rth/tags/pull-pa-20200127' into =
staging (2020-01-28 15:11:04 +0000)
>=20
> are available in the git repository at:
>=20
>    https://github.com/AMarkovic/qemu tags/mips-queue-jan-28-2020
>=20
> for you to fetch changes up to 370bf3a4196ebef247752a68b89d497522168ebb:
>=20
>    target/mips: Add implementation of GINVT instruction (2020-01-28 20:52=
:20 +0100)
>=20
> ----------------------------------------------------------------
>=20
> MIPS queue for January 28th, 2020
>=20
>    A diverse set of fixes and improvements:
>=20
>      - finalize documentation on deprecating r4k machine
>      - enable disassembler to receive target-specific data
>      - enable kernel loader to get e_flags from ELF header
>      - improve code flow in helper_do_semihosting()
>      - amend CP0 WatchHi register implementation
>      - add GINVT instruction emulation
>=20
> ----------------------------------------------------------------
>=20
> Aleksandar Markovic (2):
>    target/mips: Rectify documentation on deprecating r4k machine
>    disas: Add a field for target-dependant data
>=20
> Daniel Henrique Barboza (1):
>    mips-semi.c: remove 'uhi_done' label in helper_do_semihosting()
>=20
> Philippe Mathieu-Daud=C3=A9 (1):
>    hw/core/loader: Let load_elf() populate the processor-specific flags

Do you mind holding this pull request? I don't feel comfortable being=20
listed as the author of this patch. I'll discuss it on the patch thread=20
with Aleksandar.

>=20
> Yongbok Kim (2):
>    target/mips: Amend CP0 WatchHi register implementation
>    target/mips: Add implementation of GINVT instruction


