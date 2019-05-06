Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85130C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 07:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50574205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 07:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50574205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYNK-0005pK-Ln
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 03:49:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNYMG-0005Hn-3X
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNYMD-0006tk-PY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:48:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hNYMC-0006s2-8n
	for qemu-devel@nongnu.org; Mon, 06 May 2019 03:48:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id v10so3659987wrt.6
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 00:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=HN87jlVhtMwHVGXfqotp5rW3Ay9RJMDpyehyqTtwDT4=;
	b=H6ZRBZJwKeQZDkuGmB2gqAefWLtIHe/Uen1rdjdpRJBrH2Jv3pYqsx43mq5cjWE/VS
	qRXig3oakJljYLwfDDNV+zNgNuzHvZ1BQfRvorUad6eO184RskSFBfVNcxeIpS58SaRe
	ZvCkrJ2/Dh+numK0oosPI780tySKmUhMn7OE3uDh9gJXqANrlv0l3vBU7qceDHeISgMW
	Wt6vdwTru+hhr7TI8bGPL4/l8RG1Wb0svi0kn/yaq979218BX4VRr4lk1/xQWwZY1rYd
	HMnuS6EgpjjQjgU9zSNtDkLS0fYCJeSQv1jkH7QwhGCgvtR26oSkAiQl6lROwQ0/WFTU
	6x3A==
X-Gm-Message-State: APjAAAUdeeHTr/EW+2P6WVVGxkJrZ0qsUE/mk3qg3HYMD9cRMW7scIxj
	sEsh281gPKoOeuzb9LxxZeZJkg==
X-Google-Smtp-Source: APXvYqw9wNer+gc6DebyQ63ntetecepYfMVAkYJYtX7WL7MtFCHhJD/ELRatPTCYfoBQoKs6zNqngA==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr16130323wrv.104.1557128892388;
	Mon, 06 May 2019 00:48:12 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103]) by smtp.gmail.com with ESMTPSA id
	k206sm19580202wmk.16.2019.05.06.00.48.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 00:48:11 -0700 (PDT)
Date: Mon, 6 May 2019 09:48:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190506074809.skltdcczbbu3isll@steredhat>
References: <20190506061854.22207-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506061854.22207-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [Qemu-block] [QEMU PATCH] MAINTAINERS: Downgrade
 status of block sections without "M:" to "Odd Fixes"
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
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On Mon, May 06, 2019 at 08:18:54AM +0200, Thomas Huth wrote:
> Fixes might still get picked up via the qemu-block mailing list,
> so the status is not "Orphan" yet.
> Also add the gluster mailing list as suggested by Niels here:
> 
>  https://patchwork.kernel.org/patch/10613297/#22409943
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66ddbda9c9..899a4cd572 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2404,12 +2404,13 @@ F: block/ssh.c
>  
>  CURL
>  L: qemu-block@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: block/curl.c
>  
>  GLUSTER
>  L: qemu-block@nongnu.org
> -S: Supported
> +L: integration@gluster.org
> +S: Odd Fixes
>  F: block/gluster.c

I'm currently trying to get more experience on Gluster (and also on RBD).
I'd add myself as a reviewer since I'm trying to review all patches in these
areas and I'm working on some fixes.
I could also become a maintainer, but I'm not sure I have the right experience
you want.

Should I send a new patch to add myself as reviewer (or maintainer)?

Thanks,
Stefano

