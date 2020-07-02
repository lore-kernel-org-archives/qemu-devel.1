Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A14C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E508E207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMtzJAn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E508E207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzb5-00042D-7t
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzYo-00014O-GI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:47:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50927
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzYk-0006sH-Ae
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593697645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugvqK52qRnUNs/yjRCHEjm939/62vbCp6J9mZX2iw+Q=;
 b=aMtzJAn/pZnueBh4/e/zR6mK0Nm4+UDwyYRHhuTgru1j0bTTmyl6ifs8H5i0DnocwXhPe0
 P9X7Fn+Sen0eY0oJy8lwxXBuEwR+vSt3d8uQk6hRLr+tVSw7BThO37qbe0OmqNlJVNtKgM
 sKD8yAAlJ9dEM4pNNKUqfrOUvIuwT9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-egTBhUNcOQqpeEa_IKevKQ-1; Thu, 02 Jul 2020 09:47:20 -0400
X-MC-Unique: egTBhUNcOQqpeEa_IKevKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A1C8805EF3;
 Thu,  2 Jul 2020 13:47:19 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32A664D9E6;
 Thu,  2 Jul 2020 13:47:14 +0000 (UTC)
Date: Thu, 2 Jul 2020 14:47:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
Message-ID: <20200702134713.GH152912@stefanha-x1.localdomain>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
 <20200630124136.GM1370404@redhat.com>
 <20200701160906.GT126613@stefanha-x1.localdomain>
 <20200701161501.GJ1427561@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200701161501.GJ1427561@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 05:15:01PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 01, 2020 at 05:09:06PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jun 30, 2020 at 01:41:36PM +0100, Daniel P. Berrang=E9 wrote:
> > > On Fri, Jun 26, 2020 at 06:27:06PM +0200, Christophe de Dinechin wrot=
e:
> > > IMHO the whole point of having the pluggable trace backend impls, is
> > > precisely that we don't have to add multiple different calls in the
> > > code. A single trace_qemu_mutex_unlock() is supposed to work with
> > > any backend.
> >=20
> > I think an exception is okay when the other trace backends do not offer
> > equivalent functionality.
> >=20
> > Who knows if anyone other than Christophe will use this functionality,
> > but it doesn't cost much to allow it.
>=20
> This patch is just an example though, suggesting this kind of usage is
> expected to done in other current trace probe locations. The trace wrappe=
r
> has most of the information required already including a format string,
> so I'd think it could be wired up to the generator so we don't add extra
> record() statements through the codebase. At most it should require an
> extra annotation in the trace-events file to take the extra parameter
> for grouping, and other trace backends can ignore that.

It's true, it may be possible to put this functionality in the
trace-events.

Christophe: how does this differ from regular trace events and what
extra information is needed?

Stefan

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl795WEACgkQnKSrs4Gr
c8iO9AgApsmKi2hdfbpgYC0M6vBsykCBoLTmUmSdncck8EdXbHxXZvkkILLIEcHt
9LVNfH8nyhIMOan31cQ2yek9A5WN4prXbFvi43bxrgx2ret4mZeHGVu2UlHTetEP
oFzbQHmCj0RqiZWI6iC2Gw53c+gN3cUtcECn6yYDeVUPUpI5k6ozdY6Zd2XWPcYC
1iZPLDjtht67Lw4ZhMIE3QdBBr88NpA99EGij57wX3A2NNFb2FHUXy7wTtXPZZzx
25qqgIAHpZYDJlcTtT6PsTPRGiJNpqUnrHFt+snTJcic90O2KHLg2uG9iSdpiSel
ANcAM95O9t3uk6sQ/yi+9AcNbpdvJg==
=Fu+Z
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--


