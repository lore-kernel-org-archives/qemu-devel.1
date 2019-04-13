Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A07DC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 08:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF05A2084D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 08:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="C1hOqbwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF05A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFEKS-0003ub-55
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 04:48:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFEJE-0003Tp-98
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hFEJB-0002PU-E4
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:46:48 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:51285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hFEJA-0002FT-Om; Sat, 13 Apr 2019 04:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=EjNRL3a620Vn8jmgGxel+Z3rIvVuLJPo8qJcxtRNH1M=; 
	b=C1hOqbwckKNQPe2qp0Ruf4grimiF/PxI7RPQzUH7rNBf1xHLz1v48yTF1CrEkIPFVe5PP7BGM6e885egkG5QcAPcGSWEG0iGwc38js9dLciMXppbR/gRi9SWaKjxfWO45XkhrB+vJhC1xl5yxDEtjXkYAdjEpgAjLLeeZe26ouutOCOCTvD8Z+c0Qjr22ykGQ/f1fuaYYybCK2cFl7C8ljKgqgn01qoRZMmOf1fW0cGp/VcxqJysUZmMNfL1RfTUL6FNFX3uUd0gwb+RXJl1C52/k62HY1wk+Xw1fXFRTN/djjerD2wdUNU31Ndh4IgwrW/iU80+spUWamX/Ec1yRw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hFEIs-0001cE-NY; Sat, 13 Apr 2019 10:46:26 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hFEIs-0003mH-KZ; Sat, 13 Apr 2019 10:46:26 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
References: <cover.1554992449.git.berto@igalia.com>
	<6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Sat, 13 Apr 2019 10:46:26 +0200
Message-ID: <w51zhoufg2l.fsf@maestria.local.igalia.com>
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
Message-ID: <20190413084626.oSNelosS2Qdln_5YU_KNZ5wEhzjsEnkRXX6t21Ll0aM@z>

On Sat 13 Apr 2019 02:56:57 AM CEST, Max Reitz wrote:
>> Patch 2 fixes a different (but slightly related) issue that I found
>> while preparing the first patch.
>
> I think the real problem is that bs->backing_file is not a cache for
> bs->backing->bs->filename.
>
> In fact, every user of bs->backing_file expects it to be something
> different.  Some expect it to be a cache for
> bs->backing->bs->filename, some expect it to be what the image header
> says (i.e., it if=E2=80=99s a relative path, it=E2=80=99s relative to the=
 overlay),
> some expect it to be what the image header says, but relative paths to
> be translated so they are relative to qemu=E2=80=99s CWD.
>
> All of this should be cleaned up and this is what patch 7 in my "block:
> Deal with filters" series does:
>
> http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html

Ok, you can leave out the second patch then. The first one should still
be correct, right?

Berto

