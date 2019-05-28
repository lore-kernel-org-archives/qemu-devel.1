Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02649C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C2F20679
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C2F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36177 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVdM6-0006j8-2A
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 10:45:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVdLJ-0006IF-O5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVdLH-0003jP-OP
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:44:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hVdL6-00021L-DS
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:44:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D202CA3B48;
	Tue, 28 May 2019 14:42:11 +0000 (UTC)
Received: from work-vm (ovpn-117-218.ams2.redhat.com [10.36.117.218])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03A727DF58;
	Tue, 28 May 2019 14:42:06 +0000 (UTC)
Date: Tue, 28 May 2019 15:42:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190528144204.GF2724@work-vm>
References: <20190528135144.24028-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190528135144.24028-1-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 28 May 2019 14:42:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/migration: Disable
 /migration/postcopy/unix qtest on Travis-CI
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> This started to fail 6 months ago [1] and lately occurs too
> often on the main Travis CI.
>=20
> Travis CI set the CONTINUOUS_INTEGRATION variable in the process
> environment [2]. Let's use it to disable it when running this test
> there.
>=20
> [1] https://travis-ci.org/philmd/qemu/jobs/466594203#L4430
> [2] https://docs.travis-ci.com/user/environment-variables/#default-envi=
ronment-variables

I think the right solution here is to disable it under TCG.

Dave

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/migration-test.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index bd3f5c3125..c5091e1fb1 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -764,6 +764,11 @@ static void test_postcopy(void)
>  {
>      QTestState *from, *to;
> =20
> +    if (getenv("CONTINUOUS_INTEGRATION")) {
> +        /* Test failing on Travis-CI */
> +        g_test_skip("Running on Travis-CI");
> +    }
> +
>      if (migrate_postcopy_prepare(&from, &to, false)) {
>          return;
>      }
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

