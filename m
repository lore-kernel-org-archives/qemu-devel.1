Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FD7C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E032077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NXGSGDxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E032077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK1So-0005dA-Bw
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 10:04:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qx-0004YR-GJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qw-0006PP-Fe
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:35 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hK1Qw-0006Ny-70; Fri, 26 Apr 2019 10:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=QB9LKDf6jRbhHS1yqSko8P5SvpV/KSdunQMpKK+STNE=; 
	b=NXGSGDxfnngfxLyeeTrRz9AyrY0V1oy9Pg7PHmR7Y+MEw+X9sm+IhEGgsbFyZKGASdouZA1W1zKKxzjAefy3rKmUjXnvBM4ANqeHsb+wyky2yuv6GepKZlHypuuE1b8Zvh5Y2w/T32Ar5CvW9nF504d5jEG8l+riUIjar9n6OmaoaTgLlLMX+JAIIPUgW341rVaaanxhV8Shc6mzO8gFjHdSo0wGN8x64ZN/q0fWlwBa69n75iTpyUJ4/fCmHaPxMgcJhcBo6AiK96q51vl2wBsEoCGsge0CkCwHWAKo2E2y6izJhi5sVHwJRw6tKserKNK707tvxJ4FiIAoXi0GCw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hK1Qv-000686-2u; Fri, 26 Apr 2019 16:02:33 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hK1Qv-0000s2-0S; Fri, 26 Apr 2019 16:02:33 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
In-Reply-To: <cover.1554985749.git.berto@igalia.com>
References: <cover.1554985749.git.berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Fri, 26 Apr 2019 16:02:32 +0200
Message-ID: <w51sgu4g8zr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 0/2] commit: Make base read-only
 if there is an early failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426140232.f1-x0QStEAicmUAzgWCcAvA3n7MosdC3oupl9UtRDcE@z>

ping

On Thu 11 Apr 2019 02:32:26 PM CEST, Alberto Garcia wrote:
> Hi,
>
> this is the same patch I posted yesterday, but with a test case.
>
> Berto
>
> Alberto Garcia (2):
>   commit: Make base read-only if there is an early failure
>   iotests: Check that images are in read-only mode after block-commit
>
>  block/commit.c             |   3 ++
>  tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/249.out |  35 ++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  4 files changed, 154 insertions(+)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out
>
> -- 
> 2.11.0

