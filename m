Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895EBC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571DE20663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571DE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiwo-0003bD-JB
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfivR-0002J1-0j
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfivQ-0001yu-1E
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:43:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfivM-0001m1-8h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:43:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so17251448wrl.11
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QGUZPgkPocBxJrKZk7S4dvBZpDebcoKW0hh8K8aIc74=;
 b=ZMF1QvVDw/USo7OSp08sSpXcXbhe1H0dYK6D0bN9es5OwlNAiv+6vvjhE6gmap4YkJ
 6krIDvci+ruNACccJsVaxWFtNySK3Qhb1DaEuwRnRLD6pUtg0JRXzKbqUxnJgKHLap6E
 5ZlS0sh0h3Xnme2dJYgK0kXhdQmIvNcuBS8W6Zq941dvefXabywxZ7pOw5E6vAJMF8W1
 kC7IFacQyjpqlU12ygGt2LtC75PWdfkApgv6e0MVxHCFGtITrlFB+5G2mDF/hwq3Zg1x
 wSSFDQyEXkFUNkpPvIA0tq7GRDGtMjNqvSmbjzltLR5etqmMUXMnvo8wHovKzSe4mw5a
 a7Jw==
X-Gm-Message-State: APjAAAUgfYy9Xt00bKOFAwgCJ51rbktIthW4kR19VDxEZv1bTGQvR4HF
 kvxkNIjsm+A931pxkrcctdq9WQ==
X-Google-Smtp-Source: APXvYqy0ixztDmj0VLh7z+HpwirZJX36dhCAVwvu6Ff7R1ZgscZGJPZpLi0AwixfLsFexZ+QqS7c0A==
X-Received: by 2002:adf:fec9:: with SMTP id q9mr38022768wrs.241.1561459413488; 
 Tue, 25 Jun 2019 03:43:33 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y184sm1956237wmg.14.2019.06.25.03.43.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 03:43:32 -0700 (PDT)
To: Colin Xu <colin.xu@intel.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, kraxel@redhat.com
References: <20190625032142.13854-1-colin.xu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <429635c3-8775-ed6d-e45b-6803a8847b88@redhat.com>
Date: Tue, 25 Jun 2019 12:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625032142.13854-1-colin.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] ui: Correct icon install path
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Colin,

On 6/25/19 5:21 AM, Colin Xu wrote:
> The double slash in path will fail the installation on MINGW/MSYS.
> 
> Fixes: a8260d387638 (ui: install logo icons to $prefix/share/icons)
> 
> Signed-off-by: Colin Xu <colin.xu@intel.com>
> ---
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index cfb18f152544..562205be290c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -875,19 +875,19 @@ ifneq ($(DESCS),)
>  	done
>  endif
>  	for s in $(ICON_SIZES); do \
> -		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
> +		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
>  		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
> -			"$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
> +			"$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
>  	done; \
> -	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps"; \
> +	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps"; \
>  	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
> -		"$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
> -	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps"; \
> +		"$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
> +	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps"; \
>  	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
> -		"$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
> -	mkdir -p "$(DESTDIR)/$(qemu_desktopdir)"
> +		"$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
> +	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
>  	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
> -		"$(DESTDIR)/$(qemu_desktopdir)/qemu.desktop"
> +		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
>  ifdef CONFIG_GTK
>  	$(MAKE) -C po $@
>  endif
> 

I'm not sure about this. Did you test it on a POSIX system?

Maybe we should escape an eventual trailing '/' in datadir and DESTDIR?

