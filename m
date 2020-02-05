Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2959C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF6A214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5B9f3ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF6A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTA4-00088W-Lb
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1izT9Q-0007jy-Ss
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1izT9P-0008T0-Sd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:28:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1izT9P-0008Mm-NV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580941683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xEkW3ImkJJ3Nz5DEZiwvv0Fc2uWXkUtsYC8B4idnLXs=;
 b=E5B9f3qlhZXdH41zRyl1O0eQ7gbplfprGM6/9I6pG7dGng1RCUTaWbTI1eY+K3u76f/RkB
 HBWsu4EZ9tsGJJnPtJCKJUASILB5EHEd6WVj6hHSTv2lx+jxFBGqp9Tm2afoCX02H2i7rZ
 9E+h0DnUuT03cPM21qe920FhIZtQr1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-12rVPavjNlCaY0vTVGFIjA-1; Wed, 05 Feb 2020 17:27:58 -0500
X-MC-Unique: 12rVPavjNlCaY0vTVGFIjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A807BDB70;
 Wed,  5 Feb 2020 22:27:57 +0000 (UTC)
Received: from lpt (ovpn-200-44.brq.redhat.com [10.40.200.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89E5119C69;
 Wed,  5 Feb 2020 22:27:53 +0000 (UTC)
Date: Wed, 5 Feb 2020 23:27:50 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/2] docs: Fix typo in qemu-nbd -P replacement
Message-ID: <20200205222750.GC31521@lpt>
References: <20200123164650.1741798-1-eblake@redhat.com>
 <20200123164650.1741798-2-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123164650.1741798-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 10:46:49AM -0600, Eric Blake wrote:
>The suggested replacement for the deprecated 'qemu-nbd -P' referw to

s/referw/refer/

>'file.backing.opt' instead of 'file.file.opt'; using the example
>verbatim results in:
>
>qemu-nbd: Failed to blk_new_open 'driver=3Draw,offset=3D1m,size=3D100m,fil=
e.driver=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfile4':=
 A block device must be specified for "file"
>
>Correct this text, prior to actually finishing the deprecation process.
>
>Fixes: 0ae2d54645eb
>Reported-by: Max Reitz <mreitz@redhat.com>
>Signed-off-by: Eric Blake <eblake@redhat.com>
>---
> qemu-deprecated.texi | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl47QWIACgkQ+YPwO/Ma
t52CKAf/TMm0y5UeTQoPWhuqOHgKDidxDjxrXz15uOlF8/ZstPHcB7hmRbHhMG0V
ejgw0Vt01bBco/ZYFA0qPZueFRLFMSBJjwa3rz9s2RPDth0SLOFljURAlFOreIUD
yIP7KUA5vYkAOGYQsyHuGIu78t4iKvObuhNQ+wacFh+x5TuRdUfGchMYIKG4qMNj
uYHTgJSwulpNwr92hjBIcC86Nhx3jAYRpDvZzPVLtGxz/jAjf0tfBlXudGp6tmMN
G37lVjMsjsWLfv7EmgN/tsjQ7MAQe8twUyk0r3+gnYpk0cvpIc4NlEAQWdKB3ghW
vXEr8euVPtu6FqBkC33K7vXdH1JnPw==
=P1bs
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--


