Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31472C31E49
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF532089E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R++z3j22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF532089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hchBV-00028m-IT
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 22:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58002)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hchAT-0001Rs-GM
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hchAS-0001eZ-9h
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:14:45 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hchAS-0001dX-1u
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:14:44 -0400
Received: by mail-qt1-x842.google.com with SMTP id j19so8946182qtr.12
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 19:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wNWuXasZPcti2eEEYAJ6FZ/e1CaobtM7KDc14UrDl+Y=;
 b=R++z3j22tPpnzo38isJFGZ5wQim8vuspP7bygcncqGbcd5cOccJl0WUHRy45mBS+tK
 Zag36o4qbS7mYEHjNuP4SjgnaW6PTTTzE39gd2xk6naO7rFP/5ZdImJ06GKc5g08pYNb
 7qaylKRCUiM5ROFG6y4a35OB2bSTBzIY1sIOTngutOCej+WnrL4Dd9OD54cU4sALZvzX
 KBYqgDMaWGtCnVO/0EWQQ7TRHk8R4fM3mvszyOcq20YAnP1NCQRSPD+4svBQIjl9+mOX
 FngDZTG7HEVvQMzcjgcWG+NwfEH4PJAiHaWryivROgy3XfkmpVpjYx/iqeE1DuOy/jXz
 e8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wNWuXasZPcti2eEEYAJ6FZ/e1CaobtM7KDc14UrDl+Y=;
 b=b0elvyrODNmWcwdjW7Iu8qS5KB6zJuyRPEDKvKkllC5M98ugupe62exUhibnZEELVz
 u0yGwa4y4h/7+D+jXhHSxerP+s9AsqrAA8Py27as+gdwEXgbuMnHeMDNEcRuQzzIYqJA
 Z1UbWdvu9jZ1etLuY7FX5mmnAF79Rb9E611lU2nEUOiEvdjLb8TLCd+OkuvBaAR9KdKd
 anmcV4cvX8P8cIFcOG4+z+h3Ou3skiJs57Jzjijpxr3mVu8v92Pq1uWK1kh7akcZd/TP
 +fH5Ot05hrAdVNtyp2PiBeOhlpqZRF7FFyQy994j334vyroAwfTCn5zwpvDuZXBvWVrq
 P8Rg==
X-Gm-Message-State: APjAAAVHyR+c8zDlrt90p9SJcJtB9sZGCD83duTKvfJZEFPDUvHuRhaU
 Eb61B9COGrcTdyCQI781CA4k2aOweITcJryLa1g=
X-Google-Smtp-Source: APXvYqy5RPEO5qECP5UHTEQ/byxFBAIxd9pRXEX5/6E7K9jPSHisOX1vBH1EmMe5oaMrvRBsb77A4lk386iBJcEdM3Q=
X-Received: by 2002:a0c:b90a:: with SMTP id u10mr19069066qvf.201.1560737681501; 
 Sun, 16 Jun 2019 19:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190614093121.5580-1-xieyongji@baidu.com>
 <20190614093121.5580-2-xieyongji@baidu.com>
 <20190614134452.7924f135@bahia.lan>
In-Reply-To: <20190614134452.7924f135@bahia.lan>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 17 Jun 2019 10:14:30 +0800
Message-ID: <CAONzpcYMmw+4q-VmBOnrBBNbfrG4XeSggk3R2tAKmF5u6b1VcA@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>, Alex Williamson <alex.williamson@redhat.com>,
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH v3 1/5] virtio: add "use-started" property
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 at 19:45, Greg Kurz <groug@kaod.org> wrote:
>
> On Fri, 14 Jun 2019 17:31:17 +0800
> elohimes@gmail.com wrote:
>
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > In order to avoid migration issues, we introduce a "use-started"
> > property to the base virtio device to indicate whether use
> > "started" flag or not. This property will be true by default and
> > set to false when machine type <= 4.0.1.
> >
> > Suggested-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
> >  hw/block/vhost-user-blk.c  |  4 ++--
> >  hw/core/machine.c          |  8 ++++++--
>
> This patch conflicts with latest upstream changes to hw_compat_4_0_1[].
>
> It seems you need to rebase. Also, I'm still not sure how we're supposed
> to handle hw_compat_4_0_1[] versus hw_compat_4_0[]... nobody commented
> on:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00637.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00641.html
>
> Maybe worth to sort that out before re-posting.
>

If hw_compat_4_0_1[] is introduced only for q35, I think this patch
should be OK. If not, maybe we should handle hw_compat_4_0_1[] in
other machine types (i440fx, arm, ppc, s390)?

Hi Alex and Paolo,

Any comment for this?

Thanks,
Yongji

