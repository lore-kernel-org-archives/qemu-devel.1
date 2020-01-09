Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A8C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7BE2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuqH6oj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7BE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipbGi-00014J-Ux
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 12:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipbD4-0004Xw-Mj
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipbD1-00054v-Q6
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:03:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipbD1-0004ye-B7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578589378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxHl5f5UerijHEyc7x8aX3KValEr66UXBWgDrBGyLio=;
 b=TuqH6oj9cC3qV7QrJBy07Mr3QWZNKdMCDTWkiS1Lx5W+yMT24dmKvkO/chsqfafcofH20S
 ck+DFAv4JKnUaYJHgQ1bFAjsASMjZ+EG/kLushWTL/ei3Zceh5N0qumy54TzIJnpDYVXOj
 6Gq6X6gsvu9tj9Ut77pIJr6Hk7/s3wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-lzdGobQaNdCSAtM9syu6gQ-1; Thu, 09 Jan 2020 12:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6853102C868
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 17:02:51 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C72C60FA2;
 Thu,  9 Jan 2020 17:02:48 +0000 (UTC)
Date: Thu, 9 Jan 2020 17:02:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 056/104] virtiofsd: add security guide document
Message-ID: <20200109170245.GM6795@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-57-dgilbert@redhat.com>
 <20200106150351.GT2930416@redhat.com>
 <20200106175355.GL2798@work-vm>
 <20200107100543.GC3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107100543.GC3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: lzdGobQaNdCSAtM9syu6gQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Jan 06, 2020 at 05:53:55PM +0000, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Thu, Dec 12, 2019 at 04:38:16PM +0000, Dr. David Alan Gilbert (git=
) wrote:
> > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > >=20
> > > > Many people want to know: what's up with virtiofsd and security?  T=
his
> > > > document provides the answers!
> > > >=20
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  tools/virtiofsd/security.rst | 118 +++++++++++++++++++++++++++++++=
++++
> > >=20
> > > Do we need to link this into the rest of QEMU's docs in some
> > > index page ?
> >=20
> > I wonder how;  there's a autogenerated thing in
> >   docs/index.rst
> >=20
> > that includes some of the docs directories subdirectories/index
> > Does that mean we should have this in docs/tools/virtiofsd/security.rst
> > and a docs/tools/index  and a docs/tools/virtiofsd/index  ?
>=20
> I was wondering if this fits into any of the current three sections
> "devel" or "interop" or "specs", but it doesn't feel quite right in
> any of them to me. So having a new docs/tools subtree looks like an
> ok idea in absence of better suggestions.

OK, so what I've done is I've added a preceding patch that creates:

   docs/tools
             /conf.py
             /index.rst

  and adds it to the Makefile and docs/index.rst=20

and then this patch now adds itself as docs/tools/virtiofsd-security.rst
and just adds the entry in docs/tools/index.rst

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


