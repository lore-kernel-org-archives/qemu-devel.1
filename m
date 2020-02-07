Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7D9C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2855621741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxTeRHrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2855621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyp1-0002jI-9s
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izyoF-0002CC-Vx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izyoC-0006PE-DH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:16:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izyoC-0006MQ-9r
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581063375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tua0mF/EzerFkjcCZFd7QsTyOwzPc1o+dVOO2Yhgkmo=;
 b=dxTeRHrcqLHJJT8UUc+xU9QKQtMVbBTUvIxw3qT5NKwTV7JkVA+JdZDKTKhQ93qhTQKZu+
 bq6B0h4ENOeWL34Qc4WXhnK6nIeodP/rjnA8jefLXdi5IrnsFirqukHV6t45MxKNiUQwIF
 QFej94PsPYD5i9as48ExkHmcOZSDZJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-pfkZVe-wPCWl0DCxJRjaZg-1; Fri, 07 Feb 2020 03:16:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12ADDB23;
 Fri,  7 Feb 2020 08:16:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BA6481213;
 Fri,  7 Feb 2020 08:16:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F263411386A7; Fri,  7 Feb 2020 09:16:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 04/29] qga/qapi-schema.json: Fix missing '-' in
 GuestDiskBusType doc comment
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-5-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 09:16:03 +0100
In-Reply-To: <20200206173040.17337-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:15 +0000")
Message-ID: <87tv42vmm4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pfkZVe-wPCWl0DCxJRjaZg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> The doc comment for GuestDiskBusType doesn't match up with the
> enumeration because of a missing hyphen in 'file-backed-virtual'.
> This means the docs are rendered wrongly:
>        "virtual"
>            Win virtual bus type "file-backed" virtual: Win file-backed bu=
s type

I expected a funny rendering, but not this one.  The doc generator is
full of surprises...

>
>        "file-backed-virtual"
>            Not documented
> Add the missing hyphen.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  qga/qapi-schema.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index fb4605cc19c..23ce6af597d 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -809,7 +809,7 @@
>  # @sas: Win serial-attaches SCSI bus type
>  # @mmc: Win multimedia card (MMC) bus type
>  # @virtual: Win virtual bus type
> -# @file-backed virtual: Win file-backed bus type
> +# @file-backed-virtual: Win file-backed bus type
>  #
>  # Since: 2.2; 'Unknown' and all entries below since 2.4
>  ##

Reviewed-by: Markus Armbruster <armbru@redhat.com>


