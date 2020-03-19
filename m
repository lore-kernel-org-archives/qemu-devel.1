Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE10C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA5820722
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6QPU5qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA5820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEux9-0000X5-OH
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1jEuwZ-0008QO-GW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1jEuwY-000368-19
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:10:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1jEuwX-00033s-Ru
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584623437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VtABQyJeGiivpX5K18NZUbOOvDYw74JrX+Vaderrm4I=;
 b=a6QPU5qAgKWegjjH9EPim/Nh/xYmxulzZFXKnip/C1rIP+Hu0fhGTcclJ19PMAoZhztXJi
 Ns8718Akd95jrxqXkArDiwDn+A4Z6fnEWiq5axUmqz6KCimR37uOCWApBOjTvpM5pUgo3e
 r19DguUs2rGINL8GZWbjZ7tCy06NFZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-JfUmyJTSOTmrfEIvcj11iA-1; Thu, 19 Mar 2020 09:10:34 -0400
X-MC-Unique: JfUmyJTSOTmrfEIvcj11iA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E51801E78;
 Thu, 19 Mar 2020 13:10:33 +0000 (UTC)
Received: from lpt (unknown [10.40.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BA3B9CA3;
 Thu, 19 Mar 2020 13:10:29 +0000 (UTC)
Date: Thu, 19 Mar 2020 14:10:26 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/1] conf: qemu 9pfs: add 'multidevs' option
Message-ID: <20200319131026.GA2150275@lpt>
References: <E1jEFpH-00028X-1c@lizzy.crudebyte.com>
 <E1jEFpL-00028n-Qj@lizzy.crudebyte.com>
MIME-Version: 1.0
In-Reply-To: <E1jEFpL-00028n-Qj@lizzy.crudebyte.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On a Tuesday in 2020, Christian Schoenebeck wrote:
>Introduce new 'multidevs' option for filesystem.
>
>  <filesystem type='mount' accessmode='mapped' multidevs='remap'>

I don't like the 'multidevs' name, but cannot think of anything
beter.

'collisions' maybe?

>    <source dir='/path'/>
>    <target dir='mount_tag'>
>  </filesystem>
>
>This option prevents misbheaviours on guest if a 9pfs export
>contains multiple devices, due to the potential file ID collisions
>this otherwise may cause.
>
>Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>---
> docs/formatdomain.html.in     | 47 ++++++++++++++++++++++++++++++++++-
> docs/schemas/domaincommon.rng | 10 ++++++++
> src/conf/domain_conf.c        | 30 ++++++++++++++++++++++
> src/conf/domain_conf.h        | 13 ++++++++++
> src/qemu/qemu_command.c       |  7 ++++++
> 5 files changed, 106 insertions(+), 1 deletion(-)

Please split the XML changes from the qemu driver changes.

Also missing:
* qemu_capabilities addition
* qemuDomainDeviceDefValidateFS in qemu_domain.c - check for the capability,
   reject this setting for virtiofs
* qemuxml2xmltest addition
* qemuxml2argvtest addition

(no changes required for virschematest - it checks all the XML files in
the directories used by the above tests against the schema)

>
>diff --git a/docs/formatdomain.html.in b/docs/formatdomain.html.in
>index 594146009d..13c506988b 100644
>--- a/docs/formatdomain.html.in
>+++ b/docs/formatdomain.html.in
>@@ -3967,7 +3967,7 @@
>     &lt;source name='my-vm-template'/&gt;
>     &lt;target dir='/'/&gt;
>   &lt;/filesystem&gt;
>-  &lt;filesystem type='mount' accessmode='passthrough'&gt;
>+  &lt;filesystem type='mount' accessmode='passthrough' multidevs='remap'&gt;
>     &lt;driver type='path' wrpolicy='immediate'/&gt;
>     &lt;source dir='/export/to/guest'/&gt;
>     &lt;target dir='/import/from/host'/&gt;
>@@ -4084,13 +4084,58 @@
>         </dd>
>         </dl>
>
>+      <p>
>       <span class="since">Since 5.2.0</span>, the filesystem element
>       has an optional attribute <code>model</code> with supported values
>       "virtio-transitional", "virtio-non-transitional", or "virtio".
>       See <a href="#elementsVirtioTransitional">Virtio transitional devices</a>
>       for more details.
>+      </p>
>+

Unrelated change that can be split out.

>+      <p>
>+      The filesystem element has an optional attribute <code>multidevs</code>
>+      which specifies how to deal with a filesystem export containing more than
>+      one device, in order to avoid file ID collisions on guest when using 9pfs
>+      (<span class="since">since 6.2.0, requires QEMU 4.2</span>).
>+      This attribute is not available for virtiofs. The possible values are:
>+      </p>
>+
>+        <dl>
>+        <dt><code>default</code></dt>
>+        <dd>
>+        Use QEMU's default setting (which currently is <code>warn</code>).
>+        </dd>
>+        <dt><code>remap</code></dt>
>+        <dd>
>+        This setting allows guest to access multiple devices per export without
>+        encountering misbehaviours. Inode numbers from host are automatically
>+        remapped on guest to actively prevent file ID collisions if guest
>+        accesses one export containing multiple devices.
>+        </dd>
>+        <dt><code>forbid</code></dt>
>+        <dd>
>+        Only allow to access one device per export by guest. Attempts to access
>+        additional devices on the same export will cause the individual
>+        filesystem access by guest to fail with an error and being logged (once)
>+        as error on host side.
>+        </dd>
>+        <dt><code>warn</code></dt>
>+        <dd>
>+        This setting resembles the behaviour of 9pfs prior to QEMU 4.2, that is
>+        no action is performed to prevent any potential file ID collisions if an
>+        export contains multiple devices, with the only exception: a warning is
>+        logged (once) on host side now. This setting may lead to misbehaviours
>+        on guest side if more than one device is exported per export, due to the
>+        potential file ID collisions this may cause on guest side in that case.
>+        </dd>
>+        </dl>
>+
>       </dd>

>
>+      <p>
>+      The <code>filesystem</code> element may contain the following subelements:
>+      </p>
>+

And so can this one.

>       <dt><code>driver</code></dt>
>       <dd>
>         The optional driver element allows specifying further details
>@@ -25422,6 +25449,9 @@ virDomainFSDefFormat(virBufferPtr buf,
>         virBufferAsprintf(buf, " model='%s'",
>                           virDomainFSModelTypeToString(def->model));
>     }
>+    if (def->multidevs) {
>+        virBufferAsprintf(buf, " multidevs='%s'", multidevs);
>+    }

make syntax-check complains here:
Curly brackets around single-line body:
../src/conf/domain_conf.c:25452-25454:
     if (def->multidevs) {
         virBufferAsprintf(buf, " multidevs='%s'", multidevs);
     }

Jano

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5zbz4ACgkQ+YPwO/Ma
t52KAAgAsIQTS0LKY2zT5gwKFsHeFPfT4wqqrKJRTRcVnEi7l8wyGs/exFfhqSjW
EYD9EJ/YeBpqD0rwXXTS7+fDRhUoh+3L1HnTMr0/RBZI1iacMNQIKbjutFn7zy3M
fXnEjYbcLiJm1WDY6n9JeNoTYEzDGTBoaHjHETSNfceLPGc8UBDsg1TtLHbKWUcr
KmhwZhfn95RnL0LzjlIZze7Tzp049Xr7dtzfcRoQTPtLIEyD7c4d/FhI2ViU0nME
RAgLkpB6IGcI0Uogyar9B+bXGVgm49aVUiU/Ijx1m2yMduQXWGVfTm0F1u97sv6X
z7o+AEpEzS5wmstTgGwcyrRaeXe5ow==
=b175
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


