Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A3C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEB120879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEB120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRv8-0001Ku-2F
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:08:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTRtq-0000p8-IX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTRtp-00057E-IE
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:07:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTRtp-00056t-CX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:07:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so2437467wrr.13
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 07:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/BsPjmll5LpGKZ+MLTvrs+/UPkdB1x+tAkLJaAi8jlM=;
	b=fj+XW0kDtseJci5jpU3dQx0mG4QBQ32MDjdZ10UIo1BMT8TdoF3FuTCAZi9VhN07PY
	CZVoLddhOVrKU3Ge9GY++GOkFiPovt/Mcw8tRK8+joIztnJeS0y/fRi23Q+aQDAu4sHP
	4DfRWEnf1T2zxG/HzhJhP5mYegBnsRqXlmDqt5ECCNIyOn4qAf4WSpoDbQZK/51AqJlN
	TeUk6ClPlxMBEmm7C8l3jYwlidUNNWuptsh2aQ9Vzy7hustYN06l3zk0k3ycvbGXg1zq
	JYOavGKk4qpqA13r4yFR5Sl2nLyfpvh5aJfsuCho6c9sUXvCvjden6klFI5YqFFuBAVc
	SqLg==
X-Gm-Message-State: APjAAAVcREyGM7y1NINNmAfc+rHWsfO9ARm6ToXfSbLRN+LCHjvZvm8/
	aER8NqAUGdU0lPi44CoGRH2AjQ==
X-Google-Smtp-Source: APXvYqyEzT6L+RnuXMl1/+5SWuLFtHw18PPiIjJ8jg00PuUVVnEUwXem/NmsXL1nVBvlHOnoF5DAHg==
X-Received: by 2002:adf:ab45:: with SMTP id r5mr28874710wrc.100.1558534040274; 
	Wed, 22 May 2019 07:07:20 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	a15sm9261271wrw.49.2019.05.22.07.07.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 07:07:19 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190520213700.12620-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ac9d9453-6c2f-97c8-4a04-8fb55f6df036@redhat.com>
Date: Wed, 22 May 2019 16:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520213700.12620-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 0/7] fw_cfg_test refactor and add two
 test cases
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 11:36 PM, Philippe Mathieu-Daudé wrote:
> This is the work from Li Qiang, I added few changes while preparing
> the pull request. If Li is OK with it, I'll send as it.
> 
> Since v2:
> - split 1st patch
> - clarified commit description based on review comments on list
> 
> Since v1:
> - Add a patch to store the reboot_timeout as little endian
> 
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04064.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05679.html
> 
> Li Qiang (5):
>   tests: refactor fw_cfg_test
>   tests: fw_cfg: add a function to get the fw_cfg file
>   hw/nvram/fw_cfg: Store 'reboot-timeout' as little endian
>   tests: fw_cfg: add 'reboot-timeout' test case
>   tests: fw_cfg: add 'splash-time' test case
> 
> Philippe Mathieu-Daudé (2):
>   tests/libqos: Add io_fw_cfg_uninit() and mm_fw_cfg_uninit()
>   tests/libqos: Add pc_fw_cfg_uninit() and use it
> 
>  hw/nvram/fw_cfg.c        |   4 +-
>  tests/fw_cfg-test.c      | 127 +++++++++++++++++++++++++++++++++++----
>  tests/libqos/fw_cfg.c    |  55 +++++++++++++++++
>  tests/libqos/fw_cfg.h    |   9 +++
>  tests/libqos/malloc-pc.c |   2 +-
>  5 files changed, 184 insertions(+), 13 deletions(-)
> 

Series queued (with Laszlo's comment on patch #2 addressed).

