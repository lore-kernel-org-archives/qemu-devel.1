Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC39C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1049B206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K32VlNYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1049B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLBGG-0000pF-39
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLBEW-0007am-9d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLBEU-0005a3-I1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600892357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6JoLnN6EWPNACW7Z0Z6vFayXQ62g4flX5l9JN5s2u8=;
 b=K32VlNYZCs+wVQP2QJH02iE0o1pFCf0uvUhbOhPjkb/RaOpEzixsNkX3YaBnr/trzPkqMI
 E/0OxSZOxbIdLM9KOzrwFT6Q5PCVSULYUVn3QIYszBZkXBxTUr/EvZPvgPDUzZ3amLT0ax
 mGjxzeZd0M4D+SnHBHtESBO5aydPLvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Yp7tDq3hO8ebg2YN6ifHMg-1; Wed, 23 Sep 2020 16:19:15 -0400
X-MC-Unique: Yp7tDq3hO8ebg2YN6ifHMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71ABD420F0;
 Wed, 23 Sep 2020 20:19:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AD031002C03;
 Wed, 23 Sep 2020 20:19:13 +0000 (UTC)
Date: Wed, 23 Sep 2020 16:19:11 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 18/38] qapi/events.py: Move comments into docstrings
Message-ID: <20200923201911.GR191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-19-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-19-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dFvuq/4WPi1dbS7Q"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--dFvuq/4WPi1dbS7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 05:00:41PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--dFvuq/4WPi1dbS7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rrb8ACgkQZX6NM6Xy
CfNqUg//V+0p4TMXXHH1xQLtPYkJBrdoprxfd+YZ1tNkpMovwyUiwqWCqOmtV0EH
rA2ck+imLcyaYxnai4rT1+iJxFPqfNsiqSpy75HlUtFxNjZcpDFcD4OtvSQBOZY/
Kv1ztT/rK2+26XEr7uOzCpnZ3l6j2spJ0te8f9WWV1By83Ty9bp+RwtGISshGgD9
fUGCdmi5dy+eCiH+MsAbXMV0Lr3KLs1xwnahCnnJkQL7g+1C15UsAY0+uFP/Voms
uIN/VjSeRssSBtx3XaKY/IbPjS4+l7vPx444CFcKCBnlqryF0lRIBTwXgZbfbQrv
UWqZ7J5dHnkG3U+2Odqgu/fK+l/0+P0ma1MENoDYyhkxRK1BeakMUoXr5R5C1cKp
SuuKPw/Md3LHqtmf60prFUDP9kXjvBF+cQ40lFOuwFqM/3weJPdaQcgTbABqzHGE
JBDIOcrlWgzpeViUwmf9ItWHwK4AhGlSGQl1qZMP9zvM0xJNBRzQfJQQOPi0Zm5b
aUoyrka1by40fo6DLzPmOSwKe3/tZm0E1yE+l2WuLp4fNqwIcVQu6naONFin8bpa
u1/5V85sHL13L8MY5YrwKhPCeIJFY+9n5/PnholLRKpLAXifVgZ3amFBX2hdAKjC
GH6u5najTJOI2I5qjZterrd5xzZ50mXJNB0jMGL+wHdTITx9wUQ=
=m/mf
-----END PGP SIGNATURE-----

--dFvuq/4WPi1dbS7Q--


