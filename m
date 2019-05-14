Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14BDC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB9121473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="W1sggecQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48065 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQX8X-0000I1-Rf
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:06:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQX7i-00085u-P7
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQX7e-0003ez-6v
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:05:38 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:45166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hQX7d-0003L4-Ik; Tue, 14 May 2019 09:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=DS1U4WKVcGeNyaskPkHdvkIh17sO8DmpDx78GKgIw+8=; 
	b=W1sggecQJTM52dg5zMklrdZWz865n+fOaeASPc346Ag+UsymWFAj5mNHpSAUrAAm5q+96+xlgiNjo0NYGUlIsymvN7ES9PuOSFaJRNFXHlv/euEYmD22VfMF3gbkOyAnxNnKP/2wD6bdUOHf2R8gkJFDQec9dAZZHdJTxPjnngXY1EWuVJewHi1UII5+zv/4+gCGFcFzX1O/WqhOXQjQL+NqBRRiuIup9fsL3VKqHgCqQXCJfA1jFZRaX997AWlyqvFakI1qfKrDmXzCpehb7UjnAa4gUjD3dhQfIr3SL3uNoVoTA6oNSEU6ypC+GRqtlQhWjZW79NEmmfq5Mz1p2g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hQX7M-0007To-2m; Tue, 14 May 2019 15:05:16 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hQX7M-0001WM-0I; Tue, 14 May 2019 15:05:16 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <f3214198-33ed-5689-2831-802d26a88d21@redhat.com>
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
	<1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
	<w515zrkveul.fsf@maestria.local.igalia.com>
	<5f16da0c-d689-b06c-883b-3911a2c9ff9d@redhat.com>
	<w51k1etqnmk.fsf@maestria.local.igalia.com>
	<f3214198-33ed-5689-2831-802d26a88d21@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Tue, 14 May 2019 15:05:15 +0200
Message-ID: <w51h89xqj90.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qemu-iotests: Test the
 x-blockdev-reopen QMP command
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

On Tue 14 May 2019 03:02:33 PM CEST, Max Reitz wrote:
>> Why would both be fine? backing_file refers to the backing file
>> currently attached, and auto_backing_file refers to the one written
>> on the image metadata, or am I wrong?
>
> After my series, backing_file refers to the image metadata.

I see, clarified!

Berto

