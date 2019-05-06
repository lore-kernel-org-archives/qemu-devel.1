Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33411C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C5520830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 10:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="d228zJ7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C5520830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNazg-0001PS-77
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 06:37:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hNayg-0000w8-Cq
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukasstraub2@web.de>) id 1hNayf-0008BT-2L
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:36:10 -0400
Received: from mout.web.de ([212.227.17.12]:52753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hNaye-0008AQ-6T
	for qemu-devel@nongnu.org; Mon, 06 May 2019 06:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1557138947;
	bh=4j8FL9g6gVrZ+bFrk1QDPPWCE2RP5egzfvDj/PhUNOA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d228zJ7/IcdgO5xP/Rsea+GfWztYlSfEtvMHgeD8NMch7JTtj3YISUOmE32cnQUgX
	Q/0f4nQX66tPQtcPmwBUxvl5oyNhG03+awJAbPY0lzwJ8NnyqESKPiiOZPKC0/u38T
	0UUiJ9JKB5WUj00RFgJ4x0dMFgAYNDF4+7ye/ThY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([2.247.244.216]) by smtp.web.de (mrweb102
	[213.165.67.124]) with ESMTPSA (Nemesis) id 0LfAsW-1gvB7b1xSC-00oldJ;
	Mon, 06 May 2019 12:35:47 +0200
Date: Mon, 6 May 2019 12:32:58 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Message-ID: <20190506123020.23d168a3@luklap>
In-Reply-To: <20190420191425.7d1dab82@luklap>
References: <20190420191425.7d1dab82@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jJ7J1bz3oXyb0T7rWBo+Bx4A/RRblLGlMQWI+iZ4Hxa9bf2pZbO
	eOHnQLzenNt4TLjN9D2RtZmkluE4dncEsv+qcyMnDTWafYey978fLWXXb3L25BNTnN2bbrU
	4aNAeXXXZYD6yRaQnk9jq2Ibz2cFZ4KFI49zIZaEKDn0ejJajFRelnTLEP4yDW6rJ14pSSZ
	HpVRYl4DpnzQrTvJNgzJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:afxIkHm0k0s=:IEW7apg4qf3rXm4JZ1e9L3
	vUVLM3UjZmn/RybZ3GonKqbkvnnLM/XkO5nvRmILA8RRpXjwffvGhccMlx1jKGUBoqDSmP12k
	I+DyoYerwKkO4rb6qsBZ5h4qBeJbHqroUHz+EcfGSFA0nJYnSU/hZ6nU0ZXlHMed6fuK6MEGG
	HGdunWuGT7vn/NZF3jvtCWlN0ri6tq8QUppl0ZIiO30hRmqr6bk3XSxg/cvaUFC4zc+Uta/tm
	JJMUBbr57aORSPBL4aYhvg4nEWyux/S8y3IYLCQtE/U/zrFFW3u7uZ1arpOs5omZM6x/zm2sg
	pmcMvKZPq/oYkumvxiZKzh5LCtN0Ca7oQ4y0h3kNukmvd8nGspza8jPmDSdUMli/HMIDEDYor
	YLhsJvcPAkp5biAqVTcHwoAj6b6xpujYlJtZfH2Lu2rni4lJvKWidbEjBmEMrWANFh13K+Y01
	N8LH/DBOeLtt+sQHpvFGIydHuCvnkSMjHqH+ws6iHA1/kyMUOoCQXtmBpWKvRhMfAPmX+PIMe
	mAk27/MdGbuSReHW5pOcNb871QV5knLWHBhic9ixYBm3V0q3T1raPyrahBykVoet8mGUVWOvQ
	B/vEFWsqSesVArO0IqP1g9RqLvEyFxG1KdmaouRuIXKqCN0UCL/9MMyrXO/hKXve/pHkaAmuj
	gocSUH+q6MmV1Lm7e9VjI7jsZfYLmfP6LqjH2ZWHsZFXEXfTlXesqpdNZXVPn4EYsjNJYhCw2
	jzN6B87tciaJBKyPBaimie1Lm84T0w5vMyl4WM7k+XNdh2K5+JpuV6JZlJrGSDHL/IqQUqIbw
	XmDm2ZQAUdIP6p/9yNwNS7Aze/odfBVM8l89RawHyqTQEcsdgvk8zF+t4qMlvPB/x8/OmtHCh
	FNPFdLHY2HjSX19N6fu67ZxptLEIuQn/uUhY+Yx1aNh+iWTLuY20n2blqURxBJwyRdCudYcl5
	WVHDIwODWTg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
Subject: Re: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
 Primary.
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 20 Apr 2019 19:14:25 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> From: Lukas Straub <lukasstraub2@web.de>
> Because event_unhandled_count may be accessed concurrently, it needs
> to be protected by taking the lock. However the assert is outside the
> lock, probably causing it to read garbage and aborting Qemu
> erroneously.
>
> The Bug only happens when running Qemu in COLO mode.
>
> This Patch fixes the following bug:
> https://bugs.launchpad.net/qemu/+bug/1824622
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index bf10526f05..fcb491121b 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -813,9 +813,8 @@ static void colo_compare_handle_event(void
> *opaque) break;
>      }
>
> -    assert(event_unhandled_count > 0);
> -
>      qemu_mutex_lock(&event_mtx);
> +    assert(event_unhandled_count > 0);
>      event_unhandled_count--;
>      qemu_cond_broadcast(&event_complete_cond);
>      qemu_mutex_unlock(&event_mtx);

Ping.

Regards,
Lukas Straub

