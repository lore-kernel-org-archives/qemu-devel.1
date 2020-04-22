Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88924C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419C92077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHmipJRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419C92077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDxI-0003dQ-DS
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRDwU-000329-Bd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRDwR-0002h6-G9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:53:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23151
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRDwQ-0002NN-VE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587556401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDDHs7B9VdpGRWatgxjX32dC1p6rGZipkbsffuSr44g=;
 b=KHmipJRBlybA4VpE/2bQcBUTJLXG4r7ydwQWGNkwOcioNSWkCglaBM9RTfHVc/Bm4a+VS/
 hMWNx5fw610FMbgVZq7ceQmfJglKNgp28ZRixm8tQckukfB27r7IbD90SRVZSBHeVkZX9p
 gw4038hxpM75eYySxTlKLdhXCSZ2pxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-F-fLNFTTPZyF6iu5tkzYcw-1; Wed, 22 Apr 2020 07:53:15 -0400
X-MC-Unique: F-fLNFTTPZyF6iu5tkzYcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CE8113FC;
 Wed, 22 Apr 2020 11:53:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 585E928985;
 Wed, 22 Apr 2020 11:53:12 +0000 (UTC)
Date: Wed, 22 Apr 2020 13:53:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
Message-ID: <20200422115310.GA7155@linux.fritz.box>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
 <024af11c-180a-2ef6-fbab-fe31107d4438@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <024af11c-180a-2ef6-fbab-fe31107d4438@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.04.2020 um 07:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 21.04.2020 19:56, Kevin Wolf wrote:
> > Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Add python script with new logic of searching for tests:
> > >=20
> > > Current ./check behavior:
> > >   - tests are named [0-9][0-9][0-9]
> > >   - tests must be registered in group file (even if test doesn't belo=
ng
> > >     to any group, like 142)
> > >=20
> > > Behavior of new test:
> > >   - group file is dropped
> > >   - tests are searched by file-name instead of group file, so it's no=
t
> > >     needed more to "register the test", just create it with name
> > >     *-test. Old names like [0-9][0-9][0-9] are supported too, but not
> > >     recommended for new tests
> >=20
> > I wonder if a tests/ subdirectory instead of the -test suffix would
> > organise things a bit better.
>=20
> No objections.
>=20
> I also thought about, may be, a tests/ subtree, so we'll have something l=
ike
>=20
> tests/jobs/<mirror, stream, backup tests>
> tests/formats/<qcow2 tests and others, or may be one more subdirectory le=
vel>
> ...

I thought of that, too, but then decided not to mention it because I
feel it might be hard to decide where a test belongs. Many tests are
qcow2 and mirror tests at the same time, every commit test is also a
backing file test etc.

This is essentially why we have groups and each test can be in more
than one group.

On the other hand, I assume that for some tests it would be quite clear
where they belong. So if we're prepared to have some tests directly in
tests/ and only some others in subdirectories, we can still do that.

> > >   - groups are parsed from '# group: ' line inside test files
> > >   - optional file group.local may be used to define some additional
> > >     groups for downstreams
> > >   - 'disabled' group is used to temporary disable tests. So instead o=
f
> > >     commenting tests in old 'group' file you now can add them to
> > >     disabled group with help of 'group.local' file
> > >   - selecting test ranges like 5-15 are not supported more
> >=20
> > Occasionally they were useful when something went wrong during the test
> > run and I only wanted to repeat the part after it happened. But it's a
> > rare case and we don't have a clear order any more with arbitrary test
> > names (which are an improvement otherwise), so we'll live with it.
>=20
> Yes, I've used it for same thing.
>=20
> Actually, we still have the order, as I just sort iotests by name. I thin=
k,
> we could add a parameter for testfinder (may be, as a separate step no in
> these series), something like
>=20
> --start-from TEST : parse all other arguments as usual, make sorted seque=
nce
> and than drop tests from the first one to TEST (not inclusive). This may =
be
> used to rerun failed ./check command, starting from the middle of the pro=
cess.

True, this would be a good replacement. I don't think it's a requirement
to have it in this series, but I won't complain if you implement it. :-)

> >=20
> > > Benefits:
> > >   - no rebase conflicts in group file on patch porting from branch to
> > >     branch
> > >   - no conflicts in upstream, when different series want to occupy sa=
me
> > >     test number
> > >   - meaningful names for test files
> > >     For example, with digital number, when some person wants to add s=
ome
> > >     test about block-stream, he most probably will just create a new
> > >     test. But if there would be test-block-stream test already, he wi=
ll
> > >     at first look at it and may be just add a test-case into it.
> > >     And anyway meaningful names are better.
> > >=20
> > > This commit just adds class, which is unused now, and will be used in
> > > further patches, to finally substitute ./check selecting tests logic.
> >=20
> > Maybe mention here that the file can be executed standalone, even if
> > it'S not used by check yet.
> >=20
> > > Still, the documentation changed like new behavior is already here.
> > > Let's live with this small inconsistency for the following few commit=
s,
> > > until final change.
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
> > > ---
> > >   docs/devel/testing.rst           |  52 +++++++++-
> > >   tests/qemu-iotests/testfinder.py | 167 ++++++++++++++++++++++++++++=
+++
> >=20
> > A little bit of bikeshedding: As this can be executed as a standalone
> > tool, would a name like findtests.py be better?
>=20
> Hmm. I named it by class name, considering possibility to execute is
> just for module testing. So for module users, it's just a module with
> class TestFinder, and it's called testfinder.. But I don't have strict
> opinion in it, findtests sound more human-friendly.

It was just a thought. If you prefer testfinder.py, I'm fine with it.

> >=20
> > >   2 files changed, 218 insertions(+), 1 deletion(-)
> > >   create mode 100755 tests/qemu-iotests/testfinder.py
> > >=20
> > > diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> > > index 770a987ea4..6c9d5b126b 100644
> > > --- a/docs/devel/testing.rst
> > > +++ b/docs/devel/testing.rst
> > > @@ -153,7 +153,7 @@ check-block
> > >   -----------
> > >   ``make check-block`` runs a subset of the block layer iotests (the =
tests that
> > > -are in the "auto" group in ``tests/qemu-iotests/group``).
> > > +are in the "auto" group).
> > >   See the "QEMU iotests" section below for more information.
> > >   GCC gcov support
> > > @@ -267,6 +267,56 @@ another application on the host may have locked =
the file, possibly leading to a
> > >   test failure.  If using such devices are explicitly desired, consid=
er adding
> > >   ``locking=3Doff`` option to disable image locking.
> > > +Test case groups
> > > +----------------
> > > +
> > > +Test may belong to some groups, you may define it in the comment ins=
ide the
> > > +test. By convention, test groups are listed in the second line of th=
e test
> > > +file, after "#!/..." line, like this:
> > > +
> > > +.. code::
> > > +
> > > +  #!/usr/bin/env python3
> > > +  # group: auto quick
> > > +  #
> > > +  ...
> > > +
> > > +Additional way of defining groups is creating tests/qemu-iotests/gro=
up.local
> > > +file. This should be used only for downstream (this file should neve=
r appear
> > > +in upstream). This file may be used for defining some downstream tes=
t groups
> > > +or for temporary disable tests, like this:
> > > +
> > > +.. code::
> > > +
> > > +  # groups for some company downstream process
> > > +  #
> > > +  # ci - tests to run on build
> > > +  # down - our downstream tests, not for upstream
> > > +  #
> > > +  # Format of each line is:
> > > +  # TEST_NAME TEST_GROUP [TEST_GROUP ]...
> > > +
> > > +  013 ci
> > > +  210 disabled
> > > +  215 disabled
> > > +  our-ugly-workaround-test down ci
> > > +
> > > +The following groups are defined:
> > > +
> > > +- quick : Tests in this group should finish within some few seconds.
> > > +
> > > +- img : Tests in this group can be used to excercise the qemu-img to=
ol.
> > > +
> > > +- auto : Tests in this group are used during "make check" and should=
 be
> > > +  runnable in any case. That means they should run with every QEMU b=
inary
> > > +  (also non-x86), with every QEMU configuration (i.e. must not fail =
if
> > > +  an optional feature is not compiled in - but reporting a "skip" is=
 ok),
> > > +  work at least with the qcow2 file format, work with all kind of ho=
st
> > > +  filesystems and users (e.g. "nobody" or "root") and must not take =
too
> > > +  much memory and disk space (since CI pipelines tend to fail otherw=
ise).
> > > +
> > > +- disabled : Tests in this group are disabled and ignored by check.
> >=20
> > We have more groups than just these. We could either try and document
> > all of them here, or we could only keep auto/quick/disabled which have =
a
> > general meaning rather than defining an area of code that they test. If
> > we do the latter, I would clarify that this is not an exhaustive list,
> > and remove "img" from this section.
>=20
> OK. I'll drop img for now, documenting all the groups may be done in sepa=
rate.
>=20
> >=20
> > >   .. _docker-ref:
> > >   Docker based tests
> > > diff --git a/tests/qemu-iotests/testfinder.py b/tests/qemu-iotests/te=
stfinder.py
> > > new file mode 100755
> > > index 0000000000..1da28564c0
> > > --- /dev/null
> > > +++ b/tests/qemu-iotests/testfinder.py
> >=20
> > As this is a new code file, would you mind adding type hints from the
> > start?
>=20
> I added it in one-two non-obvious places. Is there any general thought
> about using type-hints? Should modern coder use them absolutely
> everywhere?

Type checkers only work if things are consistently annotated. For
example, if a function definition doesn't have type hints, the whole
code in this function stays completely unchecked even if it contains an
obvious error like passing a string literal to another function that is
annotated to take an int.

So I think we should add type hints everywhere.

> >=20
> > > @@ -0,0 +1,167 @@
> > > +#!/usr/bin/env python3
> > > +#
> > > +# Parse command line options to define set of tests to run.
> > > +#
> > > +# Copyright (c) 2020 Virtuozzo International GmbH
> > > +#
> > > +# This program is free software; you can redistribute it and/or modi=
fy
> > > +# it under the terms of the GNU General Public License as published =
by
> > > +# the Free Software Foundation; either version 2 of the License, or
> > > +# (at your option) any later version.
> > > +#
> > > +# This program is distributed in the hope that it will be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public License
> > > +# along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
> > > +#
> > > +
> > > +import os
> > > +import sys
> > > +import glob
> > > +import argparse
> > > +import re
> > > +from collections import defaultdict
> > > +from contextlib import contextmanager
> > > +
> > > +
> > > +@contextmanager
> > > +def chdir(path):
> > > +    if path is None:
> > > +        yield
> > > +        return
> > > +
> > > +    saved_dir =3D os.getcwd()
> > > +    os.chdir(path)
> > > +    try:
> > > +        yield
> > > +    finally:
> > > +        os.chdir(saved_dir)
> > > +
> > > +
> > > +class TestFinder:
> > > +    @staticmethod
> > > +    def create_argparser():
> > > +        p =3D argparse.ArgumentParser(description=3D"Select set of t=
ests",
> >=20
> > "a set of tests"?
> >=20
> > > +                                    add_help=3DFalse, usage=3Dargpar=
se.SUPPRESS)
> > > +
> > > +        p.add_argument('-g', metavar=3D'group1,...', dest=3D'groups'=
,
> > > +                       help=3D'include tests from these groups')
> > > +        p.add_argument('-x', metavar=3D'group1,...', dest=3D'exclude=
_groups',
> > > +                       help=3D'exclude tests from these groups')
> > > +        p.add_argument('tests', metavar=3D'TEST_FILES', nargs=3D'*',
> > > +                       help=3D'tests to run')
> > > +
> > > +        return p
> > > +
> > > +    argparser =3D create_argparser.__func__()
> > > +
> > > +    def __init__(self, test_dir=3DNone):
> > > +        self.groups =3D defaultdict(set)
> > > +
> > > +        with chdir(test_dir):
> > > +            self.all_tests =3D glob.glob('[0-9][0-9][0-9]')
> > > +            self.all_tests +=3D [f for f in glob.iglob('*-test')]
> > > +
> > > +            for t in self.all_tests:
> > > +                with open(t) as f:
> > > +                    for line in f:
> > > +                        if line.startswith('# group: '):
> > > +                            for g in line.split()[2:]:
> > > +                                self.groups[g].add(t)
> > > +
> > > +    def add_group_file(self, fname):
> > > +        with open(fname) as f:
> > > +            for line in f:
> > > +                line =3D line.strip()
> > > +
> > > +                if (not line) or line[0] =3D=3D '#':
> > > +                    continue
> > > +
> > > +                words =3D line.split()
> > > +                test_file =3D words[0]
> > > +                groups =3D words[1:]
> > > +
> > > +                if test_file not in self.all_tests:
> > > +                    print('Warning: {}: "{}" test is not found. '
> > > +                          'Skip.'.format(fname, test_file))
> >=20
> > You're using f strings in the later patches. Wouldn't it be more
> > consistent to use them here, too?
>=20
> Yes, thanks. I just wrote this code before learning f-strings)
>=20
> >=20
> > > +                    continue
> > > +
> > > +                for g in groups:
> > > +                    self.groups[g].add(test_file)
> > > +
> > > +    def find_tests(self, groups=3DNone, exclude_groups=3DNone, tests=
=3DNone):
> > > +        """
> > > +        1. Take all tests from @groups,
> > > +           or just all tests if @groups is None and @tests is None
> > > +           or nothing if @groups is None and @tests is not None
> > > +        2. Drop tests, which are in at least one of @exclude_groups =
or in
> > > +           'disabled' group (if 'disabled' is not listed in @groups)
> > > +        3. Add tests from @tests
> > > +        """
> > > +        if groups is None:
> > > +            groups =3D []
> > > +        if exclude_groups is None:
> > > +            exclude_groups =3D []
> > > +        if tests is None:
> > > +            tests =3D []
> > > +
> > > +        if groups:
> > > +            res =3D set().union(*(self.groups[g] for g in groups))
> > > +        elif tests:
> > > +            res =3D set()
> > > +        else:
> > > +            res =3D set(self.all_tests)
> > > +
> > > +        if 'disabled' not in groups and 'disabled' not in exclude_gr=
oups:
> > > +            exclude_groups.append('disabled')
> > > +
> > > +        res =3D res.difference(*(self.groups[g] for g in exclude_gro=
ups))
> > > +
> > > +        # We want to add @tests. But for compatibility with old test=
 names,
> > > +        # we should convert any number < 100 to number padded by
> > > +        # leading zeroes, like 1 -> 001 and 23 -> 023.
> > > +        for t in tests:
> > > +            if re.fullmatch(r'\d{1,2}', t):
> > > +                res.add('0' * (3 - len(t)) + t)
> > > +            else:
> > > +                res.add(t)
> > > +
> > > +        return sorted(res)
> > > +
> > > +    def find_tests_argv(self, argv):
> > > +        args, remaining =3D self.argparser.parse_known_args(argv)
> > > +
> > > +        if args.groups is not None:
> > > +            args.groups =3D args.groups.split(',')
> > > +
> > > +        if args.exclude_groups is not None:
> > > +            args.exclude_groups =3D args.exclude_groups.split(',')
> > > +
> > > +        return self.find_tests(**vars(args)), remaining
> > > +
> > > +
> > > +def find_tests(argv, test_dir=3DNone):
> > > +    tf =3D TestFinder(test_dir)
> > > +
> > > +    if test_dir is None:
> > > +        group_local =3D 'group.local'
> > > +    else:
> > > +        group_local =3D os.path.join(test_dir, 'group.local')
> > > +    if os.path.isfile(group_local):
> > > +        tf.add_group_file(group_local)
> > > +
> > > +    return tf.find_tests_argv(argv)
> > > +
> > > +
> > > +if __name__ =3D=3D '__main__':
> > > +    if len(sys.argv) =3D=3D 2 and sys.argv[1] in ['-h', '--help']:
> > > +        TestFinder.argparser.print_help()
> > > +        exit()
> > > +
> > > +    tests, remaining_argv =3D find_tests(sys.argv[1:])
> > > +    print('\n'.join(tests))
> > > +    if remaining_argv:
> > > +        print('\nUnhandled options: ', remaining_argv)
> >=20
> > I think unhandled options shouldn't be considered an error and we
> > shouldn't even try to find and display any tests then. I'd either print
> > the help text or have an error message that refers to --help.
>=20
> As I considered running this script as executable for testing purposes, i=
t's
> good to know, which options are not handled..

Yes, that makes sense. I just think it should be an error and not just
an additional hint at the end.

Kevin


