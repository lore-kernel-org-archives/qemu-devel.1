Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C1FC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6CE206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0UHITKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6CE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQwDb-0008LC-1i
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQwCj-0007ms-6Y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQwCi-0006Nf-6Y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:57:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jQwCh-0006Kh-HK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587488218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20jiDB5xoOSyqzvYwLARK6b/R9DE8+M+xT65qQw6Jcw=;
 b=T0UHITKwMIdB2mx6F3DDLEUoI8sqtuoflqe28l0jxX+BnfpKLs9ZMnFDnACk3cPxYNeax/
 seCQn4vR6GK1zy/sA5D4/WtL+ahRLA8qW1HJQet+j22mf4baLcr1Di5BqW7kyh4d8j/RXk
 rXmjTuNPdJ3sL/4LOCCHdx0sSeojQ58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-Dnolyy9yN5u0zDFeppFkUQ-1; Tue, 21 Apr 2020 12:56:52 -0400
X-MC-Unique: Dnolyy9yN5u0zDFeppFkUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A1B0107ACC4;
 Tue, 21 Apr 2020 16:56:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-155.ams2.redhat.com [10.36.112.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27E0419C70;
 Tue, 21 Apr 2020 16:56:48 +0000 (UTC)
Date: Tue, 21 Apr 2020 18:56:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
Message-ID: <20200421165647.GE22440@linux.fritz.box>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200421073601.28710-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
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

Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Add python script with new logic of searching for tests:
>=20
> Current ./check behavior:
>  - tests are named [0-9][0-9][0-9]
>  - tests must be registered in group file (even if test doesn't belong
>    to any group, like 142)
>=20
> Behavior of new test:
>  - group file is dropped
>  - tests are searched by file-name instead of group file, so it's not
>    needed more to "register the test", just create it with name
>    *-test. Old names like [0-9][0-9][0-9] are supported too, but not
>    recommended for new tests

I wonder if a tests/ subdirectory instead of the -test suffix would
organise things a bit better.

>  - groups are parsed from '# group: ' line inside test files
>  - optional file group.local may be used to define some additional
>    groups for downstreams
>  - 'disabled' group is used to temporary disable tests. So instead of
>    commenting tests in old 'group' file you now can add them to
>    disabled group with help of 'group.local' file
>  - selecting test ranges like 5-15 are not supported more

Occasionally they were useful when something went wrong during the test
run and I only wanted to repeat the part after it happened. But it's a
rare case and we don't have a clear order any more with arbitrary test
names (which are an improvement otherwise), so we'll live with it.

> Benefits:
>  - no rebase conflicts in group file on patch porting from branch to
>    branch
>  - no conflicts in upstream, when different series want to occupy same
>    test number
>  - meaningful names for test files
>    For example, with digital number, when some person wants to add some
>    test about block-stream, he most probably will just create a new
>    test. But if there would be test-block-stream test already, he will
>    at first look at it and may be just add a test-case into it.
>    And anyway meaningful names are better.
>=20
> This commit just adds class, which is unused now, and will be used in
> further patches, to finally substitute ./check selecting tests logic.

Maybe mention here that the file can be executed standalone, even if
it'S not used by check yet.

> Still, the documentation changed like new behavior is already here.
> Let's live with this small inconsistency for the following few commits,
> until final change.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/devel/testing.rst           |  52 +++++++++-
>  tests/qemu-iotests/testfinder.py | 167 +++++++++++++++++++++++++++++++

A little bit of bikeshedding: As this can be executed as a standalone
tool, would a name like findtests.py be better?

>  2 files changed, 218 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/testfinder.py
>=20
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 770a987ea4..6c9d5b126b 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -153,7 +153,7 @@ check-block
>  -----------
> =20
>  ``make check-block`` runs a subset of the block layer iotests (the tests=
 that
> -are in the "auto" group in ``tests/qemu-iotests/group``).
> +are in the "auto" group).
>  See the "QEMU iotests" section below for more information.
> =20
>  GCC gcov support
> @@ -267,6 +267,56 @@ another application on the host may have locked the =
file, possibly leading to a
>  test failure.  If using such devices are explicitly desired, consider ad=
ding
>  ``locking=3Doff`` option to disable image locking.
> =20
> +Test case groups
> +----------------
> +
> +Test may belong to some groups, you may define it in the comment inside =
the
> +test. By convention, test groups are listed in the second line of the te=
st
> +file, after "#!/..." line, like this:
> +
> +.. code::
> +
> +  #!/usr/bin/env python3
> +  # group: auto quick
> +  #
> +  ...
> +
> +Additional way of defining groups is creating tests/qemu-iotests/group.l=
ocal
> +file. This should be used only for downstream (this file should never ap=
pear
> +in upstream). This file may be used for defining some downstream test gr=
oups
> +or for temporary disable tests, like this:
> +
> +.. code::
> +
> +  # groups for some company downstream process
> +  #
> +  # ci - tests to run on build
> +  # down - our downstream tests, not for upstream
> +  #
> +  # Format of each line is:
> +  # TEST_NAME TEST_GROUP [TEST_GROUP ]...
> +
> +  013 ci
> +  210 disabled
> +  215 disabled
> +  our-ugly-workaround-test down ci
> +
> +The following groups are defined:
> +
> +- quick : Tests in this group should finish within some few seconds.
> +
> +- img : Tests in this group can be used to excercise the qemu-img tool.
> +
> +- auto : Tests in this group are used during "make check" and should be
> +  runnable in any case. That means they should run with every QEMU binar=
y
> +  (also non-x86), with every QEMU configuration (i.e. must not fail if
> +  an optional feature is not compiled in - but reporting a "skip" is ok)=
,
> +  work at least with the qcow2 file format, work with all kind of host
> +  filesystems and users (e.g. "nobody" or "root") and must not take too
> +  much memory and disk space (since CI pipelines tend to fail otherwise)=
.
> +
> +- disabled : Tests in this group are disabled and ignored by check.

We have more groups than just these. We could either try and document
all of them here, or we could only keep auto/quick/disabled which have a
general meaning rather than defining an area of code that they test. If
we do the latter, I would clarify that this is not an exhaustive list,
and remove "img" from this section.

>  .. _docker-ref:
> =20
>  Docker based tests
> diff --git a/tests/qemu-iotests/testfinder.py b/tests/qemu-iotests/testfi=
nder.py
> new file mode 100755
> index 0000000000..1da28564c0
> --- /dev/null
> +++ b/tests/qemu-iotests/testfinder.py

As this is a new code file, would you mind adding type hints from the
start?

> @@ -0,0 +1,167 @@
> +#!/usr/bin/env python3
> +#
> +# Parse command line options to define set of tests to run.
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import os
> +import sys
> +import glob
> +import argparse
> +import re
> +from collections import defaultdict
> +from contextlib import contextmanager
> +
> +
> +@contextmanager
> +def chdir(path):
> +    if path is None:
> +        yield
> +        return
> +
> +    saved_dir =3D os.getcwd()
> +    os.chdir(path)
> +    try:
> +        yield
> +    finally:
> +        os.chdir(saved_dir)
> +
> +
> +class TestFinder:
> +    @staticmethod
> +    def create_argparser():
> +        p =3D argparse.ArgumentParser(description=3D"Select set of tests=
",

"a set of tests"?

> +                                    add_help=3DFalse, usage=3Dargparse.S=
UPPRESS)
> +
> +        p.add_argument('-g', metavar=3D'group1,...', dest=3D'groups',
> +                       help=3D'include tests from these groups')
> +        p.add_argument('-x', metavar=3D'group1,...', dest=3D'exclude_gro=
ups',
> +                       help=3D'exclude tests from these groups')
> +        p.add_argument('tests', metavar=3D'TEST_FILES', nargs=3D'*',
> +                       help=3D'tests to run')
> +
> +        return p
> +
> +    argparser =3D create_argparser.__func__()
> +
> +    def __init__(self, test_dir=3DNone):
> +        self.groups =3D defaultdict(set)
> +
> +        with chdir(test_dir):
> +            self.all_tests =3D glob.glob('[0-9][0-9][0-9]')
> +            self.all_tests +=3D [f for f in glob.iglob('*-test')]
> +
> +            for t in self.all_tests:
> +                with open(t) as f:
> +                    for line in f:
> +                        if line.startswith('# group: '):
> +                            for g in line.split()[2:]:
> +                                self.groups[g].add(t)
> +
> +    def add_group_file(self, fname):
> +        with open(fname) as f:
> +            for line in f:
> +                line =3D line.strip()
> +
> +                if (not line) or line[0] =3D=3D '#':
> +                    continue
> +
> +                words =3D line.split()
> +                test_file =3D words[0]
> +                groups =3D words[1:]
> +
> +                if test_file not in self.all_tests:
> +                    print('Warning: {}: "{}" test is not found. '
> +                          'Skip.'.format(fname, test_file))

You're using f strings in the later patches. Wouldn't it be more
consistent to use them here, too?

> +                    continue
> +
> +                for g in groups:
> +                    self.groups[g].add(test_file)
> +
> +    def find_tests(self, groups=3DNone, exclude_groups=3DNone, tests=3DN=
one):
> +        """
> +        1. Take all tests from @groups,
> +           or just all tests if @groups is None and @tests is None
> +           or nothing if @groups is None and @tests is not None
> +        2. Drop tests, which are in at least one of @exclude_groups or i=
n
> +           'disabled' group (if 'disabled' is not listed in @groups)
> +        3. Add tests from @tests
> +        """
> +        if groups is None:
> +            groups =3D []
> +        if exclude_groups is None:
> +            exclude_groups =3D []
> +        if tests is None:
> +            tests =3D []
> +
> +        if groups:
> +            res =3D set().union(*(self.groups[g] for g in groups))
> +        elif tests:
> +            res =3D set()
> +        else:
> +            res =3D set(self.all_tests)
> +
> +        if 'disabled' not in groups and 'disabled' not in exclude_groups=
:
> +            exclude_groups.append('disabled')
> +
> +        res =3D res.difference(*(self.groups[g] for g in exclude_groups)=
)
> +
> +        # We want to add @tests. But for compatibility with old test nam=
es,
> +        # we should convert any number < 100 to number padded by
> +        # leading zeroes, like 1 -> 001 and 23 -> 023.
> +        for t in tests:
> +            if re.fullmatch(r'\d{1,2}', t):
> +                res.add('0' * (3 - len(t)) + t)
> +            else:
> +                res.add(t)
> +
> +        return sorted(res)
> +
> +    def find_tests_argv(self, argv):
> +        args, remaining =3D self.argparser.parse_known_args(argv)
> +
> +        if args.groups is not None:
> +            args.groups =3D args.groups.split(',')
> +
> +        if args.exclude_groups is not None:
> +            args.exclude_groups =3D args.exclude_groups.split(',')
> +
> +        return self.find_tests(**vars(args)), remaining
> +
> +
> +def find_tests(argv, test_dir=3DNone):
> +    tf =3D TestFinder(test_dir)
> +
> +    if test_dir is None:
> +        group_local =3D 'group.local'
> +    else:
> +        group_local =3D os.path.join(test_dir, 'group.local')
> +    if os.path.isfile(group_local):
> +        tf.add_group_file(group_local)
> +
> +    return tf.find_tests_argv(argv)
> +
> +
> +if __name__ =3D=3D '__main__':
> +    if len(sys.argv) =3D=3D 2 and sys.argv[1] in ['-h', '--help']:
> +        TestFinder.argparser.print_help()
> +        exit()
> +
> +    tests, remaining_argv =3D find_tests(sys.argv[1:])
> +    print('\n'.join(tests))
> +    if remaining_argv:
> +        print('\nUnhandled options: ', remaining_argv)

I think unhandled options shouldn't be considered an error and we
shouldn't even try to find and display any tests then. I'd either print
the help text or have an error message that refers to --help.

Kevin


