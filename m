Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9FBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C1920692
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C1920692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dxd-0001XO-67
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7dv5-0000Ad-Dc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7dv4-0004w2-DX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:02:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7dv4-0004vp-8L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:02:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7410389C42
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 11:02:45 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j3so8823810wrn.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 04:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Xf73poPe98buWtHqrTIYRJm4oYzJUPHAnrA3xBG172s=;
 b=dJ3HqkJ28xM/AjU5RWPSorEYvWdbYpMqJG5T7KaVeX47ZbkonCsXru0rEg7yppb2jJ
 O3AD9N5sqmDQRAMidV2zlOKcjY0aJMQeOmXBh8rjxQnN5Eev5AwtpZV3J0sh2511o7+3
 wrjqbxMLOW4nymlSVwaa73Xbubijbb4uePlq/2k2WVflWeDs0UJJvbsIsJs5z8meuNEq
 gWFiqpwNYl02ZN/hvSLYBXgH3C8l1W0RK+cORq92KatKmF6CzPGenT0/iPFQkti4yCaI
 59sYKRzWJoIbSjO2C7rn4fKxdSQqx+xkMvm1XyL7z6u/kZCCzhp5g3TyZYV113jVwDCV
 5CQA==
X-Gm-Message-State: APjAAAU6zYvxOXGxZo8AGIKqgEjhi+wFyJ6WUdrnudOsHcF1CE0OoDJd
 cvINHcq4puirSQGz9Qst9ikWhPoYpTQb9pHQ35jiLtYFOHDDZdanTc74xKWx5RvdYbb3wpix7xN
 cYaHoE9vs/+xKIaw=
X-Received: by 2002:adf:dc81:: with SMTP id r1mr25041328wrj.52.1568113364211; 
 Tue, 10 Sep 2019 04:02:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEzWsD8HbnwZGxVAGcX+SzYChM2k9A+gJ0DIri7NEKFlEsrhIhq5PSB8ngdidzUAoY+bpseg==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr25041306wrj.52.1568113363967; 
 Tue, 10 Sep 2019 04:02:43 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id w125sm4913562wmg.32.2019.09.10.04.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 04:02:43 -0700 (PDT)
Date: Tue, 10 Sep 2019 13:02:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190910110241.c6siknuc4uq33mlr@steredhat>
References: <20190910090821.28327-1-sgarzare@redhat.com>
 <87mufc1nvd.fsf@linaro.org>
 <CAFEAcA9GMtuDCZVLFECnT0uF377_T0T_-Bn_9-RvC-zHRihqSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA9GMtuDCZVLFECnT0uF377_T0T_-Bn_9-RvC-zHRihqSA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] elf-ops.h: fix int overflow in load_elf()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 10:54:25AM +0100, Peter Maydell wrote:
> On Tue, 10 Sep 2019 at 10:50, Alex Benn=E9e <alex.bennee@linaro.org> wr=
ote:
> > Seem sensible enough (although gah, I hate these glue bits). Would th=
e
> > large amount of goto fail logic be something that could be cleaned up
> > with the automatic cleanup functions we recently mentioned in
> > CODING_STYLE.rst?
>=20
> Probably not, because one bit of cleanup we *should* be doing
> in the fail-exit codepaths but currently don't is to delete
> any rom blobs we created for earlier segments in the ELF file
> before we gave up, so we need to have an error-exit path anyway...

Mmm right, I should add a new API (e.g. rom_remove()) to do this better
cleanup.

>=20
> thanks
> -- PMM
>=20

