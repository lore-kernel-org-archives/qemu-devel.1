Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1870C48BD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D33121726
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcbXHFOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D33121726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgK0r-0000vU-W2
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 22:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hgK0N-0000Wm-U2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hgK0N-0001Pq-26
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:19:19 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hgK0M-0001PN-UB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:19:18 -0400
Received: by mail-qt1-x841.google.com with SMTP id i34so814553qta.6
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 19:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wD9sFkjaBvZkKTUBz3WodT0IxcfNgujD69Mx8fsFUbc=;
 b=gcbXHFOcH43U3ri/XAi92+R8GAGxT8Oan7LH0N/P4ptWRZJtjE3v9x/4iD9S5vy8EG
 yBiu/kekUh8phwirKuYVgR3wz+qeZLOgz+U/dI/rEfTnDk7QbXtmtZOXfxnWxQ1T3vQI
 Y4yFQiAyNBLNBK1/8dSdznG/nbsetxIU0mLdqaOZC8+eeON1dwLXc/Hol7AQXzy1wJ+n
 l5FuDL8nykMOFWVnE4F5GaPiQQu8rS+R0WTTl5n0QqOYN/7mk2wjZfoAhmmj6UYaDHsG
 MWrhLHgDqlyHfgCvC7XNN3SH+a7YaSLX6g8JUpXOKEX9mC8nkGo6K2T/uuYiu7u5L3Uy
 mAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wD9sFkjaBvZkKTUBz3WodT0IxcfNgujD69Mx8fsFUbc=;
 b=Nbiyvy2d/R8MMTmA4Fd08NYi26odKjNBa90xEnX0yLwFw+UsPPm5bMJAOk6w+8f21s
 pi9vsaRHXyvTP37mBQIvdsfeVgOcHB8sGH19GaYVfs71NIORxtU/FfotsmEoSaZ9bjtg
 b3xwCso1QOzrBXOynTwivu3v57hGduRHu+HtAXy4n3UOjP/s98m+TgdEVWP9jADd4NxR
 RheUIeESbzyLVVEpqCKEb5qwCCcBGryByODcCtSm1Psq11+cxHUP/VEcfXHBN1S+0Pb+
 S/OeeO5/2i4ZGN41RQSRxX4Qly6wSTcY65TJYcsNvyi5FAdUku5u8M3+STxhTBy4tu4y
 hyog==
X-Gm-Message-State: APjAAAU92C1o5ly4ALa/xoDkpo4KRSMBlm5LIdrBGeJTefkaxSB9Khb9
 yIFWHHuK7R7T2L14rb58k5LBzWg4Uy2Cg7kpGKU=
X-Google-Smtp-Source: APXvYqyUKy5Qp9UhFef5k0mhHYwVJK7FzMA2Y1QAtO3IH/Sdsix5hLkfXc5i3PwBUN0hs7isd2pu9njwR/i813eJpbs=
X-Received: by 2002:ac8:1a3c:: with SMTP id v57mr949367qtj.339.1561601958170; 
 Wed, 26 Jun 2019 19:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190626023130.31315-1-xieyongji@baidu.com>
 <cf5017f0-c13d-fdc2-c1ef-5b36a3c595c1@redhat.com>
In-Reply-To: <cf5017f0-c13d-fdc2-c1ef-5b36a3c595c1@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 27 Jun 2019 10:19:06 +0800
Message-ID: <CAONzpcZzKEin0YnWpG-e3EYyHz8CrKbmpuxQ9vQbRRQJSV_aPg@mail.gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v4 0/5] virtio: fix some issues of
 "started" and "start_on_kick" flag
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Xie Yongji <xieyongji@baidu.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 at 18:43, Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 26/06/2019 04:31, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
>
> Could you use the same address to send the series?
> Or may be you need to add a Signed-off-by with your name and this address?
>
> I don't know what is the rule when someone send a patch with a different
> address than the author one but he is the same person (it's not obvious
> in this case).
>

Sorry for that, this two emails are both mine. The gmail is my
personal email, and I usually use it for the community works.

Thanks,
Yongji

