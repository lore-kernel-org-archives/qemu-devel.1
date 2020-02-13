Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA4C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C98D206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk+Av0lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C98D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2LPj-0004WW-6t
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j2LOu-000466-Uu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j2LOs-00042p-QD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:47:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j2LOs-0003z5-KH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581626873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wr7AHpoYHYrceo4u9lAMz/0w88fnAcz5Igvs+NjLqzM=;
 b=Lk+Av0lu/OJ5sc0r+UhXbwuXRHeVmQHNqpd099I/Zj0emRz16DbQsAXwspe0MDlTVhg11H
 gONPfJ6if63w4OZAK3Y2SFxjQ06pvS8DwTu7QOq+nO542WKQdVpcY/sb1SOL0RrxDQcPpd
 BM2mcehDISyEqEuwpWuxqtEobTlNlWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-C4anwrMAMPqC_czoFeGAHw-1; Thu, 13 Feb 2020 15:47:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4144800D5B;
 Thu, 13 Feb 2020 20:47:49 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94DA5387;
 Thu, 13 Feb 2020 20:47:49 +0000 (UTC)
Date: Thu, 13 Feb 2020 15:47:49 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qemu-doc: Clarify extent of build platform support
Message-ID: <20200213204749.GC3455@habkost.net>
References: <20200213084335.15100-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200213084335.15100-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: C4anwrMAMPqC_czoFeGAHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: jsnow@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 09:43:34AM +0100, Markus Armbruster wrote:
> Supporting a build platform beyond its end of life makes no sense.
> Spell that out just to be clear.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks!

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  qemu-doc.texi | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
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

--=20
Eduardo


