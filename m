Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AB82465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ln7C+FLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AB82465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDTE-0001rR-D7
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuDSY-0001Od-Dx
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuDSX-0003YM-2i
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:42:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuDSW-0003Xs-Vg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579689723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUJEI5OPk0D8t6C0JD6IutMxF3BbhrgbnbyXKvn8rfc=;
 b=Ln7C+FLEmXYamNX9+U11slAZtMe7O4Jzq/336/9ifWmBABMOpE/Z7NLqwgY/yv6yZGOwGw
 9itOQaR+drs+2AVcqwX3sb9bDc1lEHlNyJbQLHczIifrU/bISqU3tPg3l8NrgofFqidS9W
 23ijI2vxBK1vx9dYkobm/C5aqq1voZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-IjgofrdNNB6gn6Og0sLPUw-1; Wed, 22 Jan 2020 05:42:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFBA91060DC6;
 Wed, 22 Jan 2020 10:41:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1530719C70;
 Wed, 22 Jan 2020 10:41:50 +0000 (UTC)
Date: Wed, 22 Jan 2020 10:41:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH v2 006/109] virtiofsd: Trim down imported files
Message-ID: <20200122104148.GD3263@work-vm>
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-7-dgilbert@redhat.com>
 <5E27B810.7050605@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <5E27B810.7050605@cn.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: IjgofrdNNB6gn6Og0sLPUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com, stefanha@redhat.com,
 philmd@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Xiao Yang (yangx.jy@cn.fujitsu.com) wrote:
> On 2020/1/21 20:22, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
> >=20
> > There's a lot of the original fuse code we don't need; trim them down.
> Hi Dave,
>=20
> enum fuse_buf_copy_flags is not used by the v2 patch so I think we can
> remove it directly.
> See my patch for the detailed info:
> https://www.redhat.com/archives/virtio-fs/2020-January/msg00117.html

Yes I see it.

Dave

> Best Regards,
> Xiao Yang
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


