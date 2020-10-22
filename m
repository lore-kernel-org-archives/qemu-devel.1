Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LH_URI_DOM_IN_PATH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE9BC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E0D2463D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrURKg8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E0D2463D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVcpa-00030R-Bg
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kVcoI-0001tF-Sh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kVcoF-0007Uk-Kp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603381639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PuWL38tAX9hEki36m9sZhQhmIKpWB6GrCgJBaQyywQ=;
 b=MrURKg8Q6b3OrDl79aWrO9BfIQv9gNyHjyeO9PRihLCFCNos7dCFNfVZP9KGfKhsMKCxh6
 BjqweVmpqRRsugWfOJBFWqRdIzWjnIjdQ/v3mvktHFZo039X/48wm1u+T8iToXhZ1xlSmX
 tMGylzdC1PrxTilLKaHQja06d4A0FWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ElYOLLu4OkevYo2uaR2NDw-1; Thu, 22 Oct 2020 11:47:15 -0400
X-MC-Unique: ElYOLLu4OkevYo2uaR2NDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D96AF894C21;
 Thu, 22 Oct 2020 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E18185D9F1;
 Thu, 22 Oct 2020 15:46:59 +0000 (UTC)
Date: Thu, 22 Oct 2020 11:46:58 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 6/6] tests/acceptance: pick a random gdb port for
 reverse debugging
Message-ID: <20201022154658.GB1861304@localhost.localdomain>
References: <20201021163136.27324-1-alex.bennee@linaro.org>
 <20201021163136.27324-7-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201021163136.27324-7-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LH_URI_DOM_IN_PATH=1.534, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 05:31:36PM +0100, Alex Benn=E9e wrote:
> Currently the test randomly fails if you are using a shared machine
> due to contention on the well known port 1234. We can ameliorate this
> a bit by picking a random non-ephemeral port although it doesn't
> totally avoid the problem. While we could use a totally unique socket
> address for debugging it's impossible to probe for gdb support of the
> feature which makes this a sub-optimal but less fiddly option.
>

Hi Alex,

This is already a clear improvement, so consider my points as suggestions.

> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/acceptance/reverse_debugging.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/rev=
erse_debugging.py
> index b72fdf6cdc..f2e8245471 100644
> --- a/tests/acceptance/reverse_debugging.py
> +++ b/tests/acceptance/reverse_debugging.py
> @@ -16,6 +16,7 @@ from avocado.utils import gdb
>  from avocado.utils import process
>  from avocado.utils.path import find_command
>  from boot_linux_console import LinuxKernelTest
> +from random import randrange

Avocado ships with a "avocado.utils.network.ports.find_free_port" utility:

   https://avocado-framework.readthedocs.io/en/81.0/api/utils/avocado.utils=
.network.html#avocado.utils.network.ports.find_free_port

Which *minimizes* the possibility of a clash by checking if the port
is available.  I think it's worth to consider using it.

> =20
>  class ReverseDebugging(LinuxKernelTest):
>      """
> @@ -43,7 +44,8 @@ class ReverseDebugging(LinuxKernelTest):
>          else:
>              logger.info('replaying the execution...')
>              mode =3D 'replay'
> -            vm.add_args('-s', '-S')
> +            self.port =3D randrange(2048, 49152)
> +            vm.add_args('-gdb', 'tcp::%d' % (self.port), '-S')

It's a good idea to try to avoid setting instance attributes outside
of __init__().  In this specific case, I'd just add a "port" parameter
to run_vm().

>          vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s,rrsnapsho=
t=3Dinit' %
>                      (shift, mode, replay_path),
>                      '-net', 'none')
> @@ -122,7 +124,7 @@ class ReverseDebugging(LinuxKernelTest):
>          # replay and run debug commands
>          vm =3D self.run_vm(False, shift, args, replay_path, image_path)
>          logger.info('connecting to gdbstub')
> -        g =3D gdb.GDBRemote('127.0.0.1', 1234, False, False)
> +        g =3D gdb.GDBRemote('127.0.0.1', self.port, False, False)
>          g.connect()
>          r =3D g.cmd(b'qSupported')
>          if b'qXfer:features:read+' in r:
> --=20
> 2.20.1
>=20


So, the overall diff of my suggestions look like:

---
diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/rever=
se_debugging.py
index f2e8245471..3d91dfaa8f 100644
--- a/tests/acceptance/reverse_debugging.py
+++ b/tests/acceptance/reverse_debugging.py
@@ -14,9 +14,10 @@ from avocado import skipIf
 from avocado_qemu import BUILD_DIR
 from avocado.utils import gdb
 from avocado.utils import process
+from avocado.utils.network.ports import find_free_port
 from avocado.utils.path import find_command
 from boot_linux_console import LinuxKernelTest
-from random import randrange
+
=20
 class ReverseDebugging(LinuxKernelTest):
     """
@@ -34,7 +35,7 @@ class ReverseDebugging(LinuxKernelTest):
     STEPS =3D 10
     endian_is_le =3D True
=20
-    def run_vm(self, record, shift, args, replay_path, image_path):
+    def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger =3D logging.getLogger('replay')
         vm =3D self.get_vm()
         vm.set_console()
@@ -44,8 +45,7 @@ class ReverseDebugging(LinuxKernelTest):
         else:
             logger.info('replaying the execution...')
             mode =3D 'replay'
-            self.port =3D randrange(2048, 49152)
-            vm.add_args('-gdb', 'tcp::%d' % (self.port), '-S')
+            vm.add_args('-gdb', 'tcp::%d' % port, '-S')
         vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s,rrsnapshot=
=3Dinit' %
                     (shift, mode, replay_path),
                     '-net', 'none')
@@ -111,9 +111,10 @@ class ReverseDebugging(LinuxKernelTest):
         process.run(cmd)
=20
         replay_path =3D os.path.join(self.workdir, 'replay.bin')
+        port =3D find_free_port()
=20
         # record the log
-        vm =3D self.run_vm(True, shift, args, replay_path, image_path)
+        vm =3D self.run_vm(True, shift, args, replay_path, image_path, por=
t)
         while self.vm_get_icount(vm) <=3D self.STEPS:
             pass
         last_icount =3D self.vm_get_icount(vm)
@@ -122,9 +123,9 @@ class ReverseDebugging(LinuxKernelTest):
         logger.info("recorded log with %s+ steps" % last_icount)
=20
         # replay and run debug commands
-        vm =3D self.run_vm(False, shift, args, replay_path, image_path)
+        vm =3D self.run_vm(False, shift, args, replay_path, image_path, po=
rt)
         logger.info('connecting to gdbstub')
-        g =3D gdb.GDBRemote('127.0.0.1', self.port, False, False)
+        g =3D gdb.GDBRemote('127.0.0.1', port, False, False)
         g.connect()
         r =3D g.cmd(b'qSupported')
         if b'qXfer:features:read+' in r:
---

Regards,
- Cleber.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+RqW8ACgkQZX6NM6Xy
CfPasA//TBxNn2zo7B38sDMCowXL0wk2YseCsrBB1tKlPGerW7LXAqKtttsY/9Po
nWeZPxtkSZ8I/BY1klYwqGjJ+YusEj6Glqa84o9Mpf9L6bOvqRRkKHBZYPGWTcw0
pDnAk6AQySDtWBZPLRr3Stni2iZAqAmTbWBJ1/e/h7EkmQdztyXGiqrPhZnmeJWG
Hh11a8EZPRdglNwoFtrY+1zOKUrA+OtcFGhtZuDLFn1Od95dDrXBWpQgsufGtF+q
CSo+OV40oeO6xwM99hmeCifU8sjpKLuCtUGbFM3hYWgKogij+X20ePOl/djqMl1v
Huykg1lBPKmKs6mmZJFDd7UNTcvnM4YiR7AkCl5lfYBgrxLwzZ/tpYQXEtN7y1g2
kcNyojKHScPL778k+XvFImvZvle4EDH+XXB5rz2bRTFXoG3yi1VSlVh0TY+Hvf9R
q39UrlQKdMxB2JeJqUNMywvHP8Zvn8AvJqeNEXmF1UIn8VfvpCwNCggHuQ5KF2NM
8HOYrvGR3FoK+k1VgkFZGCqmJbVgeomeVgNYNnOQ1i3bK1lm0Tbg/X1wil52G/06
41Tvi/CnghOgMNBzjLuC7cZ/5Vbt2Bug0C/5NBYllii6Wc2Tb6rJ2qyTvFyysdlg
eEljsR2URwD5vWh27qiA7XI30Q36ow6pRF5/XibDbuGPkPqGeA0=
=t9GR
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--


