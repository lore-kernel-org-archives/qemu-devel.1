Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6644DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AFC20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5rEUd2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AFC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Lt-0005oO-GM
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k02GP-0008R8-4i
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:29:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k02GM-00070c-75
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595852988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4uavNF+nYeIfbchy/Gnexd3ES9/AHoWblRFnJoTCPA=;
 b=I5rEUd2IuGbq0iHYpw6zDhq5hfCT6v9De41rUb+sf4++1rquQ43P3dF0HaV7fvyjQpRXTA
 8xHuwssKHR/1ZNmMsz/rrOGL5gmmRvRV15uAxzg77kghpm2iyRcmL/rC9++vq0IivsNzgb
 /cWqxt7QZJICKybUYwjfkwTpAP/rMXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-aOR3GZT8Mj2cGLnXAL6lWw-1; Mon, 27 Jul 2020 08:29:46 -0400
X-MC-Unique: aOR3GZT8Mj2cGLnXAL6lWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A2F080BCAD;
 Mon, 27 Jul 2020 12:29:44 +0000 (UTC)
Received: from localhost (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24E215DA6A;
 Mon, 27 Jul 2020 12:29:40 +0000 (UTC)
Date: Mon, 27 Jul 2020 13:29:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [virtio-comment] [RFC] ivshmem v2: Shared memory device
 specification
Message-ID: <20200727122939.GB386429@stefanha-x1.localdomain>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <20200715132748.GA20677@stefanha-x1.localdomain>
 <88a33034-783a-07d2-85e0-c1a1ecd2721f@siemens.com>
 <20200723065423.GE268427@stefanha-x1.localdomain>
 <10df6427-eab0-d3b8-4624-ede98ff7ef09@siemens.com>
MIME-Version: 1.0
In-Reply-To: <10df6427-eab0-d3b8-4624-ede98ff7ef09@siemens.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 09:02:09AM +0200, Jan Kiszka wrote:
> On 23.07.20 08:54, Stefan Hajnoczi wrote:
> > On Fri, Jul 17, 2020 at 06:15:58PM +0200, Jan Kiszka wrote:
> > > On 15.07.20 15:27, Stefan Hajnoczi wrote:
> > > > On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
> >=20
> > Thanks for the responses. It would be great to update the spec with
> > these clarifications.
> >=20
> > > > > If BAR 2 is not present, the shared memory region is not relocata=
ble
> > > > > by the user. In that case, the hypervisor has to implement the Ba=
se
> > > > > Address register in the vendor-specific capability.
> > > >=20
> > > > What does relocatable mean in this context?
> > >=20
> > > That the guest can decide (via BAR) where the resource should show up=
 in the
> > > physical guest address space. We do not want to support this in setup=
s like
> > > for static partitioning hypervisors, and then we use that side-channe=
l
> > > read-only configuration.
> >=20
> > I see. I'm not sure what is vendor-specific about non-relocatable share=
d
> > memory. I guess it could be added to the spec too?
>=20
> That "vendor-specific" comes from the PCI spec which - to my understandin=
g -
> provides us no other means to introduce registers to the config space tha=
t
> are outside of the PCI spec. I could introduce a name for the ivshmem ven=
dor
> cap and use that name here - would that be better?

Sounds good.

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8eyLMACgkQnKSrs4Gr
c8iz3gf+PR7V8VCympAWs+Z7xHZgGlFUy375IgC6F5z+6fundn/iK0s7G4F+x5yO
H3NmnoiUpdobJ52yzuTaft5DEsdL8GZ3AoDeCNp0TzU+89PFsXzDeozT9v3FGagz
GLnwzyCpWZ8qfbEJSUeKk549gfdqunLm6liqo3h6yiBlAs6dYAnh9RppXFxVdmLw
ydiDM+1kLBmsU5SCM8x1Uq2DNyPPySQukuCqUMQe8ssbI3L52y5+k/xverd44fUR
rGYc2n3Z6pZ+prPkRRkUKycP0H9csQyTIcIs7PKGMhPKOMqoXCe174y4dro4GrAb
+HGBBvp2fW5ztZHRP20XjqrWhotyow==
=AR2l
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--


