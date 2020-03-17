Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CCBC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A23920714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRjCuHFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A23920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEL07-0006bz-KX
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 18:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jEKzH-0006CB-Cj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jEKzF-0003Qt-JA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:47:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jEKzF-0003Ns-Dk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584485220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WBXt7T9CF1zfcLhUsrGUyeKYQkAmFkOOAYap4NK9n7Y=;
 b=YRjCuHFj5VYy/KIWbjX3Vj54lcklj7F+DW+nfk9/7+ke0jyMUBdZ7UU2hf33qnKulxTnbb
 PjRSBgoeLq3wjw5CJ/b/eGOzxFJUDIbjsuJBhQb/yQxvcJVahKTDXmfvBWrSF0e/BGX02V
 4A8DVwBnCqE91l9IADdmlaaxfCS0K1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-swkI6xwvNEKRHX1I_irTxQ-1; Tue, 17 Mar 2020 18:46:58 -0400
X-MC-Unique: swkI6xwvNEKRHX1I_irTxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6777F18B5FA1;
 Tue, 17 Mar 2020 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-2.rdu2.redhat.com [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E73FE5C1BB;
 Tue, 17 Mar 2020 22:46:50 +0000 (UTC)
Date: Tue, 17 Mar 2020 18:46:48 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/4] tests/vm: write raw console log
Message-ID: <20200317224648.GB104204@localhost.localdomain>
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-2-kraxel@redhat.com>
 <87wo7kjsfp.fsf@linaro.org>
 <80b6dd22-aae9-268f-21a9-7add0dd3fa51@redhat.com>
MIME-Version: 1.0
In-Reply-To: <80b6dd22-aae9-268f-21a9-7add0dd3fa51@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 03:22:07PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 3/16/20 3:16 PM, Alex Benn=E9e wrote:
> >=20
> > Gerd Hoffmann <kraxel@redhat.com> writes:
> >=20
> > > Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
> > > to watch the install console.
> > >=20
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >=20
> > I suspect this is what's breaking "make check-acceptance" so I've
> > dropped the series from testing/next for now.
> >
> >    2020-03-11 12:12:30,546 stacktrace       L0039 ERROR|
> >    2020-03-11 12:12:30,546 stacktrace       L0042 ERROR| Reproduced tra=
ceback from: /home/alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/pyth=
on3.6/site-packages/avocado/c\
> >    ore/test.py:860
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| Traceback (mos=
t recent call last):
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/=
alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-packages=
/avocado/core/test.py", line \
> >    1456, in test
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     self.error=
(self.exception)
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/=
alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-packages=
/avocado/core/test.py", line \
> >    1064, in error
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     raise exce=
ptions.TestError(message)
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| avocado.core.e=
xceptions.TestError: Traceback (most recent call last):
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/l=
ib/python3.6/imp.py", line 235, in load_module
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     return loa=
d_source(name, filename, file)
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/l=
ib/python3.6/imp.py", line 172, in load_source
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     module =3D=
 _load(spec)
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froze=
n importlib._bootstrap>", line 684, in _load
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froze=
n importlib._bootstrap>", line 665, in _load_unlocked
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froze=
n importlib._bootstrap_external>", line 678, in exec_module
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<froze=
n importlib._bootstrap>", line 219, in _call_with_frames_removed
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/=
alex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/machine_mips_malta.py=
", line 15, in <module>
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from avoca=
do_qemu import Test
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/=
alex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__=
.py", line 22, in <module>
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu.=
machine import QEMUMachine
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/=
alex.bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/../../..=
/python/qemu/machine.py", lin\
> >    e 27, in <module>
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu.=
console_socket import ConsoleSocket
> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| ModuleNotFound=
Error: No module named 'qemu.console_socket'
>=20
> Cc'ing Wainer/Cleber in case...
>

I've applied the "[PATCH v4 00/10] tests/vm: Add support for aarch64
VMs" series and this patch (on top of d649689a8) and could not
replicate this issue with "make check-acceptance".

Maybe I'm missing some other patch?

- Cleber.

> >    2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|
> >    2020-03-11 12:12:30,547 stacktrace       L0046 ERROR|
> >    2020-03-11 12:12:30,548 test             L0865 DEBUG| Local variable=
s:
> >    2020-03-11 12:12:30,561 test             L0868 DEBUG|  -> self <clas=
s 'avocado.core.test.TestError'>: 1-./tests/acceptance/machine_mips_malta.p=
y:MaltaMachineFramebuffer.tes\
> >    t_mips_malta_i6400_framebuffer_logo_1core
> >=20
> >=20
> > > ---
> > >   tests/vm/basevm.py | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > > index 8400b0e07f65..c53fd354d955 100644
> > > --- a/tests/vm/basevm.py
> > > +++ b/tests/vm/basevm.py
> > > @@ -213,6 +213,9 @@ class BaseVM(object):
> > >       def console_init(self, timeout =3D 120):
> > >           vm =3D self._guest
> > >           vm.console_socket.settimeout(timeout)
> > > +        self.console_raw_path =3D os.path.join(vm._temp_dir,
> > > +                                             vm._name + "-console.ra=
w")
> > > +        self.console_raw_file =3D open(self.console_raw_path, 'wb')
> > >       def console_log(self, text):
> > >           for line in re.split("[\r\n]", text):
> > > @@ -234,6 +237,9 @@ class BaseVM(object):
> > >           while True:
> > >               try:
> > >                   chars =3D vm.console_socket.recv(1)
> > > +                if self.console_raw_file:
> > > +                    self.console_raw_file.write(chars)
> > > +                    self.console_raw_file.flush()
> > >               except socket.timeout:
> > >                   sys.stderr.write("console: *** read timeout ***\n")
> > >                   sys.stderr.write("console: waiting for: '%s'\n" % e=
xpect)
> >=20
> >=20
>=20

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5xU1UACgkQZX6NM6Xy
CfPhcw//fr5k12M7COb3jSwa6gWyvK5X9o3kBAWuy66NsgO0xhbxbsGwx4CQSidC
e5HpPK/8Gwa8XPspFzLqRTVNvk17mx8V+x8f0dVwcaiFzMeYXutNxlB8iK2M2T88
vkgRnk2XN/3cK0ZzXv3pLL0+6B2ZTZMIyN8o+Kg+gXotZDACWKgv9wWWUqd86OTV
uWYs+Jd9Su6z8W22M5YRCYzkARe4rQHJCuOv+7Km30CgfO+FoZvM2WBzOJAzQYVn
16iTXcejtKebfbas4MuhtfvVQRkE4d2CJTtLHjRSpOdHlgPQrdo7qnobX5bEN8rh
/SPWORO0+8rEezIMaLEtTz7HLyAg8ibpSlxG6MrHC0O786jHnDY4t+4cF9WP8BnW
Qv9m26M0EngBR5TFrZ2Q5nLx3syIkhmyv8WQ0Sl8OQW2nrMSBLJubYfkgv2vIJB8
1Wu+DxinJ/OfoRbfZF4IevCmpL6dmr75VanAKDMA5rNcc08DlxnPE2f1OspyH54R
yHvppMT4kHsdU2yASUBYobmtPVB3/WLWQf+Liu/I5N1pwKHNqhvumdCvfvohWdfn
GbGtse3QD5+l10EoRfzUJ+8r3hTPGz8J4ZMfvWQJiQ8V+ElsKIfmOySzJCVAe6tK
EklM6nttXbNjwA366w6yl3Bkjt7ou1i5L85xaLMuAJ+i/CtnyDc=
=E/oF
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--


