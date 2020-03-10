Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B893DC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DD624694
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPJAQWof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DD624694
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBexi-0002If-VH
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1jBewS-0001Dh-ND
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1jBewR-0000xv-Oa
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:29:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55107)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1jBewR-0000w8-Ko
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583846942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDZdjAo9bYlVSp8OMWCtQh6cbNCEIN3g7GjKNgE4fU4=;
 b=GPJAQWofIMW/Dx6KrcAG51qYHllpP22I4jutbtU4ETmpndtnqxaNJF029YwcOB91ZylBS4
 PQqr8QMPp0czwqcGWOhkl6DKJ8oRJXPBac4/UNiZZWnWFBuIkw3LjUjruhSz3Cr7ZwZRSb
 1NXKWlrOT0eRe3JEEY79FGzN51uyU90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-IyKQ1zZ_M1CI8n8LopHttw-1; Tue, 10 Mar 2020 09:29:00 -0400
X-MC-Unique: IyKQ1zZ_M1CI8n8LopHttw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C086800D48;
 Tue, 10 Mar 2020 13:28:59 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 383535C290;
 Tue, 10 Mar 2020 13:28:58 +0000 (UTC)
Date: Tue, 10 Mar 2020 14:28:55 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 6/7] iotests: Add iothread cases to 155
Message-ID: <20200310132855.GD1320660@angien.pipo.sk>
References: <20200310113831.27293-1-kwolf@redhat.com>
 <20200310113831.27293-7-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310113831.27293-7-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 12:38:30 +0100, Kevin Wolf wrote:
> This patch adds test cases for attaching the backing chain to a mirror
> job target right before finalising the job, where the image is in a
> non-mainloop AioContext (i.e. the backing chain needs to be moved to the
> AioContext of the mirror target).
>=20
> This requires switching the test case from virtio-blk to virtio-scsi
> because virtio-blk only actually starts using the iothreads when the
> guest driver initialises the device (which never happens in a test case
> without a guest OS). virtio-scsi always keeps its block nodes in the
> AioContext of the the requested iothread without guest interaction.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/155     | 32 +++++++++++++++++++++++---------
>  tests/qemu-iotests/155.out |  4 ++--
>  2 files changed, 25 insertions(+), 11 deletions(-)

Reviewed-by: Peter Krempa <pkrempa@redhat.com>


