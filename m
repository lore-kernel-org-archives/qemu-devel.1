Received: from eggs.gnu.org ([2001:4830:134:3::10]:37870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFwF4-0002dE-MO
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFwEy-0000Er-Uy
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFwEy-0000Ea-P9
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:09:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1125F3097085
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:09:04 +0000 (UTC)
Date: Fri, 26 Oct 2018 12:38:53 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181025204029.GB29995@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810261237090.8270@xnncv>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
	<nycvar.YSQ.7.76.1810251622450.11480@xnncv>
	<20181025204029.GB29995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/3] adlib: mark as insecure and
 deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

+-- On Thu, 25 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
| On Thu, Oct 25, 2018 at 04:26:16PM +0530, P J P wrote:
| > +-- On Thu, 25 Oct 2018, Gerd Hoffmann wrote --+
| > | We have a lovely, guest-triggerable buffer overflow in opl2 emulati=
on.
| > |=20
| > | Reproducer:
| > |     outw(0xff60, 0x220);
| > |     outw(0x1020, 0x220);
| > |     outw(0xffb0, 0x220);
| > | Result:
| > |     Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])
| >=20
| > + Reported-by: Wangjunqing <wangjunqing@huawei.com>
|=20
| So you have a CVE number for this ?

No, since the adlib device is not used as much and is being deprecated, I=
'm=20
not inclined to get one.

--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
