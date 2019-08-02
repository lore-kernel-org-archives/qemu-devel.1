Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41270C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 06:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB5520657
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 06:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzTOerTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB5520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htRCb-0002VJ-RN
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 02:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1htRC3-00025D-Ts
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 02:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1htRC2-0006ui-Vp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 02:37:35 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1htRC2-0006uL-PA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 02:37:34 -0400
Received: by mail-io1-xd43.google.com with SMTP id k8so149929477iot.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h/ixmyAAfJZtMl1BxdcYeWwNmFxAvFvzt/pDzkX9GnQ=;
 b=DzTOerTjcuv6hqRmY87Jth9qKw/KO6A2wavegN5gzaZbEAzHQqzUYFg8oRv57EAfQW
 SR004ed2r5Cz8D8UaIWD6Aar3+wUuY+ZF0V8WLU2mY0vUL+6t7vysGY2Hvi+UUZpkl7P
 9iHStus0bJ5knyXQVZvi8ceGghGWrZAjkDIawGifvQ94GtjQJRjlAYDRvk9lT13Emt8a
 SWnu1SIEpNooFCqFvquaHRVDOkoO4yVkZQnx3oCp9Y3xB1nb9lPCsKuCMK7MAaIEjF2y
 yBhjxGkzVHfnzVu/mEoXje76aYHyjmkS8I2PxSgDrkqoclSPaRstCnBs+KK0k8HHXYUp
 WsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h/ixmyAAfJZtMl1BxdcYeWwNmFxAvFvzt/pDzkX9GnQ=;
 b=cK+iyfDx948zPFHG3cy5aNB/U14Ilq7eMgqyD2CckT20uy/qprruyDYbR8r8+orLJa
 h/VWyrSv7Rhegp59EoVpeXqRhwOWW/iliHTHHzhDuJJx8fJbOlA7LxqitnF7+o1VakbO
 ZPvlLy9u8WeMtsNaXFDbN3zIdSkXI48wmExuSYdthB4ya3T9bNFFlkf6OvUGida2Rrlk
 aBZShEOc9I7xCdUDs4B8sHwEYrR2+8SFYmAQc/2njvs8EPo/1ZsM6zO0XrDcPrAPi07x
 zpnZ2Dtc4GbMobU3SHPCUPpqKBo46HJRcfeoBOEzBccJGWz5DcPJR54V+MR5jn1zjh3j
 i6DA==
X-Gm-Message-State: APjAAAUX3zkmUlmVp58g3tpNm3hr+k8NrEkogWnArLYBfk0doTo5e+in
 tKwZ70xjwnlSKB8Ec+gIhXa45o7dMHXXYes0h9g=
X-Google-Smtp-Source: APXvYqybCRVLrcdVEBOtzxt53pHEVXf2h7jamzEDJKYvSa+keKm6+ePMivlRpLmNSQd8or89jjRlOCEZZWcml+mTPtw=
X-Received: by 2002:a5e:d60a:: with SMTP id w10mr114487854iom.78.1564727854005; 
 Thu, 01 Aug 2019 23:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <1564464992-22305-1-git-send-email-ivanren@tencent.com>
 <20190801022118.GA21992@richard>
 <CA+6E1==Dc5Zac3Q-tt2V2pbq-DofW=AZX6tP1RoDBp4KSNxiKw@mail.gmail.com>
 <20190802004904.GA20638@richard>
 <CA+6E1=n-B7u1H_eSn-0FKeg_PuvbkJyxN6u2U37ageZVM7xUkQ@mail.gmail.com>
 <20190802055904.GA15613@richard>
In-Reply-To: <20190802055904.GA15613@richard>
From: Ivan Ren <renyime@gmail.com>
Date: Fri, 2 Aug 2019 14:37:23 +0800
Message-ID: <CA+6E1=mN-vdc=HbbBARUw1o=ZU8f9LKf8n16WvvDOgyM8Mc_Mw@mail.gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH] migration: always initial ram_counters for
 a new migration
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 2, 2019 at 1:59 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Fri, Aug 02, 2019 at 01:46:41PM +0800, Ivan Ren wrote:
> >>>>>     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >>>>>+    /*
> >>>>>+     * Update s->iteration_initial_bytes to match
> >>>s->iteration_start_time.
> >>>>>+     */
> >>>>>+    s->iteration_initial_bytes = migration_total_bytes(s);
> >>>>
> >>>>Is this one necessary? We have sent out nothing yet.
> >>>
> >>>Yes, currently nothing has been sent yet at this point.
> >>>
> >>>Is that better to always match the update of iteration_initial_bytes
> >>>and iteration_start_time in a explicit way to avoid some potential
> >missing?
> >>>
> >>
> >>You may get some point. Well after a close look, we may find other
> >potential
> >>problem.
> >>
>
> Well, I guess you need to use another tool to send mail. The format is
> corrupted.
>

OK

> >>1. To be consistency, we need to update iteration_initial_pages too.
> >>   So my opinion is to wrap the update of these three counters into a
> >helper
> >>   function. So each time all of them.
>
> I don't see you reply this one or the mail is corrupted.
>
> If we don't update iteration_initial_pages, the initial_pages will mismatch
> the initial_bytes. Am I right?

Yes, agree, I'll send a new version, thanks.

>
> >>2. In function ram_get_total_transferred_pages, do we missed multifd_bytes?
> >
> >In function ram_save_multifd_page, ram pages transferred by multifd threads
> >is
> >counted by ram_counters.normal.
> >You mean other multifd bytes like multifd packet or multifd sync info?
> >
>
> Ok, it is counted in normal.
>
> While if my understanding is correct, normal is used to count pages sent by
> save_normal_page(). Sounds this is misused?
>

Yes, current it is counted in normal, a  specific counter is more accurate.

Thanks

