Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ACAC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236272076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2KIJVBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236272076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTDD-0001lQ-Lq
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYTBE-0000mn-5I
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYTB5-0003i9-Qt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604059603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCy0R4WBzBwMlHPUHr9Zz+5Uhtrk4oJxTBMJenFrdaE=;
 b=D2KIJVBZjY3dKULoF3nXrFEUkCLMvxuUV9Jw58+/wXU0qX6GOZI94Ui7N+kqupltCTrKCY
 0LVHeja6jCgsD0RQyMjSd+Kv4bfwwRZ3vAWwi+w/+ApPgwNldpRnxDjMIdJinSNrtTQUXx
 lYShkowCaKcxpdtVXeK7R2G0ZYl/7Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Sy5gUsywP36n0sjQVtDfrA-1; Fri, 30 Oct 2020 08:06:38 -0400
X-MC-Unique: Sy5gUsywP36n0sjQVtDfrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58D9C188C135;
 Fri, 30 Oct 2020 12:06:37 +0000 (UTC)
Received: from localhost (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8E4860BFA;
 Fri, 30 Oct 2020 12:06:36 +0000 (UTC)
Date: Fri, 30 Oct 2020 12:06:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: ENQCMD
Message-ID: <20201030120635.GA320132@stefanha-x1.localdomain>
References: <20201030075046.GA307361@stefanha-x1.localdomain>
 <MWHPR11MB164567FA998B13128EB284D48C150@MWHPR11MB1645.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB164567FA998B13128EB284D48C150@MWHPR11MB1645.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Wu, Hao" <hao.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 08:04:54AM +0000, Tian, Kevin wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Friday, October 30, 2020 3:51 PM
> >=20
> > Hi,
> > The "Scalable Work Submission in Device Virtualization" talk at KVM
> > Forum 2020 was interesting and I have some beginner questions about
> > ENQCMD:
> > https://static.sched.com/hosted_files/kvmforum2020/22/Scalable_Work_Su
> > bmission_In_Device_Virtualization.pdf
> >=20
> > Security
> > --------
> > If the ENQCMD instruction is allowed for userspace applications, how ca=
n
> > they be prevented from writing to the MMIO address directly (without th=
e
> > ENQCMD instruction) and faking the 64-byte enqueue register data format=
?
> > For example, they could set the PRIV bit or an arbitrary PASID.
>=20
> ENQCMD payload is transmitted through DMWr transactions (slide 10), which
> cannot be triggered through other memory instructions. The device portal
> only handles DMWr transactions.

Thanks, that explains it! I was wondering the a regular write
transaction could fool the device :).

Stefan

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+cAcsACgkQnKSrs4Gr
c8gjUQf8Cz3bnmtojBjngXBB9jhNbNZcFMUrJd0zUQdPmGboSR1VG/hikQHxNA+s
gKIB8CHRB1G70P/V4xwowc6efSzB60utJwJLOwoMLnawSrYpCYcoYNKEcyzCxH/M
NmTSjFgPgyx/bCvXw7oIeZT9q+rqRWXyRV7xJIXyH/WVwj96pEwFXSlAwVBAMPIT
UNICGLq49/HiQ0v1nX/+VAGJVr6NErO/AF5/cIcI39q1sU7tVRA2xTb3wP5SZR+b
Yr9nKQLjcUjmI1hWRqjS4eFS7BwWkM3BVcoyEwLQPEKa763R6j3OCUPlMLFoikBJ
abWmPnKEE6dDcBftgM05J6ZMyKoz5w==
=In8c
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--


