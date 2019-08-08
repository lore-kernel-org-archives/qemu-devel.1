Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28221C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07592187F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07592187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvdYD-0000gG-7F
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 04:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hvdXh-0000GE-IQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hvdXg-0000ea-Ab
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:13:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hvdXg-0000ds-4E
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:13:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so1441779wmp.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 01:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=mYXm9UDJhY/ywqZDWE7f+3A+nfgqkEyihOXfqai7YEQ=;
 b=bcRMJrekxiKtIxTw7ZSdVzyk40byUZLDT+A64f1ApHBHNoTDQU4yfJ/gQCS+Gb1cOE
 g8Ce43qc6MQ8dju9zbbJUV0pf1wiupEsfGHZjnzjkZMNVIOlpFr7gmLT5WtotjCUD8Ag
 f17pYyU8Hh5x3HxHW+vtj034loYwd1Y0VcjBoU2/ClISuIXImdnOUkhwKQL+5rOqX0Ld
 cBHtHtzOGMflzM/YZU4kaX8yMceGMOf8rvcvFsKgFUTm4JdlPKl/24KtMbGntOS6sFsd
 cz5yXP82K/JM7DmIWFPhp7KNp0bNC0rWz5AutYRwRloyPexk/OZP9Ls+wGQ1nTsd4Yg7
 Eraw==
X-Gm-Message-State: APjAAAUQZV8Lmd+RRxFDqDGK38ypdEIdB9GnpEEpvXjqWZLtfVWztrVc
 3EP3tPIR9LiKRCvSSgyYjKveYQ==
X-Google-Smtp-Source: APXvYqxFPLb+PR4EbYvNw4rlnUoDkTHRkmutGXCeG1JtnvqRRi4lNAVPGSkWpYDWTces6+n5e7W30g==
X-Received: by 2002:a05:600c:254b:: with SMTP id
 e11mr2599351wma.171.1565251977389; 
 Thu, 08 Aug 2019 01:12:57 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id o7sm59435241wru.58.2019.08.08.01.12.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 01:12:56 -0700 (PDT)
Date: Thu, 8 Aug 2019 10:12:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190808081254.acqwu2m4mhyxctjz@steredhat>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping? (was:
 [PATCH v2 27/29] Include sysemu/sysemu.h a lot less)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 08, 2019 at 06:48:25AM +0200, Markus Armbruster wrote:
> Please excuse the attention-grabbing subject.
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
> > On 8/7/19 10:16 PM, Markus Armbruster wrote:
> [...]
> >> Can you tell me offhand what I have to install so configure enables
> >> CONFIG_NETMAP?
> >
> > The steps are listed in tests/docker/dockerfiles/debian-amd64.docker,
> > but you can get to this point running:
> >
> >   $ make docker-image-debian-amd64 V=1 DEBUG=1
> >
> > This will build the docker image with netmap (so you don't have to mess
> > with your workstation setup), then build QEMU within the image.
> 
> So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
> build and install netmap software from sources.  Which pretty much
> ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
> The commit message points to <http://info.iet.unipi.it/~luigi/netmap/>,
> which gives me "connection timed out" right now.
> 
> On the other hand, it's covered in MAINTAINERS, and has seen
> non-janitorial activity as late as Dec 2018 (commit c693fc748a).
> 
> Luigi, Giuseppe, Vincenzo, what's the status of the netmap project?

I think Giuseppe and Vincenzo are currently maintain netmap.
I worked with them on my master's thesis. :) I can give you some information,
but I'm sure they can be more specific.

More info here: https://github.com/luigirizzo/netmap

> 
> Why is the QEMU netmap backend worth keeping?

Netmap provides a virtual switch (VALE) and netmap pipes that can be
useful for VMs and the netmap backend allows us to use them.

> 
> Who is using the netmap backend?
> 
> How do they obtain a netmap-enabled QEMU?  Compile it from sources
> themselves?

Yes, I think so.

> 
> Would it make sense to have netmap packaged in common Linux distros?
> 

Maybe yes, for the virtual switch (VALE) and netmap pipes there shouldn't
be a problem. To use the network cards, however, you would need the modified
drivers.

Cheers,
Stefano

