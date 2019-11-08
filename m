Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227E6C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0937218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR5OSZoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0937218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0ba-0007kL-Df
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Zc-000681-0u
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Zb-0005Bb-0r
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:28:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT0Za-0005Az-TG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573205334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5p/Ecf0qINeeA+vaXUSGk3eNq5vkRZsj198hUN4uCtA=;
 b=SR5OSZoySXcPU2JGX55qEqjaTK7NtakQdMAL2c9PqiWO8+9dZLWm3vNRwrrTDaYDkVuZjW
 IGh3gkv8E1Bn+rCHjBrv3x7k5b0+/H9Ij2fN8nzeX2mT2VKifs+wYHMewhbWdXW2QbzLWW
 Bt9xfTOtLVnHwa4IcEa+/N7OStv/5+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-Uts3l6UVOSqC189w6E3vZw-1; Fri, 08 Nov 2019 04:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F747800C72;
 Fri,  8 Nov 2019 09:28:46 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B19D5DA70;
 Fri,  8 Nov 2019 09:28:41 +0000 (UTC)
Message-ID: <5aa3ad22b0adb236f2ff67c183121c2896e0e1da.camel@redhat.com>
Subject: Re: [PATCH v2 02/11] qcrypto-luks: extend the create options for
 upcoming encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 11:28:40 +0200
In-Reply-To: <e0e85ab0-e84b-0ee8-8467-ff11e803f7cf@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-3-mlevitsk@redhat.com>
 <e0e85ab0-e84b-0ee8-8467-ff11e803f7cf@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Uts3l6UVOSqC189w6E3vZw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-10-04 at 19:42 +0200, Max Reitz wrote:
> On 13.09.19 00:30, Maxim Levitsky wrote:
> > Now you can specify which slot to put the encryption key to
> > Plus add 'active' option which will let  user erase the key secret
> > instead of adding it.
> > Check that active=3Dtrue it when creating.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c             |  2 ++
> >  block/crypto.h             | 16 +++++++++++
> >  block/qcow2.c              |  2 ++
> >  crypto/block-luks.c        | 26 +++++++++++++++---
> >  qapi/crypto.json           | 19 ++++++++++++++
> >  tests/qemu-iotests/082.out | 54 ++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 115 insertions(+), 4 deletions(-)
>=20
> (Just doing a cursory RFC-style review)
>=20
> I think we also want to reject unlock-secret if it=E2=80=99s given for cr=
eation;
Agree, I'll do this in the next version.

> and I suppose it=E2=80=99d be more important to print which slots are OK =
than
> the slot the user has given.  (It isn=E2=80=99t like we shouldn=E2=80=99t=
 print that
> slot index, but it=E2=80=99s more likely the user knows that than what th=
e
> limits are.  I think.)
I don't really understand what you mean here :-(=20

Since this is qmp interface,
I can't really print anything from it, other that error messages.



>=20
> Max
>=20

Best regards,
=09Maxim Levitsky


