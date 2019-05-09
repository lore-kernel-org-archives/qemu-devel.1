Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F7C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327B6216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327B6216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOiH4-0008OU-5B
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:35:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hOiGF-00081l-SY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hOiGE-0005Q0-VV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:34:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hOiGE-0005Op-RE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:34:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id j1so1279503qkk.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 05:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=8XmsuH2o0LvBvg5tUckPQbDc8c87HJ4A7XWUd1kSXvs=;
	b=nEXREVinMuvDidBgPzFqi7DOr8ck1A0mY11ewL4b7r74o3DalJR8whd84Rw2KMH9Oc
	3pUiqcfl8QrEnOuP/6ruqGjayoWYVBF0YNfoYNLYtqcBQITCIGOpNY4lA6hxfwADN6+A
	KhJXle423blvSCASIe6L6oQ6uY9w2xRqNdXsHYhrYTkoeXixnT7MOTk2PacCPh9lUpv8
	VXjUnxQ61nlgs5qNJoSF6QlH5QNB8UxSZu8Vzki3cCcuqjogzaSbBpJmqiaeQN0GhSHi
	V55UAqagFjKcFeC/99i77i2/n7+lIKrP6pnwGESEux0mGaM4aqomlVPNG8FrBXHmNMwX
	eSRA==
X-Gm-Message-State: APjAAAWCoFTVyidFSK6b+JhqcKCtYnDBwXqUYM0noMX/ZaEgM/6KwL3f
	rrP1el4/LSuSq7MJpB30a1qQkw==
X-Google-Smtp-Source: APXvYqz+NHhgOjjuC31IWvHCko1R6u4f8L2rVmc4T1YZHjdvPhSfnyN8OnDHyJhp+ktJMdTu0JO97g==
X-Received: by 2002:a37:4e4d:: with SMTP id c74mr3100181qkb.230.1557405293406; 
	Thu, 09 May 2019 05:34:53 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id q3sm984259qtd.2.2019.05.09.05.34.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 09 May 2019 05:34:52 -0700 (PDT)
Date: Thu, 9 May 2019 08:34:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190509083409-mutt-send-email-mst@kernel.org>
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503130034.24916-1-marcandre.lureau@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Add vhost-user-input
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 03, 2019 at 03:00:28PM +0200, Marc-André Lureau wrote:
> Hi,
> 
> This is the vhost-user-input part of "[PATCH v6 00/11] vhost-user for input & GPU".
> 
> v2:
> - build fixes
> 
> v1: (changes since original v6 series)
> - add "libvhost-user: fix -Waddress-of-packed-member" & "util: simplify unix_listen()"
> - use unix_listen()
> - build vhost-user-input by default (when applicable)
> 
> Marc-André Lureau (6):
>   libvhost-user: fix -Waddress-of-packed-member
>   libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
>   Add vhost-user-backend
>   Add vhost-user-input-pci
>   util: simplify unix_listen()
>   contrib: add vhost-user-input

OK looks sane.

Gerd, IIUC you are going to merge this right?
If so

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

thanks!


>  include/sysemu/vhost-user-backend.h    |  57 ++++
>  backends/vhost-user.c                  | 209 +++++++++++++
>  contrib/libvhost-user/libvhost-user.c  |  10 +-
>  contrib/vhost-user-input/main.c        | 393 +++++++++++++++++++++++++
>  hw/input/vhost-user-input.c            | 129 ++++++++
>  hw/virtio/vhost-user-input-pci.c       |  53 ++++
>  util/qemu-sockets.c                    |  18 +-
>  MAINTAINERS                            |   4 +
>  Makefile                               |  11 +
>  Makefile.objs                          |   1 +
>  backends/Makefile.objs                 |   2 +
>  contrib/vhost-user-input/Makefile.objs |   1 +
>  hw/input/Kconfig                       |   5 +
>  hw/input/Makefile.objs                 |   1 +
>  hw/virtio/Makefile.objs                |   1 +
>  16 files changed, 890 insertions(+), 19 deletions(-)
>  create mode 100644 include/sysemu/vhost-user-backend.h
>  create mode 100644 backends/vhost-user.c
>  create mode 100644 contrib/vhost-user-input/main.c
>  create mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-input-pci.c
>  create mode 100644 contrib/vhost-user-input/Makefile.objs
> 
> -- 
> 2.21.0.777.g83232e3864

