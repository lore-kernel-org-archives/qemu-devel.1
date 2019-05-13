Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7F7C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979FE208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Lakp+/6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979FE208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9Yr-0001vl-Uw
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:56:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQ9XB-0000pR-Fg
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQ9Rq-0004W8-J9
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:48:52 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hQ9Ro-0004NL-IP; Mon, 13 May 2019 07:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=7hYwN2m6a89sqlEMo1+JeIA5fLxGN2G2ug2Twog+0mo=; 
	b=Lakp+/6l43G2Rv4u/YGiKaEX28XU0mZTmB7HQTpteU/3vZMJzLTD9VuLuA1Qzb8V14C84h+2alO+iYFG/M7dki6WdT/04qtCux06lwCOWG6CemOmmZAx7uNQ+hPalSDvTQ9+wrJGDhlhAKdVm15gpAn8ElHBx97+/CTShf2SV5angON1Liwtry+jq3+QM4LrfQ74xLNBSAZbeIpEv2SvHZ2rR3efZQCu1/+/GkzbM5q8kO0XUUd2/Uc0qj57eVW5iEpvmMxAjXCjBd7iBDofnd54aF5s4hktsFPtzXwwyR3rHe0y9f8dczJCV9OVJa3zoqhGEZFAEuKVdez+t+nBJA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hQ9RU-0004cm-39; Mon, 13 May 2019 13:48:28 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hQ9RU-0000Ck-0h; Mon, 13 May 2019 13:48:28 +0200
From: Alberto Garcia <berto@igalia.com>
To: Stefano Garzarella <sgarzare@redhat.com>
In-Reply-To: <20190513112846.ggnhopjwbopfexum@steredhat>
References: <20190510162254.8152-1-berto@igalia.com>
	<20190513112846.ggnhopjwbopfexum@steredhat>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Mon, 13 May 2019 13:48:27 +0200
Message-ID: <w51d0km7eyc.fsf@maestria.local.igalia.com>
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

On Mon 13 May 2019 01:28:46 PM CEST, Stefano Garzarella wrote:
>> +            int size = QCOW2_COMPRESSED_SECTOR_SIZE *
>> +                (((l2_entry >> s->csize_shift) & s->csize_mask) + 1);
>
> What about using int64_t type for the 'size' variable?
> (because the qcow2_free_clusters() 'size' parameter is int64_t)

The maximum size that can be read from a compressed cluster descriptor
using the formula above is twice the cluster size (more information on
commit abd3622cc03cf41ed542126a540385f30a4c0175 and on the Compressed
Clusters Descriptor spec in docs/interop/qcow2.txt).

Since the maximum allowed cluster size is 2MB, the value of the 'size'
variable can never be larger than 4MB, which fits comfortably on a
32-bit integer. We would need to support 512MB clusters in order to have
problems with this.

Berto

