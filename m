Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA3C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA3D23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvAv8ztK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA3D23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUG6-00062M-B0
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLTuU-00039d-9n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLTuQ-0005tm-8K
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600964148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Do8uA0sevsJAHsT4aXHQnTzq5FT+FriRFTq+cYRFu9o=;
 b=QvAv8ztKsiE0LR8p8gHFRQ30pCdWHlzlHmCGqcKk7Z+uSVI4Id8rQgLp79sT3RYa1HKqKo
 +G3w4WEhv+6Rx4u6XepJulQ4P/MH4HjPOivcpQ2cwl650q3fO61WzBgmack8DbpZDonI65
 ZZYgUXvfjsMyKMOH3//gxRkbOQtZgg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-CbM_HpeWNB-St8APFS7MHQ-1; Thu, 24 Sep 2020 12:15:41 -0400
X-MC-Unique: CbM_HpeWNB-St8APFS7MHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A0C0800475;
 Thu, 24 Sep 2020 16:15:40 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BDFC55786;
 Thu, 24 Sep 2020 16:15:39 +0000 (UTC)
Date: Thu, 24 Sep 2020 17:15:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>
Subject: Re: Problems with building using meson and fuzzing
Message-ID: <20200924161539.GA929935@stefanha-x1.localdomain>
References: <3d188586-5301-30ba-1a19-db34a273cbb0@redhat.com>
 <615f663c-f935-1401-5042-4436da257a96@redhat.com>
MIME-Version: 1.0
In-Reply-To: <615f663c-f935-1401-5042-4436da257a96@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 10:36:20AM -0400, Jon Maloy wrote:
> Alex, Stefan & al
> I am trying to build and run Marc-Andr=E9s Lureaus libslirp code with fuz=
zing
> activated, but I am running into build issues.
> https://gitlab.freedesktop.org/elmarco/libslirp/-/commit/9fba8af484ec6bc1=
0b22e3f49d9e34d95c28b086

Discussion happening here:
https://github.com/mesonbuild/meson/issues/7761

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sxisACgkQnKSrs4Gr
c8gweQf8DarVEqeGBbQZy7J7Pfi9ml92n2Zk+J2suzEPNq5vDBtVjFi9tYYWmO6y
GDaqBJEdFShgf4ickI8VrLq532zqz0FwdUTWF+XhMtMbmLkOhhJXJ8/tCDR9kGRk
0hojpyh9n9zuCV5LMd6Zs1oIpJLcoAW/k/zupusLFxiyXY5ghjgRlhz0Xabbf6CY
IXd1ddVMNYuVf2ipJSiXAqq680x43V10jwXblqX/wqUemActAyIs0aozofNQiawV
ulkXLepbjR1heZBlexDs+sJ43XQYmXoor+luYp5DxvuW9K/9NKNAI3Vb0TW1WLGE
48gtsHByXx56X4u5RJ6du9R8XKgQhA==
=SZQ9
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


