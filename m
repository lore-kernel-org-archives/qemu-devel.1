Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F1C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F250C206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfAG2G60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F250C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixSzw-0006kF-7x
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 04:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ixSzK-0006GF-3d
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ixSzH-0002Jh-So
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:53:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ixSzH-0002Ir-Ot
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580464399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rl1G7I8oolT+XwvsOCo9alwgr/smqZ975D+CJ8I1Rio=;
 b=AfAG2G609JrgIpVqZo0fDKFCeHrFQF2YXmrdM0Ai+M5vIHk+3CaGPJvCbDTTTn9UmRbLpQ
 8Nz3qWbClQAlAz9J2TBE6tvZ/E+7Wfdr+pLWj+3Gt9wVTsQOG3XWhe0lHut5dCunTMXJd6
 o6la5hOeFR+HjnPVJl6KVv7wPLNT9BA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-yJ046WtSNKWsLEdFLtsNOQ-1; Fri, 31 Jan 2020 04:53:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 834468017CC;
 Fri, 31 Jan 2020 09:53:16 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAA0160BE0;
 Fri, 31 Jan 2020 09:53:10 +0000 (UTC)
Date: Fri, 31 Jan 2020 10:53:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 08/29] python/qemu: Add binutils::binary_get_machines()
Message-ID: <20200131105308.304c1bd2.cohuck@redhat.com>
In-Reply-To: <20200129212345.20547-9-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-9-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: yJ046WtSNKWsLEdFLtsNOQ-1
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

On Wed, 29 Jan 2020 22:23:24 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Add a helper to query the list of machines built into a QEMU binary.
> We simply send the 'query-machines' command over a QMP socket.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  python/qemu/binutils.py          | 15 +++++++++++++++
>  tests/acceptance/core_scripts.py |  9 +++++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


