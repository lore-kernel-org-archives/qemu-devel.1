Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB12C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030EF20652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030EF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcv55-0002BE-4X
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47554)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuGU-0007AR-Pc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuGP-0007Df-FY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:13:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuGP-0007D7-9J
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:13:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so10633348wrs.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HGH7HBok5/Hbz7Pgz9ZWvQ2SLs1+6/iJ4VcskaEBXW4=;
 b=IyvRP4XY9L2skJ0QYutx1M55NaJJoqIDp8fKut21cw8Aj9+Qa2NO/eLpR82bKHOO2i
 RNxwvu9fPx6nOye1J11yjkHZF+huniAUEpCil7AnSEtNnv8jy4/aXar2x69NrKmhrmTU
 athzgkdSgKzOEddT58vtcXMKuMmCcZ0PrGPUq8Lq1pY8muhISN1UW3j1wnYwutCh/80k
 49HwmTD1J6kf8zuHe+Uspys/z3Iy6hVpKuH8Rpg7ZxU1y3nf9Z+xnxe7cYDDt9Zo62Cx
 FB20I2s4kqdkl1surIJqXZmBvQOlQ2z2TjmuTsm5NfMkEjbvNujLKW7J5dEUmn5UDItP
 DKYQ==
X-Gm-Message-State: APjAAAUrFL7Pm0eoV6P+iIpfhp2SOhOmUYZnLikctb/17COReH6OTALS
 F+dFNYObCWankN2tTdio4TyOTA==
X-Google-Smtp-Source: APXvYqwGFKU8ZyJ4/ZUYHbJ6KqsQgspIKaHbF05MpG0JsCD12o2HSp5Gie6CEndC/vjMp8qDes2rVg==
X-Received: by 2002:adf:a38b:: with SMTP id l11mr24363028wrb.325.1560788024229; 
 Mon, 17 Jun 2019 09:13:44 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id p26sm3705286wrp.58.2019.06.17.09.13.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:13:43 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-11-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <de8c1f09-800f-35de-f9e0-51ebd3181db8@redhat.com>
Date: Mon, 17 Jun 2019 18:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-11-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 10/11] tests/vm: fedora autoinstall,
 using serial console
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
> Download the install iso and prepare the image locally.  Install to
> disk, using the serial console.  Create qemu user, configure ssh login.
> Install packages needed for qemu builds.
> 
> Yes, we have docker images for fedora.  But for trouble-shooting it
> might be helpful to have a vm too.  When vm builds fail you can use
> it to figure whenever the vm setup or the guest os is the problem.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

From v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

