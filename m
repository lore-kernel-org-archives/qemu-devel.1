Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E048C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9562176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeBL4Mmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9562176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iad5Z-0001W2-IK
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iacnf-00076l-Ud
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iacna-0005em-OK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:42:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iacna-0005cH-E0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575020568;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYw7kp3QQGa4HNw3G8bjQxnuMXdR/1d5pl6k5N2a6Vs=;
 b=DeBL4Mmp8OOecgcDrwxgMUyY+TWkkUEmGR2a9GO9lBMEAsd0W4/f/sNIKh4f+Cru6o3Bmx
 cWFa9KaGvnyOfs3DT4SZftoY7hI1M4CcLLcnmh/RJYSUwza38mkNl8QN3fHzUmmfWnum8v
 CzPGzDFLGnmHrcVuedBnVEvS1yhzva8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-1EejB-OWOX-C-f4OQ3IyUg-1; Fri, 29 Nov 2019 04:42:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC8C10054E3;
 Fri, 29 Nov 2019 09:42:44 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F2CE60BE2;
 Fri, 29 Nov 2019 09:42:33 +0000 (UTC)
Date: Fri, 29 Nov 2019 09:42:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191129094230.GE2260471@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
 <CAMxuvaw=o9xP4G1GD95xVUb2as9R_pUB_85muRUVP8p3pEeqxw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvaw=o9xP4G1GD95xVUb2as9R_pUB_85muRUVP8p3pEeqxw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1EejB-OWOX-C-f4OQ3IyUg-1
X-Mimecast-Spam-Score: 0
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 01:31:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Nov 29, 2019 at 1:27 PM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Fri, Nov 29, 2019 at 11:30:51AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi
> > >
> > > On Fri, Nov 29, 2019 at 11:03 AM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
> > > >
> > > > On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wr=
ote:
> > > > > Hi,
> > > > >
> > > > > Setting up shared memory for vhost-user is a bit complicated from
> > > > > command line, as it requires NUMA setup such as: m 4G -object
> > > > > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=
=3Don -numa
> > > > > node,memdev=3Dmem.
> > > > >
> > > > > Instead, I suggest to add a -mem-shared option for non-numa setup=
s,
> > > > > that will make the -mem-path or anonymouse memory shareable.
> > > >
> > > > Is it an option to just use memfd by default (if available)?
> > >
> > > Yes, with a fallback path currently using a temporary file under /tmp
> > > (we may want to use shm_open() instead, or a different location such
> > > as XDG_RUNTIME_DIR? - and use O_TMPFILE)
> >
> > We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is n=
o
> > where near standard across all OS distros, and even if on tmpfs these
> > dirs can be size limited to a significant subset of available RAM. IOW
> > we can't safely use them unless explicitly told to.
>=20
> Is shm_open() acceptable instead?
>=20
> Imho, -mem-shared should do a best effort by default, but can fail.

Possibly, but if we're relying on shm_open choosing the path, then
its harder for users to know what files to clean up when QEMU crashes
or otherwise exits wthout a shm_unlink

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


