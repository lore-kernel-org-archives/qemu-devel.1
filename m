Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2891C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9182084D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du04D4UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9182084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeMl-0000GG-KD
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iadRB-0003TE-K3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iadR9-0007WO-4e
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:23:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iadR8-0007Ml-PO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575023020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njX4JVyTVB8/s+OjqTodLHTzZAQjgQJb/FkEU7ykg98=;
 b=du04D4UHg65R2TKYOmzLb/RgCt/CLCPm8TOOT1+zjWAaTRhvbdVAtgdyT797LJmC/klt38
 RQ7H5BkSUIK1b/GEIbYOU5slHDC8NJk03ARx5tp13n7elijPJszVVIqU+LWX+wrrPCiVxA
 P9CnqBAem5urY4TeTaT3VG0XdxV6nks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-LZ5nKDOGOye8Xrygvdy1NQ-1; Fri, 29 Nov 2019 05:23:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D091B107ACC4;
 Fri, 29 Nov 2019 10:23:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A668C19C4F;
 Fri, 29 Nov 2019 10:23:30 +0000 (UTC)
Date: Fri, 29 Nov 2019 11:23:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129112329.336582b7@redhat.com>
In-Reply-To: <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128161021.GA14595@habkost.net>
 <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LZ5nKDOGOye8Xrygvdy1NQ-1
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 stefanha@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 10:31:36 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 28/11/19 17:10, Eduardo Habkost wrote:
> > On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wrote:=
 =20
> >> Hi,
> >>
> >> Setting up shared memory for vhost-user is a bit complicated from
> >> command line, as it requires NUMA setup such as: m 4G -object
> >> memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don =
-numa
> >> node,memdev=3Dmem.
> >>
> >> Instead, I suggest to add a -mem-shared option for non-numa setups,
> >> that will make the -mem-path or anonymouse memory shareable. =20
> >=20
> > Can we make this be a "-m" option?
> >=20
> > Or, even better: can we make "-m" options be automatically
> > translated to memory-backend-* options somehow?
> >  =20
[...]
> Therefore, I think instead of -mem-shared we should add a "-m
> memdev=3D..." option.  This option:
>=20
> * would be mutually exclusive with both -mem-path
>=20
> * would be handled from allocate_system_memory_nonnuma.
>=20
> * could be mutually exclusive "-numa node", or could just be mutually
> exclusive with "-numa node,memdev=3D..." (the logical conclusion of that
> however would be an undeprecation of "-numa node,mem=3D...", so that has
> to be taken into account as well).

the plan was/still is to have memdev for main ram and deprecate
"-numa node,mem=3D..." for new machine types (can't be done for
old ones due to migration breakages and old libvirt which uses
it). So new machines will be forced to use "-numa memdev"
For old machines '-m memdev' provided memory region will used to
keep "-numa node,mem=3D..." working as it's now (however broken it is).


>=20
> Paolo
>=20
>=20


