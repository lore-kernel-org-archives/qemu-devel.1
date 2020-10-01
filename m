Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8C0C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E8720754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfAFAPdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E8720754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyWP-0002sp-UK
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNySb-000052-Sd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNySa-0007Fb-6x
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601558240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wOPvwC0zqJYvp8tKVb7VlJlDv/CNQYCLqGXZ8rjD8/M=;
 b=EfAFAPduHGW3hAeTgLv09LBqWqNHMy8I5ykORQN8bNfOZ/GIwU/hvopzN6CKOaqyU7yNPC
 tZO3AD69rjc87pcElA0LAukrLwnStwciUwJoC38uij8a5j7eaTwuxgNS1UvYcCpIUmeOjC
 FSyI0Hr+MkXTJE3BZNV9VTuh2lzVNcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-UYfTC2ecMQ-ofFefwgxrGg-1; Thu, 01 Oct 2020 09:17:18 -0400
X-MC-Unique: UYfTC2ecMQ-ofFefwgxrGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCE11074642;
 Thu,  1 Oct 2020 13:17:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-92.ams2.redhat.com [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 903A279980;
 Thu,  1 Oct 2020 13:17:15 +0000 (UTC)
Date: Thu, 1 Oct 2020 15:17:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: Use of "?" for help has been deprecated for 8 years, can we drop
 it?
Message-ID: <20201001131714.GC6673@linux.fritz.box>
References: <87k0wa1bf8.fsf@dusky.pond.sub.org>
 <54b77382-78c8-e6bf-45d4-616595baa87f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <54b77382-78c8-e6bf-45d4-616595baa87f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.10.2020 um 15:06 hat Eric Blake geschrieben:
> On 10/1/20 5:35 AM, Markus Armbruster wrote:
> > We deprecated "?" more than eight years ago.  We didn't have a
> > deprecation process back then, but we did purge "?" from the
> > documentation and from help texts.  Can we finally drop it?
> >=20
> > I'm asking because there is a patch on the list that bypasses
> > is_help_option() to not add deprecated "?" to a new place: "[PATCH v2
> > 1/4] keyval: Parse help options".
> >=20
>=20
> Did we ever issue a warning when it was used?  It's easier to argue that
> it can be dropped if users had notice of some form or another.  That
> said, I'm not heartbroken if we yank it immediately instead of letting
> it live for 2 more releases.

A deprecation warning for a help option would somehow feel strange.

I would consider this a human-only interface that can be changed at
will, like HMP syntax.

Kevin

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl911toACgkQfwmycsiP
L9ZwrxAAuaXmqnVLUXvxSepjfMCgbXh1Sl8JQzsfwF9Nar9otFlJzWBXlS80ojpl
TlEKxewarKmSGOao0DK5i+CP4LZnOBRAHMTM3Nz/KVcLj4aFWeb1U6+V567NfEC+
dI0BFFoKfOMAs8R1t71M/mYO+CVgQBn2xrUbymIGyrTRWBJiWPERYVT4WQezfQcu
tEd4ex7kP7HwnbgznqmgUX215AO1zl1Zd1fRQBLDOpgDWdHkw22ZcssUTJ0FVFv8
S7Z2czutbZRMUX7g+JkfYDd4FC0c+NgrGCI08vpK44Kay4GPdAamiDGRA3v8Lnj8
8FHWQUNMDwhIW2Ye27PujfR1nGlFdAM4BayfH5GrVehKFzq1cLDd0ufdp91UTMqZ
t3w/uzGWVLzf5h5hCnKd+psrftH7lqaIKv7MCD70bsjLmd++pr7S6VSwOFthld/e
ZyYazad2Wol8wwc/R0evXMbuQLzSCZepYeJO5463FsEImffu9HZ/eUxwmcxqCd+t
vFPgw1uAWUMnWrIJj0BvyJs69EF9C1SnnuzRWlvCwcY946aNnM2ypg3QHjtpNjKL
180CMxMZIVPUH0alF27y4hVAQusJQE2yGu1HHAabTxD9Z8Q2KgHTBjRpRFSInA7s
Hk6019Vn7SYc3qlPRYFgikHMbYDf4UMq/y/iXQSnJAqwQcFI0tk=
=TVk6
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--


