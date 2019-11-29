Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3284C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E272176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM+1WcVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E272176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iamqN-00043A-TY
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 15:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iamm6-0002oI-6u
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iamly-0006hh-6t
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:21:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iamlx-0006U9-IG
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575058906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQSzsOv0PTZj8uoUxKZfJxUzI7VhOI/sihTKVUne4Jo=;
 b=DM+1WcVsdgg9eSmge8yAiqkQOdaWudcaheWF2xumr6v0uh09SXfGeu8cFBcWPK6c4wsRys
 6YWXemZaJg9Hon87g2HY6MM/pfXtM4iobrnsqQcTk7zO6cfKrX4E0k7JHpXPT7VvJmSTb+
 MUb4z96pKnLkMmrPZ33UaiCHYvkiq8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Bpkhk-1dNN2jxBYvafpOOw-1; Fri, 29 Nov 2019 15:21:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C56DB20;
 Fri, 29 Nov 2019 20:21:43 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74DC21001281;
 Fri, 29 Nov 2019 20:21:38 +0000 (UTC)
Date: Fri, 29 Nov 2019 17:21:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129202137.GI14595@habkost.net>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128161021.GA14595@habkost.net>
 <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Bpkhk-1dNN2jxBYvafpOOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 10:31:36AM +0100, Paolo Bonzini wrote:
> On 28/11/19 17:10, Eduardo Habkost wrote:
> > On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=E9 Lureau wrote:
> >> Hi,
> >>
> >> Setting up shared memory for vhost-user is a bit complicated from
> >> command line, as it requires NUMA setup such as: m 4G -object
> >> memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don =
-numa
> >> node,memdev=3Dmem.
> >>
> >> Instead, I suggest to add a -mem-shared option for non-numa setups,
> >> that will make the -mem-path or anonymouse memory shareable.
> >=20
> > Can we make this be a "-m" option?
> >=20
> > Or, even better: can we make "-m" options be automatically
> > translated to memory-backend-* options somehow?
> >=20
>=20
> The original idea was to always support one NUMA node, so that you could
> do "-numa node,memdev=3D..." to specify a memory backend with -object.
> However, this is not possible anymore since
>=20
>     if (!mc->cpu_index_to_instance_props ||
>         !mc->get_default_cpu_node_id) {
>         error_setg(errp, "NUMA is not supported by this machine-type");
>         return;
>     }
>=20
> has been added to hw/core/numa.c.
>=20
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

I completely agree we could do this.  I just think this misses
completely the point of this series, because usability of:

  -object memory-backend-file,...,share=3Don,id=3Dmem -m ...,memdev=3Dmem

is not much better than the usability of:

  -object memory-backend-file,...,share=3Don,id=3Dmem -numa node,memdev=3Dm=
em

--=20
Eduardo


