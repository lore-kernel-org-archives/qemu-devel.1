Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF7C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05192072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nWwvIwEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05192072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jExZ7-0000eq-Ni
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 11:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jExYJ-0000FL-Ks
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jExYI-0005kV-4H
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:57:47 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:36005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jExYH-0005j0-MJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xJPuztGTgIFCjNionGVdOI7CEZZp9fGKo4OQrm1FXWM=; b=nWwvIwEtaYD4HhUHGvXGvKRCXK
 aVEt11N5hy4ZHZn73edgmrcNSv+GkknAtoMHKq1vYe3dYyrRY+qqMwotDVunLrLV3SBCzPd68ZfvE
 KSDVyNCNwo5UGxkbIf4QRvcrkimLNw2a5kkdoE8mf6Hufvn46OWYhhUokLW/u6A0NamGJ3dcmrwKf
 uEZ/5vBfppqPg6mAdmkDML53y8CpyHF5yd+HuIFCUPVCBmlu17UdxuD7/s83OQLijK2AB+/LIq7YV
 DWknml2j1hx4sPiOGVqgEjXB70385yZBR/hXfUFUTrJWQ8zZSnBLSo7qfr7Z+yGqRMXIWNe/9gU6Q
 1PlRPEVBTpk2F7sOh4Jc4OchBxqk4YPZHXg4dlPt1T12SOAB5HBndi7BP30RJG29CZevKOf7iuePe
 OCWPo6nX4NiB9bFQO+DbRS/bdkawjdgPk012vYSkC3c3dNMUyyCNMA1vtG5bSqK9n6/sl2e/GK6PW
 2eV7/1i+zZHvQGfrSEF4cXa41Y141Dh4dqFPYCvjgjETjMXZSXWK2/Xo5RLg8jLJwAgqOifDENwvT
 xpDFrwbnZo6LuhDBLI9ViaZx59zpTuhxKf+/dEgwU8fGcrTv8DrDMeG54mJTBiFgxJXiK/CCsd+sK
 x5pXDlXWoMJbBSp5PrNvJR3r5QcSqkOyInFwrlbQk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?J=E1n?= Tomko <jtomko@redhat.com>, libvir-list@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/1] conf: qemu 9pfs: add 'multidevs' option
Date: Thu, 19 Mar 2020 16:57:41 +0100
Message-ID: <1876644.SqPMx7qSmg@silver>
In-Reply-To: <20200319131026.GA2150275@lpt>
References: <E1jEFpH-00028X-1c@lizzy.crudebyte.com>
 <E1jEFpL-00028n-Qj@lizzy.crudebyte.com> <20200319131026.GA2150275@lpt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 19. M=E4rz 2020 14:10:26 CET J=E1n Tomko wrote:
> On a Tuesday in 2020, Christian Schoenebeck wrote:
> >Introduce new 'multidevs' option for filesystem.
> >
> >  <filesystem type=3D'mount' accessmode=3D'mapped' multidevs=3D'remap'>
>=20
> I don't like the 'multidevs' name, but cannot think of anything
> beter.
>=20
> 'collisions' maybe?

Not sure if 'collisions' is better, e.g. collisions=3D'remap' sounds scary.=
 :)
And which collision would that be? At least IMO 'multidevs' is less ambigio=
us.
I have no problem though to change it to whatever name you might come up wi=
th.=20
Just keep the resulting key-value pair set in mind:

multidevs=3D'default'
multidevs=3D'remap'
multidevs=3D'forbid'
multidevs=3D'warn'

vs.

collisions=3D'default'
collisions=3D'remap' <- probably misleading what 'remap' means in this case
collisions=3D'forbid'
collisions=3D'warn' <- wrong, it warns about multiple devices, not about fi=
le ID=20
collisions.

So different key-name might also require different value-names.

Another option would be the long form 'multi-devices=3D...'

> >    <source dir=3D'/path'/>
> >    <target dir=3D'mount_tag'>
> > =20
> >  </filesystem>
> >
> >This option prevents misbheaviours on guest if a 9pfs export
> >contains multiple devices, due to the potential file ID collisions
> >this otherwise may cause.
> >
> >Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >---
> >
> > docs/formatdomain.html.in     | 47 ++++++++++++++++++++++++++++++++++-
> > docs/schemas/domaincommon.rng | 10 ++++++++
> > src/conf/domain_conf.c        | 30 ++++++++++++++++++++++
> > src/conf/domain_conf.h        | 13 ++++++++++
> > src/qemu/qemu_command.c       |  7 ++++++
> > 5 files changed, 106 insertions(+), 1 deletion(-)
>=20
> Please split the XML changes from the qemu driver changes.

Ok

> Also missing:
> * qemu_capabilities addition

AFAICS the common procedure is to add new capabilities always to the end of=
=20
the enum list. So I guess I will do that as well.

> * qemuDomainDeviceDefValidateFS in qemu_domain.c - check for the capabili=
ty,
> reject this setting for virtiofs

Good to know where that check is supposed to go to, thanks!

> * qemuxml2xmltest addition
> * qemuxml2argvtest addition

Ok, I have to read up how those tests work. AFAICS I need to add xml files =
to=20
their data subdirs.

Separate patches required for those 2 tests?

> (no changes required for virschematest - it checks all the XML files in
> the directories used by the above tests against the schema)
>=20
> >diff --git a/docs/formatdomain.html.in b/docs/formatdomain.html.in
> >index 594146009d..13c506988b 100644
> >--- a/docs/formatdomain.html.in
> >+++ b/docs/formatdomain.html.in
> >@@ -3967,7 +3967,7 @@
> >
> >     &lt;source name=3D'my-vm-template'/&gt;
> >     &lt;target dir=3D'/'/&gt;
> >  =20
> >   &lt;/filesystem&gt;
> >
> >-  &lt;filesystem type=3D'mount' accessmode=3D'passthrough'&gt;
> >+  &lt;filesystem type=3D'mount' accessmode=3D'passthrough'
> >multidevs=3D'remap'&gt;>
> >     &lt;driver type=3D'path' wrpolicy=3D'immediate'/&gt;
> >     &lt;source dir=3D'/export/to/guest'/&gt;
> >     &lt;target dir=3D'/import/from/host'/&gt;
> >
> >@@ -4084,13 +4084,58 @@
> >
> >         </dd>
> >         </dl>
> >
> >+      <p>
> >
> >       <span class=3D"since">Since 5.2.0</span>, the filesystem element
> >       has an optional attribute <code>model</code> with supported values
> >       "virtio-transitional", "virtio-non-transitional", or "virtio".
> >       See <a href=3D"#elementsVirtioTransitional">Virtio transitional
> >       devices</a>
> >       for more details.
> >
> >+      </p>
> >+
>=20
> Unrelated change that can be split out.

Ok, I'll make that the 1st preparatory patch then including ...

> >+      <p>
> >+      The filesystem element has an optional attribute
> ><code>multidevs</code> +      which specifies how to deal with a
> >filesystem export containing more than +      one device, in order to
> >avoid file ID collisions on guest when using 9pfs +      (<span
> >class=3D"since">since 6.2.0, requires QEMU 4.2</span>). +      This
> >attribute is not available for virtiofs. The possible values are: +    =
=20
> ></p>
> >+
> >+        <dl>
> >+        <dt><code>default</code></dt>
> >+        <dd>
> >+        Use QEMU's default setting (which currently is <code>warn</code=
>).
> >+        </dd>
> >+        <dt><code>remap</code></dt>
> >+        <dd>
> >+        This setting allows guest to access multiple devices per export
> >without +        encountering misbehaviours. Inode numbers from host are
> >automatically +        remapped on guest to actively prevent file ID
> >collisions if guest +        accesses one export containing multiple
> >devices.
> >+        </dd>
> >+        <dt><code>forbid</code></dt>
> >+        <dd>
> >+        Only allow to access one device per export by guest. Attempts to
> >access +        additional devices on the same export will cause the
> >individual +        filesystem access by guest to fail with an error and
> >being logged (once) +        as error on host side.
> >+        </dd>
> >+        <dt><code>warn</code></dt>
> >+        <dd>
> >+        This setting resembles the behaviour of 9pfs prior to QEMU 4.2,
> >that is +        no action is performed to prevent any potential file ID
> >collisions if an +        export contains multiple devices, with the only
> >exception: a warning is +        logged (once) on host side now. This
> >setting may lead to misbehaviours +        on guest side if more than one
> >device is exported per export, due to the +        potential file ID
> >collisions this may cause on guest side in that case. +        </dd>
> >+        </dl>
> >+
> >
> >       </dd>
> >
> >+      <p>
> >+      The <code>filesystem</code> element may contain the following
> >subelements: +      </p>
> >+
>=20
> And so can this one.

=2E.. this one.

> >       <dt><code>driver</code></dt>
> >       <dd>
> >      =20
> >         The optional driver element allows specifying further details
> >
> >@@ -25422,6 +25449,9 @@ virDomainFSDefFormat(virBufferPtr buf,
> >
> >         virBufferAsprintf(buf, " model=3D'%s'",
> >        =20
> >                           virDomainFSModelTypeToString(def->model));
> >    =20
> >     }
> >
> >+    if (def->multidevs) {
> >+        virBufferAsprintf(buf, " multidevs=3D'%s'", multidevs);
> >+    }
>=20
> make syntax-check complains here:
> Curly brackets around single-line body:
> ../src/conf/domain_conf.c:25452-25454:
>      if (def->multidevs) {
>          virBufferAsprintf(buf, " multidevs=3D'%s'", multidevs);
>      }
>=20
> Jano

Sorry for that, I assumed same code style as qemu. I'll do the automated=20
syntax checks from now on.

Best regards,
Christian Schoenebeck



