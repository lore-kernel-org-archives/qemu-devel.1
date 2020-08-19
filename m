Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6411EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1A120639
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY+lNzob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1A120639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8KBz-000563-EB
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8KBA-0004Rp-ST
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:14:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8KB5-0007yG-BI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597828477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U5bOs1141EjFuE/ZqcnOL6cxinT+6F7yNxHGbmoomSw=;
 b=fY+lNzobys98q6GxaYV9MlkTZTm1eNKmiQh1KDTZA4LKF9MOKUtPJvmiAmK03ENyXiZwSq
 n1xHJum/brH4O9YPeX17NUgxTkX+sl2damVcVfPG517gwUBgsWgLEXdrdAIlQIiQuI+AhZ
 AFUInSscLPmgRcuPd2uAXWefoovCuaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-h7JyDg4ROWen_GCiUQv05w-1; Wed, 19 Aug 2020 05:14:22 -0400
X-MC-Unique: h7JyDg4ROWen_GCiUQv05w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72B6981F025;
 Wed, 19 Aug 2020 09:14:21 +0000 (UTC)
Received: from localhost (ovpn-114-159.ams2.redhat.com [10.36.114.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 239002635D;
 Wed, 19 Aug 2020 09:14:17 +0000 (UTC)
Date: Wed, 19 Aug 2020 10:14:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2] memory: Add trace events to audit
 MemoryRegionOps fields
Message-ID: <20200819091417.GA357031@stefanha-x1.localdomain>
References: <20200806152613.18523-1-philmd@redhat.com>
 <d87db8e9-40b1-334d-22b0-90674ddf8177@redhat.com>
 <161c9d87-677b-6806-b080-4aebfd5275c4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <161c9d87-677b-6806-b080-4aebfd5275c4@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2020 at 09:56:37AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 8/18/20 8:32 AM, Paolo Bonzini wrote:
> > On 06/08/20 17:26, Philippe Mathieu-Daud=E9 wrote:
> >> Add trace events to audit MemoryRegionOps field such:
> >>  - are all the valid/impl fields provided?
> >>  - is the region a power of two?
> >>
> >> These cases are accepted, but it is interesting to list them.
> >>
> >> Example:
> >>
> >>   $ qemu-system-i386 -S -trace memory_region_io_check\*
> >>   memory_region_io_check_odd_size mr name:'dma-page' size:0x3
>=20
> (a)
>=20
> >>   memory_region_io_check_access_size_incomplete mr name:'acpi-tmr' min=
/max:[valid:1/4 impl:4/0]
> >>   memory_region_io_check_access_size_incomplete mr name:'acpi-evt' min=
/max:[valid:1/2 impl:2/0]
> >>   memory_region_io_check_access_size_incomplete mr name:'acpi-cnt' min=
/max:[valid:1/2 impl:2/0]
>=20
> (b)
>=20
> >=20
> > Can they be detected using Coccinelle instead?
>=20
> For static declarations, probably.

Regarding the MemoryRegionOps checks, the following grep command-line
shows that all MemoryRegionOps definitions are global:

  $ git grep 'MemoryRegionOps [^*]' hw/

This means static checking is possible.

>=20
> (a) is not really fixable (because some datasheets don't
> count the reserved space in the device address map [1]),
> but is interesting to audit.
>=20
> I believe (b) has to be updated per maintainers preference,
> not by an individual developer. IIUC Michael said [2] while
> there is no bus information in MemoryRegionOps (and way to
> report a bus specific error), it is pointless to blindly fill
> the zero access sizes.
>=20
> Meanwhile I prefer to share my debugging helpers as trace
> events instead of ./configure --enable-maintainer and #ifdef'ry.

Can they be turned into a CI check instead of debugging helpers? For
example, all existing violations are exempt but new MemoryRegionOps must
comply. This way it's not necessary to audit and fix everything right
now but code quality is improved in new code.

Static checking is nice because there is no need to execute QEMU and
trigger all the code paths that lead to MemoryRegionOps usage.

Here are more static checker ideas:

1. Rename memory_region_init_io() to memory_region_init_io_unsafe() (or
   "legacy", "nocheck", etc) and then add a checkpatch.pl error if a new
   memory_region_init_io_unsafe() call is added.

2. Walk the debuginfo looking for MemoryRegionOps structs and check
   them. For example, a Python script that uses a DWARF parser. There
   can be list of exempted source files that are allowed to violate the
   rules (existing code).

3. Use __attribute__((__section__())) on MemoryRegionOps so they can
   easily be located in ELF files and check them. For example, a C
   program that opens the ELF and finds the "memoryregions" section.

Stefan

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl887WkACgkQnKSrs4Gr
c8j4KQf/VT79X5BM3zsjMo8leLBt5Kuim6zGGO4QWuJOJK7JllVIPiz3g2Fps1xm
q1nfMixPvT6cIdTU/xCffkuFFULihs3DPyeA1bFqYie5WE6zTALiqywYlxZFXdRa
YbNvAQqLsnoQ1fhC34/gEJUYY9jFdZdrA1T4fu5QO3H0muvp7py6iAvq0vluyZpC
vCKxR+oA25vk9DkHTGrijJa9HoiPUhOl9rpzf+Omb/rF18Qd1ZjUsnnIy8u/beBF
fiBHmmYyiEZyKUYXw19v57iK9Ue5wK/PBVovGfgV3dBEYvH8AAlRkjrtU6jbOoda
ezenIZNnq56LYGwsrSESBFtKdpC2hA==
=iAmw
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--


