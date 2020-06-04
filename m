Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7276C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839CB206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cldW6UYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839CB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmIO-00073H-PY
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmHn-0006V2-Et
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:35:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmHl-0002q0-Th
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDurxJL2BPA/b/F1aIAjRffHsYxT+w3Ka37mo6gbelw=;
 b=cldW6UYYEQeg1ZPKXQzL8aunuZefmzJsssc/CdlgX6sOfT4EusJLdw90pqO/YKDw4inWWX
 Ed0h0hMrthX+XbtJ+lh/8ubhTgmCHYBs5XUyDEmXpc/ffgfE2nd41e7eJczxE8HEQ+K/44
 SxzCdqpFCMZkCrEVxnDM3L4iK2qtgd4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-6LerjCRmN7SCIwUKilLtBA-1; Thu, 04 Jun 2020 05:35:38 -0400
X-MC-Unique: 6LerjCRmN7SCIwUKilLtBA-1
Received: by mail-wm1-f69.google.com with SMTP id g84so1782161wmf.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 02:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gDurxJL2BPA/b/F1aIAjRffHsYxT+w3Ka37mo6gbelw=;
 b=h89snrVb6Tlt5jsbKlIol9lok4t4dmbeAZhyOvLyhGrkrFRSIipTCCPQkVyqR3lZhA
 wTbzkrV4e5BnWahzlS7RcoT8waAhxNLxqVWTe8EVAYQqdW6cCkXlkiGIqrOifOQWLocI
 ZeNOJbjuyUnHr8MqUIOvxxM6JTN8D/L2YaTcO+KwB12YEMT7ci7PgBcPfeckjJclqbO9
 LxgfYn7sbe9EnLrfqYE5tTKX4lQvCuUt0ugsKRdT4AU37n5tgerJhf7jLewXFaN2pnfG
 MQt3ccbP9PAd2XZdtQmuM2ZeU122AHbFQFgvJPW4CYnm9ycvPukEP81mtBp2EnRSq/7v
 WNNg==
X-Gm-Message-State: AOAM530O3AyzrQis6v7hHfxMb7jm7u3VEFFO+CQ7f58MkxW5laQC1Srh
 R+PDFiJgk5BKqiZS2uDTvM4AyPWxUhA9R3kW9ixKQNdujfa5xqJ2TmZnfP15bps4RwQCP0uYTqx
 CI+4Qba2T2JkRfQQ=
X-Received: by 2002:a1c:6244:: with SMTP id w65mr3148439wmb.82.1591263334385; 
 Thu, 04 Jun 2020 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZzLK3m7jwoIcsIhPiHBY0Kj7xq56oMCmi4kXD/q2TrImYGyaT0GOl/yQFFJoM7lp7GE3Ztg==
X-Received: by 2002:a1c:6244:: with SMTP id w65mr3148412wmb.82.1591263334192; 
 Thu, 04 Jun 2020 02:35:34 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id a1sm6807659wmd.28.2020.06.04.02.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 02:35:33 -0700 (PDT)
Date: Thu, 4 Jun 2020 05:35:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
Message-ID: <20200604053351-mutt-send-email-mst@kernel.org>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
 <CAFEAcA-hApgPBn0o44sJW7=WGiLnL0PBhz+1i8MAcxwuxJ=Y=w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hApgPBn0o44sJW7=WGiLnL0PBhz+1i8MAcxwuxJ=Y=w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ren Ding <rding@gatech.edu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 10:10:07AM +0100, Peter Maydell wrote:
> On Wed, 3 Jun 2020 at 21:26, P J P <ppandit@redhat.com> wrote:
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > While reading PCI configuration bytes, a guest may send an
> > address towards the end of the configuration space. It may lead
> > to an OOB access issue. Assert that 'address + len' is within
> > PCI configuration space.
> 
> What does the spec say should happen when the guest does this?

Spec says anything can happen *to the device*. Naturally there's
an expectation that while device might crash it stays
resettable and does not blow up.

> Does it depend on the pci controller implementation?
> 
> thanks
> -- PMM

Shouldn't I think.
-- 
MST


