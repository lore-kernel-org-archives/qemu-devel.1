Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2550CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B736E21897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B736E21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTFO-0005yT-UH
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iLTEA-0004pg-1D
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iLTE6-00019y-TM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iLTDz-00012W-LC; Fri, 18 Oct 2019 10:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 632A18E581;
 Fri, 18 Oct 2019 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B4060BF4;
 Fri, 18 Oct 2019 14:27:21 +0000 (UTC)
Date: Fri, 18 Oct 2019 16:27:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] iotests: Skip read-only cases in 118 when run as root
Message-ID: <20191018142720.GH6122@localhost.localdomain>
References: <20191018115127.2671-1-kwolf@redhat.com>
 <a810971a-639e-e7dc-d5e6-6b0bb524079b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a810971a-639e-e7dc-d5e6-6b0bb524079b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 18 Oct 2019 14:27:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.10.2019 um 14:59 hat Philippe Mathieu-Daud=E9 geschrieben:
> Hi Kevin,
>=20
> On 10/18/19 1:51 PM, Kevin Wolf wrote:
> > Some tests in 118 use chmod to remove write permissions from the file
> > and assume that the image can indeed not be opened read-write
> > afterwards. This doesn't work when the test is run as root, because r=
oot
> > can still open the file as writable even when the permission bit isn'=
t
> > set.
> >=20
> > Introduce a @skip_if_root decorator and use it in 118 to skip the tes=
ts
> > in question when the script is run as root.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/118        |  3 +++
> >   tests/qemu-iotests/iotests.py | 10 ++++++++++
> >   2 files changed, 13 insertions(+)
> >=20
> > diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> > index ea0b326ae0..9eff46d189 100755
> > --- a/tests/qemu-iotests/118
> > +++ b/tests/qemu-iotests/118
> > @@ -446,6 +446,7 @@ class TestChangeReadOnly(ChangeBaseClass):
> >           self.assert_qmp(result, 'return[0]/inserted/ro', True)
> >           self.assert_qmp(result, 'return[0]/inserted/image/filename'=
, new_img)
> > +    @iotests.skip_if_root
>=20
> Why not have case_notrun() return 'reason' and use:
>=20
> @unittest.skipIf(os.getuid() =3D=3D 0, case_notrun("cannot be run as ro=
ot"))

Because we can't skip test cases using unittest functionality, it
results in different output (the test is marked as 's' instead of '.'
and a message '(skipped=3Dn)' is added), which means failure for
qemu-iotests.

Apart from that, it would duplicate the logic and the error message in
every place, which wouldn't be very nice anyway. With the necessary
iotests.case_notrun() the line becomes > 80 characters, too.

> >       def test_rw_ro_retain(self):
> >           os.chmod(new_img, 0o444)
> >           self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
> > @@ -530,6 +531,7 @@ class TestChangeReadOnly(ChangeBaseClass):
> >           self.assert_qmp(result, 'return[0]/inserted/ro', True)
> >           self.assert_qmp(result, 'return[0]/inserted/image/filename'=
, new_img)
> > +    @iotests.skip_if_root
> >       def test_make_ro_rw(self):
> >           os.chmod(new_img, 0o444)
> >           self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
> > @@ -571,6 +573,7 @@ class TestChangeReadOnly(ChangeBaseClass):
> >           self.assert_qmp(result, 'return[0]/inserted/ro', True)
> >           self.assert_qmp(result, 'return[0]/inserted/image/filename'=
, new_img)
> > +    @iotests.skip_if_root
> >       def test_make_ro_rw_by_retain(self):
> >           os.chmod(new_img, 0o444)
> >           self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
> > index 3a8f378f90..9c66db613e 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -920,6 +920,16 @@ def skip_if_unsupported(required_formats=3D[], r=
ead_only=3DFalse):
> >           return func_wrapper
> >       return skip_test_decorator
> > +def skip_if_root(func):
>=20
> skip_if_user_is_root() is slightly less confuse.

Ok, I can make this change.

Kevin

