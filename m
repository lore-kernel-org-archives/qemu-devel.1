Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3ACC3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FF223429
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FF223429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3m1Z-0005O4-D8
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i3lzv-0003yd-BO
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i3lzt-0002v1-Hu
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:51:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i3lzt-0002uZ-Ca
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F3E43086208;
 Fri, 30 Aug 2019 18:51:44 +0000 (UTC)
Received: from localhost (ovpn-116-109.gru2.redhat.com [10.97.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D82BA600F8;
 Fri, 30 Aug 2019 18:51:41 +0000 (UTC)
Date: Fri, 30 Aug 2019 15:51:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190830185139.GG3694@habkost.net>
References: <20190830184033.7630-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190830184033.7630-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 30 Aug 2019 18:51:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/acceptance: Do not install paramiko
 module by default
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 30, 2019 at 08:40:33PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The paramiko Python module has many dependencies. Some of them
> are not pure Python, such cryptography module which requires to
> be built and linked with OpenSSL.
>=20
> When native libraries and header are missing on the host, the
> error reported is not very helpful:
>=20
>   $ make check-venv
>   VENV    tests/venv
>   PIP     tests/requirements.txt
>   Command "tests/venv/bin/python -u -c "import setuptools, tokenize;__f=
ile__=3D'/tmp/pip-build-la4el5r5/cryptography/setup.py';f=3Dgetattr(token=
ize, 'open', open)(__file__);code=3Df.read().replace('\r\n', '\n');f.clos=
e();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-1efs=
22iz-record/install-record.txt --single-version-externally-managed --comp=
ile --install-headers tests/venv/include/site/python3.6/cryptography" fai=
led with error code 1 in /tmp/pip-build-la4el5r5/cryptography/
>=20
> Since currently the tests depending on paramiko are targetting
> very specific uses, we can avoid the strong dependency on the
> paramiko module, to let systems where it does not build properly
> work the rest of the tests.
> If paramiko is manually installed, the tests using it will be
> automatically run.
>=20
> Fixes: c47c336e870
> Reported-by: David Gibson <david@gibson.dropbear.id.au>
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks!  Queued on python-next.

--=20
Eduardo

