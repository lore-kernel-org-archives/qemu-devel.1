Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC044C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9491F204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9491F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBRI-0007B5-Tb
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:44:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBN4-0003mt-DI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1hUBKh-0005Ea-Ed
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:38:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1hUBKh-0005CL-9D
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:38:07 -0400
Received: by mail-it1-f193.google.com with SMTP id g24so9185920iti.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 07:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=FdJYPDFiEFFLHEHBWUkMb0ILUUgjduaY+xZlCH9Vv7c=;
	b=JYLTOjoa2I441u4AndR8/zsgusda8WSrkoBabFMiIIY1TxsthmlJvm8pvVDlig5q3u
	s6WGfApbCe3DGhMvicIwc4caQhw0DSZUDpYXbIt8vimrK5kKRROAqTq46xwMAE7DEZ8T
	j7gwqqAA+IKSwtYZoMjYZLD9wvUd48e6g2w6y+jVM7lHJj1GdbVaFc14HZNNgTY+SksF
	3jYUkLao7smp/ggJNBfvouIKZDd6m7sTVMh9O+d0Q2jTCTtMp29ikvevbztTToRQO2PZ
	sF0xE5BuBKJyNWEQDvMtzdUQFi9OAMqE8kQ+1jTDqAUjU5gIyKNlnYF6B9BXcIw9AnLl
	f5yw==
X-Gm-Message-State: APjAAAVBnnqB41qUA9HvqNsYOX4tAg9o8+TYdLGpVx8hSvToLUHL5r6Y
	bM9vnJNHyejqEfVvcJft8Dhzm2md6rNbXG9krtU=
X-Google-Smtp-Source: APXvYqzX5IUdqpGVQPobzlKLb+XEQ/aYdeAxTdr2iqwUsRH/1IwDv3xFOFkR863kOaGwJLitIpFPM6+ZMr9d36i+9N8=
X-Received: by 2002:a24:ac52:: with SMTP id m18mr16899304iti.146.1558708685903;
	Fri, 24 May 2019 07:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190521141133.27380-1-lvivier@redhat.com>
	<20190521141133.27380-2-lvivier@redhat.com>
In-Reply-To: <20190521141133.27380-2-lvivier@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 24 May 2019 04:08:54 -0400
Message-ID: <CAPyFy2CfuHJnmGGfrHNvG+enNrdbR9ecUiOdqmfv5McKkK1GeA@mail.gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.166.193
Subject: Re: [Qemu-devel] [PATCH v6 1/4] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 10:15, Laurent Vivier <lvivier@redhat.com> wrote:
>
> From: Kashyap Chamarthy <kchamart@redhat.com>
>
> [...]
>
> Given the above, change the entropy source for VirtIO-RNG device to
> `/dev/urandom`.
>
> Related discussion in these[1][2] past threads.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.htm=
l
>     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.htm=
l
>     -- "[RFC] Virtio RNG: Consider changing the default entropy source to
>        /dev/urandom"
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Ed Maste <emaste@freebsd.org>

