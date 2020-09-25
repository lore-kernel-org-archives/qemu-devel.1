Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEAC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF4E238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4nocJz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF4E238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbGZ-0003KW-3P
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbFu-0002uO-MX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbFt-0006Da-1v
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:06:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600992388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUJoZk9wDWQn1R1XCFoLIZ/SJXfxXJN8KOU8dieWoUs=;
 b=E4nocJz0IAIg9iw1dneGT8XvXUqv7XI6ro6ZoNUZYh41Ms/U+RGpoToxGMaiXwK7b7CEGf
 5+OAT4v+6eowMJQnKdghQ+wKMO5KhkAsDAcnR+xVCzRqlcflQSlwuh7uoUpg2J8oT9Rv8R
 aMVBudHddr9bkobEFSwFPyfSkWHqQTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-heiHvdwHOqaZJUtUPV7kPA-1; Thu, 24 Sep 2020 20:06:25 -0400
X-MC-Unique: heiHvdwHOqaZJUtUPV7kPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50CD802EA3;
 Fri, 25 Sep 2020 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 405F91002C0E;
 Fri, 25 Sep 2020 00:06:24 +0000 (UTC)
Date: Thu, 24 Sep 2020 20:06:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 03/16] qapi/expr.py: constrain incoming expression types
Message-ID: <20200925000622.GF347918@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-4-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-4-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:00PM -0400, John Snow wrote:
> mypy does not know the types of values stored in Dicts that masquerade
> as objects. Help the type checker out by constraining the type.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tNH4ACgkQZX6NM6Xy
CfOyhhAA0nQOiFObGRhyausIg5u6Zp416A9j1tywf5TEjLESM6ZPMghDQB1k/cKu
RaYrPK3VWfo0lbuG/foSHbotXjCtNJEYrjxmOijuwGeqqTF5QLRAL0d7vcjREkP5
ZRpFY5rVqyQ0jeEVZeHAdSrEIbN33I3NDkeqaGlALmoY95nWGO45WMDo2VRr/kHs
dPG68kGbzqAsx9kl9MXC1qrk+9oUsEkWLVKMnOztrl76CLlLzQuOFjbuZFB29G9q
hill+smn/aI0/UZrtC+jTO2BX3cjlmE1rxKVh+hossjLy+/irGxu9OwV7n9nQzdS
AUVzTDevplKAij3J4h6hO6VecrBkqzn6eatYSZAX0tuJmXA6nIrT1AtBHnjzNGD+
HsBQRKYu72jqpvKfQZ42UXCJSyaKQ8Pu6nBVrSgylGx3I7PxKnzS3Bdf/Oz3zh8t
hKPUgYbLmR2vnjwQKHWPXDBF7RgaLvBxcInO//qsTwI6aBGShyttgrx+cqwQp4XF
o5kU6RpWKMTdpkt4E/yBW05+1u0PcOor96J6mY0eNvTxLxYTCtYdZ4ATGNatKaV/
ZFL8hrZMIZqQSNHH8/18ZYHG9zhGhXA4KDncFGGIaQEUsiqyY2q4jwVfQS8CZ/ow
GUCxSeLUHirL58F1Cq9/qqQbzF1fZmoHXjCni6ScpIeZhGhUiR8=
=jo9Y
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--


