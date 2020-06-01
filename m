Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C8320734
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ET7Kh5DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C8320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfmng-0004sx-Uk
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 11:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jfmn1-0004Oy-Fl
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:55:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58079
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jfmn0-0005yr-3g
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591026948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/zLYxwipLeae36b8eIMzJBay6buNUXcYOoxHTyFpik=;
 b=ET7Kh5DBrygBxyt3ERA536Dxr6a5Ntuua0aLdx85tt9QCE51sBrwdb3Gj0LUURpcDsK8+v
 az+rXbaDmoIspi8YJ2lLNANCQtevZCcta8II+ihnj4KTunwX57kcxCxA9mP6LZKn3OrnAl
 MutM7X4G4l01cL8vN4H5TEyMfEGxzJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-pmhV804iNriFEvheEf9ieA-1; Mon, 01 Jun 2020 11:55:42 -0400
X-MC-Unique: pmhV804iNriFEvheEf9ieA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA4D8EC1BF;
 Mon,  1 Jun 2020 15:55:40 +0000 (UTC)
Received: from localhost (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F4291009940;
 Mon,  1 Jun 2020 15:55:06 +0000 (UTC)
Date: Mon, 1 Jun 2020 16:55:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC 1/3] WIP virtiofsd: import Linux <fuse.h> header file
Message-ID: <20200601155505.GA581007@stefanha-x1.localdomain>
References: <20191025100152.6638-1-stefanha@redhat.com>
 <20191025100152.6638-2-stefanha@redhat.com>
 <20191026174745-mutt-send-email-mst@kernel.org>
 <20191027123623.GO4472@stefanha-x1.localdomain>
 <87zh9n6pwj.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87zh9n6pwj.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 11:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 11:28:44AM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Sat, Oct 26, 2019 at 05:49:11PM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Oct 25, 2019 at 12:01:50PM +0200, Stefan Hajnoczi wrote:
> >> > tests/vhost-user-fs-test.c needs fuse.h.  The private copy that
> >> > virtiofsd has can be replaced with a properly imported file using
> >> > update-linux-headers.sh.
> >> >=20
> >> > TODO rerun update-linux-headers.sh with upstream kernel tree!
> >> >=20
> >> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>=20
> >> OK I would just add this with the virtiofsd patchset.
> >
> > Yes, I'll talk to David.
>=20
> Catching up after the fact I see this didn't get merged. Was there a
> reason?

This patch series is stalled because I have been busy with other tasks.

The standard-headers fuse.h header will be needed when something outside
virtiofsd uses FUSE definitions for virtio-fs. At the moment nothing
does so there is no need to merge this patch yet.

Stefan

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7VJNgACgkQnKSrs4Gr
c8jDWAf9GfRw0GKIvlbbLhOpjwgs9gY4vpGKmEfTmuiXoJcDzDEchSpA7PNH6sKc
PKY462eeO8VqxfTf23k75SaGdnbzljN1fHnb4kFi6hZKmaQPggrTGTmrYtP2zqnT
xwfhbZ1A9Q2DGZRLXt54i22UZhmpFY03scirsXmU2pj3e4ZFD+h5nMdITljZv8UP
SKIvStf8HpOFBWTwY2D/ifBxOWCwvD7dFSfMhs4V7/LpIb0svFhM+57o7O2Q/a7J
6QKTuEsAhRNFxc90L8BBa4d9n0OUFF+Wb72AbU5mewAh8ckofSM+9dUL4W/sp/y4
MRdZHst4/7bJfIdgH+G3n5xvjy/mRg==
=CWEx
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


