Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BFC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B1A20835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uenzC9/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B1A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGjiy-00077k-3K
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 08:31:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGjhw-0006df-Eh
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGjhv-0001mo-Jp
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:30:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hGjhv-0001l5-Cg; Wed, 17 Apr 2019 08:30:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so31757861wrm.4;
	Wed, 17 Apr 2019 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=vVP14952c+TRGsSJef7aqgCspSCS1LOR9EvMeWOWw/w=;
	b=uenzC9/okbKAiinj10fpbro/dM6firysYEjav06mKClixKvO7MVTyl2GJ6M6LKXExW
	DRkgJ77koI3dMDddoNDgMLraFo+DvwkQRIDEVK6QKdPhg7wYoc+CPjSLIBWCLuyOuHAM
	AEEyqq6qYj6i9ERoEzwqadzZEXWJSOi8zyIY1h3RU+6uoOs2wUNBvGFmsqYFxupIpLr8
	vgdN/49TQdn8tj5kL2YwHia9Dn5XFdc/+/mQq7CiyyocfEa36b8xQaJasRxT2RF5xDGX
	5IrWx7kJ9u24M1ITHLDSJ8TsWnnnsuNkXpbEbjEcicCyuJ+aDx/dh2QFxurvU4+LDaR/
	O/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vVP14952c+TRGsSJef7aqgCspSCS1LOR9EvMeWOWw/w=;
	b=izGzoTjdpNI9BikinBSVyHVQrYRS37pyh9ISq+Dtvd9ke+btEjYt+wsWdXPmBlBzwT
	G7vJnoMA9gnmlU2yo8HanX2vxQcmDVrB+Lr9YG0RRhhc04qM4+8uBROLXxkn6D4q2bb4
	up1cI+hZeMF4kv+g0UUKrtM2GPJDWiR3PqN8k2qdNBs8ZZo67i6vQKBBNHv2rCA1Xc0T
	uqoaDV5N65dTAyTaPlcnAqiNo5D4sRpMbDeFmVVSXxEJSqSbYx5XugqNf/PZK4GjlsTl
	AtPo0tOITiGXlaBpHUNIujrU7+q9EjatFWNi97XgT7reYqcxspIdJzE2/sLXRAKwrSXs
	4FKA==
X-Gm-Message-State: APjAAAUKbG7dw8mfSF5Y6kPmqk/mJuEN8Sjl4rjp3xHD/NeB1yLSqSvY
	g8Q8sHPjOSkzeYGp2vb/3a25fNleMeRms22yyU8=
X-Google-Smtp-Source: APXvYqwr1EAvnGEiV9AzNa3l4Iq9EdUWblOjjJcNdfpTWceAGC+D1Sg5YWE3otAGoojdUu8ZjhV9Kj+2JhYsZtbOS6c=
X-Received: by 2002:a5d:6150:: with SMTP id y16mr34598019wrt.13.1555504230168; 
	Wed, 17 Apr 2019 05:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190417115343.30527-1-pbonzini@redhat.com>
In-Reply-To: <20190417115343.30527-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 17 Apr 2019 13:30:18 +0100
Message-ID:
 <CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
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
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417123018.ZltwUDgBwRvINyqBzI4zja2jQ8fTAOvb_Ejf6d_vpwc@z>

On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
> from exceeding these limits, by capping the maximum transfer length to
> that value in the block limits VPD page.
>
> [1] Oh well, at least it was easier to follow the kernel source knowing
>     it had to end as ENOMEM...
>
> Cc: qemu-stable@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

