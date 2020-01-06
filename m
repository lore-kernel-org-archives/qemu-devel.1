Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B48C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7F2206DB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrgdlZ+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7F2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVq7-00080m-IW
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ioVp9-00075H-MV
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ioVp4-0008Da-PQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:05:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ioVp4-0008D5-La
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578330346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kovrPs1uR8E9eW21cu83x1YVGrQUxrI0NZQD9ns/75g=;
 b=hrgdlZ+dkp2UwbhI6L0+0TbN157s1Z1e5yU7n5ngkbeKZzDQphp4W0h5kUWjfQiKOh31LL
 JQJ/a18ZQdWMTMxOlhCiAWs32ckT2b3XZXZ2FkH5EpFWQ+KUjeHQhBQGK121V5o0X0O/Dw
 nZd6aRXtoV71GZwKbJrOvQw3oQ31A74=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Ba8bJMXSPHWGWEnEg2EsyQ-1; Mon, 06 Jan 2020 12:05:44 -0500
Received: by mail-qk1-f199.google.com with SMTP id d1so7639643qkk.15
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7nrgiSGZGWya5NshyMRioDKxNvrJEVEu5x6Ov8Zq+RY=;
 b=RtZVPxTG1hyAkwCMa+HOjzZUwE8czjIHm69Jv59TnGlr4LtK7zec1OsEcqzd6K109S
 2qk+a8OLmp6kYxWI+bqROEYvSzslIHMa5xeOClVmInY6zYilx9f9rT/cGcxTqylJi5L8
 TC+TUdGmUJTdX9pjdWNAtQJKRt9/xyxmbt59w+RdofuY1Pjz5n1hwe9+foJLATUV9ALF
 5XMHrexpN24x2r4b+EMC2pB2a0zYbJE658w/DQus7gBBgwIDkptpSlTzuJVc6LcuTG+s
 9cMLN1Cua+0PjnGkN5+IBSWY8fSBKRUV5coMwxJ22MJ/FSkMQAku4pioyowyMb9zy0iL
 tQqQ==
X-Gm-Message-State: APjAAAWs3TDW62KLVcQsdHXByFz7xb0lJ34GZ/SuT5qu/y1xJLT0VH2J
 rz47PsRFYWx2vxFWPckRLegkcdS7y4MUJyDMy7SrUzNgImHCoogWabRByCNhsxqk2Dw+jmXYiR5
 Bw3zc4aQCCH8iin8=
X-Received: by 2002:a37:4894:: with SMTP id
 v142mr70919253qka.220.1578330344401; 
 Mon, 06 Jan 2020 09:05:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVopkZph7eDKQTeen8r/z9NFlZ9LXpXc5r8cp/4JAN+7F2S9FSIpDVZdj42/uNwbItyXKBeQ==
X-Received: by 2002:a37:4894:: with SMTP id
 v142mr70919235qka.220.1578330344153; 
 Mon, 06 Jan 2020 09:05:44 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id a14sm21092274qko.92.2020.01.06.09.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 09:05:43 -0800 (PST)
Date: Mon, 6 Jan 2020 12:05:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 00/32] virtio, pci, pc: fixes, features
Message-ID: <20200106120515-mutt-send-email-mst@kernel.org>
References: <20200105125622.27231-1-mst@redhat.com>
 <CAFEAcA8u56NW2634q7_6BrgVOUxcNt037EQ_dNDg0RdqgUWUMQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8u56NW2634q7_6BrgVOUxcNt037EQ_dNDg0RdqgUWUMQ@mail.gmail.com>
X-MC-Unique: Ba8bJMXSPHWGWEnEg2EsyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 04:48:19PM +0000, Peter Maydell wrote:
> On Sun, 5 Jan 2020 at 12:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Changes from v2:
> > - rebased on master
> > - a couple more bugfixes
> >
> > The following changes since commit f0dcfddecee8b860e015bb07d67cfcbdfbfd=
51d9:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reques=
t' into staging (2020-01-03 17:18:08 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 93ef96f3258f489f7bff28ca7b9e0dc74de2a75b=
:
> >
> >   intel_iommu: add present bit check for pasid table entries (2020-01-0=
5 07:41:10 -0500)
> >
> > ----------------------------------------------------------------
> > virtio, pci, pc: fixes, features
> >
> > Bugfixes all over the place.
> > HMAT support.
> > New flags for vhost-user-blk utility.
> > Auto-tuning of seg max for virtio storage.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Build failure for OSX:
>=20
> /Users/pm215/src/qemu-for-merges/hw/scsi/virtio-scsi.c:904:35: error:
> format specifies type 'unsigned short' but the argument has type
> 'uint32_t' (aka 'unsigned int') [-Werror,-Wformat]
>                    "must be > 2", s->conf.virtqueue_size);
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
> expanded from macro 'error_setg'
>                         (fmt), ## __VA_ARGS__)
>                                   ^~~~~~~~~~~
> 1 error generated.
>=20
> (Everything else passed OK.)
>=20
> thanks
> -- PMM

Fixed up now - can you try again pls?

--=20
MST


