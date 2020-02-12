Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A3C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A1920659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5OZDX2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A1920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rgd-0004bA-Rd
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j1rfI-00047U-RJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j1rf7-0007ec-Vc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:02:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j1rf7-0007di-Rn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581512560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTMLPn9wN+YLWSEELMI/0wurbY1WH5fJvPq4HhxIH0M=;
 b=E5OZDX2hKAZS4wcMfJOIaxYuoEFXxkt2+YpHTtPjVBrr25OWXlX7m8/si0xmHdUfNTR0tv
 xIKPWoKRXWYQHPmDfh166SnS+/cfg4FjEtMPf3nN/uTq3DV+PbU429cw7ctnGOEAmnoCdS
 uUsKRBveBHntIouYkjVeqjx4QDtXyiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-5h__sVEKPsaUD9Dppbbp5g-1; Wed, 12 Feb 2020 08:02:26 -0500
X-MC-Unique: 5h__sVEKPsaUD9Dppbbp5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6545C107B7D6
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:02:25 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46ABB390;
 Wed, 12 Feb 2020 13:02:24 +0000 (UTC)
Date: Wed, 12 Feb 2020 14:02:21 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH] qapi: Expand documentation for LostTickPolicy
Message-ID: <20200212130221.GB2893@lpt>
References: <20200211183744.210298-1-abologna@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200211183744.210298-1-abologna@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 07:37:44PM +0100, Andrea Bolognani wrote:
>The current documentation is fairly terse and not easy to decode
>for someone who's not intimately familiar with the inner workings
>of timer devices. Expand on it by providing a somewhat verbose

Perchance exorbitantly circumlocutory, but definitely an improvement.

>description of what behavior each policy will result in, as seen
>from both the guest OS and host point of view.
>
>Signed-off-by: Andrea Bolognani <abologna@redhat.com>
>---
>This information is reported pretty much word by word in
>
>  https://libvirt.org/formatdomain.html#elementsTime
>
>so I'm hoping I can get the QEMU documentation updated and then just
>merge back the changes.
>
> qapi/misc.json | 34 +++++++++++++++++++++++-----------
> 1 file changed, 23 insertions(+), 11 deletions(-)

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5D91EACgkQ+YPwO/Ma
t51F9AgAqgXPJhN77M5T7lKpcHMcupY6UaeCL8+nlyZy8xkbOBrHZnZFKdvBh9tK
8QJeesHSlfLYHOTk+RI7QXf80sBzhhm/GT9AwREldILo36qvAGIlObVG2p/obTqU
uzZLy9b2Pu0CGVhuuZ7uunNizaldDNvQ0/qSMrmEIQUG8p6FaFR1QDs2mcOT2oKo
z907s2MXSnf3LucKroa6RpH4W0670xYq+3DYSN/tFEOJbktKKVc0oxBiKPTZdAAi
ufdDKB91wWWYV3tcPynFZGpSK++KyQDpSWZl3eh21pOtOmKkMApZEjMBvT9ukDOF
oukRKaxK4AACgCYbWCt+M6Z5xSm9mg==
=VUut
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--


