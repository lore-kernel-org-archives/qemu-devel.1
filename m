Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD0FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C9F2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQKKA7qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C9F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlJSs-0008Md-Qt
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 17:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jlJSF-0007h5-Eb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 17:49:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jlJS9-0002Qs-Vh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 17:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592344148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+U4bAwG8kqdE9/lz0OeHlyzSZXrgqJm1dLs+hjkex4k=;
 b=ZQKKA7qL0bGW0SOtg3loBDaUjdY4wOLtWruJvVQqdXWIAEwk3I4RY3AHKinpczRVGVrmW5
 HgZtoCkbZTmjrFKoHmIpRUfSmP1sFaAbxSNsSsLpSrXyAKv7I3rEXOrfwbJWUw60TQujLx
 41P34TVvh440L5U+sZRWQSTRXViI7AE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-lwl2HqdAO5a1MdXUvLb-0g-1; Tue, 16 Jun 2020 17:49:04 -0400
X-MC-Unique: lwl2HqdAO5a1MdXUvLb-0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7359D872FF2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-214.rdu2.redhat.com
 [10.10.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82EC67CAA5;
 Tue, 16 Jun 2020 21:49:02 +0000 (UTC)
Date: Tue, 16 Jun 2020 17:49:00 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
Message-ID: <20200616214900.GA347659@localhost.localdomain>
References: <20200604195252.20739-1-jsnow@redhat.com>
 <8bd27ec8-1bb6-45e2-a43a-7e0229065414@redhat.com>
 <4012de28-5837-889a-eda1-b9957cbbbad1@redhat.com>
 <5d20012b-923c-0bf4-232d-272977087fe3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5d20012b-923c-0bf4-232d-272977087fe3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 WEIRD_PORT=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 05:21:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/9/20 11:55 PM, John Snow wrote:
> >=20
> >=20
> > On 6/9/20 9:08 AM, Philippe Mathieu-Daud=E9 wrote:
> >> Hi John,
> >>
> >> On 6/4/20 9:52 PM, John Snow wrote:
> >>> v3:
> >>>  - Split _post_shutdown refactor into own patch (now 1/3)
> >>>  - Re-add sigkill warning squelch (now 3/3)
> >>>
> >>> NOTE: I re-added the squelch in its own patch for review purposes, bu=
t
> >>> for the purposes of avoiding temporary breakage, a maintainer may wis=
h
> >>> to squash patches 2 and 3 if they are accepted.
> >>>
> >>> v2: Philippe took patches 1, 3 and 4.
> >>>
> >>> This is a re-write of what was:
> >>> [PATCH RFC 03/32] python//machine.py: remove bare except
> >>> [PATCH 2/4] python/machine.py: remove bare except
> >>>
> >>> It's a bit heavier handed, but it should address some of kwolf's
> >>> feedback from the RFC version.
> >>>
> >>> Applies straight to origin/master, ought to pass pylint and flake8:
> >>>
> >>>> cd ~/src/qemu/python/qemu
> >>>> pylint *.py
> >>>> flake8 *.py
> >>>
> >>> John Snow (3):
> >>>   python/machine.py: consolidate _post_shutdown()
> >>>   python/machine.py: refactor shutdown
> >>>   python/machine.py: re-add sigkill warning suppression
> >>>
> >>>  python/qemu/machine.py | 100 +++++++++++++++++++++++++++++----------=
--
> >>>  1 file changed, 71 insertions(+), 29 deletions(-)
> >>>
> >>
> >> I'm now seeing this error:
> >>
> >> 21:31:58 DEBUG| / # reboot
> >> 21:32:01 DEBUG| / # reboot: Restarting system
> >> 21:32:01 DEBUG| >>> {'execute': 'quit'}
> >> 21:32:01 WARNI| qemu received signal 9; command:
> >> "mips-softmmu/qemu-system-mips -display none -vga none -chardev
> >> socket,id=3Dmon,path=3D/tmp/tmp679upvrk/qemu-10292-monitor.sock -mon
> >> chardev=3Dmon,mode=3Dcontrol -machine malta -chardev
> >> socket,id=3Dconsole,path=3D/tmp/tmp679upvrk/qemu-10292-console.sock,se=
rver,nowait
> >> -serial chardev:console -kernel
> >> /tmp/avocado_b3aaagr9/avocado_job_5bj0xe1h/12-tests_acceptance_boot_li=
nux_console.py_BootLinuxConsole.test_mips_malta_cpio/boot/vmlinux-4.5.0-2-4=
kc-malta
> >> -initrd
> >> /tmp/avocado_b3aaagr9/avocado_job_5bj0xe1h/12-tests_acceptance_boot_li=
nux_console.py_BootLinuxConsole.test_mips_malta_cpiorootfs.cpio
> >> -append printk.time=3D0 console=3DttyS0 console=3Dtty rdinit=3D/sbin/i=
nit
> >> noreboot -no-reboot"
> >> 21:32:01 ERROR|
> >> 21:32:01 ERROR| Reproduced traceback from:
> >> /home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-pac=
kages/avocado/core/test.py:886
> >> 21:32:01 ERROR| Traceback (most recent call last):
> >> 21:32:01 ERROR|   File
> >> "/home/travis/build/philmd/qemu/build/tests/acceptance/avocado_qemu/__=
init__.py",
> >> line 195, in tearDown
> >> 21:32:01 ERROR|     vm.shutdown()
> >> 21:32:01 ERROR|   File
> >> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 449, in
> >> shutdown
> >> 21:32:01 ERROR|     self._do_shutdown(has_quit)
> >> 21:32:01 ERROR|   File
> >> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 426, in
> >> _do_shutdown
> >> 21:32:01 ERROR|     self._soft_shutdown(has_quit, timeout)
> >> 21:32:01 ERROR|   File
> >> "/home/travis/build/philmd/qemu/python/qemu/machine.py", line 413, in
> >> _soft_shutdown
> >> 21:32:01 ERROR|     self._qmp.cmd('quit')
> >> 21:32:01 ERROR|   File
> >> "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 271, in cmd
> >> 21:32:01 ERROR|     return self.cmd_obj(qmp_cmd)
> >> 21:32:01 ERROR|   File
> >> "/home/travis/build/philmd/qemu/python/qemu/qmp.py", line 249, in cmd_=
obj
> >> 21:32:01 ERROR|     self.__sock.sendall(json.dumps(qmp_cmd).encode('ut=
f-8'))
> >> 21:32:01 ERROR| BrokenPipeError: [Errno 32] Broken pipe
> >> 21:32:01 ERROR|
> >> 21:32:01 DEBUG| DATA (filename=3Doutput.expected) =3D> NOT FOUND (data
> >> sources: variant, test, file)
> >> 21:32:01 DEBUG| DATA (filename=3Dstdout.expected) =3D> NOT FOUND (data
> >> sources: variant, test, file)
> >> 21:32:01 DEBUG| DATA (filename=3Dstderr.expected) =3D> NOT FOUND (data
> >> sources: variant, test, file)
> >> 21:32:01 DEBUG| Not logging /var/log/syslog (lack of permissions)
> >> 21:32:01 ERROR| ERROR
> >> 12-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_m=
alta_cpio
> >> -> TestSetupFail: [Errno 32] Broken pipe
> >> 21:32:01 INFO |
> >>
> >> https://travis-ci.org/github/philmd/qemu/jobs/696142277#L5329
> >>
> >=20
> > Gotcha.
> >=20
> > The problem here is that `test_mips_malta_cpio` in boot_linux_console.p=
y
> > does this:
> >=20
> >         self.vm.add_args('-kernel', kernel_path,
> >                          '-initrd', initrd_path,
> >                          '-append', kernel_command_line,
> >                          '-no-reboot')
> >=20
> > and then:
> >=20
> > exec_command_and_wait_for_pattern(self, 'reboot',
> >                          'reboot: Restarting system')
> >=20
> > and (in avocado_qemu/) __init__.py does this:
> >=20
> >     def tearDown(self):
> >         for vm in self._vms.values():
> >             vm.shutdown()
> >=20
> >=20
> >=20
> > What's happening here is that we are instructing QEMU to *close* when
> > the guest reboots instead of allowing it to reboot. Then, we are issuin=
g
> > a reboot command to the guest, which will effectively terminate QEMU as
> > well. Finally, we are trying to send a shutdown command to QEMU, but
> > QEMU has already gone.
> >=20
> > Now, in the shutdown code, we do make an attempt to catch this:
> >=20
> > def is_running(self):
> >     """Returns true if the VM is running."""
> >     return self._popen is not None and self._popen.poll() is None
> >=20
> > But, well, race conditions.
> >=20
> > When we make it here:
> >=20
> >         if self._qmp is not None:
> >             if not has_quit:
> >                 self._qmp.cmd('quit')
> >             self._qmp.close()
> >=20
> > We believe we are running and we believe we have an open QMP socket.
> > Attempting to engage the socket by sending 'quit' causes the error.
> >=20
> > It's a tight window: if quit happens earlier, we send the command
> > successfully and everything's OK. If quit happens later, we realize QEM=
U
> > isn't running and proceed to cleanup.
>=20
> Nice debugging :)
>=20
> >=20
> > Ultimately:
> >=20
> > - Avocado should not try to shut down QEMU twice, but
> > - machine.py shouldn't enable the race condition either.
> >=20
> >=20
> >=20
> > for my part, how about this:
> >=20
> > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > index 99bcb499878..813f8e477db 100644
> > --- a/python/qemu/machine.py
> > +++ b/python/qemu/machine.py
> > @@ -385,7 +385,14 @@ def _soft_shutdown(self, has_quit: bool =3D False,
> > timeout: int =3D 3) -> None:
> >=20
> >          if self._qmp is not None:
> >              if not has_quit:
> > -                self._qmp.cmd('quit')
> > +                try:
> > +                    self._qmp.cmd('quit')
> > +                except (BrokenPipeError, ConnectionResetError):
> > +                    # QMP went away just before or just after sending
> > 'quit'
> > +                    if not self.is_running():
> > +                        # "Mission Accomplished"
> > +                        pass
> > +                    raise
>=20
> Looks OK to me, Cleber/Eduardo can you Ack?
>

John's description seems spot on, and so does the solution.  I was
unable, though, to reproduce it given that the window is indeed tiny.

Phil,

In addition to this, wouldn't it make sense to:

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index 3d02519660..e117597e3b 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -180,8 +180,8 @@ class BootLinuxConsole(LinuxKernelTest):
                                + 'rdinit=3D/sbin/init noreboot')
         self.vm.add_args('-kernel', kernel_path,
                          '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
+                         '-append', kernel_command_line)
+
         self.vm.launch()
         self.wait_for_console_pattern('Boot successful.')
=20
@@ -189,8 +189,8 @@ class BootLinuxConsole(LinuxKernelTest):
                                                 'BogoMIPS')
         exec_command_and_wait_for_pattern(self, 'uname -a',
                                                 'Debian')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system=
')
+        exec_command_and_wait_for_pattern(self, 'halt',
+                                                'reboot: System halted')
=20
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
     def test_mips64el_malta_5KEc_cpio(self):

Do you know of any reason to "fake halt" (reboot) instead of actually
halting from the guests?

> >              self._qmp.close()
> >=20
> >          self._popen.wait(timeout=3Dtimeout)
> >=20
>=20

Either way (^ with this extra block):

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl7pPkcACgkQZX6NM6Xy
CfN7/BAAojONS4dM2ki+M/qVh0lWtoG6JRdk87JwGCCE2MvGrOENsdjdjoaFILcQ
oOcEQWPKVknmec6zShyL97SzCZqT6CuqpLMhWRAEqg0O2CClaD0Vogz0t2X/XpnH
0k3BOXuMTijdEro4EFt2p+mmrfy8HblpU2Pa7/YZ9aHyT5uOXNxtktw2nXULz3DL
Es5UypfNaTQ80/DN24UkItPOsf9ffw/9l2PqAIJqIuf4a+w9SqUqVHsbo8gw5Tlk
wcyFNCKX2l7r03rqs4mu3q1Gi7wOwaqzCxFd3yFfQfmwatCc5OVyMqrBxPdN3GkG
n46kMhBSsbMtSkgHfckOlMNeQyqw6eJcyApMnsItmlaVMCuF4c359X/0t/maJOrZ
5Bhta9TEwMRtNEdadYaL2+hb9jUyynMQSe9KwWEs/+45u1NIp+JbjwHiZEBfDK2Y
++kEDWaJNHYpcWyRsP32wKQ44mvXQi5oBU3isTorYI8I8ZdlO+OIzga81OXlrvuI
I82jngSsQtJ0lDRgOi6Qw1k7M/NsgCLPqKyfRU6gWmAFRRTkt0G6vPtwoR6JB4nH
nGGA9ZrGkPCVNlrtTyw1QddZurdPZNVke1MSwREjMH9b4aexIPjeDP1PH0t6nHsl
kWRI3BZLlnlfeLeCoDtB+v3Zx8VDd93OqizbDI1o4NExGd3aSt4=
=pr/9
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--


