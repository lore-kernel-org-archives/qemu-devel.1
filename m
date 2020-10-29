Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD429C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310342087D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XM/5E0ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310342087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBkN-0006GE-34
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYBhy-00041I-Hv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:27:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:48413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYBhw-0004og-0f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=vfExwQWkVvf7b00Esg1fBPUp/dzd5F5iL3/qoDpjhwE=; b=XM/5E0ZE9kzSb/m8Y/GaD+Nt6A
 MysrwFVmpVMm+XrMbWEkA6jCvOWJJZXuwtmxbcx3UocE3ag6W9+hvM5lwpsoiv9p7C9wmf4QrdHiw
 TGUntyuTQWkOlHBoUBswtk/RZ60tbUko0xKaQ0GDlQ/gOVshclXe0q3EFsLkzvfJvsxir3wwM78D8
 78KDyKqefE51OmKhD7CX9CXfk+Ys2b8+Y0DnpJDcY+87/GG4RXbL/Jfg4ecDDHVQJmZtWIhQAUHN0
 +b41h9rNhw4s6M7Kmp5sBpKuR5AKYoZU9DkREA9T6KiF3BA4bRIq6QYQ47FSU4E1Bj86ru+TSoSg5
 V/9UYQcg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
Date: Thu, 29 Oct 2020 18:27:21 +0100
Message-ID: <2309245.eTJEYpyWRi@silver>
In-Reply-To: <20201029150403.GF27369@redhat.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <CAFEAcA9KYtb7tFp5tnPGMiYg0gpurao7GbcU_ND934tvFiU-aw@mail.gmail.com>
 <20201029150403.GF27369@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 13:27:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 29. Oktober 2020 16:04:03 CET Daniel P. Berrang=E9 wrote:
> On Thu, Oct 29, 2020 at 02:52:16PM +0000, Peter Maydell wrote:
> > On Thu, 29 Oct 2020 at 14:31, Christian Schoenebeck
> >=20
> > <qemu_oss@crudebyte.com> wrote:
> > > On Donnerstag, 29. Oktober 2020 15:15:19 CET Peter Maydell wrote:
> > > > On Thu, 29 Oct 2020 at 14:06, Christian Schoenebeck
> > > >=20
> > > > <qemu_oss@crudebyte.com> wrote:
> > > > > Ok, I'll use mkdtemp() instead, that avoids other potential paral=
lel
> > > > > config
> > > > > colissions that I may not have considered yet.
> > > > >=20
> > > > > The original motivation against mkdtemp() was that /tmp is isuall=
y a
> > > > > ramfs,
> > > > > hence very limited regarding large file tests. But that's not an
> > > > > issue
> > > > > right now.
> > > >=20
> > > > How large is "large" here ?
> > >=20
> > > E.g. ~10 GiB which might be a problem for cloud based CI platforms.
> >=20
> > Yeah, 10GB is too big by an order of magnitude for anything in the
> > standard "make check" set. It could go in an optional "I'm the 9p
> > maintainer and I want to run a wider set of tests" target though.
>=20
> I think as a rough rule of thumb, tests should not create files
> that are larger than the size of the QEMU build dir, and if it is
> creating non-trivially sized files, then they should be created in
> the build dir, not /tmp.  This probably puts 1 GB as a upper bound
> on size but bear in mind tests can run in parallel, so ideally biggest
> file sizes should be more in the 100s of MB range
>=20
> Regards,
> Daniel

I definitely won't run such large-file tests uncaged, so it would not run by
default for sure. But sooner or later it would make sense to streamline test
case options in QEMU in general, so that certain tests would automatically =
run
or not depending on runner's capabilities, limits and preferences.

The TCG tests for instance periodically trigger test failures as they exceed
Travis-CI's runtime limit of 40mins once in a while.

Back to the actual 9p test failure issue, I think I will go for something l=
ike
this:

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index d43647b3b7..ebbacd5896 100644
=2D-- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -35,7 +35,12 @@ static char *concat_path(const char* a, const char* b)
 static void init_local_test_path(void)
 {
     char *pwd =3D g_get_current_dir();
=2D    local_test_path =3D concat_path(pwd, "qtest-9p-local");
+    char *template =3D concat_path(pwd, "qtest-9p-local-XXXXXX");
+    local_test_path =3D mkdtemp(template);
+    if (!local_test_path) {
+        g_test_message("mkdtemp('%s') failed: %s", template, strerror(errn=
o));
+    }
+    g_assert(local_test_path);
     g_free(pwd);
 }
=20
@@ -246,11 +251,6 @@ static void virtio_9p_register_nodes(void)
     const char *str_simple =3D "fsdev=3Dfsdev0,mount_tag=3D" MOUNT_TAG;
     const char *str_addr =3D "fsdev=3Dfsdev0,addr=3D04.0,mount_tag=3D" MOU=
NT_TAG;
=20
=2D    /* make sure test dir for the 'local' tests exists and is clean */
=2D    init_local_test_path();
=2D    remove_local_test_dir();
=2D    create_local_test_dir();
=2D
     QPCIAddress addr =3D {
         .devfn =3D QPCI_DEVFN(4, 0),
     };
@@ -278,3 +278,14 @@ static void virtio_9p_register_nodes(void)
 }
=20
 libqos_init(virtio_9p_register_nodes);
+
+static void __attribute__((constructor)) construct_virtio_9p(void) {
+    /* make sure test dir for the 'local' tests exists */
+    init_local_test_path();
+    create_local_test_dir();
+}
+
+static void __attribute__((destructor)) destruct_virtio_9p(void) {
+    /* remove previously created test dir when test suite completed */
+    remove_local_test_dir();
+}

So it would still use the current directory instead of /tmp/ and would
create and remove the test dir on process start/end. I wanted to avoid
using constructor/destructor atttributes, as some compilers don't
support them, but it seems it's already used in the code base and there
are currently no setup/teardown callbacks in libqos.

Another downside: with 'make check -jN' this will temporarily create a
bunch of unused, empty dirs. But I hope that's Ok to fix in QEMU 6
(by adding setup/teardown callbacks to libqos later).

Just hoping there are no glib versions that use threads instead of
processes.

Best regards,
Christian Schoenebeck



