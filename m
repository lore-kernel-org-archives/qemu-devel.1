Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB13C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2582077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2582077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJyUS-0003yV-8v
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 06:54:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hJyTe-0003d3-L7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hJyTd-0003Tv-Ej
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hJyTa-0003KL-Go; Fri, 26 Apr 2019 06:53:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33A98309D049;
	Fri, 26 Apr 2019 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-86.ams2.redhat.com
	[10.36.117.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C282160FBD;
	Fri, 26 Apr 2019 10:53:02 +0000 (UTC)
Date: Fri, 26 Apr 2019 12:53:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190426105301.GA20769@localhost.localdomain>
References: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 26 Apr 2019 10:53:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Failing qemu-iotest 005 with raw
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: hch@lst.de, QEMU Developers <qemu-devel@nongnu.org>,
	Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426105301.bpFaT8GwBiKMmXww-99wW1f_382wcX5e7Ty5z7Djq-o@z>

Am 26.04.2019 um 11:41 hat Thomas Huth geschrieben:
> 
> When running iotest 005 with raw, the test currently fails for me:
> 
> 005         - output mismatch (see 005.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/005.out	2019-04-23
> 16:43:11.000000000 +0200
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/005.out.bad	2019-04-26
> 11:34:11.000000000 +0200
> @@ -1,13 +1,12 @@
>  QA output created by 005
> 
>  creating large image
> +qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file
> format 'IMGFMT'
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=5368709120000
> [...]
> 
> Could this be fixed somehow, or should the test rather be skipped for
> IMGFMT=raw?

The test passes for me on XFS. Looks like the raw driver can handle
large image files, but your host filesystem can't.

We would have to check whether the host filesystem can support large
files and skip the test if it can't. I'm not sure how to do that. But
actually, this isn't testing anything interesting for raw, so just
unconditionally disabling the test for raw could be reasonable enough.

Kevin

