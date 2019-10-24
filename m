Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF26520650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtBfZkjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF26520650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcIv-0007LO-19
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNato-0001kP-8D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNatm-00057R-Uz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:03:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNatm-000575-Of
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571915000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2d1o9veGg7jg+tA2MmsC82ozYb86Q9Tm1NO64ndJl4=;
 b=UtBfZkjIDKTN3LTtB5j8bnRwDDxqa00GWSId5IED6lJDIVwd8lik3fB1P6L+eJh5BpJNkl
 voCC+JCpIZOS1WTQkv5nuTd2pZbCpY1Z/oh11H7xe4A6eiz3CF6iqRhUWBi5Ufm95YybD4
 Abt6HKmXgXAIGVUciYlpmEKFYlJtYKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-2ksBPln0NOyjRkUTJ00wlA-1; Thu, 24 Oct 2019 07:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2D23476;
 Thu, 24 Oct 2019 11:03:13 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8684E60C83;
 Thu, 24 Oct 2019 11:03:00 +0000 (UTC)
Date: Thu, 24 Oct 2019 12:02:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191024110258.GC2877@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <157166664425.24734.3489596262271351160@37313f22b938>
 <20191021143357.GB5837@work-vm>
 <20191024065826-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191024065826-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2ksBPln0NOyjRkUTJ00wlA-1
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
Cc: qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Oct 21, 2019 at 03:33:57PM +0100, Dr. David Alan Gilbert wrote:
> > * no-reply@patchew.org (no-reply@patchew.org) wrote:
> > > Patchew URL: https://patchew.org/QEMU/20191021105832.36574-1-dgilbert=
@redhat.com/
> > >=20
> > >=20
> > >=20
> > > Hi,
> > >=20
> > > This series seems to have some coding style problems. See output belo=
w for
> > > more information:
> > >=20
> > > Subject: [PATCH 00/30] virtiofs daemon (base)
> > > Type: series
> > > Message-id: 20191021105832.36574-1-dgilbert@redhat.com
> > >=20
> > > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > > #!/bin/bash
> > > git rev-parse base > /dev/null || exit 0
> > > git config --local diff.renamelimit 0
> > > git config --local diff.renames True
> > > git config --local diff.algorithm histogram
> > > ./scripts/checkpatch.pl --mailback base..
> >=20
> > Expecting checkpatch to be broken here; most of the files
> > follow FUSE's formatting.
> >=20
> > Dave
>=20
> I wonder what do others think about this.
> One problem with such inconsistencies is that people tend to copy code
> around, which tends to result in a mess.

Converting them is not entirely trivial; so shout now if you'd like it!
I've got an evil combination of indent and clang-tidy that does a
reasonablish job of getting close to qemu's coding standard - but it
does need some hand holding; so is a few days work.
(I applied it to fuse_virtio.c which had a mix of styles).

Dave

> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


