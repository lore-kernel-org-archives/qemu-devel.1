Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 07:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E172070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 07:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMUVAY6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E172070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0gaN-00074O-A2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 03:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k0gZg-0006ew-Md
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 03:32:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k0gZa-0002Og-Dt
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 03:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596007940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fdmGHj28tJka+5SRaVh3E+ZEzuzGzXi0BGAOGu9tf9Y=;
 b=dMUVAY6zqFPOHukx3p3IBgikosgJxmZl8rMm0RhAvn/yDEZFmgwqpUtlOlaiC4yAXAPesz
 Nj740CiecUmPgAjtD45l370DpJKXmB/ie58WwVUQR2NrfHCn7pm0YBC/pIqISwvZzBEAnA
 FT5KKPDwGE+QbJVKdV6TX6QZPB1X7C0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-I1elG56IOo6mfYDleHs4cg-1; Wed, 29 Jul 2020 03:32:15 -0400
X-MC-Unique: I1elG56IOo6mfYDleHs4cg-1
Received: by mail-io1-f70.google.com with SMTP id z25so7763270ioh.21
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 00:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fdmGHj28tJka+5SRaVh3E+ZEzuzGzXi0BGAOGu9tf9Y=;
 b=pGTeAETSrLLODLm4GeyUdOZEjoMD5RTiRnZI0DgJ4miLWaZ9qJKvhbsE5tPvu66VsJ
 LgISAr5fMNUtn6ZeikmaOGH0ojpSAlDjhyHOkCzEjqVxqRb1tz1Tqey8zRomylrB6/Qu
 /ZzjtGDvFgPceE0WhDSpkYphQkeuXJzhQ9MRN2a5g1DmNKgKKO0xwiHG+//vpN2Jfhe/
 lSBY6G54I1SxDuVS2q/VZmYzbbWd4MSV2jQHe0GtZwvhnpdedp4waZflMwCF21jemlE8
 VlBWp9RmKVJvIy0sq8eF8cU+ERZXTd3xCcoI0vGm6XxoxCprOBpynnsMk4UiSBNi/OoR
 oaag==
X-Gm-Message-State: AOAM533StRXrYwSM75FB4dYpmAntANtdD2D/PNs+Ypb4fAQFYRwgumfk
 5tskXR4v2P0spvrR0RXaPRWIC73SVuCXkI98hD0tM52eHwqSp1+NTIIK2SEeT7CnaQfEQ4dEdor
 Q8cR1sImLR3gkKV/iijGYxFuLydFRWo0=
X-Received: by 2002:a05:6e02:e43:: with SMTP id
 l3mr31652146ilk.11.1596007934732; 
 Wed, 29 Jul 2020 00:32:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1ggCpwKj36AkVibGLjXmXNaZkN6v5ad2qkTlRgVdezywae16V8D+N1wRid28Q+tqDeAerae0zobLgDxJ4XQY=
X-Received: by 2002:a05:6e02:e43:: with SMTP id
 l3mr31652131ilk.11.1596007934472; 
 Wed, 29 Jul 2020 00:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
In-Reply-To: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Jul 2020 11:32:03 +0400
Message-ID: <CAMxuvazccDg4B59i25jeATmO_63Jrs2L9Y9FRLY-xpQfGAVw-w@mail.gmail.com>
Subject: Re: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.74; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jul 29, 2020 at 7:16 AM Raphael Norwitz
<raphael.s.norwitz@gmail.com> wrote:
>
> Hi mst,
>
> Looking at the current changelog
> https://wiki.qemu.org/ChangeLog/5.1#virtio, I don't see any mention of
> the VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS protocol feature. It is a
> user visible change so shouldn't we add a note?
>

Sure, feel free to do so.

cheers


