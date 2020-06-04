Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EFDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D304F206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IHM9iqhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D304F206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnc3-00070y-IJ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jgnYH-000516-BJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:56:49 -0400
Received: from mout.web.de ([212.227.17.12]:40251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jgnYE-0002tA-KN
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591268173;
 bh=ZZ2M06SjTtIvbf+D/Zr3aKWFuiVWpU4Bx0/m6WYIRTk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IHM9iqhKzZZnBHxZ5qMiYLj9grpZPviRRPKp3rYsLilN4PIni2kxmqICej86+BCYK
 VAsqrCxXf0V+g2+Y399N+RbpY7opEbfhuCz/zZKLy5zt9epxjlTtdmCbkgZaVSZ9+m
 tahXuVnSgOBfIHLeMmM0HGo86fXcjUNgdZiKXQuk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.31]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFt8s-1jmrpT1Peg-00Es7Q; Thu, 04
 Jun 2020 12:56:13 +0200
Date: Thu, 4 Jun 2020 12:55:55 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 3/5] colo: Introduce high-level test suite
Message-ID: <20200604125555.15e9a171@luklap>
In-Reply-To: <fa2f9239-a1f0-0c38-0d1e-1fee77a28811@redhat.com>
References: <cover.1589199922.git.lukasstraub2@web.de>
 <9ebbc340436b2b60c27bdb1fc5d47734d9854514.1589199922.git.lukasstraub2@web.de>
 <fa2f9239-a1f0-0c38-0d1e-1fee77a28811@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rrGzCrPAVLYDxrwLJj97KBr";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:KJupMxfJab/rAgUvMcXKjNkAWkh+Nbu9/FAhN/eW3E84OgI7aEm
 f3pYrxOpsl2xt3xDVRIb6ja2dIZTj2rRGoHcT3TVPIQ1Dsqw7Izc23ZPxf7evZd2Jl/oaox
 hdNbqJuwcRgX6DfXWbTM8SJgjhvQfZoyAiWmNIeySoHnThn9m5QgaWRXfjPSFWQ/YU8MALV
 c+a3GVEuwJ6mpCFLoI12Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Zvch2J46vI=:7WTY8/tIRCLCT+nzwH5CeV
 JxnZHsqf5fhq7y20br8swnjRKF9tYg9dEykpmq93pY11Fi6swyLGHZ+vDHmtNdagUE5gc4xhL
 oDPYcVXuRp9ifTE3nbhFYz/U08af5I+rtwCcDtyn7nn2Q8VQLzMAex3TtbAoiIpAE1Hz2ALM5
 EdMBMu3xlsC/qpQIsZTV+CktBVyeVEcOtstMcE0jAXovYzw8E/TlyHqKd8b4GWPwV1lM4JQ8X
 EDf5HB7/uVI2osW51I6kbmth3gAIEr7w15RErrTxVSibCC7E8Glclm4HtXKlTkDDPsIJeBf0P
 xOToDZimTl1r/tb1ZT5MtVRzSncgThtjnTTCuNS47dYitiP3R83dCk904wkh/FKxUzeNeNHZh
 MalHsSTA73lm9dxWySTli2HjEKEvc46+qj98oHzQTCz1nSIj6h3VaeriSOYRnr8b3LgU92U2D
 XbQlmCO3belOZ+f/nkgkjcriXdKJlPTIqnytq6oibDBmt1MxWeXTqIYti88eH5DPImzTcoqYM
 yqueLF6TgkAE1tp354K8rCj3fPwFo/kcw1hVP+1hO7tS2wzke6i0qOWyerj9qpNaFBglR7MkD
 qhyiroG6A782Zzd3aho5n92jVnVxmEzkIf8SAq8qYmdt7iV1RmSeCytC5CN6w45YPsQHnEzUQ
 NpwLdip7Wy/0ovP9qqXDeapbpC+KGWPqga415EraAYFzlZFXf02bEmJ9VLL/lciILT+/1tKp0
 lIga6dBRFC0oCdQnIrzCZGc4LoTxAFHo10ADNaZAtafK8ZLrKBXhH1IVpKMFF4KLY1sI/5ohC
 sR1lxEJ9DxmoCYUX7lEWG6kPy4E0wS6cM5t1BfKNV8Cm/MuGzGyRxATfnIDZHMPrwmZuV6npa
 TWC8eZnWvz77awq1YfefpI/VVCQXy9QQpa+w+rCV3WW5v+GpnUbAzot7PdeDF7Pv5vT3VFbS7
 f6yL0e+AdLvUXX4Rrgp5TjMKM30zpArWEmaSfrDrCULEr00RVkhUM48B8rSe++hEQ/V+3mI/Q
 WTnOhw8A9KPADxLQaUbhOcUrsCJGKBe6tNNhSBM9WI4DArOuoMzyh28u8u5Fzje9cDrnAjTzi
 m07prbxBPvrkl0znaYPPDajbq6umkTqcrR08nQ6DBbyTJ+PIpVVD6fI9DQZyu5X/2tz/qtlkQ
 eQyMbCre6iNy15FiirvXnNSTW31Sf7aLSA/ntDdj1jTWTADu01zjH5mEUjEiqNJ9n/9c7yWgX
 Q1ezlN/fpnT4zmIG3
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 06:56:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/rrGzCrPAVLYDxrwLJj97KBr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jun 2020 14:19:08 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> +Cleber/Wainer
>=20
> On 5/11/20 2:27 PM, Lukas Straub wrote:
> > Add high-level test relying on the colo resource-agent to test
> > all failover cases while checking guest network connectivity.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  scripts/colo-resource-agent/crm_master   |  44 ++
> >  scripts/colo-resource-agent/crm_resource |  12 +
> >  tests/acceptance/colo.py                 | 689 +++++++++++++++++++++++
> >  3 files changed, 745 insertions(+)
> >  create mode 100755 scripts/colo-resource-agent/crm_master
> >  create mode 100755 scripts/colo-resource-agent/crm_resource
> >  create mode 100644 tests/acceptance/colo.py
> >=20
> > diff --git a/scripts/colo-resource-agent/crm_master b/scripts/colo-reso=
urce-agent/crm_master
> > new file mode 100755
> > index 0000000000..886f523bda
> > --- /dev/null
> > +++ b/scripts/colo-resource-agent/crm_master
> > @@ -0,0 +1,44 @@
> > +#!/bin/bash
> > +
> > +# Fake crm_master for COLO testing
> > +#
> > +# Copyright (c) Lukas Straub <lukasstraub2@web.de>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +TMPDIR=3D"$HA_RSCTMP"
> > +score=3D0
> > +query=3D0
> > +
> > +OPTIND=3D1
> > +while getopts 'Qql:Dv:N:G' opt; do
> > +    case "$opt" in
> > +        Q|q)
> > +            # Noop
> > +        ;;
> > +        "l")
> > +            # Noop
> > +        ;;
> > +        "D")
> > +            score=3D0
> > +        ;;
> > +        "v")
> > +            score=3D$OPTARG
> > +        ;;
> > +        "N")
> > +            TMPDIR=3D"$COLO_TEST_REMOTE_TMP"
> > +        ;;
> > +        "G")
> > +            query=3D1
> > +        ;;
> > +    esac
> > +done
> > +
> > +if (( query )); then
> > +    cat "${TMPDIR}/master_score" || exit 1
> > +else
> > +    echo $score > "${TMPDIR}/master_score" || exit 1
> > +fi
> > +
> > +exit 0
> > diff --git a/scripts/colo-resource-agent/crm_resource b/scripts/colo-re=
source-agent/crm_resource
> > new file mode 100755
> > index 0000000000..ad69ff3c6b
> > --- /dev/null
> > +++ b/scripts/colo-resource-agent/crm_resource
> > @@ -0,0 +1,12 @@
> > +#!/bin/sh
> > +
> > +# Fake crm_resource for COLO testing
> > +#
> > +# Copyright (c) Lukas Straub <lukasstraub2@web.de>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +# Noop
> > +
> > +exit 0
> > diff --git a/tests/acceptance/colo.py b/tests/acceptance/colo.py
> > new file mode 100644
> > index 0000000000..465513fb6c
> > --- /dev/null
> > +++ b/tests/acceptance/colo.py
> > @@ -0,0 +1,689 @@
> > +# High-level test suite for qemu COLO testing all failover cases while=
 checking
> > +# guest network connectivity
> > +#
> > +# Copyright (c) Lukas Straub <lukasstraub2@web.de>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +# HOWTO:
> > +#
> > +# This test has the following parameters:
> > +# bridge_name: name of the bridge interface to connect qemu to
> > +# host_address: ip address of the bridge interface
> > +# guest_address: ip address that the guest gets from the dhcp server
> > +# bridge_helper: path to the brige helper
> > +#                (default: /usr/lib/qemu/qemu-bridge-helper)
> > +# install_cmd: command to run to install iperf3 and memtester in the g=
uest
> > +#              (default: "sudo -n dnf -q -y install iperf3 memtester")
> > +#
> > +# To run the network tests, you have to specify the parameters.
> > +#
> > +# Example for running the colo tests:
> > +# make check-acceptance FEDORA_31_ARCHES=3D"x86_64" AVOCADO_TAGS=3D"-t=
 colo \
> > +#  -p bridge_name=3Dbr0 -p host_address=3D192.168.220.1 \
> > +#  -p guest_address=3D192.168.220.222"
> > +#
> > +# The colo tests currently only use x86_64 test vm images. With the
> > +# FEDORA_31_ARCHES make variable as in the example, only the x86_64 im=
ages will
> > +# be downloaded.
> > +#
> > +# If you're running the network tests as an unprivileged user, you nee=
d to set
> > +# the suid bit on the bridge helper (chmod +s <bridge-helper>).
> > +#
> > +# The dhcp server should assign a static ip to the guest, else the tes=
t may be
> > +# unreliable. The Mac address for the guest is always 52:54:00:12:34:5=
6.
> > +
> > +
> > +import select
> > +import sys
> > +import subprocess
> > +import shutil
> > +import os
> > +import signal
> > +import os.path
> > +import time
> > +import tempfile
> > +
> > +from avocado import Test
> > +from avocado import skipUnless
> > +from avocado.utils import network
> > +from avocado.utils import vmimage
> > +from avocado.utils import cloudinit
> > +from avocado.utils import ssh
> > +from avocado.utils.path import find_command
> > +
> > +from avocado_qemu import pick_default_qemu_bin, BUILD_DIR, SOURCE_DIR
> > +from qemu.qmp import QEMUMonitorProtocol
> > +
> > +def iperf3_available():
> > +    try:
> > +        find_command("iperf3")
> > +    except CmdNotFoundError:
> > +        return False
> > +    return True
> > +
> > +class ColoTest(Test):
> > +
> > +    # Constants
> > +    OCF_SUCCESS =3D 0
> > +    OCF_ERR_GENERIC =3D 1
> > +    OCF_ERR_ARGS =3D 2
> > +    OCF_ERR_UNIMPLEMENTED =3D 3
> > +    OCF_ERR_PERM =3D 4
> > +    OCF_ERR_INSTALLED =3D 5
> > +    OCF_ERR_CONFIGURED =3D 6
> > +    OCF_NOT_RUNNING =3D 7
> > +    OCF_RUNNING_MASTER =3D 8
> > +    OCF_FAILED_MASTER =3D 9
> > +
> > +    HOSTA =3D 10
> > +    HOSTB =3D 11
> > +
> > +    QEMU_OPTIONS =3D (" -display none -vga none -enable-kvm"
> > +                    " -smp 2 -cpu host -m 768"
> > +                    " -device e1000,mac=3D52:54:00:12:34:56,netdev=3Dh=
n0"
> > +                    " -device virtio-blk,drive=3Dcolo-disk0")
> > +
> > +    FEDORA_VERSION =3D "31"
> > +    IMAGE_CHECKSUM =3D "e3c1b309d9203604922d6e255c2c5d098a309c2d46215d=
8fc026954f3c5c27a0"
> > +    IMAGE_SIZE =3D "4294967296b"
> > +
> > +    hang_qemu =3D False
> > +    checkpoint_failover =3D False
> > +    traffic_procs =3D []
> > +
> > +    def get_image(self, temp_dir):
> > +        try:
> > +            return vmimage.get(
> > +                "fedora", arch=3D"x86_64", version=3Dself.FEDORA_VERSI=
ON,
> > +                checksum=3Dself.IMAGE_CHECKSUM, algorithm=3D"sha256",
> > +                cache_dir=3Dself.cache_dirs[0],
> > +                snapshot_dir=3Dtemp_dir)
> > +        except:
> > +            self.cancel("Failed to download/prepare image")
> > +
> > +    @skipUnless(ssh.SSH_CLIENT_BINARY, "No SSH client available")
> > +    def setUp(self):
> > +        # Qemu and qemu-img binary
> > +        default_qemu_bin =3D pick_default_qemu_bin()
> > +        self.QEMU_BINARY =3D self.params.get("qemu_bin", default=3Ddef=
ault_qemu_bin)
> > +
> > +        # If qemu-img has been built, use it, otherwise the system wid=
e one
> > +        # will be used.  If none is available, the test will cancel.
> > +        qemu_img =3D os.path.join(BUILD_DIR, "qemu-img")
> > +        if not os.path.exists(qemu_img):
> > +            qemu_img =3D find_command("qemu-img", False)
> > +        if qemu_img is False:
> > +            self.cancel("Could not find \"qemu-img\", which is require=
d to "
> > +                        "create the bootable image")
> > +        self.QEMU_IMG_BINARY =3D qemu_img =20
>=20
> Probably worth refactoring that as re-usable pick_qemuimg_bin() or
> better named?
>=20
> Similarly with BRIDGE_HELPER... We need a generic class to get binaries
> from environment or build dir.

Agreed, I think a new function pick_qemu_util similar to this code in tests=
/acceptance/avocado_qemu/__init__.py should suffice.

> > +        vmimage.QEMU_IMG =3D qemu_img
> > +
> > +        self.RESOURCE_AGENT =3D os.path.join(SOURCE_DIR,
> > +                                           "scripts/colo-resource-agen=
t/colo")
> > +        self.ADD_PATH =3D os.path.join(SOURCE_DIR, "scripts/colo-resou=
rce-agent")
> > +
> > +        # Logs
> > +        self.RA_LOG =3D os.path.join(self.outputdir, "resource-agent.l=
og")
> > +        self.HOSTA_LOGDIR =3D os.path.join(self.outputdir, "hosta")
> > +        self.HOSTB_LOGDIR =3D os.path.join(self.outputdir, "hostb")
> > +        os.makedirs(self.HOSTA_LOGDIR)
> > +        os.makedirs(self.HOSTB_LOGDIR)
> > +
> > +        # Temporary directories
> > +        # We don't use self.workdir because of unix socket path length
> > +        # limitations
> > +        self.TMPDIR =3D tempfile.mkdtemp()
> > +        self.TMPA =3D os.path.join(self.TMPDIR, "hosta")
> > +        self.TMPB =3D os.path.join(self.TMPDIR, "hostb")
> > +        os.makedirs(self.TMPA)
> > +        os.makedirs(self.TMPB)
> > +
> > +        # Network
> > +        self.BRIDGE_NAME =3D self.params.get("bridge_name")
> > +        if self.BRIDGE_NAME:
> > +            self.HOST_ADDRESS =3D self.params.get("host_address")
> > +            self.GUEST_ADDRESS =3D self.params.get("guest_address")
> > +            self.BRIDGE_HELPER =3D self.params.get("bridge_helper",
> > +                                    default=3D"/usr/lib/qemu/qemu-brid=
ge-helper")
> > +            self.SSH_PORT =3D 22
> > +        else:
> > +            # QEMU's hard coded usermode router address
> > +            self.HOST_ADDRESS =3D "10.0.2.2"
> > +            self.GUEST_ADDRESS =3D "127.0.0.1"
> > +            self.BRIDGE_HOSTA_PORT =3D network.find_free_port(address=
=3D"127.0.0.1")
> > +            self.BRIDGE_HOSTB_PORT =3D network.find_free_port(address=
=3D"127.0.0.1")
> > +            self.SSH_PORT =3D network.find_free_port(address=3D"127.0.=
0.1")
> > +
> > +        self.CLOUDINIT_HOME_PORT =3D network.find_free_port()
> > +
> > +        # Find free port range
> > +        base_port =3D 1024
> > +        while True:
> > +            base_port =3D network.find_free_port(start_port=3Dbase_por=
t,
> > +                                               address=3D"127.0.0.1")
> > +            if base_port =3D=3D None:
> > +                self.cancel("Failed to find a free port")
> > +            for n in range(base_port, base_port +4):
> > +                if n > 65535:
> > +                    break
> > +                if not network.is_port_free(n, "127.0.0.1"):
> > +                    break
> > +            else:
> > +                # for loop above didn't break
> > +                break
> > +
> > +        self.BASE_PORT =3D base_port
> > +
> > +        # Disk images
> > +        self.log.info("Downloading/preparing boot image")
> > +        self.HOSTA_IMAGE =3D self.get_image(self.TMPA).path
> > +        self.HOSTB_IMAGE =3D self.get_image(self.TMPB).path
> > +        self.CLOUDINIT_ISO =3D os.path.join(self.TMPDIR, "cloudinit.is=
o")
> > +
> > +        self.log.info("Preparing cloudinit image")
> > +        try:
> > +            cloudinit.iso(self.CLOUDINIT_ISO, self.name,
> > +                          username=3D"test", password=3D"password",
> > +                          phone_home_host=3Dself.HOST_ADDRESS,
> > +                          phone_home_port=3Dself.CLOUDINIT_HOME_PORT)
> > +        except Exception as e:
> > +            self.cancel("Failed to prepare cloudinit image")
> > +
> > +        self.QEMU_OPTIONS +=3D " -cdrom %s" % self.CLOUDINIT_ISO
> > +
> > +        # Network bridge
> > +        if not self.BRIDGE_NAME:
> > +            self.BRIDGE_PIDFILE =3D os.path.join(self.TMPDIR, "bridge.=
pid")
> > +            self.run_command(("'%s' -pidfile '%s'"
> > +                " -M none -display none -daemonize"
> > +                " -netdev user,id=3Dhost,hostfwd=3Dtcp:127.0.0.1:%s-:2=
2"
> > +                " -netdev socket,id=3Dhosta,listen=3D127.0.0.1:%s"
> > +                " -netdev socket,id=3Dhostb,listen=3D127.0.0.1:%s"
> > +                " -netdev hubport,id=3Dhostport,hubid=3D0,netdev=3Dhos=
t"
> > +                " -netdev hubport,id=3Dporta,hubid=3D0,netdev=3Dhosta"
> > +                " -netdev hubport,id=3Dportb,hubid=3D0,netdev=3Dhostb")
> > +                % (self.QEMU_BINARY, self.BRIDGE_PIDFILE, self.SSH_POR=
T,
> > +                   self.BRIDGE_HOSTA_PORT, self.BRIDGE_HOSTB_PORT), 0)
> > +
> > +    def tearDown(self):
> > +        try:
> > +            pid =3D self.read_pidfile(self.BRIDGE_PIDFILE)
> > +            if pid and self.check_pid(pid):
> > +                os.kill(pid, signal.SIGKILL)
> > +        except Exception as e:
> > +            pass
> > +
> > +        try:
> > +            self.ra_stop(self.HOSTA)
> > +        except Exception as e:
> > +            pass
> > +
> > +        try:
> > +            self.ra_stop(self.HOSTB)
> > +        except Exception as e:
> > +            pass
> > +
> > +        try:
> > +            self.ssh_close()
> > +        except Exception as e:
> > +            pass
> > +
> > +        for proc in self.traffic_procs:
> > +            try:
> > +                os.killpg(proc.pid, signal.SIGTERM)
> > +            except Exception as e:
> > +                pass
> > +
> > +        shutil.rmtree(self.TMPDIR)
> > +
> > +    def run_command(self, cmdline, expected_status, env=3DNone):
> > +        proc =3D subprocess.Popen(cmdline, shell=3DTrue, stdout=3Dsubp=
rocess.PIPE,
> > +                                stderr=3Dsubprocess.STDOUT,
> > +                                universal_newlines=3DTrue, env=3Denv)
> > +        stdout, stderr =3D proc.communicate()
> > +        if proc.returncode !=3D expected_status:
> > +            self.fail("command \"%s\" failed with code %s:\n%s"
> > +                           % (cmdline, proc.returncode, stdout))
> > +
> > +        return proc.returncode
> > +
> > +    def cat_line(self, path):
> > +        line=3D""
> > +        try:
> > +            fd =3D open(path, "r")
> > +            line =3D str.strip(fd.readline())
> > +            fd.close()
> > +        except:
> > +            pass
> > +        return line
> > +
> > +    def read_pidfile(self, pidfile):
> > +        try:
> > +            pid =3D int(self.cat_line(pidfile))
> > +        except ValueError:
> > +            return None
> > +        else:
> > +            return pid
> > +
> > +    def check_pid(self, pid):
> > +        try:
> > +            os.kill(pid, 0)
> > +        except OSError:
> > +            return False
> > +        else:
> > +            return True
> > +
> > +    def ssh_open(self):
> > +        self.ssh_conn =3D ssh.Session(self.GUEST_ADDRESS, self.SSH_POR=
T,
> > +                                    user=3D"test", password=3D"passwor=
d")
> > +        self.ssh_conn.DEFAULT_OPTIONS +=3D (("UserKnownHostsFile", "/d=
ev/null"),)
> > +        for i in range(10):
> > +            try:
> > +                if self.ssh_conn.connect():
> > +                    return
> > +            except Exception as e:
> > +                pass
> > +            time.sleep(4)
> > +        self.fail("sshd timeout")
> > +
> > +    def ssh_ping(self):
> > +        if self.ssh_conn.cmd("echo ping").stdout !=3D b"ping\n":
> > +            self.fail("ssh ping failed")
> > +
> > +    def ssh_close(self):
> > +        self.ssh_conn.quit()
> > +
> > +    def setup_base_env(self, host):
> > +        PATH =3D os.getenv("PATH", "")
> > +        env =3D { "PATH": "%s:%s" % (self.ADD_PATH, PATH),
> > +                "HA_LOGFILE": self.RA_LOG,
> > +                "OCF_RESOURCE_INSTANCE": "colo-test",
> > +                "OCF_RESKEY_CRM_meta_clone_max": "2",
> > +                "OCF_RESKEY_CRM_meta_notify": "true",
> > +                "OCF_RESKEY_CRM_meta_timeout": "30000",
> > +                "OCF_RESKEY_qemu_binary": self.QEMU_BINARY,
> > +                "OCF_RESKEY_qemu_img_binary": self.QEMU_IMG_BINARY,
> > +                "OCF_RESKEY_disk_size": str(self.IMAGE_SIZE), =20
>=20
> We can remove IMAGE_SIZE and use a runtime filesize(HOSTA_IMAGE) instead.

I will change the resource-agent so it doesn't need OCF_RESKEY_disk_size.

> > +                "OCF_RESKEY_checkpoint_interval": "10000",
> > +                "OCF_RESKEY_base_port": str(self.BASE_PORT),
> > +                "OCF_RESKEY_debug": "2"}
> > +
> > +        if host =3D=3D self.HOSTA:
> > +            env.update({"OCF_RESKEY_options":
> > +                            ("%s -qmp unix:%s,server,nowait"
> > +                             " -drive if=3Dnone,id=3Dparent0,file=3D'%=
s'")
> > +                            % (self.QEMU_OPTIONS, self.get_qmp_sock(ho=
st),
> > +                               self.HOSTA_IMAGE),
> > +                        "OCF_RESKEY_active_hidden_dir": self.TMPA,
> > +                        "OCF_RESKEY_listen_address": "127.0.0.1",
> > +                        "OCF_RESKEY_log_dir": self.HOSTA_LOGDIR,
> > +                        "OCF_RESKEY_CRM_meta_on_node": "127.0.0.1",
> > +                        "HA_RSCTMP": self.TMPA,
> > +                        "COLO_TEST_REMOTE_TMP": self.TMPB})
> > +
> > +        else:
> > +            env.update({"OCF_RESKEY_options":
> > +                            ("%s -qmp unix:%s,server,nowait"
> > +                             " -drive if=3Dnone,id=3Dparent0,file=3D'%=
s'")
> > +                            % (self.QEMU_OPTIONS, self.get_qmp_sock(ho=
st),
> > +                               self.HOSTB_IMAGE),
> > +                        "OCF_RESKEY_active_hidden_dir": self.TMPB,
> > +                        "OCF_RESKEY_listen_address": "127.0.0.2",
> > +                        "OCF_RESKEY_log_dir": self.HOSTB_LOGDIR,
> > +                        "OCF_RESKEY_CRM_meta_on_node": "127.0.0.2",
> > +                        "HA_RSCTMP": self.TMPB,
> > +                        "COLO_TEST_REMOTE_TMP": self.TMPA})
> > +
> > +        if self.BRIDGE_NAME:
> > +            env["OCF_RESKEY_options"] +=3D \
> > +                " -netdev bridge,id=3Dhn0,br=3D%s,helper=3D'%s'" \
> > +                % (self.BRIDGE_NAME, self.BRIDGE_HELPER)
> > +        else:
> > +            if host =3D=3D self.HOSTA:
> > +                env["OCF_RESKEY_options"] +=3D \
> > +                    " -netdev socket,id=3Dhn0,connect=3D127.0.0.1:%s" \
> > +                    % self.BRIDGE_HOSTA_PORT
> > +            else:
> > +                env["OCF_RESKEY_options"] +=3D \
> > +                    " -netdev socket,id=3Dhn0,connect=3D127.0.0.1:%s" \
> > +                    % self.BRIDGE_HOSTB_PORT
> > +        return env
> > +
> > +    def ra_start(self, host):
> > +        env =3D self.setup_base_env(host)
> > +        self.run_command(self.RESOURCE_AGENT + " start", self.OCF_SUCC=
ESS, env)
> > +
> > +    def ra_stop(self, host):
> > +        env =3D self.setup_base_env(host)
> > +        self.run_command(self.RESOURCE_AGENT + " stop", self.OCF_SUCCE=
SS, env)
> > +
> > +    def ra_monitor(self, host, expected_status):
> > +        env =3D self.setup_base_env(host)
> > +        self.run_command(self.RESOURCE_AGENT + " monitor", expected_st=
atus, env)
> > +
> > +    def ra_promote(self, host):
> > +        env =3D self.setup_base_env(host)
> > +        self.run_command(self.RESOURCE_AGENT + " promote", self.OCF_SU=
CCESS,env)
> > +
> > +    def ra_notify_start(self, host):
> > +        env =3D self.setup_base_env(host)
> > +
> > +        env.update({"OCF_RESKEY_CRM_meta_notify_type": "post",
> > +                    "OCF_RESKEY_CRM_meta_notify_operation": "start"})
> > +
> > +        if host =3D=3D self.HOSTA:
> > +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "12=
7.0.0.1",
> > +                        "OCF_RESKEY_CRM_meta_notify_start_uname": "127=
.0.0.2"})
> > +        else:
> > +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "12=
7.0.0.2",
> > +                        "OCF_RESKEY_CRM_meta_notify_start_uname": "127=
.0.0.1"})
> > +
> > +        self.run_command(self.RESOURCE_AGENT + " notify", self.OCF_SUC=
CESS, env)
> > +
> > +    def ra_notify_stop(self, host):
> > +        env =3D self.setup_base_env(host)
> > +
> > +        env.update({"OCF_RESKEY_CRM_meta_notify_type": "pre",
> > +                    "OCF_RESKEY_CRM_meta_notify_operation": "stop"})
> > +
> > +        if host =3D=3D self.HOSTA:
> > +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "12=
7.0.0.1",
> > +                        "OCF_RESKEY_CRM_meta_notify_stop_uname": "127.=
0.0.2"})
> > +        else:
> > +            env.update({"OCF_RESKEY_CRM_meta_notify_master_uname": "12=
7.0.0.2",
> > +                        "OCF_RESKEY_CRM_meta_notify_stop_uname": "127.=
0.0.1"})
> > +
> > +        self.run_command(self.RESOURCE_AGENT + " notify", self.OCF_SUC=
CESS, env)
> > +
> > +    def get_pid(self, host):
> > +        if host =3D=3D self.HOSTA:
> > +            return self.read_pidfile(os.path.join(self.TMPA,
> > +                                                 "colo-test-qemu.pid"))
> > +        else:
> > +            return self.read_pidfile(os.path.join(self.TMPB,
> > +                                                 "colo-test-qemu.pid"))
> > +
> > +    def get_master_score(self, host):
> > +        if host =3D=3D self.HOSTA:
> > +            return int(self.cat_line(os.path.join(self.TMPA, "master_s=
core")))
> > +        else:
> > +            return int(self.cat_line(os.path.join(self.TMPB, "master_s=
core")))
> > +
> > +    def get_qmp_sock(self, host):
> > +        if host =3D=3D self.HOSTA:
> > +            return os.path.join(self.TMPA, "my-qmp.sock")
> > +        else:
> > +            return os.path.join(self.TMPB, "my-qmp.sock")
> > +
> > +
> > +    def kill_qemu_pre(self, host):
> > +        pid =3D self.get_pid(host)
> > +
> > +        qmp_sock =3D self.get_qmp_sock(host)
> > +
> > +        if self.checkpoint_failover:
> > +            qmp_conn =3D QEMUMonitorProtocol(qmp_sock)
> > +            qmp_conn.settimeout(10)
> > +            qmp_conn.connect()
> > +            while True:
> > +                event =3D qmp_conn.pull_event(wait=3DTrue)
> > +                if event["event"] =3D=3D "STOP":
> > +                    break
> > +            qmp_conn.close()
> > +
> > +
> > +        if pid and self.check_pid(pid):
> > +            if self.hang_qemu:
> > +                os.kill(pid, signal.SIGSTOP)
> > +            else:
> > +                os.kill(pid, signal.SIGKILL)
> > +                while self.check_pid(pid):
> > +                    time.sleep(1)
> > +
> > +    def kill_qemu_post(self, host):
> > +        pid =3D self.get_pid(host)
> > +
> > +        if self.hang_qemu and pid and self.check_pid(pid):
> > +            os.kill(pid, signal.SIGKILL)
> > +            while self.check_pid(pid):
> > +                time.sleep(1)
> > +
> > +    def prepare_guest(self):
> > +        pass
> > +
> > +    def cycle_start(self, cycle):
> > +        pass
> > +
> > +    def active_section(self):
> > +        return False
> > +
> > +    def cycle_end(self, cycle):
> > +        pass
> > +
> > +    def check_connection(self):
> > +        self.ssh_ping()
> > +        for proc in self.traffic_procs:
> > +            if proc.poll() !=3D None:
> > +                self.fail("Traffic process died")
> > +
> > +    def _test_colo(self, loop=3D1):
> > +        loop =3D max(loop, 1)
> > +        self.log.info("Will put logs in %s" % self.outputdir)
> > +
> > +        self.ra_stop(self.HOSTA)
> > +        self.ra_stop(self.HOSTB)
> > +
> > +        self.log.info("*** Startup ***")
> > +        self.ra_start(self.HOSTA)
> > +        self.ra_start(self.HOSTB)
> > +
> > +        self.ra_monitor(self.HOSTA, self.OCF_SUCCESS)
> > +        self.ra_monitor(self.HOSTB, self.OCF_SUCCESS)
> > +
> > +        self.log.info("*** Promoting ***")
> > +        self.ra_promote(self.HOSTA)
> > +        cloudinit.wait_for_phone_home(("0.0.0.0", self.CLOUDINIT_HOME_=
PORT),
> > +                                      self.name)
> > +        self.ssh_open()
> > +        self.prepare_guest()
> > +
> > +        self.ra_notify_start(self.HOSTA)
> > +
> > +        while self.get_master_score(self.HOSTB) !=3D 100:
> > +            self.ra_monitor(self.HOSTA, self.OCF_RUNNING_MASTER)
> > +            self.ra_monitor(self.HOSTB, self.OCF_SUCCESS)
> > +            time.sleep(1)
> > +
> > +        self.log.info("*** Replication started ***")
> > +
> > +        self.check_connection()
> > +
> > +        primary =3D self.HOSTA
> > +        secondary =3D self.HOSTB
> > +
> > +        for n in range(loop):
> > +            self.cycle_start(n)
> > +            self.log.info("*** Secondary failover ***")
> > +            self.kill_qemu_pre(primary)
> > +            self.ra_notify_stop(secondary)
> > +            self.ra_monitor(secondary, self.OCF_SUCCESS)
> > +            self.ra_promote(secondary)
> > +            self.ra_monitor(secondary, self.OCF_RUNNING_MASTER)
> > +            self.kill_qemu_post(primary)
> > +
> > +            self.check_connection()
> > +
> > +            tmp =3D primary
> > +            primary =3D secondary
> > +            secondary =3D tmp
> > +
> > +            self.log.info("*** Secondary continue replication ***")
> > +            self.ra_start(secondary)
> > +            self.ra_notify_start(primary)
> > +
> > +            self.check_connection()
> > +
> > +            # Wait for resync
> > +            while self.get_master_score(secondary) !=3D 100:
> > +                self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> > +                self.ra_monitor(secondary, self.OCF_SUCCESS)
> > +                time.sleep(1)
> > +
> > +            self.log.info("*** Replication started ***")
> > +
> > +            self.check_connection()
> > +
> > +            if self.active_section():
> > +                break
> > +
> > +            self.log.info("*** Primary failover ***")
> > +            self.kill_qemu_pre(secondary)
> > +            self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> > +            self.ra_notify_stop(primary)
> > +            self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> > +            self.kill_qemu_post(secondary)
> > +
> > +            self.check_connection()
> > +
> > +            self.log.info("*** Primary continue replication ***")
> > +            self.ra_start(secondary)
> > +            self.ra_notify_start(primary)
> > +
> > +            self.check_connection()
> > +
> > +            # Wait for resync
> > +            while self.get_master_score(secondary) !=3D 100:
> > +                self.ra_monitor(primary, self.OCF_RUNNING_MASTER)
> > +                self.ra_monitor(secondary, self.OCF_SUCCESS)
> > +                time.sleep(1)
> > +
> > +            self.log.info("*** Replication started ***")
> > +
> > +            self.check_connection()
> > +
> > +            self.cycle_end(n) =20
>=20
> Interesting test :)
>=20
> > +
> > +        self.ssh_close()
> > +
> > +        self.ra_stop(self.HOSTA)
> > +        self.ra_stop(self.HOSTB)
> > +
> > +        self.ra_monitor(self.HOSTA, self.OCF_NOT_RUNNING)
> > +        self.ra_monitor(self.HOSTB, self.OCF_NOT_RUNNING)
> > +        self.log.info("*** all ok ***")
> > +
> > +
> > +class ColoQuickTest(ColoTest):
> > +    """
> > +    :avocado: tags=3Dcolo
> > +    :avocado: tags=3Dquick
> > +    :avocado: tags=3Darch:x86_64
> > +    """
> > +
> > +    timeout =3D 300
> > +
> > +    def cycle_end(self, cycle):
> > +        self.log.info("Testing with peer qemu hanging"
> > +                      " and failover during checkpoint")
> > +        self.hang_qemu =3D True
> > +
> > +    def test_quick(self):
> > +        self.checkpoint_failover =3D True
> > +        self.log.info("Testing with peer qemu crashing"
> > +                      " and failover during checkpoint")
> > +        self._test_colo(loop=3D2)
> > +
> > +
> > +class ColoNetworkTest(ColoTest):
> > +
> > +    def prepare_guest(self):
> > +        install_cmd =3D self.params.get("install_cmd", default=3D
> > +                                "sudo -n dnf -q -y install iperf3 memt=
ester")
> > +        self.ssh_conn.cmd(install_cmd)
> > +        # Use two instances to work around a bug in iperf3
> > +        self.ssh_conn.cmd("iperf3 -sD; iperf3 -sD -p 5202")
> > +
> > +    def _cycle_start(self, cycle):
> > +        pass
> > +
> > +    def cycle_start(self, cycle):
> > +        self._cycle_start(cycle)
> > +        tests =3D [("", "client-to-server tcp"), ("-R", "server-to-cli=
ent tcp")]
> > +
> > +        self.log.info("Testing iperf %s" % tests[cycle % 2][1])
> > +        iperf_cmd =3D "iperf3 %s -t 60 -i 60 --connect-timeout 30000 -=
c %s" \
> > +                        % (tests[cycle % 2][0], self.GUEST_ADDRESS)
> > +        proc =3D subprocess.Popen("while %s && %s; do sleep 1; done >>=
'%s' 2>&1"
> > +                    % (iperf_cmd, iperf_cmd + " -p 5202",
> > +                    os.path.join(self.outputdir, "iperf.log")),
> > +                    shell=3DTrue, preexec_fn=3Dos.setsid, stdin=3Dsubp=
rocess.DEVNULL,
> > +                    stdout=3Dsubprocess.DEVNULL, stderr=3Dsubprocess.D=
EVNULL) =20
>=20
> So this run on the host, require the host to be Linux + iperf3
> installed. Don't we need to be privileged to run it?

Not for iperf3, but the bridge helper needs the setuid bit to be set if the=
 test runs unprivileged.

> > +        self.traffic_procs.append(proc)
> > +        time.sleep(5) # Wait for iperf to get up to speed
> > +
> > +    def cycle_end(self, cycle):
> > +        for proc in self.traffic_procs:
> > +            try:
> > +                os.killpg(proc.pid, signal.SIGTERM)
> > +                proc.wait()
> > +            except Exception as e:
> > +                pass
> > +        self.traffic_procs.clear()
> > +        time.sleep(20)
> > +
> > +class ColoRealNetworkTest(ColoNetworkTest):
> > +    """
> > +    :avocado: tags=3Dcolo
> > +    :avocado: tags=3Dslow
> > +    :avocado: tags=3Dnetwork_test
> > +    :avocado: tags=3Darch:x86_64
> > +    """
> > +
> > +    timeout =3D 900
> > +
> > +    def active_section(self):
> > +        time.sleep(300)
> > +        return False
> > +
> > +    @skipUnless(iperf3_available(), "iperf3 not available")
> > +    def test_network(self):
> > +        if not self.BRIDGE_NAME:
> > +            self.cancel("bridge options not given, will skip network t=
est")
> > +        self.log.info("Testing with peer qemu crashing and network loa=
d")
> > +        self._test_colo(loop=3D2)
> > +
> > +class ColoStressTest(ColoNetworkTest):
> > +    """
> > +    :avocado: tags=3Dcolo
> > +    :avocado: tags=3Dslow
> > +    :avocado: tags=3Dstress_test
> > +    :avocado: tags=3Darch:x86_64
> > +    """
> > +
> > +    timeout =3D 1800 =20
>=20
> How long does this test take on your hw (what CPU, to compare)?

The CPU is an Intel i7-5600U and M.2 SATA SSD (during resync the whole imag=
e is copied), here are the runtimes:
Quick test: ~200s
Network test: ~800s
Stress test: ~1300s

> > +
> > +    def _cycle_start(self, cycle):
> > +        if cycle =3D=3D 4:
> > +            self.log.info("Stresstest with peer qemu hanging, network =
load"
> > +                          " and failover during checkpoint")
> > +            self.checkpoint_failover =3D True
> > +            self.hang_qemu =3D True
> > +        elif cycle =3D=3D 8:
> > +            self.log.info("Stresstest with peer qemu crashing and netw=
ork load")
> > +            self.checkpoint_failover =3D False
> > +            self.hang_qemu =3D False
> > +        elif cycle =3D=3D 12:
> > +            self.log.info("Stresstest with peer qemu hanging and netwo=
rk load")
> > +            self.checkpoint_failover =3D False
> > +            self.hang_qemu =3D True
> > +
> > +    @skipUnless(iperf3_available(), "iperf3 not available")
> > +    def test_stress(self):
> > +        if not self.BRIDGE_NAME:
> > +            self.cancel("bridge options not given, will skip network t=
est")
> > +        self.log.info("Stresstest with peer qemu crashing, network loa=
d"
> > +                      " and failover during checkpoint")
> > +        self.checkpoint_failover =3D True
> > +        self._test_colo(loop=3D16)
> >  =20
>=20


--Sig_/rrGzCrPAVLYDxrwLJj97KBr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7Y0zsACgkQNasLKJxd
slgD/w//Qel42OWsywGhwFnCCUGnz6APg22kD2FHmW6JKsXZDh8lHlennnmiBwav
1qSsJtVWJbpWTqXCJVOho7NFZvTyLrLs2htNv214TxpOxLKiRjOe5QzJrf77yZoC
lOmCoqNQnaHY5IvBg7/1kChIXLSt5ECIF1kcBj86zNWz+oBzGsV0BbA+Kv7TitoN
xEEBoiKy6T4QIGgM9jqsojCGNoMEiKA1T6nxSvszKU/HeHAPSJDTGEj5D9RAwaUz
oAOdkNmXTQS5GmIN8fPp/UMj6xWuSxeE/QO+tC8J+6XOu6qZT2RjQGJ4WFWBO0LE
EfvFDdUVD78fPgm46s0uBgt4IjBneCpawq9QmMfmT5Bk5brRjFys+KSpJo24g3yS
mMmEa24ZsCVOv134UF7TTpue1oRcemC85VTFAM3SuI8u+xkQjI2rUmlgagCjQBvK
uPuZT9EgZZXXadXBDa5Wp3ufWWWfYqB6Xx7pwE43aY8+S4qOvtdux3FiG5WMSIdT
/KuFbaUTlObsNNv7vf/RcgfUGYNEvu45gwPzd90wqL9fyop++ao9HWM7qzo5QR1o
1clQkKMY0w9KVj9Pwipa2Rf9I3vi0RyOZBVL9NeSs73ndX3c1uqDT6MIWvSeSOo7
tTZO/fY/NcObi3GEt9+80dkIs1S/QFxV+qaYbHA8gMZZfPQqUhw=
=Wrim
-----END PGP SIGNATURE-----

--Sig_/rrGzCrPAVLYDxrwLJj97KBr--

