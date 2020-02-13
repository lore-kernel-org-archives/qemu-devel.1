Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D6C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FAC21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9q2bHE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FAC21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Aqk-0004vI-Ja
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j2Apq-0004Hy-1B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j2Apn-0006Ob-GO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:31:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j2Apm-0006Nd-OL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581586257;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/Z73Y+Nz88H31/zruCQ4ZyD8XbYulGWg0WlAtXQaxY=;
 b=D9q2bHE4N4/nVOQScCJTXBVO2PJwsky0IH0CM8zGW6eV3eSPLhFv43yTqn6v6sfBoSJ8i6
 deW3lHQ0xR643jmGFERYeAtjl3mRJG54q3bLoAi/qCY20hMBD5oX+1A8HboSk0b0x9lTSq
 D9FVMDHt037di+zBKwabRmZrWY5G5xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-T9IhgDrCMIm394WWOVZueQ-1; Thu, 13 Feb 2020 04:30:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FB51084430;
 Thu, 13 Feb 2020 09:30:49 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE1E790092;
 Thu, 13 Feb 2020 09:30:47 +0000 (UTC)
Date: Thu, 13 Feb 2020 09:30:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qemu-doc: Clarify extent of build platform support
Message-ID: <20200213093044.GC594756@redhat.com>
References: <20200213084335.15100-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200213084335.15100-1-armbru@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: T9IhgDrCMIm394WWOVZueQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 09:43:34AM +0100, Markus Armbruster wrote:
> Supporting a build platform beyond its end of life makes no sense.
> Spell that out just to be clear.

Agreed, that matches my intention when first writing this doc.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-doc.texi | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index a1ef6b6484..33b9597b1d 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2880,10 +2880,11 @@ lifetime distros will be assumed to ship similar =
software versions.
> =20
>  For distributions with long-lifetime releases, the project will aim to s=
upport
>  the most recent major version at all times. Support for the previous maj=
or
> -version will be dropped 2 years after the new major version is released.=
 For
> -the purposes of identifying supported software versions, the project wil=
l look
> -at RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distr=
os will
> -be assumed to ship similar software versions.
> +version will be dropped 2 years after the new major version is released,
> +or when it reaches ``end of life''. For the purposes of identifying
> +supported software versions, the project will look at RHEL, Debian,
> +Ubuntu LTS, and SLES distros. Other long-lifetime distros will be
> +assumed to ship similar software versions.
> =20
>  @section Windows
> =20
> --=20
> 2.21.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


