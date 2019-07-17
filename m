Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D89C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAD721849
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAD721849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnrt3-00045v-1D
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56623)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dray@redhat.com>) id 1hnlh2-00074q-PX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dray@redhat.com>) id 1hnlh1-0007fb-P6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:18:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dray@redhat.com>) id 1hnlh1-0007dQ-Iz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:18:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so22565014wme.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 08:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o50Mwg1Y1mDbKxrHHfq/0CW5EviszAvkc2BP4jNdftI=;
 b=AkSyOtOkZ+NP6TDBfqQUOx8qFBeDWZ3sYA811O3jUXTYjJHNdsk4zg+FZsnF5L6jAH
 nPMicejFplrYbAMC4kAmJkXPFy+7F8+m5fkAi2t6T/nnPXNrYF2nBefpc2aZAIW7GLQC
 RkcdxZjt451A+EKBm7TFEgV1Nt94pcZqPssZEnk6185JQwJQM9y6TwOvy1l+1rahWs5E
 /2513xdDHiUCRg+EPPUdqKrDSZoYLRd5alDlrlLFWC3GcjiOYi30yFt4vGRZF952PnMj
 cbECl4y/TQsfEroFyBHFUdHtmMNO2QUWrcYd6W7SRt1oUx1zHC68IzpFTrDD8uuH0kiz
 ymLQ==
X-Gm-Message-State: APjAAAWW95TnNbjRAxPaHnLkwEQV5uiwuhmd4NM/ccox0fSKTLbuxo2o
 mScdXSSxGm8Sxcn4aoa7Ijl/tQy8e5tYDr3LY/o20A==
X-Google-Smtp-Source: APXvYqzmNyhtGvzFzN4NxVFAXytvCF4y/lR9hvM0XbAO66a7yneaFfDHyQP+q4u7aG1lqGv53WvPOKBtq1csVyQnemo=
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr35957425wmi.146.1563376685565; 
 Wed, 17 Jul 2019 08:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190709194330.837-3-marcandre.lureau@redhat.com>
From: Debarshi Ray <dray@redhat.com>
Date: Wed, 17 Jul 2019 17:17:54 +0200
Message-ID: <CADVaYxbhJX2Fp-nNYqLN4fY+A7pAW5wTTfkg3iNgM9p5BJASNA@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
X-Mailman-Approved-At: Wed, 17 Jul 2019 17:54:35 -0400
Subject: Re: [Qemu-devel] [PATCH v2 2/5] tests/docker: add podman support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Debarshi Ray <rishi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hey,

Sorry for the late response. I was on vacation and away from my keyboard.

On Tue, Jul 9, 2019 at 9:44 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> With current podman, we have to use a uidmap trick in order to be able
> to rw-share the ccache directory with the container user.
>
> With a user 1000, the default mapping is:
> 1000 (host) -> 0 (container).
>
> So write access to /var/tmp/ccache ends will end with permission
> denied error.
>
> With "--uidmap 1000:0:1 --uidmap 0:1:1000", the mapping is:
> 1000 (host) -> 0 (container, 1st namespace) -> 1000 (container, 2nd names=
pace).
>
> (the rest is mumbo jumbo to avoid holes in the range of UIDs)
>
> A future podman version may have an option such as --userns-keep-uid.

The future is here! :)

Since Podman 1.4.0, released on 7th June 2019, you can use
--userns=3Dkeep-id instead of typing out the entire UID mapping. The
relevant Podman pull request is:
https://github.com/containers/libpod/pull/3196

Cheers,
Rishi

