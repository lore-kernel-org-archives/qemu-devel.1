Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E328C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1E32082E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1E32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj12r-0003Ip-Rx
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hj124-0002fP-W5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hj123-0000uT-Uw
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:40:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hj123-0000sg-PD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:40:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0C2085A03
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 12:39:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64B5F16D22;
 Thu,  4 Jul 2019 12:39:52 +0000 (UTC)
Date: Thu, 4 Jul 2019 14:39:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190704143948.54466ed3@redhat.com>
In-Reply-To: <c553e0b6-95e2-af3c-47b8-7db84f77a532@redhat.com>
References: <20190704082736.25258-1-imammedo@redhat.com>
 <20190704082736.25258-3-imammedo@redhat.com>
 <c553e0b6-95e2-af3c-47b8-7db84f77a532@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 04 Jul 2019 12:39:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: acpi: do not skip tests when
 IASL is not installed
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jul 2019 11:33:19 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 7/4/19 10:27 AM, Igor Mammedov wrote:
> > tests do binary comparition so we can check tables without
> > IASL. Move IASL condition right before decompilation step
> > and skip it if IASL is not installed.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/bios-tables-test.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 13bd166b81..a356ac3489 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -389,6 +389,14 @@ static void test_acpi_asl(test_data *data)
> >          all_tables_match =3D all_tables_match &&
> >              test_acpi_find_diff_allowed(exp_sdt);
> > =20
> > +        /*
> > +         * don't try to decompile if IASL isn't present, in this case =
user
> > +         * will just 'get binary file mismatch' warnings and test fail=
ure
> > +         */
> > +        if (!iasl) {
> > +            continue;
> > +        }
> > +
> >          err =3D load_asl(data->tables, sdt);
> >          asl =3D normalize_asl(sdt->asl);
> > =20
> > @@ -431,6 +439,11 @@ static void test_acpi_asl(test_data *data)
> >          g_string_free(asl, true);
> >          g_string_free(exp_asl, true);
> >      }
> > +    if (!iasl && !all_tables_match) {
> > +        fprintf(stderr, "to see ASL diff between mismatched files inst=
all IASL,"
> > +                " rebuild QEMU from scratch and re-run tests with V=3D=
1"
> > +                " environment variable set"); =20
>=20
> I guess remember Thomas asked to use g_printerr() instead of fprintf()
whole file uses fprintf().
I'd rather send extra patch on top that consistently changes
test to g_printerr()

> in tests/*.c.
>=20
> Anyway,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Thanks!

>=20
> > +    }
> >      g_assert(all_tables_match);
> > =20
> >      free_test_data(&exp_data);
> > @@ -599,7 +612,7 @@ static void test_acpi_one(const char *params, test_=
data *data)
> > =20
> >      if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
> >          dump_aml_files(data, true);
> > -    } else if (iasl) {
> > +    } else {
> >          test_acpi_asl(data);
> >      }
> > =20
> >  =20
>=20


