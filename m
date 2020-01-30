Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2182C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C93206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0rczBZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C93206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix90v-0004wa-LI
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ix906-00043y-6F
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ix902-0002TO-OU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:32:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ix902-0002T3-Kl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VkiuKTZaOx89iTbz+jb3MVZc+M11BjA9rgss98dvDlc=;
 b=g0rczBZ8TDafd2g8sPB2Z+eWxvwXaU6pILrsKZ0GufR5gbmZtz67iHv4GvYsMgbRVBB0p1
 dmSVDfXpapXfTA2T6PD1MtnwSAyymiu4czpY641pFb6qPF6GTN3r3boErRdEufENWaEhB6
 M7eu0aHeifuJwaoQqnsgZlWo8d07mHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Fmlv2CN6NI-3uHxavaFaRQ-1; Thu, 30 Jan 2020 07:32:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E7F9108838E;
 Thu, 30 Jan 2020 12:32:42 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8918B863D6;
 Thu, 30 Jan 2020 12:32:35 +0000 (UTC)
Date: Thu, 30 Jan 2020 13:32:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 15/29] tests: rename virtio_seg_max_adjust to
 virtio_check_params
Message-ID: <20200130133233.05452052.cohuck@redhat.com>
In-Reply-To: <20200129212345.20547-16-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-16-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Fmlv2CN6NI-3uHxavaFaRQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 22:23:31 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> From: Denis Plotnikov <dplotnikov@virtuozzo.com>
>=20
> Since, virtio_seg_max_adjust checks not only seg_max, but also
> virtqueue_size parameter, let's make the test more general and
> add new parameters to be checked there in the future.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Message-Id: <20200129140702.5411-5-dplotnikov@virtuozzo.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .../{virtio_seg_max_adjust.py =3D> virtio_check_params.py}          | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename tests/acceptance/{virtio_seg_max_adjust.py =3D> virtio_check_para=
ms.py} (100%)
>=20
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_check_params.py
> similarity index 100%
> rename from tests/acceptance/virtio_seg_max_adjust.py
> rename to tests/acceptance/virtio_check_params.py

Makes sense, especially if we want to add non-blk/scsi checks in there.

Acked-by: Cornelia Huck <cohuck@redhat.com>


