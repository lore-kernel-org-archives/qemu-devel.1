Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF8C04E84
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BEB208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BEB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37429 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVefL-00007f-B0
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:09:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVeeX-0008Ia-2x
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVeeW-0000A1-6U
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:08:41 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVeeW-0008JU-1m
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:08:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id m1so517607vsr.6
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 09:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=tVdJKwVZNA1dZG6wSQh4qRI9eLglGA/uuKX8LXX5SEs=;
	b=mGL4IDxfKjVdYyVM4B1ID2l73VR2rhcV+ir/dr3QN69OnlPTZza7Y+MwQOdLLwt5P5
	k2tTeHRbvafongy7SoFuVKKydycEVVOPZWOdLNDWFnC/BmC3nedUQNklAYp5SdXcy5TI
	Q/gwU6G5xEU6uFeKlJqFBh5c7qp8DcIurP/WFaUSmWMecmX6uCmkscQMBGAdgJXJNBVP
	WiosEJYiGDKoraqSkuyYRX6LNAllMQ8LLypy6oEOsIWVd2oauLSxsjxQqQMCF8Z5C35h
	+IfHALhBtoWqx//ReuQduQpiV5ArFKSN84QSsmYuef+Osps1tkt3PFXisGIuMo7iqFjd
	WEIQ==
X-Gm-Message-State: APjAAAXQsbKkFBaXpFiO1/jDnYeKeq3oAZ4JwDs1R8xdY93pJnALjwjC
	fUs01thu1vyrKk91kf5t0uPchQ==
X-Google-Smtp-Source: APXvYqzxIAXo0Tn1mrN7t4tujgb09FKv83XgKZeP4nJ5BJ/xsK01BwDOZ0p5iYb5bhm57RNRCtVjBw==
X-Received: by 2002:a67:ec15:: with SMTP id d21mr69719789vso.186.1559059688845;
	Tue, 28 May 2019 09:08:08 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id s78sm6556810vke.1.2019.05.28.09.08.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 28 May 2019 09:08:07 -0700 (PDT)
Date: Tue, 28 May 2019 12:08:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190528120741-mutt-send-email-mst@kernel.org>
References: <20190528153304.27157-1-philmd@redhat.com>
	<eb44b164-aabe-d072-b2a8-392bdb37dc7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb44b164-aabe-d072-b2a8-392bdb37dc7e@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.217.68
Subject: Re: [Qemu-devel] [PATCH v2] tests/docker: Update the Fedora image
 to Fedora 30
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 05:36:54PM +0200, Philippe Mathieu-Daudé wrote:
> Cc'ing Michael/Igor/Stefan about git comment format.
> 
> On 5/28/19 5:33 PM, Philippe Mathieu-Daudé wrote:
> > Fedora 30 got released:
> > 
> >   https://fedoramagazine.org/announcing-fedora-30/
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2: Added Marc-André and Stefano tags
> 
> ^ This is my local commit
> 
> > ---
> 
> ^ This line was added by git publish via format-patch
> 
> Michael is that what break your patch workflow?


Used to but seems to work fine now.
So I guess you can ignore me sorry about the noise.

> >  tests/docker/dockerfiles/fedora.docker | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> > index 69d4a7f5d7..1496b68ba1 100644
> > --- a/tests/docker/dockerfiles/fedora.docker
> > +++ b/tests/docker/dockerfiles/fedora.docker
> > @@ -1,4 +1,4 @@
> > -FROM fedora:29
> > +FROM fedora:30
> >  ENV PACKAGES \
> >      bc \
> >      bison \
> > 

