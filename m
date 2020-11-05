Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D07CC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FBB206FB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esFmml6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FBB206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kade1-0001fW-Cz
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaddL-00017T-Rw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaddJ-0004Ds-DP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604576447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4AtYW7TPmsC7S4rait9mV57GDUU+FIyWwhrLxATm3jw=;
 b=esFmml6pp0M23l2vh5UAtq5ZuZKVmlV1guEjqHGiHIaBygN1QnCcIt3EvWn0THVQ7urXZ2
 nlEhTH2n9xF16zOoOT4FX3q7AQzV7yvHIbLoR4MlX7JV71sJj5uMvw+gxhY7oFDX37GAp9
 IuMfkDcWS5EdvxPP0xagQBNLJeNqh+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-_Ku6eqWdOT-mwHI_qGGRSg-1; Thu, 05 Nov 2020 06:40:44 -0500
X-MC-Unique: _Ku6eqWdOT-mwHI_qGGRSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B1D25F9EA;
 Thu,  5 Nov 2020 11:40:42 +0000 (UTC)
Received: from localhost (ovpn-114-186.ams2.redhat.com [10.36.114.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5C707367B;
 Thu,  5 Nov 2020 11:40:38 +0000 (UTC)
Date: Thu, 5 Nov 2020 11:40:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201105114037.GC462479@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103121709.GD3566@work-vm>
 <20201103152752.GC253848@stefanha-x1.localdomain>
 <20201103184951.GM3566@work-vm>
 <20201104073636.GB390503@stefanha-x1.localdomain>
 <20201104101423.GB3896@work-vm>
 <20201104164744.GC425016@stefanha-x1.localdomain>
 <20201104173202.GG3896@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201104173202.GG3896@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 05:32:02PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > Michael replied in another sub-thread wondering if versions are really
> > necessary since tools do the migration checks. Let's try dropping
> > versions to simplify things. We can bring them back if needed later.
>=20
> What does a user facing tool do?  If I say I want one of these NICs
> and I'm on the latest QEMU machine type, who sets all these parameters?

The machine type is orthogonal since QEMU doesn't know about every
possible VFIO device. The device is like a PCI adapter that is added to
a physical machine aftermarket, it's not part of the base machine's
specs.

The migration tool queries the parameters from the source device.
VFIO/mdev will provide sysfs attrs. For vfio-user I'm not sure whether
to print the parameters during device instantiation, require a
VFIO-compatible FUSE directory, or to use a query-migration-params RPC
command.

Let's discuss this more when the next revision of the document is sent
out, because it modifies the approach so that migration parameters are
logically separate from device configuration parameters. That changes
things a bit.

Stefan

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+j5LUACgkQnKSrs4Gr
c8hHTggAjE2oMLFVAmoNr11D54ao1A2QybD+psxdSNS5uQcu6MSRJIjLC59QkX9E
8T1vZzxZay1W+mQPzrdBwItkYIA2YQkrtpjum/fDD0uqCbgCXfvM00kDXb2u235J
lor+Eh+nBLc8yEwT6yREIu9rJ5KOJ+kFCdzJfuBHLBzQlph+g1nWrTcNnXkuwfCp
8gSBtdfePI+Q3GxZDsFjXIuG3b9TrKV9Y0lsLIRG6u+hl0y1oh3MkFYiGPyWD8UN
BclNh/D2vKF4CkDUPEUoRbQjV0yuvfzTEwczBmW6dkL15ERvguR6utzwsnCPva7d
qU/xGbWAcxiv8MbErY42RwzwqSisXw==
=O6RZ
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--


