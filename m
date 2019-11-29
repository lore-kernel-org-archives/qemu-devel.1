Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D8CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73180217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+xh1/jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73180217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacUM-0002Q3-Jo
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iacQ7-0000JN-IH
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iacQ3-0002uj-R8
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:18:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iacPy-0002oN-9H
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575019104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyQKkIIa/cHDKfTSgCUbJMTe5IRUb+mVbtl9EKtYIAI=;
 b=e+xh1/jtvwS81vPT6GPQEhHPSQgBSJAFCzegjx1q4KJ5ZzCm+hkxwSciUcpndCbEpRt6xW
 xlA7xeo26/TBWTP8YMT5rz84RebU5U2eOPxnKadLNJ0qgI8qjCCHVmfrkPqBZIRiRABIyA
 EdoeKIdhh0f/nhXiT3Tx8qn9d4qv00I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-_NYMGngYNfmXbUrB8B1nxQ-1; Fri, 29 Nov 2019 04:18:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA9F8800D4E;
 Fri, 29 Nov 2019 09:18:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E51025D9C5;
 Fri, 29 Nov 2019 09:18:14 +0000 (UTC)
Date: Fri, 29 Nov 2019 10:18:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129101813.21121399@redhat.com>
In-Reply-To: <20191128161021.GA14595@habkost.net>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128161021.GA14595@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: _NYMGngYNfmXbUrB8B1nxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 13:10:21 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >=20
> > Setting up shared memory for vhost-user is a bit complicated from
> > command line, as it requires NUMA setup such as: m 4G -object
> > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -=
numa
> > node,memdev=3Dmem.
> >=20
> > Instead, I suggest to add a -mem-shared option for non-numa setups,
> > that will make the -mem-path or anonymouse memory shareable. =20
>=20
> Can we make this be a "-m" option?
>=20
> Or, even better: can we make "-m" options be automatically
> translated to memory-backend-* options somehow?
-m SIZE will be translated to a one of memdev properties,
so new suboption potentially could be an aliased to
another memdev property.


