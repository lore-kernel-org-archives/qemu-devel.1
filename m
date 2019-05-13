Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B6C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36882208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OgJRzaLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36882208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBNL-0004B0-DT
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:52:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBLZ-0002eK-SX
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBJo-0006PB-EX
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:48:41 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hQBJo-0006Og-4X; Mon, 13 May 2019 09:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=yTO/i8kQ9l/2/EhGCTNpDDPi+O7TF6OMyYzwsJ5PsXY=; 
	b=OgJRzaLRHt8GMbcHWMYVAnNBET+Ny1a3l58AjrLryT8W+9PQYFdRrHmSHHxugIhLhG8kMp7Zlws12b5ULuyZTFS/QS7cjh7Lo+Hb38UOiVQ7FriF0eeyf9VZnQLzhdpoaGTHOBAh2NISHxWJ9Cyl0oDhzGqfsqJrcLzHBCZe7dMVCXoeb3FuVSicvcxNLxIyvKGVP6zKb+u1SlUHIgv7u0htia3OyKMLIoWM6THMyVH2Vb33sLB3AC0ICn+K4kUPmlcWR2QhEs7h2NPJQgbCDz1HC/Hcgd8zl0yBnKt5iOOgVchkoo0vA9dZOhh6y3ZYGGMJYFEM3Bu+r286zz9CnA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hQBJm-0003zE-SU; Mon, 13 May 2019 15:48:38 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hQBJm-0005J9-Pr; Mon, 13 May 2019 15:48:38 +0200
From: Alberto Garcia <berto@igalia.com>
To: Stefano Garzarella <sgarzare@redhat.com>
In-Reply-To: <20190513131440.kdtj6jchn3uo6ihq@steredhat>
References: <20190510162254.8152-1-berto@igalia.com>
	<20190513112846.ggnhopjwbopfexum@steredhat>
	<w51d0km7eyc.fsf@maestria.local.igalia.com>
	<20190513131440.kdtj6jchn3uo6ihq@steredhat>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Mon, 13 May 2019 15:48:38 +0200
Message-ID: <w51a7fq79e1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH] qcow2: Define and use
 QCOW2_COMPRESSED_SECTOR_SIZE
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 13 May 2019 03:14:40 PM CEST, Stefano Garzarella wrote:
>> Since the maximum allowed cluster size is 2MB, the value of the
>> 'size' variable can never be larger than 4MB, which fits comfortably
>> on a 32-bit integer. We would need to support 512MB clusters in order
>> to have problems with this.
>
> Thanks for the explaination and sorry for that!

No need to say sorry, the question was perfectly valid and it could have
been an actual bug, so I appreciate that you wrote the e-mail.

Thanks,

Berto

