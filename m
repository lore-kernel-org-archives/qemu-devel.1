Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172FBC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B402084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B402084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcv7m-0005fG-8u
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuIN-0000gq-M2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuIL-00014K-9s
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:15:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuIG-0000z2-Bk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:15:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so323872wme.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xj7F1/LF17MU8fv8q7eKJ4RAdNqP8Mk9Hzg/2wzsqFI=;
 b=NwAUNTrhrArp/ahRwJ9EYeDb5+jHQqfvE22Z+xpZfHfR+XT/SGYzl0BqJyoB2jjQ+Y
 zpvsaFhQKCgr0LfD19f63I05TAy9HuoxEMZ4JNc7YXtHtObNd079YRgmfGUpKOVnwuMf
 bPj/6LqwRGTB2axh8D/dEqh86vNM8WpHowC3TSWM0dZbrEyEL7ovQ/AaJEki+WKlbgnH
 w+eUUbvv9onNvgfVtIcQrmPiXE5cd202/uk7E8iJAIfaz03XeBiKnhBgSVMZ3Oibss52
 BmfLHJfwhI5A6EZ6Pejsc1gUxTmLx2BQpEJtAaXiDO512Nva7GtRmmLueHqx2IY9vMyw
 +Sjw==
X-Gm-Message-State: APjAAAXA2fAAMiDJdPJl3VnZ2H0eGN/De1X8P3EPYbKyc9k+V3jEAj2M
 d1edrk7tCqUg43Cs7u4DePhutQ==
X-Google-Smtp-Source: APXvYqz0kp/iXNSK6V6GY/kFzSEnM1UZ80f1RfIt7EQbopF4jqNgwOjJ+FxtP/BtrXtH2sckxozsVQ==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr19474693wml.126.1560788134778; 
 Mon, 17 Jun 2019 09:15:34 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id c4sm12939533wrb.68.2019.06.17.09.15.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:15:34 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-4-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7bf59382-412f-025a-15f2-2d1dcc38b156@redhat.com>
Date: Mon, 17 Jun 2019 18:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 03/11] tests/vm: run test builds on
 snapshot
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 6:38 AM, Gerd Hoffmann wrote:
> The build script doesn't shutdown the guest VMs properly,
> which results in filesystem corruption and guest boot
> failures sooner or later.
> 
> Use the --snapshot to run builds on a snapshot,
> That way killing the VM doesn't corrupt the base image.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

From v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Ed Maste <emaste@freebsd.org>

