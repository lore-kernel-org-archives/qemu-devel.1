Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED252C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D08207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1ZFwgWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D08207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iok3y-0006GG-OI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iojXw-0002RL-Rz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iojXv-0006Nt-Ie
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:45:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iojXv-0006NU-DS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578383099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APc49/5FcwoLYepVGQyfNtrgMzt6/DG8+Dthw2jjXNM=;
 b=T1ZFwgWlxE0y4W7dngwkZzZrZPZOpTlhg9dwTRCXZoGoJLdgb27WtOPHb2Mf8/cCip6J0n
 E4aciiO294iAXgPWftM2nUbP0NJuq7OtlhW0KhrFw+QQbOcH0lwP3eUTeJtZtrwMavBGDZ
 egpk7TQsmb+9yM96wa4AQaK6pCnk03A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-7y312h7yOfypiiNn3J13kQ-1; Tue, 07 Jan 2020 02:44:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 827061800D4E;
 Tue,  7 Jan 2020 07:44:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 590B21036D1B;
 Tue,  7 Jan 2020 07:44:46 +0000 (UTC)
Date: Tue, 7 Jan 2020 08:44:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v3 2/2] tests/ide-test: Create a single unit-test
 covering more PRDT cases
Message-ID: <20200107074444.GE4076@linux.fritz.box>
References: <20191223175117.508990-1-alex.popov@linux.com>
 <20191223175117.508990-3-alex.popov@linux.com>
MIME-Version: 1.0
In-Reply-To: <20191223175117.508990-3-alex.popov@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7y312h7yOfypiiNn3J13kQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Am 23.12.2019 um 18:51 hat Alexander Popov geschrieben:
> Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
> using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
> ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
> Currently this bug is not reproduced by the unit tests.
>=20
> Let's improve the ide-test to cover more PRDT cases including one
> that causes this particular qemu crash.
>=20
> The test is developed according to the Programming Interface for
> Bus Master IDE Controller (Revision 1.0 5/16/94).
>=20
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

The time this test takes is much better now (~5s for me).

> +/*
> + * This test is developed according to the Programming Interface for
> + * Bus Master IDE Controller (Revision 1.0 5/16/94)
> + */
> +static void test_bmdma_various_prdts(void)
>  {
> -    QTestState *qts;
> -    QPCIDevice *dev;
> -    QPCIBar bmdma_bar, ide_bar;
> -    uint8_t status;
> -
> -    PrdtEntry prdt[] =3D {
> -        {
> -            .addr =3D 0,
> -            .size =3D cpu_to_le32(0x1000 | PRDT_EOT),
> -        },
> -    };
> -
> -    qts =3D test_bmdma_setup();
> -
> -    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
> -
> -    /* Normal request */
> -    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 1,
> -                              prdt, ARRAY_SIZE(prdt), NULL);
> -    g_assert_cmphex(status, =3D=3D, BM_STS_ACTIVE | BM_STS_INTR);
> -    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
> +    int sectors =3D 0;
> +    uint32_t size =3D 0;
> +
> +    for (sectors =3D 1; sectors <=3D 256; sectors *=3D 2) {
> +        QTestState *qts =3D NULL;
> +        QPCIDevice *dev =3D NULL;
> +        QPCIBar bmdma_bar, ide_bar;
> +
> +        qts =3D test_bmdma_setup();
> +        dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);

I'm wondering why the initialisation has to be inside the outer for
loop. I expected that moving it outside would further improve the speed.
But sure enough, doing that makes the test fail.

Did you have a look why this happens? I suppose we might be running out
of some resources in the qtest framework becasue each send_dma_request()
calls get_pci_device() again?

5 seconds isn't that bad, so this shouldn't block this series, but it's
still by far the slowest test in ide-test, so any improvement certainly
wouldn't hurt.

> +        for (size =3D 0; size < 65536; size +=3D 256) {
> +            uint32_t req_size =3D sectors * 512;
> +            uint32_t prd_size =3D size & 0xfffe; /* bit 0 is always set =
to 0 */
> +            uint8_t ret =3D 0;
> +            uint8_t req_status =3D 0;

If you end up sending another version for some reason, I would also
consider renaming req_status, because reg_status already exists, which
looks almost the same. This confused me for a moment when reading the
code below.

Kevin


