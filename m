Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F06FC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E20208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fICObV2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E20208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kND6e-0006vQ-TZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kND5I-0005os-32
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kND5G-00085V-As
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:42:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601376127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQfO+k45ztxhBiKJHNWsb6qOC+W1Z1rhGuPT/tXZ6Qg=;
 b=fICObV2hJsF8S7waxsHT0dmD6RAyku2nq/mz2QcboYgvvZOaJZqiKvSS5xcqDEgIq5ig/g
 aE8L2sgixcKEOcdS1SdS4kHwz00TfczhXa5ZyPuZJbdcD07KkvRyTjNQrlhYvcIXeKOpkN
 ZW1bbyRJAuijU7+ImvDhIQkrYZyRjs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-5loiDFbTMSKtp1zmQK64wQ-1; Tue, 29 Sep 2020 06:42:03 -0400
X-MC-Unique: 5loiDFbTMSKtp1zmQK64wQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C661801F9B;
 Tue, 29 Sep 2020 10:42:01 +0000 (UTC)
Received: from localhost (ovpn-112-247.ams2.redhat.com [10.36.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD79810013C0;
 Tue, 29 Sep 2020 10:41:54 +0000 (UTC)
Date: Tue, 29 Sep 2020 11:41:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Message-ID: <20200929104154.GC181609@stefanha-x1.localdomain>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: benjamin.walker@intel.com, elena.ufimtseva@oracle.com,
 tomassetti.andrea@gmail.com, John G Johnson <john.g.johnson@oracle.com>,
 jag.raman@oracle.com, james.r.harris@intel.com, swapnil.ingle@nutanix.com,
 konrad.wilk@oracle.com, yuvalkashtan@gmail.com, qemu-devel@nongnu.org,
 raphael.norwitz@nutanix.com, ismael@linux.com, alex.williamson@redhat.com,
 Kanth.Ghatraju@oracle.com, felipe@nutanix.com, xiuchun.lu@intel.com,
 marcandre.lureau@redhat.com, tina.zhang@intel.com, changpeng.liu@intel.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:29:17AM -0700, Thanos Makatos wrote:
> This patch introduces the vfio-user protocol specification (formerly
> known as VFIO-over-socket), which is designed to allow devices to be
> emulated outside QEMU, in a separate process. vfio-user reuses the
> existing VFIO defines, structs and concepts.
>=20
> It has been earlier discussed as an RFC in:
> "RFC: use VFIO over a UNIX domain socket to implement device offloading"
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>

I reviewed the recently-added kernel VFIO_IOMMU_DIRTY_PAGES ioctl and
VFIO_REGION_TYPE_MIGRATION features. They enable live migration and
device state save/load.

Including them early would be good because it's difficult to retrofit
live migration into existing code later.

Stefan

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9zD3EACgkQnKSrs4Gr
c8gvCggAkCv1be+K0JEg+YdCyJxExpNwP/bAdCb1KWGLbv14ZsNyTccxZsitorbl
nvOSdUvlPo32/lwif1CUlOnaVvhFBLvkpRS6/ZkUkwjxg2tC6AfNt/bXYhbl2Le2
JVyU3tVS5KXBeSC4EC++ostE3wrDsLaD9RH5Su/Rt8aZxgH1dAwxGfaeB6aTybXZ
HC9jTUDIpRmaZ8MR/tYRosUSMnwpEeekCODyB5L8S4ZoBih9qTkesAbO9OsrznT/
noKbQZjC+ILxsfd4ESt9i/l6TcwjZxVclhufLEx+3gT+oyknDAfYEGUvDdxTdBoW
Xrqkj83JqWRuOtJ37Gm/gP0qKCFhPQ==
=Ux3r
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--


