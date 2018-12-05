Received: from eggs.gnu.org ([2001:4830:134:3::10]:49649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gUe10-0003h4-L9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gUe0v-0005Ie-Mj
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:43:26 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:41292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gUe0v-0005IN-Hu
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:43:21 -0500
Received: by mail-io1-f45.google.com with SMTP id s22so17832705ioc.8
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 12:43:21 -0800 (PST)
MIME-Version: 1.0
From: Ed Maste <emaste@freebsd.org>
Date: Wed, 5 Dec 2018 15:43:07 -0500
Message-ID: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

I'd very much like to have CI coverage for QEMU on FreeBSD, and as of
yesterday there's a hosted CI service that supports FreeBSD: Cirrus
CI. They also offer free service for OSS projects. I created a
.cirrus.yml (shown below) in a QEMU GitHub fork and successfully
executed a build test.

I can submit a patch to add the config file, but wanted to ask for
advice or comments from those who set up the existing Linux CI first.
Is there anything I should be aware of or should address? Although
this is a very basic build / test I believe it will prove quite
valuable in reducing the latency between a commit and finding an issue
on FreeBSD.

.cirrus.yml:
freebsd_instance:
  image: freebsd-12-0-rc3-amd64

env:
  CIRRUS_CLONE_DEPTH: 1

task:
  install_script: pkg install -y git glib gmake perl5 pixman pkgconf
  script:
    - mkdir build
    - cd build
    - ../configure || { cat config.log; exit 1; }
    - gmake
    - gmake check
