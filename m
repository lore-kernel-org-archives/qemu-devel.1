Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E272C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6606E2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0ahzNf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6606E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjEj-0007kq-Jh
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTjDc-0006r0-Cr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTjDb-00027U-M0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:41:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jTjDb-00027I-8W
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588153286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbC2jaE5jsp1BfYTAHfnlc3jFYnpo08QjzWoLYNKX6I=;
 b=V0ahzNf+A6rT/l2eT6GEvmxKn7/Ml646DqKZCzdFi4Y831Wm6XZldGtAiVsocX7t3vqJuE
 6Q2h0pL/hnlY/uhkd6A0b7lM7cv0NJ6/leEs/RDSuoOk9w/U6xjk0iLBN1BA8ykmn1VWTM
 ICJ+6Es8zyl+YkEW6Eh7kk9pjuuL78k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-if43sHWuPC6Zy9VB40EoUQ-1; Wed, 29 Apr 2020 05:41:22 -0400
X-MC-Unique: if43sHWuPC6Zy9VB40EoUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A97745F;
 Wed, 29 Apr 2020 09:41:20 +0000 (UTC)
Received: from localhost (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F387A60DB4;
 Wed, 29 Apr 2020 09:41:13 +0000 (UTC)
Date: Wed, 29 Apr 2020 10:41:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH RESEND v6 08/36] multi-process: Add stub functions to
 facilitate build of multi-process
Message-ID: <20200429094112.GE122432@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <647fa5bf70dbea7d2b4e47d2084dea3a66385433.1587614626.git.elena.ufimtseva@oracle.com>
 <20200424131230.GA190507@stefanha-x1.localdomain>
 <A0E83A03-3B01-4863-949A-F5DDC328A387@oracle.com>
 <20200428162916.GC109767@stefanha-x1.localdomain>
 <DDBFBA4D-9922-4D60-B761-A8199F09CC90@oracle.com>
MIME-Version: 1.0
In-Reply-To: <DDBFBA4D-9922-4D60-B761-A8199F09CC90@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 02:58:21PM -0400, Jag Raman wrote:
> > On Apr 28, 2020, at 12:29 PM, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > On Fri, Apr 24, 2020 at 09:47:56AM -0400, Jag Raman wrote:
> >>> On Apr 24, 2020, at 9:12 AM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >>> On Wed, Apr 22, 2020 at 09:13:43PM -0700, elena.ufimtseva@oracle.com =
wrote:
> >>>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> >>>> index f884bb6180..f74c7e927b 100644
> >>>> --- a/stubs/Makefile.objs
> >>>> +++ b/stubs/Makefile.objs
> >>>> @@ -20,6 +20,7 @@ stub-obj-y +=3D migr-blocker.o
> >>>> stub-obj-y +=3D change-state-handler.o
> >>>> stub-obj-y +=3D monitor.o
> >>>> stub-obj-y +=3D monitor-core.o
> >>>> +stub-obj-y +=3D get-fd.o
> >>>> stub-obj-y +=3D notify-event.o
> >>>> stub-obj-y +=3D qtest.o
> >>>> stub-obj-y +=3D replay.o
> >>>=20
> >>> audio.c, vl-stub.c, and xen-mapcache.c are added by this patch but no=
t
> >>> added to Makefile.objs?  Can they be removed?
> >>=20
> >> Hey Stefan,
> >>=20
> >> Sorry it=E2=80=99s not clear. but these files are referenced in Makefi=
le.target.
> >=20
> > Why is the Makefile.target change not in this patch?
> >=20
> > Please structure patch series as logical changes that can be reviewed
> > sequentially.  Not only is it hard for reviewers to understand what is
> > going on but it probably also breaks bisectability if patches contain
> > incomplete changes.
>=20
> Hi Stefan,
>=20
> We grouped all the stubs into a separate patch for ease of review. If you=
=E2=80=99re finding
> it hard to review this way, we=E2=80=99ll modify to ensure that the Makef=
ile changes go along
> with the stubs.

Grouping all the stubs into a single patch isn't a problem.

The issue is that some of the new .c files are not referenced by any
makefile rules.  They aren't being compiled and may contain syntax
errors.

There is also no justification for these stubs so reviewers don't know
why exactly they are needed.  I would have liked to know what required
the creation of each stub.  If you don't remember the details anymore
then let's not worry about it, but sometimes there are cleaner ways of
resolving dependencies than adding stubs.

Stefan

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6pS7gACgkQnKSrs4Gr
c8jSCggAjty0JTyJ4h2Ta/N/uYc86aBw+eIq/OyeBLR2EJRTYsZN4fL+lYD62yYC
MT26BVhcvS0v8vGmG3qIrqaOvkEbstja8lpZBm3Fje847R409yYo2c9/A4IBy4X1
njNXYwKkn0cvMQI+6y8ZGjbbirr4fTGC90OFvfQsGmz6pElXWbiSbwQCtaUaUnyS
erhGHHVC2++KiHa2TjuHJrANrn9XeRVFXH0WXSUqO4m15mW/L9wG7szMOaYzObuc
afr4NKSMHZov2A6E57Z+dbJrJOARXBvGtqdkeF/1b6GxjQS+MS2HN705axo5QzpU
C16oRvbvVxVMhA5Fzb/Ky9vMmHMefw==
=cWLn
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--


