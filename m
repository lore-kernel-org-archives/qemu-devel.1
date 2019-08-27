Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B373C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C822186A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C822186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dy2-00025K-2R
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i2dtm-0006gd-8Y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i2dtg-0000iM-Hg
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1i2dtg-0000h4-9L; Tue, 27 Aug 2019 12:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1236519CF7A;
 Tue, 27 Aug 2019 16:00:39 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FFFA1001B13;
 Tue, 27 Aug 2019 16:00:38 +0000 (UTC)
Date: Tue, 27 Aug 2019 12:00:36 -0400
From: Cleber Rosa <crosa@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190827160036.GB25965@dhcp-17-173.bos.redhat.com>
References: <20190819082820.14817-1-sathnaga@linux.vnet.ibm.com>
 <20190824093255.GI3027@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190824093255.GI3027@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 27 Aug 2019 16:00:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 1/2] tests.acceptance.avocado_qemu: Add
 support for powerpc
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
Cc: ehabkost@redhat.com, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, sathnaga@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 24, 2019 at 07:32:55PM +1000, David Gibson wrote:
> On Mon, Aug 19, 2019 at 01:58:20PM +0530, sathnaga@linux.vnet.ibm.com w=
rote:
> > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> >=20
> > Current acceptance test will not run properly in powerpc
> > environment due qemu target is different from arch, this
> > usually matches, except with bi-endian architectures like ppc64.
> > uname would return `ppc64` or `ppc64le` based `big` or `little`
> > endian but qemu `target` is always `ppc64`. Let's handle it.
> >=20
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> I sent a similar patch a little while back, but it seems it got lost.
>=20
>=20
> > ---
> >  tests/acceptance/avocado_qemu/__init__.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accept=
ance/avocado_qemu/__init__.py
> > index aee5d820ed..bd41e0443c 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -39,6 +39,9 @@ def pick_default_qemu_bin(arch=3DNone):
> >      """
> >      if arch is None:
> >          arch =3D os.uname()[4]
> > +    # qemu binary path does not match arch for powerpc, handle it
> > +    if 'ppc64le' in arch:
> > +        arch =3D 'ppc64'
> >      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
> >                                            "qemu-system-%s" % arch)
> >      if is_readable_executable_file(qemu_bin_relative_path):
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Yes, I remember that.  I have the feeling the discussion evolved into
"let's do it for all other arch differences", because I found a patch
here about that.  Anyway, sorry about that.

I've queued this one.

- Cleber.

