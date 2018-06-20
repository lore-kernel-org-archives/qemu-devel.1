Received: from eggs.gnu.org ([2001:4830:134:3::10]:53966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVhdU-0006ex-Lj
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVhdR-0000Gz-Hr
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:15:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fVhdR-0000Gl-Be
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:15:13 -0400
References: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce257b1b-4d04-9e76-2ded-730b2a410f91@redhat.com>
Date: Wed, 20 Jun 2018 20:15:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] regression: sata cdrom boot broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jsnow@redhat.com, f4bug@amsat.org

On 20.06.2018 13:07, Gerd Hoffmann wrote:
>   Hi,
>=20
> $subject says all.  Noticed while testing the upcoming seabios update.
> Reproducer:
>=20
>   qemu-system-x86_64 -M q35 -m 4G -cdrom Fedora-Workstation-Live-x86_64=
-28-1.1.iso

Once this has been fixed, please add a regression test to tests/cdrom-tes=
t.c
for this, so that it can not happen so easily again. A line like this
should do the job:

 qtest_add_data_func("cdrom/boot/q35", "-M q35 -cdrom ", test_cdboot);

  Thomas
