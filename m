Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCE5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1AD2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3ypcRCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1AD2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBK2-0004xT-AG
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 06:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZBIo-0003tu-9R
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:41:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZBIl-0004UN-PA
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589452877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yyFhILTqNfLhJllHfzm6x/MBmO7/BIsAKVopUr5QcEc=;
 b=b3ypcRCC/sfNupOLbyqmATAnR8mnawRmiigcvKj8mJqWJ40NzLvYHZ8iY29rS/fazeBI0L
 UcxJuKhWaInvw4GFvV7DvxzNkexMIac1GG2+YrUtavtSRzas7bOUVgRyU1kFEz0mJe2Pau
 HF2Z2vJ+flYY7Kiem4En1vnnis+kPYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-jO6a9zd0P1u6ckovCSZSDw-1; Thu, 14 May 2020 06:41:15 -0400
X-MC-Unique: jO6a9zd0P1u6ckovCSZSDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D00461;
 Thu, 14 May 2020 10:41:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCDAA1000320;
 Thu, 14 May 2020 10:41:06 +0000 (UTC)
Date: Thu, 14 May 2020 12:41:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200514104105.GC5518@linux.fritz.box>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200513211235.4d0711d1@luklap>
MIME-Version: 1.0
In-Reply-To: <20200513211235.4d0711d1@luklap>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.05.2020 um 21:12 hat Lukas Straub geschrieben:
> Terminology:
> instance =3D one (nbd) blockdev/one chardev/the single migrationstate
> connection =3D one TCP connection
>=20
> Hello Everyone,
> Having read all the comments, here is proposal v2:

Looks quite good to me.

> Every instance registers itself with a unique name in the form
> "blockdev:<node-name>", "chardev:<chardev-name>" and "migration" using
> yank_register_instance which will do some sanity checks like checking
> if the same name exists already. Then (multiple) yank functions can be
> registered as needed with that single name. When the instance exits/is
> removed, it unregisters all yank functions and unregisters it's name
> with yank_unregister_instance which will check if all yank functions
> where unregistered.

Feels like nitpicking, but you say that functions are registered with a
name that you have previously registered. If you mean literally passing
a string, could this lead to callers forgetting to register it first?

Maybe yank_register_instance() should return something like a
YankInstance object that must be passed to yank_register_function().
Then you would probably also have a list of all functions registered for
a single instance so that yank_unregister_instance() could automatically
remove all of them instead of requiring the instance to do so.

> Every instance that supports the yank feature will register itself and
> the yank functions unconditionally (No extra 'yank' option per
> instance).
> The 'query-yank' oob qmp command lists the names of all registered
> instances.
> The 'yank' oob qmp command takes a list of names and for every name
> calls all yank functions registered with that name. Before doing
> anything, it will check that all names exist.
>=20
> If the instance has multiple connections (say, migration with
> multifd), i don't think it makes much sense to just shutdown one
> connection. Calling 'yank' on a instance will always shutdown all
> connections of that instance.

I think it depends. If shutting down one connection basically kills the
functionality of the whole instance, there is no reason not to kill all
connections. But if the instance could continue working on the second
connection, maybe it shouldn't be killed.

Anyway, we can extend things as needed later. I already mentioned
elsewhere in this thread that block node-names have a restricted set of
allowed character, so having a suffix to distinguish multiple yankable
things is possible. I just checked chardev and it also restricts the
allowed set of characters, so the same applies. 'migration' is only a
fixed string, so it's trivially extensible.

So we know a path forward if we ever need to yank individual
connections, which is good enough for me.

> Yank functions are generic and in no way limited to connections. Say,
> if migration is started to an 'exec:' address, migration could
> register a yank function to kill that external command on yank (Won't
> be implemented yet though).

Yes, this makes sense as a potential future use case.

Kevin

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl69IEEACgkQfwmycsiP
L9Y0Xw/+JoK/scMwhlZ99A26X5iAm6R1UTwayN5qHLRlEkcLY0iCpQ1TmHtptbeV
63PoSYiRB/G8nrRoVHwX66ButG/Pi2la7JZFK1Lvs7GQDZO89z7tVk+XUpgyiEaM
cYAV4BYHT9fF7wqQys8ekliTsPSJspfz6Dh6y+yKeCtQl4rDOxpmuNcUgQgVKLHm
UD2n6B7ZosdOWcaIaPn5SlfxT4tadqja8mPKOw2l/g9N3v4X3x47+XPvdhBxzhV5
MYFWGYb2HOWbNEz4ZS+JbZ9lIOojnvmrRYUw0+L7/vBoMSmzwd2uMHJwS4c3MMUF
DyMhz9sT83M2NLGgQHzAXgLedKc6R7uozXniv+kVQoOAYh3lnsMJzHIAvvcS7tQC
puIJtvzfnQ/5QZUA1hPKRrNhQemDErbR41bJQHIgtOAejx4RfwrZ21Mx66Tnudi2
HFRmoPvETyuxS4llcpMXAQqDlpTJBbrLN9aFWA2dozVtKy8dkwxS3+dEHqdgCtfS
yU+U6I1wVItTZ4w609GKrbAtI921NmtLd191ZiEH9UI5ya35XQELYyqowOJUFAl8
Vn6ioLchGrr05LXa1VXsKgggbuZ84HNvch59dJa7sozwf80faXeJJ0fdr4VJgIDP
2hOszhhGYHo/8IjH/g36neoMFHKf570o3q2uKbuBUshiBjCDiq0=
=kE26
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


