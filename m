Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A2FC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 17:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19A5206B7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oBlrtRfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19A5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFMrA-0000lL-K9
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 13:54:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFMqI-0000PS-7O
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 13:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFMqH-0000Og-92
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 13:53:30 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hFMqG-0000NC-LD; Sat, 13 Apr 2019 13:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=45ifwiIzlE4cIrJYo5KkZTWldnMSQLRiIRmjoS8vlwc=; 
	b=oBlrtRfd817GGHP77fNYteLILSXTJSXJy8t6XO5XbJ80unuCnOOpxeaP6KFiwt5igf2KB0L3a/T0nZli/J4psKHFJAZZZ9osAHQ7yjDsg9r8hHHQy+Cm5l4U4mLQNBzrU2ghWHLbnU8tWqg6pXImiWZrLu+opsqWBjAYZ1i6qKiTLSmojJVWyfyxU8Oouyaf0RPBIWgoEbJ7LDA6ya5NSDdrQs2cOYFaMJOtg3Xj9jy2c3yg2DcWCGZvAA8tlS9iJRGRe2HkkwIiAGjhpz/AQ4Gtyu2kJ/uXk/6FZXuRXaWIepz9YcvmzpVG7ZXjckwkimpLHFPJeIMBC9Lz6sNthA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hFMqE-0007Vd-99; Sat, 13 Apr 2019 19:53:26 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hFMqE-0003Hg-6R; Sat, 13 Apr 2019 19:53:26 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
References: <cover.1554992449.git.berto@igalia.com>
	<6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
	<w51zhoufg2l.fsf@maestria.local.igalia.com>
	<b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Sat, 13 Apr 2019 19:53:25 +0200
Message-ID: <w51zhotu6zu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413175325.6vlLR9lRQe3nex5FQutJBqVMueqrqIMisgh1YC-Rq-s@z>

On Sat 13 Apr 2019 05:48:11 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
>> Ok, you can leave out the second patch then. The first one should
>> still be correct, right?
>
> I just think it=E2=80=99s unnecessary because as of my series both
> backing_file and auto_backing_file serve the purpose.

Ok then!

Berto

