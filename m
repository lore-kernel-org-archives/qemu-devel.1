Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88DDCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C332064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBp7GCHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C332064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNElv-000237-FW
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iNEj3-0000JE-Em
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iNEj1-0002jR-2Q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:22:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iNEj0-0002iz-VY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571829766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOkwPqwcemwq2VGzE+fxbh4zItWJYOEXK81FsM8kHrw=;
 b=GBp7GCHqaNQb0GxN/ZAIQeIqzyFNHprFwoh6f+r2hdIQ8E2Fq33VczbMwkT93H4S1pAWVp
 UzGjEq8q4oU6hwWszjbrM/toNuwfVc0BaRKFcqnhCT++8VI+RsxcUjdLrKURQDEUEXL50Y
 g6DYWVRS/21FdUiqaVxdKkHtdqExU0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-RqetXT27PJ67LT6SjzgwWQ-1; Wed, 23 Oct 2019 07:22:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF2F801E66;
 Wed, 23 Oct 2019 11:22:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46C626061E;
 Wed, 23 Oct 2019 11:22:42 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 331B94EE50;
 Wed, 23 Oct 2019 11:22:42 +0000 (UTC)
Date: Wed, 23 Oct 2019 07:22:42 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <2108631048.8152017.1571829762031.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191023100425.12168-17-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
 <20191023100425.12168-17-stefanha@redhat.com>
Subject: Re: [PATCH v4 16/16] libqos: add VIRTIO PCI 1.0 support
MIME-Version: 1.0
X-Originating-IP: [149.14.88.107, 10.4.196.12, 10.5.101.130, 10.4.195.25]
Thread-Topic: libqos: add VIRTIO PCI 1.0 support
Thread-Index: Q1x9nXsf3bdp3y39wWGlWgA8pV7WVg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RqetXT27PJ67LT6SjzgwWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, slp@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> Sent: Wednesday, October 23, 2019 12:04:25 PM
>=20
> Implement the VIRTIO 1.0 virtio-pci interface.  The main change here is
> that the register layout is no longer a fixed layout in BAR 0.  Instead
> we have to iterate of PCI Capabilities to find descriptions of where
> various registers are located.  The vring registers are also more
> fine-grained, allowing for more flexible vring layouts, but we don't
> take advantage of that.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> ---
>  tests/Makefile.include           |   1 +
>  tests/libqos/virtio-pci-modern.h |  17 ++
>  tests/libqos/virtio-pci.h        |  10 +
>  tests/libqos/virtio-pci-modern.c | 443 +++++++++++++++++++++++++++++++
>  tests/libqos/virtio-pci.c        |   6 +-
>  5 files changed, 476 insertions(+), 1 deletion(-)
>  create mode 100644 tests/libqos/virtio-pci-modern.h
>  create mode 100644 tests/libqos/virtio-pci-modern.c

Acked-by: Thomas Huth <thuth@redhat.com>


