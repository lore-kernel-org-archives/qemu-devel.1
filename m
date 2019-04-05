Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C9C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC3920652
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC3920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCM93-0006Hp-G0
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 06:32:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hCM7r-0005rW-53
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hCM7q-0004XL-B1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:31:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hCM7p-0004W1-UR
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:31:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so7381271wrp.0
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 03:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=2fhTwlPnlDw+cjs1jfSYST3lsfh/ELP6nYZrid0Icxo=;
	b=Goe3NqTup/eOxdvsXuM/OhCyBd9boiiN3HA1QIpl1pqJ2+rz/a8gL8FlqM6GDNDTu5
	QUqQKcHswp94NwFziExOKe9MMYIhvzg1yTmG9cyOMc7lnsmMQelHCfNXX10MdmLJYM3F
	6Hmo+S3FO/trzWgEpXKUv32hRz52tgdB+dqGjZTbujdB3U2xaqccmG9nGJKcAuGkg0Eo
	nqttrB1Z/rxstsHKSqoVH0Ve9onhwLYkGipkgz7lEUdAPHVGo+NcpX+d2IEqwbpCjuXI
	3YrGZbROi/Cm9Hbopae3grqmAp24FH00I9D8gnRxiRrHl0AioayJ4BOSFz6U6Xn3nYky
	lD0Q==
X-Gm-Message-State: APjAAAWFsnp7paWp89fdlS1o7FPvCfiG/4FcHAHY/e8D1G7Gvahnx345
	nNNiKOFOH4g0kEjKH2XsTjTh9g==
X-Google-Smtp-Source: APXvYqyDToo1TmpCNueK6YneVgzdgstf4FLTDOMIPH5NDxIhFuYcHoc69PWg1RONWq3w8WIKEwNgKg==
X-Received: by 2002:adf:e94d:: with SMTP id m13mr8520774wrn.141.1554460268830; 
	Fri, 05 Apr 2019 03:31:08 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35])
	by smtp.gmail.com with ESMTPSA id r6sm1260224wmc.11.2019.04.05.03.31.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 03:31:07 -0700 (PDT)
Date: Fri, 5 Apr 2019 12:31:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <20190405103105.c2ohp53bitfgamax@steredhat>
References: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] e1000: Never increment the RX undersize
 count register
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
Cc: Chris Kenna <chris.kenna@oracle.com>, Jason Wang <jasowang@redhat.com>,
	bhavesh.davda@oracle.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405103105.vOYydNvOZuovOyMhpR7AU-5h0JkOhXeLJoPCxzBTOsc@z>

On Thu, Apr 04, 2019 at 10:21:26AM -0500, Mark Kanda wrote:
> From: Chris Kenna <chris.kenna@oracle.com>
> 
> In situations where e1000 receives an undersized Ethernet frame,
> QEMU increments the emulated "Receive Undersize Count (RUC)"
> register when padding the frame.
> 
> This is incorrect because this an expected scenario (e.g. with
> VLAN tag stripping) and not an error. As such, QEMU should not
> increment the emulated RUC.
> 
> Fixes: 3b2743017749 ("e1000: Implementing various counters")
> 
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Signed-off-by: Chris Kenna <chris.kenna@oracle.com>
> ---
>  hw/net/e1000.c | 1 -
>  1 file changed, 1 deletion(-)

CCing Jason.

LGTM, if we don't discard it, we shouldn't increase the RUC counter.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

