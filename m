Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A3C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595FB20879
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595FB20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRakT-0000uw-Hk
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:10:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hRaff-0004ky-TX
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hRac2-0001eb-I3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hRabx-00014Q-1Q; Fri, 17 May 2019 07:01:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E556B30C1AF9;
	Fri, 17 May 2019 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-213.ams2.redhat.com
	[10.36.116.213])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 042845D9CD;
	Fri, 17 May 2019 11:00:39 +0000 (UTC)
Date: Fri, 17 May 2019 13:00:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190517110038.GD7009@localhost.localdomain>
References: <20190517095628.10119-1-mreitz@redhat.com>
	<20190517095628.10119-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517095628.10119-4-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 17 May 2019 11:00:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] iotests: Test driver whitelisting in
 093
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.05.2019 um 11:56 hat Max Reitz geschrieben:
> null-aio may not be whitelisted.  If it is not, fall back to null-co.
> This may run tests twice in the same configuration, but this is the
> simplest way to effectively skip the tests in setUp() (without changing
> the output, and while having the respective driver in a class
> attribute).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/093 | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
> index bd56c94708..d6f285001a 100755
> --- a/tests/qemu-iotests/093
> +++ b/tests/qemu-iotests/093
> @@ -22,9 +22,11 @@
>  import iotests
> =20
>  nsec_per_sec =3D 1000000000
> +supported_null_drivers =3D list(filter(lambda f: f.startswith('null-')=
,
> +                                     iotests.supported_formats()))

Is this just a convoluted way of writing the following?

    supported_null_drivers =3D [ f for f in iotests.supported_formats()
                               if f.startswith('null-') ]

>  class ThrottleTestCase(iotests.QMPTestCase):
> -    test_img =3D "null-aio://"
> +    test_driver =3D "null-aio"
>      max_drives =3D 3
> =20
>      def blockstats(self, device):
> @@ -36,9 +38,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
>          raise Exception("Device not found for blockstats: %s" % device=
)
> =20
>      def setUp(self):
> +        global supported_null_drivers
> +        if self.test_driver not in supported_null_drivers:
> +            # Silently fall back to supported driver
> +            self.test_driver =3D supported_null_drivers[0]

I think this is what you mentioned in the cover letter:

> Final note: The best thing would probably to skip the null-aio tests in
> 093/136 if there is no null-aio support.  However, I didn=E2=80=99t get=
 anything
> to work: Annotating with @iotests.skip_if_unsupported() didn=E2=80=99t =
work
> because the format name is a class instance attribute; and just
> iotests.skipTest() didn=E2=80=99t work because that would print 's' cha=
racters
>  instead of '.' in the output (and emit the number of skipped tests), s=
o
> the comparison against the reference output fails...

With a little modification to the @skip_if_unsupported() decorator it
can be done. I think I'd prefer this (hacked up on top of this series):

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index f811f69135..f83d56b156 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -789,8 +789,11 @@ def skip_if_unsupported(required_formats=3D[], read_=
only=3DFalse):
        Runs the test if all the required formats are whitelisted'''
     def skip_test_decorator(func):
         def func_wrapper(*args, **kwargs):
-            usf_list =3D list(set(required_formats) -
-                            set(supported_formats(read_only)))
+            if callable(required_formats):
+                fmts =3D required_formats(args[0])
+            else:
+                fmts =3D required_formats
+            usf_list =3D list(set(fmts) - set(supported_formats(read_onl=
y)))
             if usf_list:
                 case_notrun('{}: formats {} are not whitelisted'.format(
                     args[0], usf_list))
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index d6f285001a..e23a8189bc 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -22,8 +22,6 @@
 import iotests

 nsec_per_sec =3D 1000000000
-supported_null_drivers =3D list(filter(lambda f: f.startswith('null-'),
-                                     iotests.supported_formats()))

 class ThrottleTestCase(iotests.QMPTestCase):
     test_driver =3D "null-aio"
@@ -37,11 +35,12 @@ class ThrottleTestCase(iotests.QMPTestCase):
                 return stat['rd_bytes'], stat['rd_operations'], stat['wr=
_bytes'], stat['wr_operations']
         raise Exception("Device not found for blockstats: %s" % device)

+    def required_driver(self):
+        return self.test_driver
+
     def setUp(self):
-        global supported_null_drivers
-        if self.test_driver not in supported_null_drivers:
-            # Silently fall back to supported driver
-            self.test_driver =3D supported_null_drivers[0]
+        if not self.required_driver() in iotests.supported_formats():
+            return

         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
@@ -49,6 +48,9 @@ class ThrottleTestCase(iotests.QMPTestCase):
         self.vm.launch()

     def tearDown(self):
+        if not self.required_driver() in iotests.supported_formats():
+            return
+
         self.vm.shutdown()

     def configure_throttle(self, ndrives, params):
@@ -145,6 +147,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
         self.vm.qtest("clock_step %d" % ns)

     # Connect N drives to a VM and test I/O in all of them
+    @iotests.skip_if_unsupported(required_driver)
     def test_all(self):
         params =3D {"bps": 4096,
                   "bps_rd": 4096,
@@ -163,6 +166,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
                 self.do_test_throttle(ndrives, 5, limits)

     # Connect N drives to a VM and test I/O in just one of them a time
+    @iotests.skip_if_unsupported(required_driver)
     def test_one(self):
         params =3D {"bps": 4096,
                   "bps_rd": 4096,
@@ -180,6 +184,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
                 self.configure_throttle(self.max_drives, limits)
                 self.do_test_throttle(1, 5, limits, drive)

+    @iotests.skip_if_unsupported(required_driver)
     def test_burst(self):
         params =3D {"bps": 4096,
                   "bps_rd": 4096,
@@ -218,6 +223,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
     # Test that removing a drive from a throttle group should not
     # affect the remaining members of the group.
     # https://bugzilla.redhat.com/show_bug.cgi?id=3D1535914
+    @iotests.skip_if_unsupported(required_driver)
     def test_remove_group_member(self):
         # Create a throttle group with two drives
         # and set a 4 KB/s read limit.
@@ -433,6 +439,6 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase)=
:


 if __name__ =3D=3D '__main__':
-    if 'null-co' not in supported_null_drivers:
+    if 'null-co' not in iotests.supported_formats():
         iotests.notrun('null-co driver support missing')
     iotests.main(supported_fmts=3D["raw"])

