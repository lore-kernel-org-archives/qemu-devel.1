Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72EEC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836BA20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0vnWAsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836BA20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWal-00040S-KB
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ioWZu-0003BK-P6
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ioWZs-0004v6-2f
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:54:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ioWZp-0004rj-Op
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578333244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83RBup/F8s49tca9izyIbPPPEaM4EPRtGLl0wVZeOjc=;
 b=X0vnWAsGJ0gi2HloHDoxyQxDCDgPh+nfUrxvZr3NEz4PKuhk65HAIsT/WeDCPsaeAgPQo4
 qk8EG1r+LzNGQR32ABQBMp0jtuZq8HV6R6qm4/1xihcSOovAvZ0+7ZZTgNl84HIITjzE0L
 HxMb9fOfLBNqXAG3+JSILfpdbqFkp/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-8-_DxOysPZq2JpY3TQIbZA-1; Mon, 06 Jan 2020 12:54:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2329100551D
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 17:54:01 +0000 (UTC)
Received: from work-vm (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 566BA5D9E1;
 Mon,  6 Jan 2020 17:53:58 +0000 (UTC)
Date: Mon, 6 Jan 2020 17:53:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 056/104] virtiofsd: add security guide document
Message-ID: <20200106175355.GL2798@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-57-dgilbert@redhat.com>
 <20200106150351.GT2930416@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200106150351.GT2930416@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8-_DxOysPZq2JpY3TQIbZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:16PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Many people want to know: what's up with virtiofsd and security?  This
> > document provides the answers!
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/security.rst | 118 +++++++++++++++++++++++++++++++++++
>=20
> Do we need to link this into the rest of QEMU's docs in some
> index page ?

I wonder how;  there's a autogenerated thing in
  docs/index.rst

that includes some of the docs directories subdirectories/index
Does that mean we should have this in docs/tools/virtiofsd/security.rst
and a docs/tools/index  and a docs/tools/virtiofsd/index  ?

> >  1 file changed, 118 insertions(+)
> >  create mode 100644 tools/virtiofsd/security.rst
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks!

Dave

>=20
>=20
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


