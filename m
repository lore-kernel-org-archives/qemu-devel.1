Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0270C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 23:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D98423899
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 23:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nlg05IIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D98423899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLaLS-0007RF-Oj
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 19:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLaKG-00070p-QI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 19:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLaKE-0007St-0s
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 19:06:56 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600988812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxrZIt56Ub6l91HiGmJPsRorkFrX8QLCrXnxNqPokFU=;
 b=Nlg05IIcpD7V67bWe6aD69a2d5tQVhrDL/T/WScXx6EPlpUoz+q1SsUlh2vNZ2MDtKiL60
 Gb+iSx4KAY+p3Rqjua9+NpQGdI17xQtIiot1ReOmDxUc9e9qGw2dmz/D99kaPf+gYsLBN4
 2vOK+vjwfZigMwTuC2yttDrwbRLUbJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-_l1u8bNKNYaM14i4DO-Iiw-1; Thu, 24 Sep 2020 19:06:49 -0400
X-MC-Unique: _l1u8bNKNYaM14i4DO-Iiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF9111868432;
 Thu, 24 Sep 2020 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C63F73662;
 Thu, 24 Sep 2020 23:06:48 +0000 (UTC)
Date: Thu, 24 Sep 2020 19:06:46 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 01/16] qapi/expr.py: Remove 'info' argument from nested
 check_if_str
Message-ID: <20200924230646.GB347918@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:12:58PM -0400, John Snow wrote:
> The function can just use the argument from the scope above. Otherwise,
> we get shadowed argument errors because the parameter name clashes with
> the name of a variable already in-scope.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tJoMACgkQZX6NM6Xy
CfOUXQ/8DBmkLcAFBv3pBw2Ld5Sh/M/kO972Um+AvAguzSmM+sBXtC2/frTOdKDR
P2ghE1fyj3QwMmZ06agUtpiDkRNJT3geL82+p6fQqFo1y/x4jAP3LiL1ELijQ1FF
t+gd/GkAY1vzauUC95B2sth28ssIFUCeHNlH8qv2dAM4NqU3r1WjLxdEfR9J2w5e
SKnIk7r7Rlh11k/Vs5xG75yrPG1H+cc2k4w556NhqNlV8+Yk6nuvBDxJJMrWbE2c
BweoRK17+LnneDPXQpzSMBsvjFFgEht+2NMb6x1a3rlZ8kUaJIdBGQLpmWrBeK7v
Ll7sdAPGiAF30WSbjE+yMDfUAWSeqh1U6AoPusb2QpHSk9B9dD1hKn536j5+aUDy
Gv5GfVavMM3wZNkQ/EoPZhD8vROx5rFypPGtnnErhTzTdf4OD5ntVIQw5ga08O3G
FmaurBAqDsnaR8bMoFf1U59jiQXeBUjdR3j6r9fxc+d2d9Dx6yseLGNLpld+aJqC
Ip7dA4XyfItvCI2WsrIxXKnpF8JjZPy1nmjW4rQtGMOtSzc/bqJrgLY+RBxMyOzV
7Z2X68VrS77GEHLM00rSMQvRh2VE5rgn0vMhQKeNLgRR7tmQLdspps2BVMII/9iO
m+N6E5RyQyMiPXof5Jp5/1nOP3bbBjx32W5FwyWF1wFwE3AdtsM=
=tdsl
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--


