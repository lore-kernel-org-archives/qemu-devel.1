Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9217AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D61D2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uqz0dG8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB4K-0002HA-Ha
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jAAyv-0008Ai-LN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jAAyu-0003iO-4R
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:17:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jAAyt-0003es-Uy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583493447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2s9JXeDz4EqltLl6mL+qavCzz0ZKxnmqBZNo8uPIpzA=;
 b=Uqz0dG8nMIq/Vg03LKLd/eDsXuYalEKrb8ho1z7p37COXynQuh+XuGhaSAKVotCt9cPoqY
 eyl+eAGqak4ff45ZVG6JN+Yo9Wzc2dGWWYeuWaPJ4OvLrhje1LI0Jg3aVHBapcmQSd28my
 3PP9zPXmX99WPj7Bv2hewQaPLbWYVA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-8KIxNJuBPBm6Gz2RDngudg-1; Fri, 06 Mar 2020 06:17:25 -0500
X-MC-Unique: 8KIxNJuBPBm6Gz2RDngudg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0789F800D50;
 Fri,  6 Mar 2020 11:17:23 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB76384D90;
 Fri,  6 Mar 2020 11:17:01 +0000 (UTC)
Date: Fri, 6 Mar 2020 12:16:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 0/2] misc: Replace zero-length arrays with flexible
 array member
Message-ID: <20200306121659.5365e50b@redhat.com>
In-Reply-To: <20200304153601.23423-1-philmd@redhat.com>
References: <20200304153601.23423-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  4 Mar 2020 16:35:59 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> v2:
> - do not modify qed.h (structure with single member)
> - based on hw/scsi/spapr_vscsi fix series
>=20
> This is a tree-wide cleanup inspired by a Linux kernel commit
> (from Gustavo A. R. Silva).
>=20
> --v-- description start --v--
>=20
>   The current codebase makes use of the zero-length array language
>   extension to the C90 standard, but the preferred mechanism to
>   declare variable-length types such as these ones is a flexible
>   array member [1], introduced in C99:
>=20
>   struct foo {
>       int stuff;
>       struct boo array[];
>   };
>=20
>   By making use of the mechanism above, we will get a compiler
>   warning in case the flexible array does not occur last in the
>   structure, which will help us prevent some kind of undefined
>   behavior bugs from being unadvertenly introduced [2] to the
>   Linux codebase from now on.
>=20
> --^-- description end --^--
>=20
> Do the similar housekeeping in the QEMU codebase (which uses
> C99 since commit 7be41675f7cb).
>=20
> The first patch is done with the help of a coccinelle semantic
> patch. However Coccinelle does not recognize:
>=20
>   struct foo {
>       int stuff;
>       struct boo array[];
>   } QEMU_PACKED;
>=20
> but does recognize:
>=20
>   struct QEMU_PACKED foo {
>       int stuff;
>       struct boo array[];
>   };
>=20
> I'm not sure why, neither it is worth refactoring all QEMU
> structures to use the attributes before the structure name,
> so I did the 2nd patch manually.
>=20
> Anyway this is annoying, because many structures are not handled
> by coccinelle. Maybe this needs to be reported to upstream
> coccinelle?
>=20
> I used spatch 1.0.8 with:
>=20
>   -I include --include-headers \
>   --macro-file scripts/cocci-macro-file.h \
>   --keep-comments --indent 4
>=20
> Regards,
>=20
> Phil.
>=20
> Based-on: <20200304153311.22959-1-philmd@redhat.com>
> Supersedes: <20200304005105.27454-1-philmd@redhat.com>

For acpi parts
Acked-by: Igor Mammedov <imammedo@redhat.com>

>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   misc: Replace zero-length arrays with flexible array member
>     (automatic)
>   misc: Replace zero-length arrays with flexible array member (manual)
>=20
>  docs/interop/vhost-user.rst           |  4 ++--
>  bsd-user/qemu.h                       |  2 +-
>  contrib/libvhost-user/libvhost-user.h |  2 +-
>  hw/m68k/bootinfo.h                    |  2 +-
>  hw/scsi/srp.h                         |  6 +++---
>  hw/xen/xen_pt.h                       |  2 +-
>  include/hw/acpi/acpi-defs.h           | 16 ++++++++--------
>  include/hw/arm/smmu-common.h          |  2 +-
>  include/hw/boards.h                   |  2 +-
>  include/hw/i386/intel_iommu.h         |  3 ++-
>  include/hw/s390x/event-facility.h     |  2 +-
>  include/hw/s390x/sclp.h               |  8 ++++----
>  include/hw/virtio/virtio-iommu.h      |  2 +-
>  include/sysemu/cryptodev.h            |  2 +-
>  include/tcg/tcg.h                     |  2 +-
>  pc-bios/s390-ccw/bootmap.h            |  2 +-
>  pc-bios/s390-ccw/sclp.h               |  2 +-
>  tests/qtest/libqos/ahci.h             |  2 +-
>  block/linux-aio.c                     |  2 +-
>  block/vmdk.c                          |  2 +-
>  hw/acpi/nvdimm.c                      |  6 +++---
>  hw/char/sclpconsole-lm.c              |  2 +-
>  hw/char/sclpconsole.c                 |  2 +-
>  hw/dma/soc_dma.c                      |  2 +-
>  hw/i386/x86.c                         |  2 +-
>  hw/misc/omap_l4.c                     |  2 +-
>  hw/nvram/eeprom93xx.c                 |  2 +-
>  hw/rdma/vmw/pvrdma_qp_ops.c           |  4 ++--
>  hw/s390x/virtio-ccw.c                 |  2 +-
>  hw/usb/dev-network.c                  |  2 +-
>  hw/usb/dev-smartcard-reader.c         |  4 ++--
>  hw/virtio/virtio.c                    |  4 ++--
>  net/queue.c                           |  2 +-
>  target/s390x/ioinst.c                 |  2 +-
>  34 files changed, 53 insertions(+), 52 deletions(-)
>=20


