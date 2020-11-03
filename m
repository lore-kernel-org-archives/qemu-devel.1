Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B15BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FF520735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7ngli6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FF520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyKy-0002LP-4c
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kZyDM-0000ft-QU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kZyDK-0007Lg-C9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604417233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XmsV8V02GIyiq1VAtbijdVC/xhzGUTu39HqmWDSgVoQ=;
 b=A7ngli6H6QJTIOtHXFnSbYiM33K1ulFNlH1Qxr3qpP4QVAyVw4i83h6RGfDtqwfqE5Xi+i
 3ZqZKKPaLbLwMr8M9w/oESnXnsH1hnL0J+wwhfYVYnua2EzmVLMDdvOnSs38yExQtl+tde
 MidjCRpjj6z4UexVyIv/knDYoM6P5fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-bXdzfTOpMw2v7y6Eqtl-Sw-1; Tue, 03 Nov 2020 10:27:11 -0500
X-MC-Unique: bXdzfTOpMw2v7y6Eqtl-Sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B679E1006CAB;
 Tue,  3 Nov 2020 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69F345B4BB;
 Tue,  3 Nov 2020 15:27:05 +0000 (UTC)
Date: Tue, 3 Nov 2020 10:27:03 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 5/7] tests.acceptance: adds simple migration test
Message-ID: <20201103152636.GA3140758@localhost.localdomain>
References: <20190222194146.13102-1-crosa@redhat.com>
 <20190222194146.13102-6-crosa@redhat.com>
 <CAP+75-UtiMFdp=ReaH0Vn7OD60hS+ZNsSvJyvVp1948Syn=ZGQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+75-UtiMFdp=ReaH0Vn7OD60hS+ZNsSvJyvVp1948Syn=ZGQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Wainer Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 11:40:30AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> On Fri, Feb 22, 2019 at 8:42 PM Cleber Rosa <crosa@redhat.com> wrote:
> >
> > From: Caio Carrara <ccarrara@redhat.com>
> >
> > This change adds the simplest possible migration test. Beyond the test
> > purpose itself it's also useful to exercise the multi virtual machines
> > capabilities from base avocado qemu test class.
> >
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Caio Carrara <ccarrara@redhat.com>
> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > Message-Id: <20190212193855.13223-3-ccarrara@redhat.com>
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/acceptance/migration.py | 53 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 tests/acceptance/migration.py
> >
> > diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration=
.py
> > new file mode 100644
> > index 0000000000..6115cf6c24
> > --- /dev/null
> > +++ b/tests/acceptance/migration.py
> > @@ -0,0 +1,53 @@
> > +# Migration test
> > +#
> > +# Copyright (c) 2019 Red Hat, Inc.
> > +#
> > +# Authors:
> > +#  Cleber Rosa <crosa@redhat.com>
> > +#  Caio Carrara <ccarrara@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +
> > +from avocado_qemu import Test
> > +
> > +from avocado.utils import network
> > +from avocado.utils import wait
> > +
> > +
> > +class Migration(Test):
> > +    """
> > +    :avocado: enable
> > +    """
> > +
> > +    timeout =3D 10
> > +
> > +    @staticmethod
> > +    def migration_finished(vm):
> > +        return vm.command('query-migrate')['status'] in ('completed', =
'failed')
> > +
> > +    def _get_free_port(self):
> > +        port =3D network.find_free_port()
> > +        if port is None:
> > +            self.cancel('Failed to find a free port')
> > +        return port
>=20
> This method doesn't seem to work when running with -j2: 2 tests started
> with different arch configurations get the same port... Is this a known i=
ssue?
>

It's not bullet proof, but it seems to be quite safe... This is what I've t=
ried:

 $ ./tests/venv/bin/avocado run --test-runner=3Dnrunner --nrunner-max-paral=
lel-tasks=3D10 tests/acceptance/migration.py:Migration.test_migration_with_=
tcp_localhost{,,,,,,,,,,,,,,,,,,,}=20
JOB ID     : 377957f4a16fbc2c6a6f6d9ae225c61af86bd570
JOB LOG    : /home/cleber/avocado/job-results/job-2020-11-03T10.24-377957f/=
job.log
 (02/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (06/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (01/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (05/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (03/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (10/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (07/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (09/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (04/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (08/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: STARTED
 (02/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.46 s)
 (06/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.60 s)
 (01/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.51 s)
 (03/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.49 s)
 (05/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.52 s)
 (10/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.51 s)
 (07/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.52 s)
 (09/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.53 s)
 (04/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.49 s)
 (08/20) tests/acceptance/migration.py:Migration.test_migration_with_tcp_lo=
calhost: PASS (0.56 s)
...
RESULTS    : PASS 20 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | C=
ANCEL 0
JOB HTML   : /home/cleber/avocado/job-results/job-2020-11-03T10.24-377957f/=
results.html
JOB TIME   : 3.82 s

If this is about the issue you posted on IRC, it's about s390x and migratio=
n instead:

2020-11-03 10:06:33,124 qmp              L0255 DEBUG| >>> {'execute': 'quer=
y-migrate'}
2020-11-03 10:06:33,124 qmp              L0148 DEBUG| <<< {'timestamp': {'s=
econds': 1604415993, 'microseconds': 124382}, 'event': 'GUEST_PANICKED', 'd=
ata': {'action': 'pause', 'info': {'core': 0, 'psw-addr': 0, 'reason': 'dis=
abled-wait', 'psw-mask':

I ran across this on Friday, and will properly report it.

Let me know if that helps,
- Cleber.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+hdscACgkQZX6NM6Xy
CfNo6g/9HDMO9UyCvbze2GCukIRfF7CiSRpqi8g9HwDGH37+yThMnnmH/1M5YOYo
tWiF2e6aZ8vCWk6tLX2+aZJOSh0bBnpVV7fmKQYaK0z+eRytWkKaLXKCyN5a6Pbg
5bb82XFRdZVQ1H6YIguISN3/6h0akgIwQkZxEyjWhXsYnqeA/k5nO5wWbjnANnzQ
DlYKEEV5LOuZ4S8WdNG617T1qd/wgojADCcIfwOzgIU6diCaZ45XaiCLhMSuUqY8
Phr7YSMxEvQGGxiceyia9c0so1YZO58EFGid3kyEKmvUiQb/oTKKriaII9Eh6Aei
LxGtkctZosgfm0TF6xBZUD8wuH8KH39CXxu+PM8rZ2OR2d+/2wWqEjuFtNMnHd4f
56q6Lt6CKsi7HVgpaU1tizvlAUK52YOC969T7ZxAP9paPmJ/N1BZGl4HOyxTTRRO
udwGCFlKsDs3itTiCN4nnYHkwovd5nYvrUqU7EnVXW5xKZRXK3RkSg8stba+wV2e
1hYKvy0UrlpN0lonl7WPnlWkMmhaOlKopjyUPAj3YFD2hdUpNAIWsd7zVcYuZ/0A
aTd3iVpijMdpD0J2CkrsYBEpvO0O2NmWkFeigSrgZKx/B1p2uvzFBT43hTL5Pxmb
DKbIh173aTLnKzT0SP/3AxFCRindhp9t6ijcFK5heexHFTNTxIs=
=Hx64
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--


