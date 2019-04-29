Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC1C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2EA2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2EA2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55307 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL3Ut-0001oT-BL
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 06:26:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL3RK-0006W5-IW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL3Fv-0003A9-KE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:11:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL3Fv-000398-E5
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:11:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so15106412wra.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 03:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=CPaDH9akEtm5aWVaDKCPJvR2ZbYzKNgiNnXnpyyndcU=;
	b=XWlFljN7UBc2f4+ehJBUi9j+0NKR/tifmQi3+L8BU2ZS1oOyO/z6HeGfieAibKA5DX
	Q6VsUtKqPJtZLvf8bBa9xtsKB79zLyQUvWHtkC62ZZ0wgAhESBE+KGe35T8UNUqGECFZ
	Di3cp/Tfyojy2HuEb04wwxYb5mxyEpPZwfW3EIQhdfnbkITyM2IZkNggBWwc3XfLXmIW
	RZaa9uV+Zm9EoGOLWRr9caSRUBUWz3ozg+tGIrJjdcTd2miW3HnUAIZe8eq31FazH4QM
	88F8edxe6g+bINn41g5vkNmWMUSVZmMjpN/FRgF/JyN8q4Xz6ECE3UrdSW8zwlwK/pvU
	dCUg==
X-Gm-Message-State: APjAAAV0fDpg1Rl0wPe1jbWnzrhQKVRFQRxzAy5tKen6J7vDNqnTMX4b
	mx+0JX00lwQo2WpHhKNYaFketw==
X-Google-Smtp-Source: APXvYqw8z3J2LQEIMkMJmawACqvhz/4Qwx7xZaW/f0oYL4+BsQfAIH6dTAQaXLGXCxnKlaj90RktHg==
X-Received: by 2002:a5d:6b04:: with SMTP id v4mr37968947wrw.69.1556532683885; 
	Mon, 29 Apr 2019 03:11:23 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	t13sm19684395wru.70.2019.04.29.03.11.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 03:11:23 -0700 (PDT)
Date: Mon, 29 Apr 2019 12:11:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429101120.bu5djv7pbwippq46@steredhat>
References: <20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
	<20190415080452.GA6031@localhost.localdomain>
	<20190417073438.r57lemi6emu4x3ld@steredhat>
	<20190417080443.GA8330@localhost.localdomain>
	<20190419122356.7dmwwdbtnzgimydw@steredhat>
	<20190423075619.GB9041@localhost.localdomain>
	<20190423082657.mzulhihpv6rhgiww@steredhat>
	<20190423083805.GC9041@localhost.localdomain>
	<20190429095855.GC8492@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429095855.GC8492@localhost.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 1/1] block/rbd: increase
 dynamically the image size
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
Cc: Josh Durgin <jdurgin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429101120.7kKFYnwPqfVayLGy0d_MkA6zwXLk-0fnxqWqq8T7vMc@z>

On Mon, Apr 29, 2019 at 11:58:55AM +0200, Kevin Wolf wrote:
> 
> Hm, this is an RFC patch, which suggests that it wasn't originally meant
> to be merged as it is. Are you going to send a new version, or did it
> turn out to be exactly what we want and the "RFC" tag was a mistake?

I put the "RFC" tag because I was not sure about this patch, but after
your comments and some tests on the rbd_resize() impact, I think that
it turns out exactly what we want.

If you agree, you can queue it as is.

Thanks,
Stefano

