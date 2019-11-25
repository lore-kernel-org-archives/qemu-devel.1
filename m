Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C44C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CAB20679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB2BRq9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CAB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEta-0005xu-57
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iZEsf-0005Y1-Qv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iZEse-0004kh-By
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:58:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iZEse-0004ja-7e
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574690299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGtsg6TAv6M+rGCA7c1MwmrGuqh2MCpcas82NtW4ZOI=;
 b=PB2BRq9YbZXvNmDkpWNKwaR3ekAObjmkXYdzWNxDZY9HJWflDyhLczwZsHc58pZgm6WXTj
 5ecNSjCWcpypDWSiUF1G7V76Yhvtrx6m36LCJwnSO5OkELim8rn5iScfN6bmiTu4CSNPnq
 WxV64FX9R30Ngiwx71yxKt/GEC57210=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-PcsVnwfjPDebp2utfS_dXw-1; Mon, 25 Nov 2019 08:58:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 085311934E68
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 13:58:17 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E13F5D9D6;
 Mon, 25 Nov 2019 13:58:04 +0000 (UTC)
Date: Mon, 25 Nov 2019 10:58:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Avocado notes from KVM forum 2019
Message-ID: <20191125135802.GH4438@habkost.net>
References: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: PcsVnwfjPDebp2utfS_dXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: avocado-devel@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you, Philippe, those are great ideas.  I have copied them
to the Avocado+QEMU Trello board so we don't forget about them:
https://trello.com/b/6Qi1pxVn/avocado-qemu

Additional comments below:

On Mon, Nov 25, 2019 at 01:35:13PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Cleber,
>=20
> Here are my notes from talking about Avocado with various people during t=
he
> KVM forum in Lyon last month.
>=20
> All comments are QEMU oriented.
>=20
>=20
> 1) Working offline
>=20
> Various people complained Avocado requires online access, and they would
> like to use it offline.
>=20
>   Maintainer workflow example is:
>=20
>   - run avocado
>   - hack QEMU, build
>   - git pull
>   - build
>   - hack QEMU
>   (go offline)
>   - hack QEMU
>   - build
>   - run avocado <- FAILS
>=20

Ouch.  This shouldn't happen even with no explicit --offline
option.  Failure to download artifacts shouldn't make tests
report failure.


> Failure is because mainstream added new tests, which got pulled in, and t=
he
> user only notice when running avocado again, but offline.
> Test example is boot_linux_console.py, which added various tests from oth=
er
> subsystems, so the maintainer has to disable the new tests manually to be
> able to run his previous tests.
>=20
> Expected solution: skip tests when artifact is not available, eventually
> when the --offline option is used
>=20
>=20
> 2) Add artifacts manually to the cache
>=20
> Not all artifacts can be easily downloadable, some are public but require
> the user to accept an End User License Agreement.
> Users would like to share their tests with the documentation about where/=
how
> to download the requisite files (accepting the EULA) to run the tests.
>=20
>=20
> 2b) Add reference to artifact to the cache
>=20
> Group of users might share group of files (like NFS storage) and would li=
ke
> to use directly their remote read-only files, instead of copying it to th=
eir
> home directory.

This sounds nice and useful, but I don't know how to make the
interface for this usable.


>=20
>=20
> 3) Provide qemu/avocado-qemu Python packages
>=20
> The mainstream project uses Avocado to test QEMU. Others projects use QEM=
U
> to test their code, and would like to automatize that using Avocado. They
> usually not rebuild QEMU but use a stable binary from distributions. The
> python classes are not available, so they have to clone QEMU to use Avoca=
do
> (I guess they only need 5 python files).
> When running on Continuous Integration, this is overkill, because when yo=
u
> clone QEMU you also clone various other submodules.

I only have one concern, here: I don't think we have the
bandwidth to start maintaining a stable external Python API.
Users of those packages will need to be aware that future
versions of the modules might have incompatible APIs.

>=20
>=20
> 4) Warn the user when Avocado is too old for the tests
>=20
> Some users tried Avocado following the examples on the mailing list and t=
he
> one in some commit's descriptions where we simply show "avocado run ...".

Oops.

> They installed the distribution Avocado package and tried and it fails fo=
r
> few of them with no obvious reason (the .log file is hard to read when yo=
u
> are not custom to). IIUC their distribution provides a older Avocado (69?=
)
> while we use recent features (72).
>=20
> We never noticed it because we use 'make check-venv' and do not test the
> distrib Avocado. While we can not test all distribs, we could add a versi=
on
> test if the Avocado version is too old, display a friendly message to the
> console (not the logfile).

Sounds like a good idea.

>=20
>=20
> That it for my notes.
>=20
> Eduardo/Wainer, are there other topics I forgot?

I don't remember anything specific right now.  Thanks again!

--=20
Eduardo


