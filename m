Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13025C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BD220759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7yKWAjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BD220759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMb9-0006nI-Jw
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kaMXx-0002GG-LH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:26:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kaMXv-0008Lv-JR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwvrnVGl3zzk4/gRFIeOl2yhxYKlFhxgYMVkMxa2fNM=;
 b=d7yKWAjnlVRwrxr3Hp9qt+Bt/zO47ieXCrKY6VzHGKS1IPK2jZponIKPH+8y3hsW/f+20i
 fHgq6qzsQj5RD8gK1gy4LPAK1qUc1Bi19xhR+wTa0dtlz/xcGXaf0ff59XqN+o+2tB6E4U
 h4g3j2Pvwqxb7Kh3+U/1HCbzYS++FTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-kTuKYArhNmCBw7vDWTV9Ow-1; Wed, 04 Nov 2020 12:26:03 -0500
X-MC-Unique: kTuKYArhNmCBw7vDWTV9Ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5500B803659;
 Wed,  4 Nov 2020 17:26:01 +0000 (UTC)
Received: from gondolin (ovpn-114-18.ams2.redhat.com [10.36.114.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 031BF6F142;
 Wed,  4 Nov 2020 17:25:49 +0000 (UTC)
Date: Wed, 4 Nov 2020 18:25:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v3 1/4] s390x: fix build for
 --without-default-devices
Message-ID: <20201104182547.5ae54d3f.cohuck@redhat.com>
In-Reply-To: <20201104115706.3101190-2-philmd@redhat.com>
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201104115706.3101190-2-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, Greg Kurz <groug@kaod.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  4 Nov 2020 12:57:03 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> From: Cornelia Huck <cohuck@redhat.com>
>=20
> s390-pci-vfio.c calls into the vfio code, so we need it to be
> built conditionally on vfio (which implies CONFIG_LINUX).
>=20
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Fixes: cd7498d07fbb ("s390x/pci: Add routine to get the vfio dma availabl=
e count")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Message-Id: <20201103123237.718242-1-cohuck@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Greg Kurz <groug@kaod.org>
> Tested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/s390x/s390-pci-vfio.h | 3 ++-
>  hw/s390x/meson.build             | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

I think you're missing Matt's r-b?

Do you plan to send this, or should I include it on my s390-fixes
branch?


