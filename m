Received: from eggs.gnu.org ([2001:4830:134:3::10]:42223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMD4V-0002P6-14
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMD4R-0008NG-MJ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:15:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:41052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMD4R-0008Ma-GZ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:15:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMD4P-0003J1-Ei
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 13:15:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 667A22E8050
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 13:15:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Dec 2017 13:10:23 -0000
From: Greg Kurz <groug@kaod.org>
Reply-To: Bug 1736376 <1736376@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151246997532.20350.210206455230339629.malonedeb@chaenomeles.canonical.com>
Message-Id: <151247942341.20315.10691487242582165378.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1736376] Re: CVE-2017-7471 repeated?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When using the proxy backend, all accesses to the host filesystem are
handled by an external process running in a chroot() jail. No need to
bother about paths in this case.

CVE-2017-7471 is only applicable to the local backend, because accesses
are handled by QEMU directly in this case.


** Changed in: qemu
       Status: New =3D> Invalid

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2017-7471

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1736376

Title:
  CVE-2017-7471 repeated?

Status in QEMU:
  Invalid

Bug description:
  In the hw/9pfs/9p-proxy.c file I can see the following which is
  changed because of CVE-2017-7471 in the hw/9pfs/9p-local.c. I might be
  wrong but I guess that should be changed as well.

  if(dir_path){
  v9fs_path_sprintf(target,"%s/%s",dir_path->data,name);
  }
  else{
  v9fs_path_sprintf(target,"%s",name);
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1736376/+subscriptions
