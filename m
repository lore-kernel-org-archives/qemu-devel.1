Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A5EC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17AE2070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2TsEsKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17AE2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7a6-00022N-SP
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ip7ZD-00015d-6g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ip7ZB-0006uX-Dc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:23:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ip7ZB-0006re-A6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578475431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh2klXvD+cjdDIabcqfnfvftYJVR+whFlwcURMtNmOU=;
 b=A2TsEsKXSdScoUvlCk3/8Zd/FsqZbiLuvfFXBwOzQ/XM8Repyn1Y9T7WjFx9/YL3xd2qZY
 bwNNRnsSTWlUuU1j+YM3droW0VxQrMYeSwVviO4JGSxtcw+/HPw+joc4tu8j+2u2WWoGXU
 ioaextWpEa+8ieY8r+QjzLOE7g0Pwh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-AWn6Az40NtSd6D6T9jypPQ-1; Wed, 08 Jan 2020 04:23:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5629100E71A;
 Wed,  8 Jan 2020 09:23:45 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF89310013A7;
 Wed,  8 Jan 2020 09:23:35 +0000 (UTC)
Date: Wed, 8 Jan 2020 10:23:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v3 2/2] tests/ide-test: Create a single unit-test
 covering more PRDT cases
Message-ID: <20200108092334.GA5057@dhcp-200-226.str.redhat.com>
References: <20191223175117.508990-1-alex.popov@linux.com>
 <20191223175117.508990-3-alex.popov@linux.com>
 <20200107074444.GE4076@linux.fritz.box>
 <79b3fccf-f289-245c-429e-517215249ce9@linux.com>
MIME-Version: 1.0
In-Reply-To: <79b3fccf-f289-245c-429e-517215249ce9@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: AWn6Az40NtSd6D6T9jypPQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.01.2020 um 23:39 hat Alexander Popov geschrieben:
> > Did you have a look why this happens? I suppose we might be running out
> > of some resources in the qtest framework becasue each send_dma_request(=
)
> > calls get_pci_device() again?
>=20
> I've spent some time on investigating, but didn't succeed.
>=20
> 1. After several hundreds of send_dma_request() calls the following asser=
tion in
> that function fails:
>     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), BSY | DRQ);
>=20
> 2. If I comment out this assertion, the test system proceeds but eventual=
ly stalls.
>=20
> 3. I tried to send the CMD_FLUSH_CACHE command to the device, it didn't h=
elp.
>=20
> 4. That behavior is not influenced by ide_dma_cb() code that I changed.
>=20
> I guess it would be better if that effect is examined by somebody with mo=
re
> knowledge about DMA and qtest.
>=20
> > 5 seconds isn't that bad, so this shouldn't block this series, but it's
> > still by far the slowest test in ide-test, so any improvement certainly
> > wouldn't hurt.
>=20
> Thanks for not making that mandatory. It would take me much more time.

Ok, don't bother then.

I seem to remember that I ran into something similar some time ago and
found out that it was related to some integer overflow, I think during
the PCI BAR mapping. This might be the same. Maybe I'll have another
look later.

Kevin


