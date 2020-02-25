Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53007C4BA01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 21:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBD020675
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 21:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOZHFM6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBD020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6iDt-0003fq-BZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 16:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6iCj-0003Az-V1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 16:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6iCi-0001zs-TR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 16:57:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6iCi-0001y1-My
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 16:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582667844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8+dhKs6AsWaK6CsUzc51Cv3AgXh0aJ2T5G0xp7DUIw=;
 b=dOZHFM6uub4t4cRPJ4jiKihFeiXkfnpc/skgTlOgci8rZeaYQA0fabtEeJPgZksvhTztio
 yfniBX5YEbK6T+gGm2ky2Mdp5fAiYhzXbQIcuN5JYiQZrcZbH6Vy0CNRPWNegA9YlJ7NF1
 eEyv/V6EfiYiDsgxp8+2OhPA4HrtddI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-V5N9UeFhN3GR75yihL_ppg-1; Tue, 25 Feb 2020 16:57:18 -0500
X-MC-Unique: V5N9UeFhN3GR75yihL_ppg-1
Received: by mail-qt1-f197.google.com with SMTP id p12so1254704qtu.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 13:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sQfQsxErc9iLVD/ni6ETNEoHbeJANcIbLc93FGh9aK8=;
 b=D/x5NDRpFN6YuWmYoK/Nl2iv3n4vPYcoNqZhGXvZWcpO2L6hKrEeGqmWXrlQ8yt9OY
 RmvF+mb17Xp/Yyk8i5d+65YkKYWpGDzJ7ZK105tNSARsX3t9ZpSQpbmGEGkebbTNQzZD
 Jj/mLGcB+qotS2b4+XpsTCJV6nOizdjUSQryF6GEoE9+FzIBa5sHt7vBzL35oK8v5iua
 9o2J6ONUlQUaJI30XhPratplWbnDi42bex65wihTEA+74BiqQUEv/lJYfVWVeKNgU/X9
 R6qKk3WMeL7KjETIV+ZdRE/SXnG4QJ6PebS/RqXkRaTDr56pjwd5xRyJL6uV0SO1si7u
 fZFw==
X-Gm-Message-State: APjAAAU3AyQFIq9tm1DNnjFJwFE8H0EtiR1Wzp9yGZTeBA5T9yWyRegZ
 X/sJChXTDJ3gLeqs+kn4WCSJHHDvwRKtYZZYUjW83gKc41IXm4cR6njSXUbSMF1EajyDJ+PS/4o
 FAq+cbzZwcSuUEEA=
X-Received: by 2002:a0c:a281:: with SMTP id g1mr1254907qva.168.1582667837721; 
 Tue, 25 Feb 2020 13:57:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEF5iwZszCsyrDybLfjlUifm+JXQcFyVVv7xrcru5VsJi7/9HT98isS13CeYNkXInFVycCoA==
X-Received: by 2002:a0c:a281:: with SMTP id g1mr1254885qva.168.1582667837466; 
 Tue, 25 Feb 2020 13:57:17 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 65sm8120245qtc.4.2020.02.25.13.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 13:57:16 -0800 (PST)
Date: Tue, 25 Feb 2020 16:57:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/32] virtio, pc: fixes, features
Message-ID: <20200225165637-mutt-send-email-mst@kernel.org>
References: <20200225151210.647797-1-mst@redhat.com>
 <CAFEAcA-eDYoyD-Hs6i7b3J+nt92DNUpFo9J+UZJtoxQ49R3i1w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-eDYoyD-Hs6i7b3J+nt92DNUpFo9J+UZJtoxQ49R3i1w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 04:47:31PM +0000, Peter Maydell wrote:
> On Tue, 25 Feb 2020 at 15:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 9a8abceb5f01d1066d3a1ac5a33aabcbaeec=
1860:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-2020022=
5' into staging (2020-02-25 11:03:47 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to afc37debf27ecf34d6bc1d4b52fa0918d0bd3f3c=
:
> >
> >   Fixed assert in vhost_user_set_mem_table_postcopy (2020-02-25 08:47:4=
7 -0500)
> >
> > ----------------------------------------------------------------
> > virtio, pc: fixes, features
> >
> > New virtio iommu.
> > Unrealize memory leaks.
> > In-band kick/call support.
> > Bugfixes, documentation all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Hi; this fails to build on OSX:
>=20
>   CC      contrib/libvhost-user/libvhost-user.o
> /Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.c:27=
:10:
> fatal error: 'sys/eventfd.h' file not found
> #include <sys/eventfd.h>
>          ^~~~~~~~~~~~~~~
> In file included from
> /Users/pm215/src/qemu-for-merges/contrib/vhost-user-bridge/main.c:37:
> /Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.h:21=
:10:
> fatal error: 'linux/vhost.h' file not found
> #include <linux/vhost.h>
>          ^~~~~~~~~~~~~~~
> 1 error generated.
>=20
> thanks
> -- PMM

OK this must be the move to contrib. Peter could you please try
again now? New tag at c3744b57bb37cd1120acb621ce4683b1c8e8a1c6.



