Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96855C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC442084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m239Hntt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC442084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTmM-0004gd-EY
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUTlM-0003ie-Jd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUTlL-0002WP-C5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:51:08 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUTlL-0002Vr-6j
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:51:07 -0500
Received: by mail-ot1-x341.google.com with SMTP id 5so77994otk.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 02:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IU6TXDnvwtd6p1q67vCtVzrG4DPIqESfBgVohMfO8uM=;
 b=m239HnttZceqjMxpc93PXydJp+8S4f6bZDhDoI01jTMObd8sNEVeg3brvmWLclDgZ6
 Exr3gGtZxRfirPv4pc/zA2dQ3tcTezE20kb5N+eptDc43vBlmcfNDKTb6ufuKhwsv2GY
 Bn9JTUEimGXSOhZFTYA4h1jyH1Wor+RQb3uGdo9Qbe7/ma3s7LIfFa+Zuc/UUR/UXSfu
 RyTl+3Zf2diq0+y2tRX/yKuHVacsGooqHWUMtMqEV7sRqD5gvsIRefR+a/eCHWXj8mgX
 F/RfthcOK4cJIuE3tN+ZIht/ojnCIumvj+yeK2abq1MniiTG+YNC6QBoXelC9s5yzDvL
 TzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IU6TXDnvwtd6p1q67vCtVzrG4DPIqESfBgVohMfO8uM=;
 b=esnd6NuY7QMdAui0uDMJTrZeNmffTTfRMY4B9DAGCDN2TAEz4nKEPo+OKT3mKSDe6g
 XhjX4UNBPD2rE/tgblQvDdD0/zH8rCn8fdJTG3fICanc9TMGVbLZ5wUoXTXw3rncMBe4
 Xfy4PgbalefkN+vswolzGWKi5LiFrVzOOf+maFZvsitY5eCTlDUhPxiEIjpcdztuIiiV
 +GA9SR68mORKRj4FcpdfmEHBrvh852Z1TgFOBAuty2DLte/xgrK80s/bHujbSs4OUAGW
 lVhTTocdHfWeuP3ARQm0xDx+4lh0RvciKB+W8lgoTn6SjlbfRUjRraSo3o+w3VLvWRUF
 J8oQ==
X-Gm-Message-State: APjAAAXPaALm/hAW73FewWkWO9w7c1Ix1WkT8cdxZ34BokC2iYBx4q8G
 ZB9UZMLFT1MynnmoAN/5FxeobEWBmmqbI57voAR87w==
X-Google-Smtp-Source: APXvYqxhfZ33HCwkYRAbgqCJP6zt8rKp5o3knj2nFWb8DKn25JTXYoDEd88Dqp5eK7isVApVnD3mD0fbaXiyn5i9Cqs=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr20128754oto.97.1573555866074; 
 Tue, 12 Nov 2019 02:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20191111203524.21912-1-eblake@redhat.com>
 <9f0f8f87-3025-67be-d423-51e2e910f5f5@virtuozzo.com>
In-Reply-To: <9f0f8f87-3025-67be-d423-51e2e910f5f5@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 10:50:55 +0000
Message-ID: <CAFEAcA889WOTONP-veXYzPHmBOs8pkFXdJKe9O-SpnCJGdTocw@mail.gmail.com>
Subject: Re: [PATCH] qemu-coroutine-sleep: Silence Coverity warning
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 at 10:08, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 11.11.2019 23:35, Eric Blake wrote:
> > Coverity warns that we store the address of a stack variable through a
> > pointer passed in by the caller, which would let the caller trivially
> > trigger use-after-free if that stored value is still present when we
> > finish execution.  However, the way coroutines work is that after our
> > call to qemu_coroutine_yield(), control is temporarily continued in
> > the caller prior to our function concluding, and in order to resume
> > our coroutine, the caller must poll until the variable has been set to
> > NULL.  Thus, we can add an assert that we do not leak stack storage to
> > the caller on function exit.
> >
> > Fixes: Coverity CID 1406474
>
> Hmm, I doubt that it will fix it.. Do Coverity pay attention to assertions?

Yes, it knows that an assertion means that the condition must
be true.

thanks
-- PMM

