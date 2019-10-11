Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012ECC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB23420679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB23420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpiq-0001NJ-Ow
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIpd6-0004fo-5n
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIpd1-0001Pi-GF
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iIpcv-00017K-JB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 597114E83C
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 07:46:15 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-231.brq.redhat.com [10.40.204.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B55E45B8;
 Fri, 11 Oct 2019 07:46:14 +0000 (UTC)
Date: Fri, 11 Oct 2019 09:46:11 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 2/3] tests: qapi: Test 'features' of commands
Message-ID: <20191011074611.GA1979@andariel.pipo.sk>
References: <cover.1570705279.git.pkrempa@redhat.com>
 <7a97c6dbe0747f604a4da81ff055fbf3ac97afb3.1570705279.git.pkrempa@redhat.com>
 <87pnj4ogf9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <87pnj4ogf9.fsf@dusky.pond.sub.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 11 Oct 2019 07:46:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 15:53:30 +0200, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
>=20
> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > ---
> >  tests/qapi-schema/qapi-schema-test.json | 26 ++++++++++++++++++++++
> >  tests/qapi-schema/qapi-schema-test.out  | 29 +++++++++++++++++++++++++
> >  tests/qapi-schema/test-qapi.py          |  4 ++++
> >  tests/test-qmp-cmds.c                   | 28 ++++++++++++++++++++++++
> >  4 files changed, 87 insertions(+)
>=20
> More thorough than I asked for.  I'm not complaining :)
>=20
> >
> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schem=
a/qapi-schema-test.json
> > index 75c42eb0e3..220859d4c9 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -290,3 +290,29 @@
> >              'cfs1': 'CondFeatureStruct1',
> >              'cfs2': 'CondFeatureStruct2',
> >              'cfs3': 'CondFeatureStruct3' } }
> > +
> > +# test 'features' for command
> > +
> > +{ 'command': 'test-command-features1',
> > +  'features': [] }
> > +
> > +{ 'command': 'test-command-features2',
> > +  'features': [ 'feature1' ] }
> > +
> > +{ 'command': 'test-command-features3',
> > +  'features': [ 'feature1', 'feature2' ] }
> > +
> > +{ 'command': 'test-command-features4',
> > +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1=
)'} ] }
> > +
> > +{ 'command': 'test-command-features5',
> > +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1=
)'},
> > +                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2=
)'} ] }
> > +
> > +{ 'command': 'test-command-features6',
> > +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1=
)'},
> > +                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2=
)'} ] }
>=20
> Do you need both test-command-features5 and 6?  They look the same to me.=
=2E.

No. It can be dropped. Looks like I mistakenly appropriated
'CondFeatureStruct2' test twice :/

> > +{ 'command': 'test-command-features7',
> > +  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)=
',
> > +                                              'defined(TEST_IF_COND_2)=
'] } ] }
> > diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema=
/qapi-schema-test.out
> > index 98031da96f..a38e348d54 100644
> > --- a/tests/qapi-schema/qapi-schema-test.out
> > +++ b/tests/qapi-schema/qapi-schema-test.out
> > @@ -412,3 +412,32 @@ object q_obj_test-features-arg
> >      member cfs3: CondFeatureStruct3 optional=3DFalse
> >  command test-features q_obj_test-features-arg -> None
> >     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +command test-command-features1 None -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +command test-command-features2 None -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +   feature feature1
> > +command test-command-features3 None -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +   feature feature1
> > +   feature feature2
> > +command test-command-features4 None -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +   feature feature1
> > +        if ['defined(TEST_IF_FEATURE_1)']
> > +command test-command-features5 None -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +   feature feature1
> > +        if ['defined(TEST_IF_FEATURE_1)']
> > +   feature feature2
> > +        if ['defined(TEST_IF_FEATURE_2)']
> > +command test-command-features6 None -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +   feature feature1
> > +        if ['defined(TEST_IF_FEATURE_1)']
> > +   feature feature2
> > +        if ['defined(TEST_IF_FEATURE_2)']
> > +command test-command-features7 None -> None
> > +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
> > +   feature feature1
> > +        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
> > diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qa=
pi.py
> > index e13c2e8671..62e65b6a7d 100755
> > --- a/tests/qapi-schema/test-qapi.py
> > +++ b/tests/qapi-schema/test-qapi.py
> > @@ -80,6 +80,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
> >          print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s p=
reconfig=3D%s'
> >                % (gen, success_response, boxed, allow_oob, allow_precon=
fig))
> >          self._print_if(ifcond)
> > +        if features:
> > +            for f in features:
> > +                print('   feature %s' % f.name)
> > +                self._print_if(f.ifcond, 8)
>=20
> Copied from visit_object_type().  Let's factor it into a @staticmethod
> _print_features().

I'm not sure if that's intentional but the 'struct' and 'command'
feature printers differ in indentation level by one space. I went for
aligning it with the 'gen' line above. I thought it's for visual
separation with other possible lines.

> >      def visit_event(self, name, info, ifcond, arg_type, boxed):
> >          print('event %s %s' % (name, arg_type and arg_type.name))
> > diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> > index 36fdf5b115..19f6e06ba7 100644
> > --- a/tests/test-qmp-cmds.c
> > +++ b/tests/test-qmp-cmds.c
> > @@ -51,6 +51,34 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureS=
truct1 *fs1,
> >  {
> >  }
> >
> > +void qmp_test_command_features1(Error **errp)
> > +{
> > +}
> > +
> > +void qmp_test_command_features2(Error **errp)
> > +{
> > +}
> > +
> > +void qmp_test_command_features3(Error **errp)
> > +{
> > +}
> > +
> > +void qmp_test_command_features4(Error **errp)
> > +{
> > +}
> > +
> > +void qmp_test_command_features5(Error **errp)
> > +{
> > +}
> > +
> > +void qmp_test_command_features6(Error **errp)
> > +{
> > +}
> > +
> > +void qmp_test_command_features7(Error **errp)
> > +{
> > +}
> > +
> >  UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
> >                                bool has_udb1, UserDefOne *ud1b,
> >                                Error **errp)
>=20
> Any particular reason why we shouldn't squash this into PATCH 1?

Not really. I tend to prefer tests added separately and it was also done
so in case of features for 'structs' so I went with that approach. Said
that I'm perfectly fine with squashing them.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl2gM0AACgkQHGwCByjY
1GqJmg/9FmcPJlbzUOdWjIaVuuvCiXpKCPxZOO4U90ZkDJY0vN3mvny0EAnEtSUn
Av87lPAybBaVwx9cLUdIAmngnbdXNiEnDNE7iOzP9gRwjVDhgSedGE7XqQjDOnSt
/N8JgDV85cw9O4L3RG9XIPU3orrGB6KOFbJGl6+M02r8Ub1KtQMvPuv0E+KOgpye
uB2va0Ymy5hRldodbjO+6plS6ytnlQsD+7ZYJKV8YCRqxKo/U0FCImdEM9zbqzjD
yUZPU+tirEZSTiQ9bmPeTCk32vloQmDYJDIiqWrd9dSc0uFPYzeJkpw9bqKVWIsB
95MYXDKz0vtjRZnPNWCk9OFcXZeR5BCkTf5iEecCaT+iAA/Dv1pRRo1JUv99kSpF
8ixAn1JGBKnNlgWRgFbSlY2w2difJvTC4fgXCosIXjXTh8pwiAPIdpwsaIA5da5J
rl8KtC44eXaaJrzQPCnI+roEq8riuFqNV9ERX5G/OIF3OmMq6/aNjISqG5cEs9//
W11ZZJddoo33eiZDX66H5zQE+ttGizXskQI5W/1iadg4yQte/5f3ckeeRM75B4H/
HpirgqTCXB26i7l1Y3dQB1h9KvSwujmx631pNlHDXLHkiocCKk7K0p+HAZEyKoGO
m0CDQ2fmOkF6DTUS8ahbO7RzwyaX36ZfcNqGYSLP0eSgsdvNRRE=
=pIRm
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

