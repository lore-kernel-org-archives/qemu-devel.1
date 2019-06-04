Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2785DC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA45524AE7
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qpp7N4V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA45524AE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48727 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY51J-0002a6-9Z
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:42:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hY50V-0002EU-2c
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hY50U-00040o-6X
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:41:23 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:58745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hY50P-0003qn-KP; Tue, 04 Jun 2019 04:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=4pQLcnJcpvIw1jSzsnYj0z6R3znBXnp2ev+5s3BeyNs=; 
	b=qpp7N4V7LFzzYVmc+Q82lt6WPdmnaAmPyyGFv2bEpyb2fQ3iZLcFUKSPGNtkvpuw9yc5rhCbR2KIgPqihExKUnEIqQHFSIyjJ0BG2lBSTANAHSgboSU0w1BBMdGx22hhDZr/eC+bF4XMufLI18GZ3WOG1l6lg8UstyQK5l0pa819A/XvXB6Fje8zfp06FwF3049NkuNnBXsCrBvqkG4IAaHqvxx++avKIVZ7LlVdy4zsUOdmzAttNHTF19iE0o48DptVf06sLNQxJcmrBmP2ibeSlP5Cnsl8OeODkwDi1RRFH21c5Pt27IwwhuBnKe4bZg0d2yxUZ7ABD8zZN0tJQg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hY504-0003gx-OH; Tue, 04 Jun 2019 10:40:56 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hY504-00034r-LV; Tue, 04 Jun 2019 10:40:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190603202236.1342-1-mreitz@redhat.com>
References: <20190603202236.1342-1-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Tue, 04 Jun 2019 10:40:56 +0200
Message-ID: <w51pnntrbdz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] blockdev: Overlays are
 not snapshots
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 03 Jun 2019 10:22:34 PM CEST, Max Reitz wrote:
> QEMU=E2=80=99s always been confused over what a snapshot is: Is it the ov=
erlay?
> Is it the backing image?
>
> Confusion is rarely a good thing.  I can=E2=80=99t think of any objective=
 reason
> why the overlay would be a snapshot.  A snapshot is something that does
> not change over time; the overlay does.
>
> (I suppose historically the reason is that =E2=80=9CTaking an overlay=E2=
=80=9D makes no
> sense, so the operations are called =E2=80=9CTaking a snapshot=E2=80=9D. =
 Somehow, this
> meaning carried over to the new file that is created during that
> operation; if =E2=80=9CCreating a snapshot=E2=80=9D creates a file, that =
file must be
> the snapshot, right?  Well, no, it isn=E2=80=99t.)
>
> Let=E2=80=99s fix this as best as we can.  Better Nate than lever.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

