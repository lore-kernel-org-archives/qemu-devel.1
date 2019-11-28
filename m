Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2D2C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878AF216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE1hhgc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878AF216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaQNH-0004Wt-Kl
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 15:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iaNJ1-0005ZH-0a
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iaN8w-0006Kw-SY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:59:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iaN8w-00067K-Ns
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574960387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+gKnFB7aqsHGDTDcrp/7FHk0vxbPnXuLjkksK8oJRE=;
 b=eE1hhgc0oSdo2T83IVUnYn3MSXDB6bv9kkUN3S/lmm8Aqm5N1mnwz1CTL9nqLeLz2UdWie
 GAq/8ujoWfqe2r4FZrJUR/KkFc52Ogji504JE5n0m8QXl0JreHLshhPNyYXqrO5rKzILPu
 pxzxH35PxrKG0HWctYbLolYHA636bTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-bjzBHTW0ONePu8hU5Zwe-g-1; Thu, 28 Nov 2019 11:59:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0CE0911A3;
 Thu, 28 Nov 2019 16:59:42 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C13600C8;
 Thu, 28 Nov 2019 16:59:35 +0000 (UTC)
Date: Thu, 28 Nov 2019 16:59:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 imammedo@redhat.com
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191128165933.GB3295@work-vm>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128141518.628245-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bjzBHTW0ONePu8hU5Zwe-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, stefanha@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi,
>=20
> Setting up shared memory for vhost-user is a bit complicated from
> command line, as it requires NUMA setup such as: m 4G -object
> memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -nu=
ma
> node,memdev=3Dmem.
>=20
> Instead, I suggest to add a -mem-shared option for non-numa setups,
> that will make the -mem-path or anonymouse memory shareable.
>=20
> Comments welcome,

It's worth checking with Igor (cc'd) - he said he was going to work on
something similar.

One other thing this fixes is that it lets you potentially do vhost-user
on s390, since it currently has no NUMA.

Dave

> Marc-Andr=E9 Lureau (2):
>   memfd: add qemu_memfd_open()
>   Add -mem-shared option
>=20
>  exec.c                  | 11 ++++++++++-
>  hw/core/numa.c          | 16 +++++++++++++++-
>  include/qemu/memfd.h    |  3 +++
>  include/sysemu/sysemu.h |  1 +
>  qemu-options.hx         | 10 ++++++++++
>  util/memfd.c            | 39 +++++++++++++++++++++++++--------------
>  vl.c                    |  4 ++++
>  7 files changed, 68 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.24.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


