Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3C7FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78193214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtICZYzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78193214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT19n-0000my-5v
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT17s-0007Bz-CO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT17r-0005MI-1L
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:04:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT17q-0005Kv-TU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8kAm7lki0HEyIketRqHW+FrvJ+aE7pa4AGa298cFEY=;
 b=WtICZYzlDXdUZ0u+4O+WRvrGlNpgulRMMP3WrNxKXgPVp6ya6x0LoKErrW1/h/SjDO13vO
 W/tJDpHc1omNFUDzeeFKB5LYaloU3/pmmsTuKWG2F+IL1mvBVgnFfe/m0bsHv/jF/hosIe
 72wgvUWGP0x4q4yllUB56wmFgwwf5fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-2-cJLhBONViDOYw8Q7qMrw-1; Fri, 08 Nov 2019 05:04:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E17171005500;
 Fri,  8 Nov 2019 10:04:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C88E5C290;
 Fri,  8 Nov 2019 10:04:08 +0000 (UTC)
Message-ID: <01869101beb86ddca08e1003e48dfd653ca45d58.camel@redhat.com>
Subject: Re: [PATCH v2 02/11] qcrypto-luks: extend the create options for
 upcoming encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 08 Nov 2019 12:04:07 +0200
In-Reply-To: <20191010134423.GC7616@localhost.localdomain>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-3-mlevitsk@redhat.com>
 <20191010134423.GC7616@localhost.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2-cJLhBONViDOYw8Q7qMrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-10-10 at 15:44 +0200, Kevin Wolf wrote:
> Am 13.09.2019 um 00:30 hat Maxim Levitsky geschrieben:
> > Now you can specify which slot to put the encryption key to
> > Plus add 'active' option which will let  user erase the key secret
> > instead of adding it.
> > Check that active=3Dtrue it when creating.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index b2a4cff683..9b83a70634 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -190,6 +190,20 @@
> >  #                  Currently defaults to 'sha256'
> >  # @hash-alg: the master key hash algorithm
> >  #            Currently defaults to 'sha256'
> > +#
> > +# @active: Should the new secret be added (true) or erased (false)
> > +#          (amend only, since 4.2)
> > +#
> > +# @slot: The slot in which to put/erase the secret
> > +#        if not given, will select first free slot for secret addtion
> > +#        and erase all matching keyslots for erase. except last one
> > +#        (optional, since 4.2)
> > +#
> > +# @unlock-secret: The secret to use to unlock the image
> > +#        If not given, will use the secret that was used
> > +#        when opening the image.
> > +#        (optional, for amend only, since 4.2)
> > +#
> >  # @iter-time: number of milliseconds to spend in
> >  #             PBKDF passphrase processing. Currently defaults
> >  #             to 2000. (since 2.8)
>=20
> This approach doesn't look right to me. BlockdevCreateOptions should
> describe the state of the image after the operation. You're describing
> an update instead (and in a way that doesn't allow you to change
> everything that you may want to change, so that you need to call the
> operation multiple times).
>=20
> I imagined the syntax of a blockdev-amend QMP command similar to
> x-blockdev-reopen: Describe the full set of options that you want to
> have in effect after the operation; if you don't want to change some
> option, you just specify it again with its old value.

This approach is a compromise trying to create more or less usable interfac=
e.
In particular we (I and Daniel) wanted the following to work:

1. ability to add a new password to an empty keyslot and then remove the
old password. This is probably the most common operation and it won't
require the caller to know anything about the keyslots.

2. Allow the user to not know the passwords of some keyslots.
For example if I want to add a new keyslot, I might  not know
some of the other keyslots. Specifying all the active keyslots,
on each amend would force the user to know all the passwords
(you can't 'extract' a password by reading a keyslot, since only
hash of it is stored there for the security reasons)


Thus the amend interface either allows you to add a keyslot (either a speci=
fic one,
or first free one), and to remove a keyslot (again, either a specific one, =
or
one that matches given password).




>=20
> Specifically for luks, this probably means that you have a @slots, which
> is a list that contains at least the secret for each slot, or JSON null
> for a slot that should be left empty.
>=20
> With the same approach, you don't have to make 'size' optional in later
> patches, you can just require that the current size is re-specified. And
> later, blockdev-amend could actually allow changing the size of images
> if you provide a different value.

This can be done IMHO.

>=20
> Kevin


Best regards,=09
=09Maxim Levitsky


