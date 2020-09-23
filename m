Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD1DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17B421BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUe7RVp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17B421BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4z4-0000do-06
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL4y5-0008C5-T8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL4y3-0005wE-E1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600868273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7y2T60Be2Tsk5+yTVziK7F3f+SrjThNJd+5DfkB0/SI=;
 b=IUe7RVp/qWBcM+ZyZhCtSk78SMm00UFuwm6C0y5Gze9ik+NmwMe2CjvGYfILdi2nyWSjHZ
 h1f9WXv+md6ljdIhmyFux6YfEf1CvM+PJLRq3RL7R4IrrKBwYtDBaByoTswFKjMrTI0N5V
 wusQhq0XJbap6/wswIRAmTEfNIqAQVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-xiXXR5WXNFud16pFGQ6wtA-1; Wed, 23 Sep 2020 09:37:49 -0400
X-MC-Unique: xiXXR5WXNFud16pFGQ6wtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B49B8ECE72;
 Wed, 23 Sep 2020 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C00C100238E;
 Wed, 23 Sep 2020 13:37:47 +0000 (UTC)
Date: Wed, 23 Sep 2020 09:37:45 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 06/38] qapi: delint using flake8
Message-ID: <20200923133745.GF191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-7-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-7-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
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

--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:29PM -0400, John Snow wrote:
> Petty style guide fixes and line length enforcement.  Not a big win, not
> a big loss, but flake8 passes 100% on the qapi module, which gives us an
> easy baseline to enforce hereafter.
>=20
> A note on the flake8 exception: flake8 will warn on *any* bare except,
> but pylint's is context-aware and will suppress the warning if you
> re-raise the exception.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rT58ACgkQZX6NM6Xy
CfOyFxAAtajiPmGffNppnw9wZXfwKXJpo4ZWCv1vdrWOoAvswkMQ/0t7vf4Oid9L
OwlvTsxfJNVnt+KE2jfqbwRCLcLKLFZkTMVRaoHy8PwocY5pyLNPGjpESlmXWrpN
+wbgMGB1aXU0oMdu6cNB1T4He8X1jTAsniv9gavbH66z2P/Pqy8KYZ/+bf5KUr5L
Egw3F/g+mCXCpCCBHUmc4OX66uK15IKJxDJqqRUB5EDOW0aAfz4u9lJetuIsBu+i
MU4Xc+L7NzQofWuJTj5AuIUqUWQ3AWxgkPa86Qxh4uDg6kswIa9QnG98osNbzTzx
K6EETDy9/PtBJ7U/9Ji0P5Kqs+qHOGnf8Q+rTuuvTMxU2GUaB3boFDFzy4CYRdJ3
U97MzEdnq1WCB9NLq0X2JbeTknDABETlj+eRxU5Q5FwwSDF38zS3b8DQfkumo5iB
M7DA7qwXmUBKX1qI8llrwRz4A+yYMmpe+6hDoEZXXxYwkDUfzCpqjhYbAe/oBt50
v4DDaO+uh7iJyHmQnUM7TEH1ilRDneuliPfO42zmr04M8YhrrIWu4CYpgnCsmaF+
zLwgAEis3PObVqFCkPnyfvdJ7clLHDhV/K2ludqDqfW6aUJ+JLievdhmcoQXgb7q
dhQNrvzpGBUcaHgF/s1YqctDLESyzCjiVCG7dS+7k6CxVwwtf84=
=X8Cy
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--


