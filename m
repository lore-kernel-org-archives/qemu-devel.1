Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E25C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20544206A3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edZUaSYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20544206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTovf-0002mn-Dz
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:42:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTouY-0001kH-6t
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTouX-0004K0-6T
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:41:38 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hTouV-0004Fi-7M
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:41:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id n14so5671422otk.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QBmnu1LEmcuyOzLtmMtO+yAs7pP/eUMlcW70tRmCsiY=;
	b=edZUaSYZg8WHocXE30PmdS9NHHHsnT8ZmKwF5+ZnzKEJ87s4KYIo6Ivbp8PrZQlVCH
	MUE8/Sxg2IxqWMTTZ1kMzkv6HOILobHtqvBVNJVaQvCBcnOrMkPNu3AT0P+9w3ySZ0oj
	kotydb+smt9ecozOgWowNKYODBkYi1kDOFUaUaMJI5CmQ0+jFwA3PqfRG3lTqK4+cPOK
	sunO+bNiOqO6dG9cV1OK3UDjbmoIxSpRawUBpUpOGXF4GopdCbhv9IxOL/52IbEPESyb
	0SehgGXNef3WWbSheUj70BeJayzWOiFSkMaIo89eEYulqD+J60wInc/Dcq7g5C/HRGeu
	91QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QBmnu1LEmcuyOzLtmMtO+yAs7pP/eUMlcW70tRmCsiY=;
	b=Kzj8IgG3gtqq+7KK5VltLk0usu0dHUV81hzZyGj95HXzJ2HGaY1IuJeqG6e7LBUQLb
	buerihmSAnBsgblen6A5aYMZotkfKQKHyBj+c0ZdzMo4vkkT5QxFX3pRhyP5nX8aA6rj
	TOaZkleEAuDObMRc0yp6HK1Q9f0EISa6Yhit6DPI1RQMfUQxxOFiLdYrtBO6nrPzEMLw
	tYupGpyI+CPqO6Pxa5UO9jxf7397ia9nwpSuJFCJozfoof6uL98OZ4rBbR2OYFj5wuUi
	CzSSfLoWMsLm8xx0wmiQPxkbd4D16pg/oLbVCVRV9NqkV0UcGXZ4l0l0xehz27vbU+E/
	HVIQ==
X-Gm-Message-State: APjAAAXuMzTE1zbA1ogvqZ/oh5qrW2Q5Gb5SQDH9UwaQHDT2WSnhqQDE
	REDziuRdtZRTc2nd0sZImTEUJ65CVOHKn7jtAnc=
X-Google-Smtp-Source: APXvYqygrOm5yXUSAqIlzuakeusNYiyGsqOCm5Z0qlbnOO3HNuGKS1EFt61JKl1e2yIg91Laj/1LHd3CzSqH6FL9jp0=
X-Received: by 2002:a9d:7d9a:: with SMTP id j26mr6360770otn.102.1558622489921; 
	Thu, 23 May 2019 07:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
	<20190523115950.GH26632@stefanha-x1.localdomain>
	<41d64b8971a097d1568f947517b45d09c156ccc8.camel@sipsolutions.net>
In-Reply-To: <41d64b8971a097d1568f947517b45d09c156ccc8.camel@sipsolutions.net>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 May 2019 15:41:18 +0100
Message-ID: <CAJSP0QWSZXT3OJAc=abagD40xZ7DWWrcP_+AwVBuqQyQNgaOEg@mail.gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
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
Cc: ido@wizery.com, linux-um@lists.infradead.org,
	qemu-devel <qemu-devel@nongnu.org>,
	Linux Virtualization <virtualization@lists.linux-foundation.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 3:25 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> Not sure I understand why there's all this stuff about multiple FDs,
> once you have access to the guest's memory, why do you still need a
> second (or more) FDs?

The memory regions could be different files (maybe additional RAM was
hotplugged later).

> Also, not sure I understand how the client is started?

The vhost-user device backend can be launched before QEMU.  QEMU is
started with the UNIX domain socket path so it can connect.

QEMU itself doesn't fork+exec the vhost-user device backend.  It's
expected that the user or the management stack has already launched
the vhost-user device backend.

> Once we have a connection, I guess as a client I'd at the very least
> have to handle
>  * VHOST_USER_GET_FEATURES and reply with the features, obviously, which
>    is in this case just VHOST_USER_F_PROTOCOL_FEATURES?
>
>  * VHOST_USER_SET_FEATURES - not sure, what would that do? the master
>    sends VHOST_USER_GET_PROTOCOL_FEATURES which is with this feature
>    bit? Especially since it says: "Slave that reported
>    VHOST_USER_F_PROTOCOL_FEATURES must support this message even before
>    VHOST_USER_SET_FEATURES was called."
>
>  * VHOST_USER_GET_PROTOCOL_FEATURES - looking at the list, most I don't
>    really need here, but OK
>
>  * VHOST_USER_SET_OWNER - ??
>
>  * VHOST_USER_RESET_OWNER - ignore
>
>  * VHOST_USER_SET_MEM_TABLE - store the data/FDs for later use, I guess
>
>  * VHOST_USER_SET_VRING_NUM - store the data for later use
>  * VHOST_USER_SET_VRING_ADDR - dito
>  * VHOST_USER_SET_VRING_BASE - dito
>  * VHOST_USER_SET_VRING_KICK - start epoll on the FD (assuming there is
>                                one, give up if not?) - well, if ring is
>                                enabled?
>  * VHOST_USER_SET_VRING_CALL - ...
>
> I guess there might be better documentation on the ioctl interfaces?
>
>
> Do you know if there's a sample client/server somewhere?

See contrib/libvhost-user in the QEMU source tree as well as the
vhost-user-blk and vhost-user-scsi examples in the contrib/ directory.

Stefan

