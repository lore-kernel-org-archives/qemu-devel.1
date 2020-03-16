Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DEC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C5C20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChNjgYCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C5C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv7k-0000zw-KO
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDv6Y-0007gA-6b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDv6W-0007Vj-RI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:08:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDv6W-0007Pv-Li
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584385728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDzbNbpNDhXjJ7cpAPZf36BEqSbvw1vvLlQ6NBOvHBI=;
 b=ChNjgYClDGsUT7RwcoXmsp7C6AGkRvtFwyv3fMggUtrIu2TewGQjeF8t5B94KU3UwqowGy
 Pek0PUOHfA0pZbJHojqwEtbN3y//2m+eTngSGeCW9jVP5Ga9558TUeNeYL8joevB/v28++
 CnY9IakEsUPfvLU8NKAKZWIB2Yy0lVU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-s2RfARiBPlCC9qEmX24nLA-1; Mon, 16 Mar 2020 15:08:45 -0400
X-MC-Unique: s2RfARiBPlCC9qEmX24nLA-1
Received: by mail-wm1-f72.google.com with SMTP id z16so1102026wmi.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/z7rijHB78FNDtHGjv+Mp8r8Fle6QoCboT1ahYd5OUY=;
 b=iOwkP59TS7RUzDXQY37in0kwrI2k+LY7gewg5TW37KLPolsk0GW1Y/rlCY1p9sB5bY
 sD88PnCjLM3b1IZdJm5Q8aSqPvlyfPUF59QuM4iU+xYw7t9ZmbIfv7/ppM0rQO0QGoB5
 i/Cp5a9OAi9W/P4cDCZbHKvQQl235z/YCMHvHpI6VNPPSKru/axwuDqybUo1ck1zi53e
 LZ5Et0TFuBAyo4UJlPi2K0V9bBvfsMgRgSmzjc9Jwo3++Cur5kiqLgoB5GJAou7hPKWG
 pl6A5FxaSCUhHLZw3hctdbd7/SlG9p6MMX+3+jXAp6OBU+uy8sbwhB16FkCgAvI4SqWL
 YPgw==
X-Gm-Message-State: ANhLgQ22D2R//pZxRwS/VPGiWM2EmWYfvyAcPWbP/Xva9w+EaCymCBxr
 BH0X8sojJrT+Yka//nx1orVktp9IxkrLa0Atc+SkkVyMBvh/TNXTPa2E+BEXCX1rPhYZqDrzo7I
 /VDaDKzoHSZ5T70o=
X-Received: by 2002:a05:600c:24c:: with SMTP id
 12mr547774wmj.119.1584385724676; 
 Mon, 16 Mar 2020 12:08:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtJB+azXv8UG5huHrHBc2toSfW78VeJ/7GwDSth6mnxmrH1KtPaIJb43u4xJWsDWox6hvGMsg==
X-Received: by 2002:a05:600c:24c:: with SMTP id
 12mr547751wmj.119.1584385724414; 
 Mon, 16 Mar 2020 12:08:44 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 n2sm1154333wrr.62.2020.03.16.12.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 12:08:43 -0700 (PDT)
Date: Mon, 16 Mar 2020 15:08:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200316150538-mutt-send-email-mst@kernel.org>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
 <20200315154559.GW1187748@habkost.net>
 <20200315170229-mutt-send-email-mst@kernel.org>
 <20200316173039.GB1817047@habkost.net>
 <CAFEAcA9CYeTjmUSbMtGjDazrh1p=5vLAd3bq7JBtLd0RfnruDw@mail.gmail.com>
 <20200316184046.GD1817047@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200316184046.GD1817047@habkost.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jingqi Liu <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 02:40:46PM -0400, Eduardo Habkost wrote:
> On Mon, Mar 16, 2020 at 06:08:54PM +0000, Peter Maydell wrote:
> > On Mon, 16 Mar 2020 at 17:51, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> > > Yes, but both MAP_SYNC and MAP_SHARED_VALIDATE aren't available
> > > if the host is not Linux.
> > >
> > > Defining MAP_SYNC to 0 on MIPS would restore the existing
> > > behavior, so it seems like a reasonable step to fix the build
> > > failure.  But not even printing a warning when the host doesn't
> > > have MAP_SYNC (the existing behavior on MIPS and non-Linux) seems
> > > wrong.
> >=20
> > The usual approach is that if you don't have the Linux-specific
> > feature available you quietly fall back to whatever the sensible
> > behaviour is for when the feature isn't present. We definitely
> > don't want to be printing warnings on non-Linux systems that
> > are effectively just saying "you're not running Linux". Same goes
> > for "host happens not to be running a bleeding-edge Linux kernel
> > and this feature isn't available yet".
>=20
> I don't think using pmem=3Don without MAP_SYNC is expected to be a
> supported use case, is it?  If a use case is not supported, the
> sensible behavior is to tell the user it is not supported.

Futher when eventually an arch does gain the feature, not failing
when it's not available would mean users have no way to detect
what's actually going on.

> --=20
> Eduardo


