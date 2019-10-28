Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9842CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4262054F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdydpXQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4262054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPE4u-0005iJ-6K
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 19:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPE34-0004Np-MX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPE2a-0002a5-4U
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:03:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPE2Z-0002Ze-Vr
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572303790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxQ2vFHrmF0sliBsU5LefI+/LAgzsjMyLNF+0gRi98A=;
 b=GdydpXQs7SPr46VynFGgSe15J3QG4d/9gvaQkOQ1zmSQLE2zxBmPdRcSLCikGwwLxIKCw5
 spD0aX2y/Y28qkj8tsfMwsbhO28xm9Utjh0L+uBxcgdtVSBAEI4+mYZfuFDIjbU9EhtJk7
 hPMuqZKDmMBIoPWJfQuvKBhm47GNihs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-FPjWX1HOOdarUXUAtQl5gw-1; Mon, 28 Oct 2019 19:03:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E0471804975;
 Mon, 28 Oct 2019 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0EDA26199;
 Mon, 28 Oct 2019 23:03:01 +0000 (UTC)
Date: Mon, 28 Oct 2019 19:02:59 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 2/3] Acceptance tests: introduce utility method for tags
 unique vals
Message-ID: <20191028230259.GA6770@localhost.localdomain>
References: <20190924194501.9303-1-crosa@redhat.com>
 <20190924194501.9303-3-crosa@redhat.com>
 <53219208-0345-cba4-0482-aea085bca6c0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <53219208-0345-cba4-0482-aea085bca6c0@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FPjWX1HOOdarUXUAtQl5gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 06:12:25PM -0300, Wainer dos Santos Moschetta wrote=
:
> Hi Cleber,
>=20
> On 9/24/19 4:45 PM, Cleber Rosa wrote:
> > Currently a test can describe the target architecture binary that it
> > should primarily be run with, be setting a single tag value.
> >=20
> > The same approach is expected to be done with other QEMU aspects to be
> > tested, for instance, the machine type and accelerator, so let's
> > generalize the logic into a utility method.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++------
> >   1 file changed, 13 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> > index bd41e0443c..02775bafcf 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -54,14 +54,21 @@ def pick_default_qemu_bin(arch=3DNone):
> >   class Test(avocado.Test):
> > +    def _get_unique_tag_val(self, tag_name):
> > +        """
> > +        Gets a tag value, if unique for a key
> > +        """
> > +        vals =3D self.tags.get(tag_name, [])
> > +        if len(vals) =3D=3D 1:
>=20
>=20
> An small optimization:
>=20
> if vals:
>=20
> =A0 return vals.pop()
>

IIUC, this would break the idea of uniqueness that this method, for
now, has.  Read on.

>=20
> > +            return vals.pop()
> > +        return None
>=20
> Does it allows to express a scenario like "I want my test method to run o=
n
> x86_64 and aarch64" using tags? If so, _get_unique_tag_val logic returns
> None for multi-value tags (e.g. 'tags=3Darch:x86_64,arch:aarch64').
>

I thought that initially we should attempt to pick a default arch or
machine type only of len(vals) =3D=3D 1.  Not because what you describe
can't be done, but because I would like to go through the tests and
make sure we run them in all the given tagged arches when we allow
that.

Thanks,
- Cleber.

> Thanks,
>=20
> Wainer
>=20
> > +
> >       def setUp(self):
> >           self._vms =3D {}
> > -        arches =3D self.tags.get('arch', [])
> > -        if len(arches) =3D=3D 1:
> > -            arch =3D arches.pop()
> > -        else:
> > -            arch =3D None
> > -        self.arch =3D self.params.get('arch', default=3Darch)
> > +
> > +        self.arch =3D self.params.get('arch',
> > +                                    default=3Dself._get_unique_tag_val=
('arch'))
> > +
> >           default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
> >           self.qemu_bin =3D self.params.get('qemu_bin',
> >                                           default=3Ddefault_qemu_bin)


