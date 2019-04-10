Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E4C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 07:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F8020850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 07:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F8020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE7hP-0004CO-7s
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 03:31:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hE7gR-0003hl-8f
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hE7gQ-0002Wu-E2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:30:11 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hE7gQ-0002RR-55
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:30:10 -0400
Received: by mail-wr1-f53.google.com with SMTP id h4so1595813wre.7
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 00:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=uqFbpRXIN7n8AUAJOqb/BpKIHFBnLAfBb2oZD++V6rw=;
	b=RI6rzZn0IEubf85pPaXO63WOoMcYYyhK8RhgUZ1598C5qlCEHnffNtbmBU6xTla/gs
	lX5nQrgsZQLQ7iJPo5NC17Eqlig7z6jHeSOFwRiLjTn9mR977D2ASgLFtF0J8v+D7qYK
	POWQt/69O6FWGbVxx8JjgV3Fg9zdMiMKT0NLOS/czJcbIF15ZdE5KZboJbkj/NbqIdx4
	vmGA8fP82OAfOAVc8rvRHcV3ScT2DtCCAwcS61H4O7Q8RjIyx99aLBq5hYwmUNQRQl6e
	GDSIii7rvdNDXy3hU8Zz8QbJgYM/yQjtT9z+wpQXlztMcy2bhW/G92YAJExhAV2YZE84
	JUyg==
X-Gm-Message-State: APjAAAU26fej5iRpki2+HY9n4UKStPmBM4GOu0zaI44NxRg6FSKQDp+C
	OvFbWoRZOlvSTXCydHGzi4Z4Qw==
X-Google-Smtp-Source: APXvYqyWHC3vsSUIBlsqUZkLCK22EhEp2WxnBIQOo2AQn3mIFmtRjusY/Fc3mY4IiL7tO+VasBtyzw==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr4629264wrp.172.1554881408109; 
	Wed, 10 Apr 2019 00:30:08 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	l12sm41950108wrt.31.2019.04.10.00.30.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 10 Apr 2019 00:30:07 -0700 (PDT)
Date: Wed, 10 Apr 2019 09:30:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190410073005.orqlxvqdp7ebwbas@steredhat>
References: <20190409154435.28807-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409154435.28807-1-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.53
Subject: Re: [Qemu-devel] [PATCH] docs: replace min-glib with fedora
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410073005.TCu3-uhk-q8SuRg-hZdJZWdQTwMmRbi6RmgjhZiYOZU@z>

On Tue, Apr 09, 2019 at 05:44:35PM +0200, Marc-André Lureau wrote:
> min-glib.docker was removed in commit
> e7b3af81597db1a6b55f2c15d030d703c6b2c6ac ("glib: bump min required
> glib library version to 2.40").
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/testing.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

