Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5469C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 12:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12AA21D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 12:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc9/MXas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12AA21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4OMg-0004Az-Qd
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 07:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1j4OM6-0003kP-Rp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 07:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1j4OM5-0004tl-2M
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 07:21:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1j4OM4-0004sv-Mw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 07:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582114887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xWsQplDAwWiWm/WZnAsyhds3G6FnkY/wC3FlpUYaKOc=;
 b=Hc9/MXas1+zQLOkRg8JqBS2x8z9KkKtFCE/YdGsf3ti1cnpHlEnySepJjX1NmkOi9PZu2g
 wqv43IRImbTRzaJmj1CawTeDLgS/SOUQZBUiaauNnuj+4vZIjTw9XYKLjTXpjc5wxAVtpD
 zVyGzbT8baEJ8BmfbpP68hAt+AifsW4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-YdOly4D_OU6fYoY_7AxBcw-1; Wed, 19 Feb 2020 07:21:23 -0500
Received: by mail-lf1-f70.google.com with SMTP id w72so3038657lff.20
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 04:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6z9OWZ81GxaELEBpSfiOUN7pTHLnPBu4cClufM2GgfI=;
 b=tqdDV1yYQ8q6z7f2P4hmuJDF3q6AqlHshGrZzm08SxBJvKM8pd/DXW/id+ZvFbECDf
 KppbvSUJMcytUHe8fk1fjk/pacx4KTsqClxwvA2hLKqyuj9IiIn2CY/TO1dpkOsCOADJ
 ExzZPkJevD/ssWSdcIxLZzqkaUq2zExHNFfqbvNt/63vIf4K9oM2Ygr+4oHhMd0c3EL8
 dO1o9VACpfvrgWpMqEBTUQAGcWW077g29dF1lW26NT5RIuuPjidcYlzdDwIjLSLic21O
 fMj8T1Rq3kvotf5HoESS1NS5NiUR4W9bFZBqlqDnqIYSjwaDzlhQrMOmDr3uz8wL7+jc
 /vcg==
X-Gm-Message-State: APjAAAX2WotUYUY4Gm6drHA1hTuMX4iY135N4VGx8z45J6z9yC+/ATbY
 vk+HFVrNaAyIEmPIMp+Hk57aWg2UiNyBq70/yQF5vAjLIx1HRya8B6CFBB7tdG/HPzrTNiUpcdq
 mPyyXe8FYzt1vL9sOxNcZPaxudwtij3Q=
X-Received: by 2002:a2e:9050:: with SMTP id n16mr15776317ljg.49.1582114882150; 
 Wed, 19 Feb 2020 04:21:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6RdLvwHZoY40xaJWh/KmCLEg8p5ee9lnKzlwtDKxT2vpb0G5WGnsUv8CY9NngPA8v58NOC5UlPuifhDOncB8=
X-Received: by 2002:a2e:9050:: with SMTP id n16mr15776304ljg.49.1582114881893; 
 Wed, 19 Feb 2020 04:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20200218161717.386723-1-jusual@redhat.com>
 <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
 <CAMDeoFVQis-UXKpGZNJkD9NqyozwUxW+nn_h6iv+f-EgkLeRKw@mail.gmail.com>
 <9ea6a6b9-778d-78a8-1909-dce1ed98a24d@redhat.com>
 <20200218223104-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200218223104-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 19 Feb 2020 13:21:10 +0100
Message-ID: <CAMDeoFUcAbjvii2wtFKO06cEjxV4-xc1Cz1x5xyM=LGWoA+4iA@mail.gmail.com>
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
To: "Michael S. Tsirkin" <mst@redhat.com>
X-MC-Unique: YdOly4D_OU6fYoY_7AxBcw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laine Stump <laine@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 4:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 18, 2020 at 10:02:19PM -0500, Laine Stump wrote:
> > Also, is there a rhyme/reason for some options having true/false, and s=
ome
> > being off/on? disable-acs seems to be true/false, but disable-modern is
> > on/off. Doesn't make any difference to me in the end, but just thought =
I'd
> > bring it up in case there might be a reason to use on/off instead of
> > true/false for this one.
>
> Some places accept on/off, some true/false, some on/off/true/false
> others on/off/yes/no and others on/off/true/false/yes/no.
>
> In this case both user visitor machinery. Which I *think*
> means on/off is the safe choice and true/false can be
> broken in some places.
>
> We really should clean up this mess ... Julia, what do you think?
> Let's make them all support all options?

Options already support all of on/off/true/false/yes/no as long as
they are defined as boolean (look at parse_type_bool()). That is, you
can use disable-modern with yes/no/true/false too.
The only problem is with types OnOffSplit and OnOffAuto (as in disable-lega=
cy).

Best regards, Julia Suvorova.


