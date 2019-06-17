Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEF2C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0113F20652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0113F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuzn-0006hX-8d
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuFy-0005xc-HC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuFx-0006p6-HS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:13:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuFx-0006nE-9x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:13:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so4997wms.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ev3gbEYXmUm7TfRZHap9k0OqcBJEGAVvJHzuOaeRzvo=;
 b=hT6Q5tmD7eqyZaaU4an2AxLUxExapVhwTHH8nDc9dY3PH+Mt+MEzHkXJZy8vFTVaMW
 G54YrajIoEmnxSQ6ebWTRCkHnX1msnUzWYDCymLx2s+w2JSGOSli9NzLP81S3Pxp7O6y
 rEn9ZnOx8t9VXjJoOgafonz4Mq9F1yji1uDAgnV5HpAqKI5QHVdrZaZuHjTVgXc55LxK
 50MZP2+n2xzKMQ7frucCqmTyfmTvzvZ7ZbFC/R1l7x4jXV/sZSpE+bFyDLlzJ0EdhkZY
 N1hy3+bjcWj7Xr0iVyHAnqMrC/DTWqLB5JQsLMVfedwNqTTnzwvAsc7ntSFYLj1Pf1ac
 O7Ig==
X-Gm-Message-State: APjAAAW7twFPYP+OlgAIbFbFlt1XFOF3zkyZ6XAks2a/fGb1gLIVXeOB
 leZXt/5k0pQcKv3pYuihJ8aypg==
X-Google-Smtp-Source: APXvYqxsssgOnxqIVft0SgK7M5qGvttvRLWWu+kwTOtKfjSkPKBa57AgGN0RtMKwfKY8u44Au3WyaQ==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr18175282wmj.4.1560787995066; 
 Mon, 17 Jun 2019 09:13:15 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id n10sm12901074wrw.83.2019.06.17.09.13.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:13:14 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4b592cb6-6da5-0eba-4b86-2656529eff51@redhat.com>
Date: Mon, 17 Jun 2019 18:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-10-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall,
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
> Instead of fetching the prebuilt image from patchew download the install
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

From v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

