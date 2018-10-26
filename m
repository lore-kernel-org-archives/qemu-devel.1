Received: from eggs.gnu.org ([2001:4830:134:3::10]:55969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFypM-0005KW-14
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFypH-0006Ep-TG
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:54:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gFypF-0006Dj-VN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76F2730B7EC6
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:54:39 +0000 (UTC)
Date: Fri, 26 Oct 2018 10:54:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181026095433.GF31390@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
	<nycvar.YSQ.7.76.1810251622450.11480@xnncv>
	<20181025204029.GB29995@redhat.com>
	<nycvar.YSQ.7.76.1810261237090.8270@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1810261237090.8270@xnncv>
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
To: P J P <ppandit@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Fri, Oct 26, 2018 at 12:38:53PM +0530, P J P wrote:
> +-- On Thu, 25 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
> | On Thu, Oct 25, 2018 at 04:26:16PM +0530, P J P wrote:
> | > +-- On Thu, 25 Oct 2018, Gerd Hoffmann wrote --+
> | > | We have a lovely, guest-triggerable buffer overflow in opl2 emula=
tion.
> | > |=20
> | > | Reproducer:
> | > |     outw(0xff60, 0x220);
> | > |     outw(0x1020, 0x220);
> | > |     outw(0xffb0, 0x220);
> | > | Result:
> | > |     Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])
> | >=20
> | > + Reported-by: Wangjunqing <wangjunqing@huawei.com>
> |=20
> | So you have a CVE number for this ?
>=20
> No, since the adlib device is not used as much and is being deprecated,=
 I'm=20
> not inclined to get one.

Any security issue that affects code in QEMU that is currently being
shipped by distros should have a CVE.

Whether we intend to deprecate & delete it later should not be a factor
because we are free to cancel the deprecation process at any time if we
find a reason to keep the feature around.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
