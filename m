Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4478FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBB32088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPAFaA2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBB32088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEGR-0004No-6d
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeEFj-00035h-JU
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:51:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeEFh-0002i5-OA
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590655860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1C6BG9c/JaMiOIm41N7LYwcVaqkjDcuIb5Ie7fT48xw=;
 b=OPAFaA2CtRNiTl/YD1dsUtkJbw4hm8M4EHEZi13cs7PZ+i3S1XlOHvy06qxU3+uTJojrwp
 Z5Z8jLw1f/uKsqh5Eeisojohr6jY4qlqs+WnbUFixIb8Tzxx4n+RDpCvj3x4bPltjt+prz
 hQmV2o4O6Rbfma5WidY7VfZcRjEGrKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-UU0POPhrMgO765xHNJN4vA-1; Thu, 28 May 2020 04:50:58 -0400
X-MC-Unique: UU0POPhrMgO765xHNJN4vA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D586107ACCA;
 Thu, 28 May 2020 08:50:57 +0000 (UTC)
Received: from localhost (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB795D9EF;
 Thu, 28 May 2020 08:50:53 +0000 (UTC)
Date: Thu, 28 May 2020 09:50:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200528085052.GA148227@stefanha-x1.localdomain>
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-4-stefanha@redhat.com>
 <20200527103817.GI2665520@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200527103817.GI2665520@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 11:38:17AM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, May 27, 2020 at 11:29:23AM +0100, Stefan Hajnoczi wrote:
> > Automatically size the number of virtio-scsi-pci, vhost-scsi-pci, and
> > vhost-user-scsi-pci request virtqueues to match the number of vCPUs.
> > Other transports continue to default to 1 request virtqueue.
>=20
> IIRC this was raised on earlier versions of the series, but i don't
> recall the outcome and no caveats are mentioned here...
>=20
> Is this default still valid for very large $vCPUs. eg if I run QEMU
> with "-smp 512" or even larger (I've seen people discussing 1000's of
> CPUs), is this going to cause problems with the virtio-scsi default
> queue counts ? Is there such a thing as "too large" for the num
> of queues setting ?   num vectors defaults to a value derived from
> num queues, so is there concept of "too large" for num of vectors
> setting ?
>=20
> Ideally the commit message would answer these questions for future
> reference.  Same for the next patch to virtio-blk

Good point. Actually this patch and the virtio-blk ones no longer
contain the queue number policy. The new virtio_pci_optimal_num_queues()
function encapsulates the policy to avoid duplication. I'll resend and
update that patch with the full rationale.

Thanks!

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7Pe2wACgkQnKSrs4Gr
c8gjewf7BFjphWoBtrZIEwZIUOEaV0uAPweq3FBBkF8RyL2CuIbJvefAMqidt3xC
/Y4edJpqoItQcw+6wocsZtu0dsA39ZD2fi7wDIKluRPI84fY2MzidlKQ51dDNOxH
DQvtKdA3BFNMFN5VvoCC5RO2KRDCW9kCwBlektSJ785MgxDuD3oK+TgGwwW8gV1G
ZcfaSFkZ0hzZ7JoVDh4wJuZL5MkqOpXBh8U/aXZpO7pDt998WcnV+1zqdHVOYn+3
M6AC1r666PoYFckAVb1qMCKV9tQK9Z7Wg05LoQim1OT7aQ3pih3RGRoOYdfg14jn
/CEptjyYM/ohjf0p5F5FCMHBux0XLQ==
=3y6w
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--


