Received: from eggs.gnu.org ([2001:4830:134:3::10]:51901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dT1Em-0000Re-RT
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dT1El-0000Bi-VG
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:30:08 -0400
Date: Thu, 6 Jul 2017 15:29:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170706072955.GB13548@lemon.lan>
References: <1498734863-164338-1-git-send-email-imammedo@redhat.com>
	<149932540890.339.7607386893555558786@239b34022e6d>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149932540890.339.7607386893555558786@239b34022e6d>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qom: enforce readonly nature of link's
 check callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, alistair.francis@xilinx.com, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, pbonzini@redhat.com, afaerber@suse.de

On Thu, 07/06 00:16, no-reply@patchew.org wrote:
> /var/tmp/patchew-tester-tmp-s55a7o8g/src/hw/virtio/virtio-crypto.c: In =
function =E2=80=98virtio_crypto_instance_init=E2=80=99:
> /var/tmp/patchew-tester-tmp-s55a7o8g/src/hw/virtio/virtio-crypto.c:918:=
30: error: passing argument 5 of =E2=80=98object_property_add_link=E2=80=99=
 from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
>                               virtio_crypto_check_cryptodev_is_used,
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /var/tmp/patchew-tester-tmp-s55a7o8g/src/include/=
hw/hw.h:10:0,
>                  from /var/tmp/patchew-tester-tmp-s55a7o8g/src/include/=
hw/qdev.h:4,
>                  from /var/tmp/patchew-tester-tmp-s55a7o8g/src/hw/virti=
o/virtio-crypto.c:15:
> /var/tmp/patchew-tester-tmp-s55a7o8g/src/include/qom/object.h:1353:6: n=
ote: expected =E2=80=98void (*)(const Object *, const char *, Object *, E=
rror **) {aka void (*)(const struct Object *, const char *, struct Object=
 *, struct Error **)}=E2=80=99 but argument is of type =E2=80=98void (*)(=
Object *, const char *, Object *, Error **) {aka void (*)(struct Object *=
, const char *, struct Object *, struct Error **)}=E2=80=99
>  void object_property_add_link(Object *obj, const char *name,
>       ^~~~~~~~~~~~~~~~~~~~~~~~

No worry, I've taken care of it when including this patch in my series.

Fam
