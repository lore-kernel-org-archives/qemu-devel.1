Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B76C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B89020717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YFdxCP+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B89020717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhIv-00054E-A1
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:32:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhHv-0004Sl-1V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhHu-000788-6x
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:31:55 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:52725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hJhHq-0006Cz-P4; Thu, 25 Apr 2019 12:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=260lxhZwbe/115x3VTvOafnw7zqv6AkHtR56y/B3fpw=; 
	b=YFdxCP+HmJWFeJIQTwBEaGQWi2s8FaRIe60NJuuzu/qEEY0zRUHQDXnUQo1y+hO78fVXrijRQAsPpfT7O/X/5KQ5/9g8ccrFH6VpA0fbDTqwkPDCp0zWTCc/6ji7adoG0Bv2/yjy2+EiyPdor0rEupC8Wc5VH+rohcsFTW5T+EBaIPp51Q8bcIit/WnfS5UfaWUSkvfHt6oLfqz6imgTOUtj04g5bjCNVkXjk0JltWGVe3cAZJza6peow1GkvTD7gEgcl0yQjcEM5WcQx3UZp0LtBJl47+UoRHESqGp3E8EbEJdwBdvkVov434aVjfmFELznUkxxINNFaTd4pLnmdw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hJhHR-0004Cb-P7; Thu, 25 Apr 2019 18:31:25 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hJhHR-0001lh-M9; Thu, 25 Apr 2019 18:31:25 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190417153005.30096-1-mreitz@redhat.com>
References: <20190417153005.30096-1-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 25 Apr 2019 18:31:25 +0200
Message-ID: <w51ef5q11ya.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 182 do without device_add
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425163125.PyxYnpaC6F5NBWmt0QBfpPKsTpR2laHh-BExzBasFGw@z>

On Wed 17 Apr 2019 05:30:05 PM CEST, Max Reitz wrote:
> 182 fails if qemu has no support for hotplugging of a virtio-blk device.
> Using an NBD server instead works just as well for the test, even on
> qemus without hotplugging support.
>
> Fixes: 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963
> Reported-by: Danilo C. L. de Paula <ddepaula@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Acked-by: Alberto Garcia <berto@igalia.com>

Berto

