Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F5C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215F12051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlLyOu4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215F12051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIoI-0000lK-4e
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEInL-0008HX-Sl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEInK-0005pB-ML
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:26:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEInK-0005iA-Im
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584476791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/i9WXgisJ1g+RA1rppOjUNagbGqFwC92ciPUCh5EP/w=;
 b=VlLyOu4BWDYrVPeR8pLIHZnQWzz0yYPdRpLtQ9Mvn7chaQDB1zIWyYH0RstqoOIFzh/JOz
 avn/nuo+eeBM6An0G5O3z9swJGxosqJyHRfAb8Hwe2Btyylkc6Hnp8GSskKAVxbjmOW1ZO
 tg36E/UQzL9Ire8mukaU0UtJTqHzwUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-p9TtGonCPd6MYEG9QgCR3A-1; Tue, 17 Mar 2020 16:26:29 -0400
X-MC-Unique: p9TtGonCPd6MYEG9QgCR3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A351007269;
 Tue, 17 Mar 2020 20:26:28 +0000 (UTC)
Received: from work-vm (ovpn-114-234.ams2.redhat.com [10.36.114.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A375C1BB;
 Tue, 17 Mar 2020 20:26:22 +0000 (UTC)
Date: Tue, 17 Mar 2020 20:26:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/4] tests/migration: Disable autoconverge test on
 Travis-CI s390x
Message-ID: <20200317202620.GJ3369@work-vm>
References: <20200317200541.6246-1-philmd@redhat.com>
 <20200317200541.6246-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200317200541.6246-4-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> This test fails on Travis-CI s390x when configured with --disable-tcg:
>=20
>   $ make check-qtest
>     TEST    check-qtest-s390x: tests/qtest/boot-serial-test
>   qemu-system-s390x: -accel tcg: invalid accelerator tcg
>   qemu-system-s390x: falling back to KVM
>     TEST    check-qtest-s390x: tests/qtest/pxe-test
>     TEST    check-qtest-s390x: tests/qtest/test-netfilter
>     TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
>     TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
>     TEST    check-qtest-s390x: tests/qtest/drive_del-test
>     TEST    check-qtest-s390x: tests/qtest/device-plug-test
>     TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
>     TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
>     TEST    check-qtest-s390x: tests/qtest/migration-test
>   **
>   ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'go=
t_stop' should be FALSE
>   ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_=
auto_converge: 'got_stop' should be FALSE
>   make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1

Before we take the hammer to it, could you try reducing it's initial
bandwidth, the code that says:

    /*
     * Set the initial parameters so that the migration could not converge
     * without throttling.
     */
    migrate_set_parameter_int(from, "downtime-limit", 1);
    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/=
s */

knock a couple of 0's off that and see if it's happy.

Dave

> Per David Gilbert, it might be a threshold requiring tuning:
> "it could just be the writing is slow on s390 and the migration
> thread fast; in which case the autocomplete wouldn't be needed.
> Perhaps we just need to reduce the bandwidth limit."
>=20
> Disable the autoconverge test for now.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/qtest/migration-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 3d6cc83b88..878399666e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1181,6 +1181,16 @@ static void test_migrate_auto_converge(void)
>      MigrateStart *args =3D migrate_start_new();
>      QTestState *from, *to;
>      int64_t remaining, percentage;
> +    char *travis_arch;
> +
> +    /*
> +     * This test does not work reliably on Travis s390x.
> +     */
> +    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
> +    if (travis_arch && g_str_equal(travis_arch, "s390x")) {
> +        g_test_skip("Test does not work reliably on s390x Travis contain=
ers.");
> +        return;
> +    }
> =20
>      /*
>       * We want the test to be stable and as fast as possible.
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


