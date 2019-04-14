Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90242C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 15:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5257E20880
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="Evihb5zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5257E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFhLX-0002Me-Mi
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 11:47:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIX-00005A-7K
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIW-0002wh-EY
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:44:01 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:59496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1hFhIT-0002lA-SH; Sun, 14 Apr 2019 11:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
	; s=25047;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=r0e03arzJ3GBOK/RJoYs73vAufjJczgRx88ZGd6NnAE=;
	b=Evihb5zc1fPbGr4Q0jAJwbH5Ow
	cpg6l3hTGNzp6aS2iS9jTcXbZJ1f7bJIMPuu9lSDxyYSOjSpY+sPKM428MgrFwenr7MdghJNYGG4t
	gohpqrn8Jz5UZH3BdCD8EWLmNJFmvUgXYBhCy5DVvSsvBxj8jQKtLLLstFthowlEfK6g=; 
Received: from rob92-5-82-227-227-196.fbx.proxad.net ([82.227.227.196]
	helo=[192.168.0.35]) by iserv.reactos.org with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <hpoussin@reactos.org>)
	id 1hFhIS-00064Q-Qe; Sun, 14 Apr 2019 15:43:56 +0000
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <ec7f01c8-815b-8743-a321-5a4b56e37ea5@reactos.org>
Date: Sun, 14 Apr 2019 17:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
Subject: Re: [Qemu-devel] [PATCH 3/4] target/ppc: improve performance of
 large BAT invalidations
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414154355.Xchv2eDp3zUu6iycLZWh0Oup1KJrXnSB5f0HVxFnzuk@z>

Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
> Performing a complete flush is ~ 100 times faster than flushing
> 256MiB of 4KiB pages. Set a limit of 1024 pages and perform a complete
> flush afterwards.
> 
> This patch significantly speeds up AIX 5.1 and NetBSD-ofppc.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   target/ppc/mmu_helper.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

