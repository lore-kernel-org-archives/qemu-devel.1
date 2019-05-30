Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C7CC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D2624F53
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D2624F53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGQr-0001RR-9z
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 04:29:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWGQ2-00010E-Qf
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWGQ2-0002vd-16
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:28:14 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hWGQ1-0002lH-Qy
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:28:13 -0400
Received: by mail-wm1-f53.google.com with SMTP id z23so3229501wma.4
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 01:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Ym8zAV4HuOVtBjpiNLxVUk0ikr3v6QLlxKO837em+FQ=;
	b=bPjRoUf1Cxq1p8hnDMirKOToUOPQ0GG4BorFtOpUUG8NqVP4owprger1gmHbCDEHQ7
	nK0R0CCjASdeqARfmdjzIxsTGyP3WjJCN4ByMkFydMLOSh6pW2qOMeXfGIGlRokBKDeU
	+OqLat961HloxBs+oXll5AlWPxZyo7abMe0wCGZHUhROgPp5oVmZn8txNFduDfdXA4nS
	x3bMddRH8MPbyOxPwrAy/Z5DmaHw71LrzPeTZaAuZnJmFZg6SCLjSoHE+fzvp/FohuCe
	I7WVitHX1vjidTHuWwIYRq6cU+fNVIQ0feQd9BcxBm/dZwmCs3ieng1b8o8jZ45kSjnl
	W82Q==
X-Gm-Message-State: APjAAAWTgafX+zUOB4hsux16b3xOXNkNIF9895TgbJ9PAr2VjpVh6542
	YKPOLbaZACNxdxe74doqogzsLsnEsPoTpw==
X-Google-Smtp-Source: APXvYqx6CznjikUK/mOZp0hWYjcY0af+eg6+nEAlIOjfPrvFJyz5EFjBsKpNDnYkrhIG4K5VJ1UEjQ==
X-Received: by 2002:a1c:c8:: with SMTP id 191mr1496667wma.6.1559204876666;
	Thu, 30 May 2019 01:27:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3da1:318a:275c:408?
	([2001:b07:6468:f312:3da1:318a:275c:408])
	by smtp.gmail.com with ESMTPSA id m17sm1475406wmc.6.2019.05.30.01.27.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 01:27:55 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190524183638.20745-1-stefanha@redhat.com>
	<24b93cc5-edb1-a197-14be-e63ac356325d@redhat.com>
	<20190529221030.GD3471@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2666245b-7873-dc66-4af0-6b9c1eaa445d@redhat.com>
Date: Thu, 30 May 2019 10:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529221030.GD3471@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.53
Subject: Re: [Qemu-devel] [RFC v3 0/3] scsi: restart dma after vm change
 state handlers
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
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/05/19 00:10, Kevin Wolf wrote:
> I don't think this is as nice because stopping or resuming a device
> could involve some async operation (e.g. be delegated to a BH). In this
> case, a device on a child bus must still wait for the BH (or other async
> part) to be completed before it can resume its own operation.
> 
> Basically, a single flat list of global VM state handlers wasn't a good
> design, because what we actually need in such cases is something
> hierarchical.

So add an AioContext state change handler?

