Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4A6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E1E20692
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E1E20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5yNl-0001SW-Cn
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 16:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i5yN3-0000t2-2o
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i5yN0-0000hF-VY
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:28:44 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:59526
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i5yMy-0000YH-Qa
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:28:42 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.92.1) (envelope-from <johannes@sipsolutions.net>)
 id 1i5yMs-0004K7-M8; Thu, 05 Sep 2019 22:28:34 +0200
Message-ID: <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Thu, 05 Sep 2019 22:28:33 +0200
In-Reply-To: <20190902121233.13382-2-johannes@sipsolutions.net>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 
> +``VHOST_USER_VQ_CALL``
> +  :id: 34
> +  :equivalent ioctl: N/A
> +  :slave payload: vring state description
> +  :master payload: N/A

Oops. This message should be called VHOST_USER_VRING_KICK.

This file doesn't take about virtqueues, just vrings, and I inverted the
call/kick.

[...]
 
> +``VHOST_USER_VQ_KICK``
> +  :id: 4
> +  :equivalent ioctl: N/A
> +  :slave payload: vring state description
> +  :master payload: N/A

Similarly, that should be called VHOST_USER_SLAVE_VRING_CALL.

Anyway, some comments would be appreciated. I'm working on an
implementation now for my simulation environment, and I guess I can keep
that private etc. but if there's interest I can submit an (optional)
implementation of this for libvhost-user too, I think.

johannes


