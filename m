Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D02C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53A3214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5gmMn99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53A3214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkh7-0007Uf-SV
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iSkg4-0006xv-V3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iSkg3-0002gI-1Q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:30:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iSkg2-0002fn-Ta
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zxZD6np6FpeheM8jaj6Cfdkw9OmlgZZ5wELW+AIj4U=;
 b=K5gmMn99/N9jv89EtMMdSDRqb9n72Jzk3am0x9cgYygKJBW9ArLm7OMQxKyb2VFMeHS/Dc
 yv21Q5x1VXKjm151yX+Z2wz4GxaHkKDxiPzn2SjUcNFtfLORYBRifjsjuY7x6cRJ4zO+qJ
 l+3pbJswt3WFIuPv9x1LtOoKlKMP43A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-nlSAr7KEMOStkhNr34d1TA-1; Thu, 07 Nov 2019 11:30:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53D478017DD;
 Thu,  7 Nov 2019 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7362B5D6B7;
 Thu,  7 Nov 2019 16:30:14 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:30:12 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v1 4/4] iotests: add test for virtio-scsi and virtio-blk
 machine type settings
Message-ID: <20191107163012.GB29053@localhost.localdomain>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-5-dplotnikov@virtuozzo.com>
 <20191106092412.GH189998@stefanha-x1.localdomain>
 <909f6a98-a750-db34-de23-6c9d89f9f19e@redhat.com>
 <20191106192641.GP3812@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20191106192641.GP3812@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nlSAr7KEMOStkhNr34d1TA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 04:26:41PM -0300, Eduardo Habkost wrote:
> On Wed, Nov 06, 2019 at 11:04:16AM +0100, Max Reitz wrote:
> > On 06.11.19 10:24, Stefan Hajnoczi wrote:
> > > On Tue, Nov 05, 2019 at 07:11:05PM +0300, Denis Plotnikov wrote:
> > >> It tests proper queue size settings for all available machine types.
> > >>
> > >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > >> ---
> > >>  tests/qemu-iotests/267     | 154 ++++++++++++++++++++++++++++++++++=
+++
> > >>  tests/qemu-iotests/267.out |   1 +
> > >>  tests/qemu-iotests/group   |   1 +
> > >>  3 files changed, 156 insertions(+)
> > >>  create mode 100755 tests/qemu-iotests/267
> > >>  create mode 100644 tests/qemu-iotests/267.out
> > >=20
> > > The qemu-iotests maintainers might prefer for this to be at the
> > > top-level in tests/ since it's not really an iotest, but the code its=
elf
> > > looks fine to me:
> > >=20
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Good question.  I don=E2=80=99t really mind, but it would be weird if s=
tarted
> > adding all kinds of =E2=80=9Cexternal=E2=80=9D qemu tests (i.e. that us=
e QMP) in the
> > iotests directory.
> >=20
> > What is the alternative?  Just putting it in a different directory
> > doesn=E2=80=99t sound that appealing to me either, because it would sti=
ll depend
> > on the iotests infrastructure, right?  (i.e., iotests.py and check)
>=20
> We do have tests/acceptance for simple test cases written in
> Python.  What's the reason for this test case to depend on the
> iotests infrastructure?
>=20
> --=20
> Eduardo

This test does look similar in spirit to "tests/acceptance/virtio_version.p=
y".

Denis,

If you think this is more of a generic test than an IO test, and would
rather want to have it a more agnostic location, I can provide you
with tips (or a patch) to do so.

Cheers,
- Cleber.


