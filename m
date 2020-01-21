Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628FEC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BAF24653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+l3ODnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BAF24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituZe-0005e0-LZ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ittzO-00046E-0G
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ittzM-0002hR-Ry
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:54:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ittzM-0002gr-NL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579614880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAPsVAjugB5XRyo7HdUV1TWGHRy9A5yyrBvF5QYgqCs=;
 b=g+l3ODnGt1wibaWHCaRwP2MsaH6IL5hsSY7yHJ5Hl3/zHnWAoce+Ct+OSkW3xFcJB4W0n+
 eW+xvVdIkkaWqqd+fgY7EP77JaqTD+cumLsKsFDJIPRmOGqGsGJPL5xF6YEhpMyi8ImkFw
 t3tKPxdOmUy2znUq7EPlsW44xaLxvvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Nk3LPpWsM46f4eiwjZPVDg-1; Tue, 21 Jan 2020 08:54:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9FC5107ACC4;
 Tue, 21 Jan 2020 13:54:37 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B470F60BE0;
 Tue, 21 Jan 2020 13:54:30 +0000 (UTC)
Date: Tue, 21 Jan 2020 14:54:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 06/10] qom/object: Display more helpful message when
 a parent is missing
Message-ID: <20200121145428.56e2f962.cohuck@redhat.com>
In-Reply-To: <20200121110349.25842-7-philmd@redhat.com>
References: <20200121110349.25842-1-philmd@redhat.com>
 <20200121110349.25842-7-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Nk3LPpWsM46f4eiwjZPVDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 12:03:45 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> QEMU object model is scarse in documentation. Some calls are
> recursive, and it might be hard to figure out even trivial issues.
>=20
> We can avoid developers to waste time in a debugging session by
> displaying a simple error message.
>=20
> This commit is also similar to e02bdf1cecd2 ("Display more helpful
> message when an object type is missing").
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: New patch
> ---
>  qom/object.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 0d971ca897..bc13a55094 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -173,7 +173,11 @@ static TypeImpl *type_get_parent(TypeImpl *type)
>  {
>      if (!type->parent_type && type->parent) {
>          type->parent_type =3D type_get_by_name(type->parent);
> -        g_assert(type->parent_type !=3D NULL);
> +        if (!type->parent_type) {
> +            fprintf(stderr, "Object '%s' missing its parent '%s'\n",

Maybe s/missing/is missing/ ?

Anyway, a real improvement :)

> +                    type->name, type->parent);
> +            abort();
> +        }
>      }
> =20
>      return type->parent_type;

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


