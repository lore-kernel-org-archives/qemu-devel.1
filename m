Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3546C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B920740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNCBudVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B920740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZHE5-0004Pn-Oq
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iZHCz-0002yB-Vw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iZHCy-0006KP-HD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:27:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iZHCx-0006Jz-Jj
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574699247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w33UwICHWSMRge5bI5OvItWaUWj+OilrjCHx9WzcfJw=;
 b=aNCBudVtMXQCMbNBJk13V5S73pxD2cf+cDo5I37hC2URGxV5Q9G8k8bq0swJtM5EEySpFY
 YkOJyqhDN+/AOJWkYVtu4lU0FXiQVMlE6je7IO3d/GGY/VtEcB2FRu22kVCuk3fjlXRQMp
 Ni3xLiK6+VloU5fWq9Dxn/UumjWFDfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-JVk_J23OPIaiItp6jt4M4A-1; Mon, 25 Nov 2019 11:27:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E1D61005509
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-170.rdu2.redhat.com
 [10.10.120.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 750B05D6A0;
 Mon, 25 Nov 2019 16:27:15 +0000 (UTC)
Date: Mon, 25 Nov 2019 11:27:14 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Avocado notes from KVM forum 2019
Message-ID: <20191125162714.GA8589@localhost.localdomain>
References: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: JVk_J23OPIaiItp6jt4M4A-1
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
Cc: avocado-devel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
>

Just to be extra clear, Avocado itself doesn't require online access, but:

 * "make check-venv" will download packages from PyPI if the same
   Avocado version is not previously installed in the system

 * "make check-acceptance" depends on "make check-venv"

 * many tests depend on downlodable assets

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
>

Understood and agreed.  I've already adopted this approach in the
"boot_linux.py" series I'm working (about to send v8).  If the
download/preparation of images fail, we cancel the tests.  I'll look
into making that the default across all tests or in the base
avocado_qemu.Test class.

We could also have a "make check-acceptance-prepare" kind of target,
that won't run the tests, but will download all needed assets.

>=20
> 2) Add artifacts manually to the cache
>=20
> Not all artifacts can be easily downloadable, some are public but require
> the user to accept an End User License Agreement.
> Users would like to share their tests with the documentation about where/=
how
> to download the requisite files (accepting the EULA) to run the tests.
>=20
>

OK, RFE taken.

> 2b) Add reference to artifact to the cache
>=20
> Group of users might share group of files (like NFS storage) and would li=
ke
> to use directly their remote read-only files, instead of copying it to th=
eir
> home directory.
>=20
>

The underlying "asset fetcher" utility code supports multiple locations
and multiple cache dirs (and one could be a read-only NFS-like storage):

  https://avocado-framework.readthedocs.io/en/73.0/api/utils/avocado.utils.=
html#avocado.utils.asset.Asset

But we need to make that easily accessible/configurable to users
of the fetch_asset() Test method.  RFE taken.

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
>

Agreed, and I already have a prototype.  I'll send the RFC/patches to
the list ASAP.

>=20
> 4) Warn the user when Avocado is too old for the tests
>=20
> Some users tried Avocado following the examples on the mailing list and t=
he
> one in some commit's descriptions where we simply show "avocado run ...".
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
>

OK, agreed.  RFE taken.

>=20
> That it for my notes.
>=20
> Eduardo/Wainer, are there other topics I forgot?
>=20
>=20
> Regards,
>=20
> Phil.
>=20

Thanks *so much* for this feedback!  I'll provide individual feedback as
each of those items progresses.

- Cleber.


