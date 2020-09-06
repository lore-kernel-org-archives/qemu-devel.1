Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6019CC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 14:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3BD20714
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 14:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3BD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unixzen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEvs8-000679-Hy
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 10:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kallisti5@unixzen.com>)
 id 1kEvrb-0005Um-2U
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 10:41:51 -0400
Received: from [2001:19f0:6401:8d3:5400:1ff:fe4f:75e6] (port=57680
 helo=mx.dal1.terarocket.io) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kallisti5@unixzen.com>) id 1kEvrZ-000402-D5
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 10:41:50 -0400
Received: by mx.dal1.terarocket.io (Postfix, from userid 1001)
 id E655D5E770; Sun,  6 Sep 2020 14:41:47 +0000 (UTC)
Received: from mx.dal1.terarocket.io (localhost [IPv6:::1])
 by mx.dal1.terarocket.io (Postfix) with ESMTPSA id E93D85E765
 for <qemu-devel@nongnu.org>; Sun,  6 Sep 2020 14:41:46 +0000 (UTC)
MIME-Version: 1.0
Date: Sun, 06 Sep 2020 14:41:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.13.0
From: "Alexander von Gluck IV" <kallisti5@unixzen.com>
Message-ID: <00452072441b963bd56bcc9a8b758bfc@unixzen.com>
Subject: Re: [PATCH] tests/vm: Add Haiku test based on their vagrant
 images
To: qemu-devel@nongnu.org
In-Reply-To: <20200906143439.1924930-1-kallisti5@unixzen.com>
References: <20200906143439.1924930-1-kallisti5@unixzen.com>
X-Host-Lookup-Failed: Reverse DNS lookup failed for
 2001:19f0:6401:8d3:5400:1ff:fe4f:75e6 (failed)
Received-SPF: pass client-ip=2001:19f0:6401:8d3:5400:1ff:fe4f:75e6;
 envelope-from=kallisti5@unixzen.com; helo=mx.dal1.terarocket.io
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 10:34:45
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

September 6, 2020 9:35 AM, "Alexander von Gluck IV" <kallisti5@unixzen.co=
m> wrote:=0A> Signed-off-by: Alexander von Gluck IV <kallisti5@unixzen.co=
m>=0A> ---=0A> tests/keys/vagrant | 27 +++++++++=0A> tests/keys/vagrant.p=
ub | 1 +=0A> tests/vm/basevm.py | 5 +-=0A> tests/vm/haiku.x86_64 | 121 ++=
+++++++++++++++++++++++++++++++++++++++=0A> 4 files changed, 152 insertio=
ns(+), 2 deletions(-)=0A> create mode 100644 tests/keys/vagrant=0A> creat=
e mode 100644 tests/keys/vagrant.pub=0A> create mode 100755 tests/vm/haik=
u.x86_64=0A> =0A> diff --git a/tests/keys/vagrant b/tests/keys/vagrant=0A=
> new file mode 100644=0A> index 0000000000..7d6a083909=0A> --- /dev/null=
=0A> +++ b/tests/keys/vagrant=0A> @@ -0,0 +1,27 @@=0A> +-----BEGIN RSA PR=
IVATE KEY-----=0A> +MIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz=
4TjGYe7gHzI=0A>=0A> diff --git a/tests/keys/vagrant.pub b/tests/keys/vagr=
ant.pub=0A> new file mode 100644=0A> index 0000000000..18a9c00fd5=0A> ---=
 /dev/null=0A> +++ b/tests/keys/vagrant.pub=0A> @@ -0,0 +1 @@=0A> +ssh-rs=
a=0A> AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4T=
jGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oX=0A=0AA little background information fo=
r context. These are the Vagrant SSH keys which are packed with every vag=
rant OS image and allow OS access for automation.  The python vm tester k=
nowing of these lets it leverage Vagrant OS images for testing without mu=
ch work.=0A=0A=0A=0A> --- a/tests/vm/basevm.py=0A> +++ b/tests/vm/basevm.=
py=0A> @@ -44,6 +44,7 @@ DEFAULT_CONFIG =3D {=0A> 'machine' : 'pc',=0A> '=
guest_user' : "qemu",=0A> 'guest_pass' : "qemupass",=0A> + 'root_user' : =
"root",=0A> 'root_pass' : "qemupass",=0A> 'ssh_key_file' : SSH_KEY_FILE,=
=0A> 'ssh_pub_key_file': SSH_PUB_KEY_FILE,=0A> @@ -245,13 +246,13 @@ clas=
s BaseVM(object):=0A> return self._ssh_do(self._config["guest_user"], cmd=
, False)=0A> =0A> def ssh_root(self, *cmd):=0A> - return self._ssh_do("ro=
ot", cmd, False)=0A> + return self._ssh_do(self._config["root_user"], cmd=
, False)=0A> =0A> def ssh_check(self, *cmd):=0A> self._ssh_do(self._confi=
g["guest_user"], cmd, True)=0A> =0A> def ssh_root_check(self, *cmd):=0A> =
- self._ssh_do("root", cmd, True)=0A> + self._ssh_do(self._config["root_u=
ser"], cmd, True)=0A> =0A> def build_image(self, img):=0A> raise NotImple=
mentedError=0A=0A=0AHaiku's user is UID 0, so essentially our root user i=
sn't named root.=0AThis adds the (optional) ability to override the root =
username.=0A=0A=0A> diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x=
86_64=0A> new file mode 100755=0A> index 0000000000..9777722f51=0A> --- /=
dev/null=0A> +++ b/tests/vm/haiku.x86_64=0A> @@ -0,0 +1,121 @@=0A> +#!/us=
r/bin/env python3=0A> +#=0A> +# Haiku VM image=0A> +#=0A> +# Copyright 20=
20 Haiku, Inc.=0A> +#=0A> +# Authors:=0A> +# Alexander von Gluck IV <kall=
isti5@unixzen.com>=0A> +#=0A> +# This code is licensed under the GPL vers=
ion 2 or later. See=0A> +# the COPYING file in the top-level directory.=
=0A> +#=0A=0A=0AThis build script works as expected, transferring the qem=
u archive over=0Avia the virtio block device and building it.=0A=0AMore i=
nformation here (including output of tools):=0Ahttps://bugs.launchpad.net=
/qemu/+bug/1715203=0A=0AThis purpose of this is trying to prevent the nee=
d to remove=0Aupstream qemu support for Haiku.=0A=0AWe have some out-of-t=
ree patches to fix the error seen in our ports, i'll=0Awork on upstreamin=
g these.=0A=0A=0A -- Alex

