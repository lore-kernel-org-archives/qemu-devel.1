Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77563C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E46520872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBiDk0fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E46520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRVP-0000CI-BK
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXRT5-00077Q-CG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXRT3-0005sL-Rf
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:00:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXRT3-0005rv-6f
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574262028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hnI+xxZbGkNB7hDGNz9um74UdzfMlhVggsO4HG99Qc=;
 b=hBiDk0fqyP3AUGXjitb94UKWVFNWCuuNiT4ZnKJ4RX5npI66mO66BMa+Mdqx/kxDkdaOGK
 D+/1VsZFiN0ZbgVNQWD9t9agjm0Yd2s0s133bj7NfCpKDP3kzV/gbEEIbos4RSsiTf0pnm
 iQ28JzsTiTuUhVwS84BOQ9oryhoTgL0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-iza2DrxHPSqrSjkwzWsYWg-1; Wed, 20 Nov 2019 09:59:08 -0500
Received: by mail-qt1-f200.google.com with SMTP id 2so19823qtg.8
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RVfA81r+HWsKIx8ERWG62XWKG76Zt8AuZkQ8zB/EkTM=;
 b=d4HxUal6CSEN82QBa6m8BIwpZDJH5eyhdrp808OVEI2SVqqXpBetJ7MAJtIydU5bjv
 CBhGgFg+xnDApRRwLCdyXdj1DmehkXA55DHQO53ze/NnIZpFjN1bjQdB19/dEIEC5nGm
 FJteODfVECUWz/yMtoYbrJr33JKn2CYhgUlquNff887PGIeYNFa55w0XY8RQMuf0Vvdt
 7XnHFm+L+YWLhf/XKTyyKs2s4R3gVi8WQmlWsR+Ztht7RaX20vWKMvRhXhplMMI/qBV/
 Jm1hblUB7sdtMjPT1jT/A/n04RH/f31ZXrhqe+/6JSzQbRt8315WmM1Ynr2VgO/awRjN
 74QQ==
X-Gm-Message-State: APjAAAWRO83VcziVQYamyHVBcPUOfmHypNYbG3kakUs9nPoew6DahMmS
 C5KRtePan9Duoqt0vGk4s9PoUipyTfaJflaQQDXfqGAtppx601s3E6Q2MVGMZPAhp4CbyIsyqJM
 GAlIC8BZlb+icjvo=
X-Received: by 2002:a05:620a:81a:: with SMTP id
 s26mr1833716qks.11.1574261947817; 
 Wed, 20 Nov 2019 06:59:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTQvswGi3ntwkJAOA0RPd4vsfWmYSa+69mybz320fHaIB9Fd+ykIaMZyquhxZn3K9YLWmQtw==
X-Received: by 2002:a05:620a:81a:: with SMTP id
 s26mr1833694qks.11.1574261947624; 
 Wed, 20 Nov 2019 06:59:07 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id y21sm12214481qka.49.2019.11.20.06.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 06:59:06 -0800 (PST)
Date: Wed, 20 Nov 2019 09:59:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 0/3] Some memory leak fixes
Message-ID: <20191120095810-mutt-send-email-mst@kernel.org>
References: <20191107192731.17330-1-marcandre.lureau@redhat.com>
 <20191108045257-mutt-send-email-mst@kernel.org>
 <CAJ+F1CJ3NHq1fcvpkMy+SsGxV2fr+dPeAK4bjn4yduaTA8QJ+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ3NHq1fcvpkMy+SsGxV2fr+dPeAK4bjn4yduaTA8QJ+A@mail.gmail.com>
X-MC-Unique: iza2DrxHPSqrSjkwzWsYWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 06:50:05PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Fri, Nov 8, 2019 at 1:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 07, 2019 at 11:27:28PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Hi,
> > >
> > > Another bunch of fixes spotted by ASAN when running check-qtest-x86_6=
4.
> >
> > So who's merging this?
> >
> > > Marc-Andr=E9 Lureau (3):
> > >   virtio-input: fix memory leak on unrealize
>=20
> This one is still pending. Michael, could you take it?

Expected gerd to do that but ok. Pls re-post a separate patch though,
I don't cherry-pick things out of series.

> > >   qtest: fix qtest_qmp_device_add leak
> > >   cpu-plug-test: fix leaks
> > >
> > >  hw/input/virtio-input.c | 3 +++
> > >  tests/cpu-plug-test.c   | 2 ++
> > >  tests/libqtest.c        | 1 +
> > >  3 files changed, 6 insertions(+)
> > >
> > > --
> > > 2.24.0.rc0.20.gd81542e6f3
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau


