Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0B520856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG/ZaXnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0B520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbt4-0006H6-Ep
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNb59-0007Jk-Tw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNb58-0002Yc-6s
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:15:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNb58-0002UG-2A
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571915695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uHuojtoM4+pRGnc2fC/uASFcIPEoOkUoCTnhlegUO8=;
 b=TG/ZaXnPiYbTUD5HtL0HxXrw3nsSexAxzMnVAFklbinizlgrh/W+SQa3Ts9ZuHOyiVo/Ys
 O2NboZ6mHTn9/oky5HN5zCgb1rAXMtZSSln+E76EHSRT2rr1oGBsl1w5GcqLiIpL8v+75V
 2Xc0Wx/XDHwJYi4N2dEsJd5kWJ0LES0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-Nr9deEWZPcuaQorcLF1VMw-1; Thu, 24 Oct 2019 07:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB92D100550E;
 Thu, 24 Oct 2019 11:14:52 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6AD560C83;
 Thu, 24 Oct 2019 11:14:41 +0000 (UTC)
Date: Thu, 24 Oct 2019 12:14:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191024111439.GD2877@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <157166664425.24734.3489596262271351160@37313f22b938>
 <20191021143357.GB5837@work-vm>
 <20191024065826-mutt-send-email-mst@kernel.org>
 <20191024110708.GI3700@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191024110708.GI3700@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Nr9deEWZPcuaQorcLF1VMw-1
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 piaojun@huawei.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Oct 24, 2019 at 06:59:33AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Oct 21, 2019 at 03:33:57PM +0100, Dr. David Alan Gilbert wrote:
> > > * no-reply@patchew.org (no-reply@patchew.org) wrote:
> > > > Patchew URL: https://patchew.org/QEMU/20191021105832.36574-1-dgilbe=
rt@redhat.com/
> > > >=20
> > > >=20
> > > >=20
> > > > Hi,
> > > >=20
> > > > This series seems to have some coding style problems. See output be=
low for
> > > > more information:
> > > >=20
> > > > Subject: [PATCH 00/30] virtiofs daemon (base)
> > > > Type: series
> > > > Message-id: 20191021105832.36574-1-dgilbert@redhat.com
> > > >=20
> > > > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > > > #!/bin/bash
> > > > git rev-parse base > /dev/null || exit 0
> > > > git config --local diff.renamelimit 0
> > > > git config --local diff.renames True
> > > > git config --local diff.algorithm histogram
> > > > ./scripts/checkpatch.pl --mailback base..
> > >=20
> > > Expecting checkpatch to be broken here; most of the files
> > > follow FUSE's formatting.
> > >=20
> > > Dave
> >=20
> > I wonder what do others think about this.
> > One problem with such inconsistencies is that people tend to copy code
> > around, which tends to result in a mess.
>=20
> IIUC, most of this code is simpy copied as-is from the fuse or linux
> git repos. I'm wondering what the intention is for it long term ?
>=20
> For header files, I would have expected us to be able to compile against
> the -devel package provided by the kernel or fuse packages. I can
> understand if we want to import the headers if the VSOCK additions to
> them are not yet widely available in distros though. If this is the case
> we should put a time limit on how long we'd keep these copied headers
> around for before dropping them. It would be fine to violate QEMU coding
> style in this case as its not code QEMU would "maintain" long term - just
> a read-only import.

The headers are really two types;  one are external definitions, the
other are internal parts of libfuse.  I'd expect to keep the internal
parts long term; teh external parts hmm; where would we pull them in
externally from?

> The source files though, we appear to then be modifying locally, which
> suggests they'll live in our repo forever. In this case I'd expect to
> have compliance with QEMU coding standards.

OK.

> I'm surprised we need to copy so much in from fuse though. Is there a
> case to be made for fuse to provide a library of APIs for people who
> are building fuse daemons to link against, instead of copy & fork ?

libfuse *is* such a library; but it preserves ABI compliance; it's
intention is to be used to build filesystem implementations on top of -
and that's got a fairly good separation;  however changing the fuse
transport, and security models is much more invasive than it was
designed for.

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


