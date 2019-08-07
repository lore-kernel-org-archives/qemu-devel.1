Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F0FC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A653921E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X16MA+P6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A653921E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMur-0004f7-Vf
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvMuK-0003c0-LK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvMuJ-0002EC-Jt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:27:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvMuJ-0002DB-CR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:27:15 -0400
Received: by mail-ot1-x341.google.com with SMTP id l15so47784814oth.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2ozGHsPkd1Go5zDyxLtjbOQCpEDoE85m9DKFLiNy74I=;
 b=X16MA+P6k8AmHk/FIwDn3tCMXZ/H8VKs5XuaNBQ4077f5F3DOQCRxKiU5j+ix4ob6D
 1lBE62swr0ejYv7arUqNTXLAzf2UfttycI/Cw5fCOIgbjSnVcaRV74RUG0FzoL+fAbaq
 jCW+YvCdrTcZJ91PTqJgkR90T8VV7QPvtPluEABYf3eqgF0koKZ9P3m4ov1TLHBetwJS
 05pgquFociCesAuVbkTYyQ5iJ5+b49hxt0Qql1pipdU2htgDwUWKHp+w5OyaKd96VZDB
 o3z0OliJUm4rbp5x1JSgJzW0UlPEVIv11BbVkRLiE/McoZT21vZFFYmayhHck74sGuz4
 NozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ozGHsPkd1Go5zDyxLtjbOQCpEDoE85m9DKFLiNy74I=;
 b=CxN3j/tX+AzABBmzucp//XfzXXWyWwITW4vhEFNdbelG169GKyfEfRjEktZDfbBEic
 51fDDc2kq7dU8v5gIkUNmC5hswruxm1xvR5QLpt0uaA3YQxqtiQ381TdhsGzLyWtOmdC
 IuLc7TezLv5VoEDUxRmdKsQaHu8gIy1tBehYY5ugr8FPs2u7q4O2Bbmr0yF47BDsUUGQ
 dBCB0S8cLeB/BwHrFAonPBuGeAItETxkkhJ4Ms137eCgdw9yDkUO4wkR+aMRojjMoJUd
 ZV6+ypDxMBZv2TC0nD7/tQ1+xyp5AeIYNN+26CpQO4AACb0Ppm5q5z0rGdGZhNwe8eOY
 wlCg==
X-Gm-Message-State: APjAAAWkLR/I2mmV2OmrsUZe/GWa8OVR6bheuWseF/IiA+dKkQh2zWeu
 XtYJQJkSGxDQDYyDT26Q6R4Jzj7cEtJ3AuPNOXUN3Q==
X-Google-Smtp-Source: APXvYqxaLQB2PhInv8JL2VTkzPP0pUZEPdNyWq2y4SDZIVza/QOWW4Qijzbf3EiYu0WXuX03BSx0X48b1xTlxKCnq+I=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr8491893otr.232.1565188034240; 
 Wed, 07 Aug 2019 07:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-3-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-3-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 15:27:03 +0100
Message-ID: <CAFEAcA9puHxUvxbSBsFrEQ6QN=fq3GJH4SgzcpQWQB60PTVR=g@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 02/33] add temporary device_legacy_reset
 function to replace device_reset
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:58, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Provide a temporary function doing what device_reset does to do the
> transition with Resettable API which will trigger a prototype change
> of device_reset.

The other point here is that device_legacy_reset() resets
only that device, not any of its qbus children, right?
So the new function which we eventually replace the callsites
with also has different semantics, which is why we do the
changes one by one in patches 10-28.

So you could add:

The new resettable API function also has different semantics
(resetting child buses as well as the specified device).
Subsequent commits will make the changeover for each callsite
individually; once that is complete device_legacy_reset() will be
removed.

> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

I agree with David that patch 3 could be squashed into this one.

If you do that and tweak the commit message you can have
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

