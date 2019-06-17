Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4333AC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA4320652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA4320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcv5T-0003Fl-Bg
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46313)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuCJ-0002Ju-8i
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuCI-0003zj-8t
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:09:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuCI-0003z4-35
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:09:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so9734493wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Usp2DZtQd4O5xHqmPVmrFAaMrxG2FglYPRdUeJc2Hpo=;
 b=l6BNe7XJzf3KVokGqIhbYa+QFuw+fNLog9HkQLUE2K+GjX4hBEjS5GZ21Adi1gX91P
 LQTHW3dGYM5X6f41MQsDrlaKqRepw9QC8S6CbbZTMf6A0Di+p+vdIBoJ5dpuS6KBiKEz
 sNvH5ECX62rijIk6VgSf5qQ2rtsHsWwW80l5FNCSl3fjqhPXNChmZSk1QerBHXpomjG7
 vioBoa/pfqxXnhoiF9uBrjNm7DzMMn3n9UHZ+8HG9HUhL6wwyIdQF2Q44trLZehtODCo
 SP5DrUWtYVrn7SX8tcRpCul9NxTQdq7wtQ5NO46lfYD4wh8ZXf5Owgxz4aXcmIb41CCg
 vEZw==
X-Gm-Message-State: APjAAAX1jNcXjdzA27v13SD9F+miHy2aP8A4SIzqdHpMm0dspWo+VunO
 F5ZuEk+aVq7YSWATLEuM9i8Flw==
X-Google-Smtp-Source: APXvYqyANZFPgtq0W+jGo+OmdGX9BSBHEuI1eQeS0MYGLNmNEmVM6H0r1obPkzp7I9jrO+kEQIRq6g==
X-Received: by 2002:a1c:a783:: with SMTP id q125mr20439066wme.94.1560787769125; 
 Mon, 17 Jun 2019 09:09:29 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y44sm12250622wrd.13.2019.06.17.09.09.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:09:28 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <50ccf205-1be7-5d0e-c4b4-7fb94459330c@redhat.com>
Date: Mon, 17 Jun 2019 18:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v4 04/11] tests/vm: proper guest shutdown
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
> When not running in snapshot mode ask the guest to poweroff and wait for
> this to finish instead of simply quitting qemu, so the guest can flush
> pending updates to disk.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Tags from v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

