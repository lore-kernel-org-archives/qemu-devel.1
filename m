Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C331C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FC524654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCywnxvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FC524654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RBz-0004sP-1b
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4RBM-0004Sd-8O
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4RBK-00016H-Uu
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:22:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4RBK-00015o-Qz
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582125754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3g2INvuraOlJf+qcBYwxXmpxi0/dsld5tty0zGYYEA=;
 b=BCywnxvc+AZeB/n5ZEBKuPd5AWs/9f9QwSg6dNWPl5XlPBgIOG3vENuMDHzrNz1/wY6pk8
 a+MijlepehuMR0Z1rHNk/fvqbvDWx5jnwXQcvXhQGDYV2JUj04+HUHpU2W69OqVQrATEDr
 uEsRIN0N6n3EQ+SNp2hCFjNdg9wn8gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-JEXswl2AOE2OBJrj4AMWVg-1; Wed, 19 Feb 2020 10:22:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 595E313EA;
 Wed, 19 Feb 2020 15:22:29 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D17319756;
 Wed, 19 Feb 2020 15:22:28 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 0E4963E04B8; Wed, 19 Feb 2020 16:22:26 +0100 (CET)
Date: Wed, 19 Feb 2020 16:22:25 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/2] docs: Convert qemu-cpu-models.texi to rST
Message-ID: <20200219152225.GB24572@paraplu>
References: <20200219114607.1855-1-kchamart@redhat.com>
 <20200219114607.1855-2-kchamart@redhat.com>
 <CAFEAcA94A3doGQthOTrPuMadOfqrSLBadUbi+3BpHr1MGp_w1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94A3doGQthOTrPuMadOfqrSLBadUbi+3BpHr1MGp_w1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JEXswl2AOE2OBJrj4AMWVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 01:16:11PM +0000, Peter Maydell wrote:
> On Wed, 19 Feb 2020 at 11:46, Kashyap Chamarthy <kchamart@redhat.com> wro=
te:

[...]

> >  docs/qemu-cpu-models.texi       | 677 --------------------------------
> >  docs/system/index.rst           |   1 +
> >  docs/system/qemu-cpu-models.rst | 496 +++++++++++++++++++++++
> >  3 files changed, 497 insertions(+), 677 deletions(-)
> >  delete mode 100644 docs/qemu-cpu-models.texi
> >  create mode 100644 docs/system/qemu-cpu-models.rst
>=20
> Hi; I haven't looked in detail at the actual conversion
> parts, but from the diffstat you're missing some parts:

Hi, Peter.

Thanks for the helpfully detailed response.  I realized some of the
missing bits due to the Patchew failure and as I look closer into your
patch for qemu-block-drivers.rst.

> 1) qemu-doc.texi has an "@include docs/qemu-cpu-models.texi"
> that needs to be removed. That then means that the
> "CPU models" section in qemu-doc.texi is empty, so we
> can just delete it (the @node and @section directives,
> and the reference to it in the earlier @menu)
> (I'm surprised this didn't cause 'make' to fail with
> an error trying to build the texi docs.)
>=20
> 2) The bit of Makefile which lists the dependencies of
> qemu-doc.html needs to be updated to remove
> docs/qemu-cpu-models.texi.
>=20
> 3) we create a qemu-cpu-models.7 manpage, so the parts
> of Makefile that currently handle creating it from the
> texi need to be changed to do it from the rST instead.
> You can look at how we handle qemu-block-drivers.7
> for an example. Don't forget that you'll need to add
> a line to docs/system/conf.py to get Sphinx to build
> the manpage, as well as the makefile changes.
> You can check how the manpage renders with
> 'man -l /path/to/builddir/docs/interop/qemu-cpu-models.7'
>=20
> 4) The qemu-cpu-models.texi uses a substitution
> "@set qemu_system_x86 qemu-system-x86-64" so that
> downstream RedHat can easily update the examples text
> to refer to whatever they rename the binary to. The
> equivalent of this in rST you can see in qemu-block-drivers.rst:
> at the top of the file we have
> =EF=BB=BF=EF=BB=BF
> .. |qemu_system| replace:: qemu-system-x86_64
>=20
> and then an example block using it is like:
>=20
> .. parsed-literal::
>=20
>   |qemu_system| linux.img -hdb fat:/my_directory
>=20
> (you have to use a parsed-literal block and not the
> usual :: so that the expansion is done.)

Ah, noted.  I used the regular :: out of habit from elsewhere, and
didn't even look at the details of qemu-block-drivers.rst.

I'm addressing them as we speak; v2 upcoming.

Thanks, again.

--=20
/kashyap


