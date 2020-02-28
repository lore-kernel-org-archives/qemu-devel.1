Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F0CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8723720665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtyR2Y1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7f8J-0004Lp-Jz
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1j7f7c-0003xN-5X
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1j7f7a-0002K7-C6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:52:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1j7f7a-0002Jz-8T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582894321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwl0bs98tScylQa1ApKYz3amT2WVTLJDy+ssmPy9fOA=;
 b=XtyR2Y1XfELDfMQxYtCvSejTxi48ewPQujvE4rDQLIq94SyNqtTknRp3upZbJXoZaNjYHo
 op8ePDbiJeMETD8RNBBjw/nRfr7x2a/Bzg1KpUQdSRWFgZLOouQWwXmH9FAoDsLTtBwHrx
 5I2Wsni/bWAijOVsqiSeBX1K0HGnJYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-tsqG4lf4NFCvZNGW27A8nw-1; Fri, 28 Feb 2020 07:50:47 -0500
X-MC-Unique: tsqG4lf4NFCvZNGW27A8nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C39718AB2C0;
 Fri, 28 Feb 2020 12:50:46 +0000 (UTC)
Received: from horse.redhat.com (ovpn-122-84.rdu2.redhat.com [10.10.122.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA8CD10027BA;
 Fri, 28 Feb 2020 12:50:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 97B732257D2; Fri, 28 Feb 2020 07:50:44 -0500 (EST)
Date: Fri, 28 Feb 2020 07:50:44 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH v4 0/2] virtiofsd: Fix xattr operations
Message-ID: <20200228125044.GA21565@redhat.com>
References: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 02:59:25PM +0900, Misono Tomohiro wrote:
> Currently xattr operations on virtiofs does not work properly in some cas=
e:
>  - directory ... cannot set
>  - special files (pipe) ... cause hang
>=20
> This fixes these problems and now xfstests generic/062 passes on virtiofs
> with -o xattr option (I tested with xfs).
>=20
> v3 -> v4:
>  - No logic change
>  - Some code style fix/update comments and commit log as suggested by Viv=
ek
>  - CC qemu-devel ML too
>=20
> Previous versions can be found in virtiofs ML:
>  v3: https://www.redhat.com/archives/virtio-fs/2020-February/msg00032.htm=
l
>=20
> Thanks,
> Misono Tomohiro (2):
>   virtiofsd: passthrough_ll: cleanup getxattr/listxattr
>   virtiofsd: Fix xattr operations

Thanks Misono for this work. I am fine with this patch series.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

>=20
>  tools/virtiofsd/fuse_virtio.c    |  13 +++
>  tools/virtiofsd/passthrough_ll.c | 139 ++++++++++++++++---------------
>  tools/virtiofsd/seccomp.c        |   6 ++
>  3 files changed, 89 insertions(+), 69 deletions(-)
>=20
> --=20
> 2.21.1
>=20


