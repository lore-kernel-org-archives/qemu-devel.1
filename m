Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C6C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69022074D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnpHjZh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69022074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOI9K-0004e7-SQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jOI8G-0003OE-Dz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jOI8E-0001fT-TX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jOI8E-0001ez-Gb
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586857526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqQcjBaUA4/pWS6QQM0cWlmT+P/BcxGgavR3JzzWkIM=;
 b=cnpHjZh27dM/73VANj+eH8Z8NhKkzeaaFerTwBFEkqTQYTTxW5R1fmH7amMI5StjAxI3eQ
 3EvJJpiafT5SRPYBPHeAzM00+DaGIgDK3jZF8fUiko+Y59PHfd4ERFBpzUBmcEOJHxESM3
 3H8CeMKmR/GrJvt7NgMpTU6rU93A7/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ZJN9VRskMtK3FqqwWJ6GCA-1; Tue, 14 Apr 2020 05:45:22 -0400
X-MC-Unique: ZJN9VRskMtK3FqqwWJ6GCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE6C2107ACC4;
 Tue, 14 Apr 2020 09:45:18 +0000 (UTC)
Received: from gondolin (ovpn-113-32.ams2.redhat.com [10.36.113.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52EA59F9A1;
 Tue, 14 Apr 2020 09:45:00 +0000 (UTC)
Date: Tue, 14 Apr 2020 11:44:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 2/3] various: Remove unnecessary OBJECT() cast
Message-ID: <20200414114457.06e15bcb.cohuck@redhat.com>
In-Reply-To: <20200412210954.32313-3-f4bug@amsat.org>
References: <20200412210954.32313-1-f4bug@amsat.org>
 <20200412210954.32313-3-f4bug@amsat.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Laurent Vivier <laurent@vivier.eu>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 12 Apr 2020 23:09:53 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> The OBJECT() macro is defined as:
>=20
>   #define OBJECT(obj) ((Object *)(obj))
>=20
> Remove unnecessary OBJECT() casts.
>=20
> Patch created mechanically using spatch with this script:
>=20
>   @@
>   typedef Object;
>   Object *o;
>   @@
>   -   OBJECT(o)
>   +   o
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/bus.c                       | 2 +-
>  hw/ide/ahci-allwinner.c             | 2 +-
>  hw/ipmi/smbus_ipmi.c                | 2 +-
>  hw/microblaze/petalogix_ml605_mmu.c | 8 ++++----
>  hw/s390x/sclp.c                     | 2 +-
>  monitor/misc.c                      | 3 +--
>  qom/object.c                        | 4 ++--
>  7 files changed, 11 insertions(+), 12 deletions(-)
>=20

s390x part:

Acked-by: Cornelia Huck <cohuck@redhat.com>


