Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122EAC2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D370F205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyiSIakt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D370F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icxu6-00089b-US
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 15:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1icxsX-0007RA-Cn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1icxsW-0000aT-75
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:37:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1icxsV-0000WN-Rv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575578253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+Ms4oK14lCx0cWv082pH+l+ab5cD3lN4rSYuDQ+s0A=;
 b=DyiSIakttBueYDZfdlq4Bt2ulyBrBXB5tHc58F04ZvY21rpbgWbLqM8g9UdgkNcTcoa824
 u0xHV8G8ZkodBp+wt5iQHTnB2ARxaB6Gdf86hMP0DDIHA97C8Wrh6cEI8WfnuyfLZrLy+0
 AtRDsy3EeZ9pkYvV6usQqQRSdDvpq3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-aPUj9rIWPI-ZrbcKRHci7A-1; Thu, 05 Dec 2019 15:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A561318557C0;
 Thu,  5 Dec 2019 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-37.rdu2.redhat.com
 [10.10.125.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E5555D6A3;
 Thu,  5 Dec 2019 20:37:21 +0000 (UTC)
Date: Thu, 5 Dec 2019 15:37:19 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 5/7] tests/test-util-filemonitor: Skip test on non-x86
 Travis containers
Message-ID: <20191205203719.GE29262@localhost.localdomain>
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-6-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-6-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: aPUj9rIWPI-ZrbcKRHci7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 04:46:16PM +0100, Thomas Huth wrote:
> test-util-filemonitor fails in restricted non-x86 Travis containers
> since they apparently blacklisted some required system calls there.
> Let's simply skip the test if we detect such an environment.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/test-util-filemonitor.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.=
c
> index 301cd2db61..45009c69f4 100644
> --- a/tests/test-util-filemonitor.c
> +++ b/tests/test-util-filemonitor.c
> @@ -406,10 +406,21 @@ test_file_monitor_events(void)
>      char *pathdst =3D NULL;
>      QFileMonitorTestData data;
>      GHashTable *ids =3D g_hash_table_new(g_int64_hash, g_int64_equal);
> +    char *travis_arch;
> =20
>      qemu_mutex_init(&data.lock);
>      data.records =3D NULL;
> =20
> +    /*
> +     * This test does not work on Travis LXD containers since some
> +     * syscalls are blocked in that environment.
> +     */
> +    travis_arch =3D getenv("TRAVIS_ARCH");
> +    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
> +        g_test_skip("Test does not work on non-x86 Travis containers.");
> +        return;
> +    }
> +
>      /*
>       * The file monitor needs the main loop running in
>       * order to receive events from inotify. We must
> --=20
> 2.18.1
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>


