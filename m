Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E70FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CA120709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Klo1QfLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CA120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyV8c-0004st-0P
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 02:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyV7l-0004Sw-HS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:54:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyV7h-0003KC-KH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595487272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E0jBLOg3PXf+PwoMlF70oXxdvZJUwqGx3A88F2ekrnU=;
 b=Klo1QfLrUEexkt12SdwhZTQWxEQ0KmyLtCzeilnmeD8SYr1/3W4UOms3+93tAl6aT6mgLv
 0TZtLXSQk7ImeRLPjsr2kOGnXTocor/s2EtNBR86DrRfxwa+fKQwFbTHuQjYOK+ev5ZebM
 OzVX7Rg1lXgf3BJOSCzuelluJjvYCCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-8PSZ-f0CP2WLVsQwmpLXXg-1; Thu, 23 Jul 2020 02:54:29 -0400
X-MC-Unique: 8PSZ-f0CP2WLVsQwmpLXXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B54380046A;
 Thu, 23 Jul 2020 06:54:28 +0000 (UTC)
Received: from localhost (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2FF471D12;
 Thu, 23 Jul 2020 06:54:24 +0000 (UTC)
Date: Thu, 23 Jul 2020 07:54:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [virtio-comment] [RFC] ivshmem v2: Shared memory device
 specification
Message-ID: <20200723065423.GE268427@stefanha-x1.localdomain>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <20200715132748.GA20677@stefanha-x1.localdomain>
 <88a33034-783a-07d2-85e0-c1a1ecd2721f@siemens.com>
MIME-Version: 1.0
In-Reply-To: <88a33034-783a-07d2-85e0-c1a1ecd2721f@siemens.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 06:15:58PM +0200, Jan Kiszka wrote:
> On 15.07.20 15:27, Stefan Hajnoczi wrote:
> > On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:

Thanks for the responses. It would be great to update the spec with
these clarifications.

> > > If BAR 2 is not present, the shared memory region is not relocatable
> > > by the user. In that case, the hypervisor has to implement the Base
> > > Address register in the vendor-specific capability.
> >=20
> > What does relocatable mean in this context?
>=20
> That the guest can decide (via BAR) where the resource should show up in =
the
> physical guest address space. We do not want to support this in setups li=
ke
> for static partitioning hypervisors, and then we use that side-channel
> read-only configuration.

I see. I'm not sure what is vendor-specific about non-relocatable shared
memory. I guess it could be added to the spec too?

In any case, since "relocatable" hasn't been fully defined, I suggest
making the statement more general:

  If BAR 2 is not present the hypervisor has to implement the Base
  Address Register in the vendor-specific capability. This can be used
  for vendor-specific shared memory functionality.

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZNB8ACgkQnKSrs4Gr
c8hi6QgArR1ztVQRUCI/zFwqALXQy51hWMFUA+NSJfdRpFEYsMrCeF2dvpqW73++
PNSI2bqn1BrDwR8gnA8djoRSTk30D0pCH52U4lXR5CcmErlg/z8eLwNpezNzO2gS
dwIoQUlRHnezozBBbu308MLp9bx7UB9y0Ds0K4n33N7Ntm3rCRDjjIas7nYv9jNs
X67im89ptEIaYQ3dNIOp58RrOl16zjSsWod1nV3BFmBWQFmoiFx+4eVwCf3N9AoE
2Bh3WkTfj4sL53oFdfOlrNVfLrOzbSO+UJRyJK9n01mH+FlJxbJeE81kMgvwyBU+
gTBcaaNYoG9eIM2ea55aX/rOsFc2gg==
=T30T
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--


