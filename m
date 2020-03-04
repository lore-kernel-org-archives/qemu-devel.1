Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C130C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35532214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wx6KpTEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35532214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9PHM-0006xs-9K
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9PFe-0004wk-F0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9PFc-0001M8-G7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:19:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9PFc-0001Jm-9w
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583309971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UfUlF8qPgLvcFdbS7mrM602BDfWuOYed+kpU7o2XhQ8=;
 b=Wx6KpTEMizYPW6wwAyhTscefd9l4ZfXZBPMCF7ys5iYwC+8einWJ+60+2qHgqayEkcw9dc
 3iksPGbWto51PQAT75OfIF8be6xsFtrQ2X7adiQsMdlbtbs6AVnt77/kxrcCHRuq0iIWU4
 rGWH9NlkBnJEiRUfS47Uoz0l1Wt0uRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-CYEG4cbiM2eLvu4GaFuBQw-1; Wed, 04 Mar 2020 03:19:28 -0500
X-MC-Unique: CYEG4cbiM2eLvu4GaFuBQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 707A8107ACC9;
 Wed,  4 Mar 2020 08:19:25 +0000 (UTC)
Received: from [10.36.117.195] (ovpn-117-195.ams2.redhat.com [10.36.117.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D967D5C1D6;
 Wed,  4 Mar 2020 08:19:04 +0000 (UTC)
Subject: Re: [PATCH 2/2] misc: Replace zero-length arrays with flexible array
 member (manual)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200304005105.27454-1-philmd@redhat.com>
 <20200304005844.28346-1-philmd@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <483a00fd-ff30-4f4e-2477-7b0c0c71d85f@redhat.com>
Date: Wed, 4 Mar 2020 09:19:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304005844.28346-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04.03.20 01:58, Philippe Mathieu-Daud=C3=A9 wrote:
> Description copied from Linux kernel commit from Gustavo A. R. Silva
> (see [3]):
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
> All these instances of code were found with the help of the
> following command (then manual analysis):
>=20
>   git grep -F '[0];'
>=20
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D76497732932f
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/=
commit/?id=3D17642a2fbd2c1
>=20
> Inspired-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  docs/interop/vhost-user.rst       | 4 ++--
>  block/qed.h                       | 2 +-
>  include/hw/acpi/acpi-defs.h       | 4 ++--
>  include/hw/boards.h               | 2 +-
>  include/hw/s390x/event-facility.h | 2 +-
>  include/hw/s390x/sclp.h           | 8 ++++----
>  block/vmdk.c                      | 2 +-
>  hw/char/sclpconsole-lm.c          | 2 +-
>  hw/char/sclpconsole.c             | 2 +-
>  hw/s390x/virtio-ccw.c             | 2 +-
>  target/s390x/ioinst.c             | 2 +-
>  11 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 401652397c..3b1b6602c7 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -568,7 +568,7 @@ For split virtqueue, queue region can be implemented =
as:
>        uint16_t used_idx;
> =20
>        /* Used to track the state of each descriptor in descriptor table =
*/
> -      DescStateSplit desc[0];
> +      DescStateSplit desc[];
>    } QueueRegionSplit;
> =20
>  To track inflight I/O, the queue region should be processed as follows:
> @@ -690,7 +690,7 @@ For packed virtqueue, queue region can be implemented=
 as:
>        uint8_t padding[7];
> =20
>        /* Used to track the state of each descriptor fetched from descrip=
tor ring */
> -      DescStatePacked desc[0];
> +      DescStatePacked desc[];
>    } QueueRegionPacked;
> =20
>  To track inflight I/O, the queue region should be processed as follows:
> diff --git a/block/qed.h b/block/qed.h
> index 42c115d822..87428ba00e 100644
> --- a/block/qed.h
> +++ b/block/qed.h
> @@ -103,7 +103,7 @@ typedef struct {
>  } QEMU_PACKED QEDHeader;
> =20
>  typedef struct {
> -    uint64_t offsets[0];            /* in bytes */
> +    uint64_t offsets[];             /* in bytes */
>  } QEDTable;
> =20
>  /* The L2 cache is a simple write-through cache for L2 structures */
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 19f7ba7b70..c13327fa78 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -152,7 +152,7 @@ typedef struct AcpiSerialPortConsoleRedirection
>   */
>  struct AcpiRsdtDescriptorRev1 {
>      ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
> -    uint32_t table_offset_entry[0];  /* Array of pointers to other */
> +    uint32_t table_offset_entry[];  /* Array of pointers to other */
>      /* ACPI tables */
>  } QEMU_PACKED;
>  typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescriptorRev1;
> @@ -162,7 +162,7 @@ typedef struct AcpiRsdtDescriptorRev1 AcpiRsdtDescrip=
torRev1;
>   */
>  struct AcpiXsdtDescriptorRev2 {
>      ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
> -    uint64_t table_offset_entry[0];  /* Array of pointers to other */
> +    uint64_t table_offset_entry[];  /* Array of pointers to other */
>      /* ACPI tables */
>  } QEMU_PACKED;
>  typedef struct AcpiXsdtDescriptorRev2 AcpiXsdtDescriptorRev2;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 9bc42dfb22..c96120d15f 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -71,7 +71,7 @@ typedef struct CPUArchId {
>   */
>  typedef struct {
>      int len;
> -    CPUArchId cpus[0];
> +    CPUArchId cpus[];
>  } CPUArchIdList;
> =20
>  /**
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-f=
acility.h
> index bdc32a3c09..700a610f33 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -122,7 +122,7 @@ typedef struct MDBO {
> =20
>  typedef struct MDB {
>      MdbHeader header;
> -    MDBO mdbo[0];
> +    MDBO mdbo[];
>  } QEMU_PACKED MDB;
> =20
>  typedef struct SclpMsg {
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index c54413b78c..cd7b24359f 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -132,7 +132,7 @@ typedef struct ReadInfo {
>      uint16_t highest_cpu;
>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>      uint32_t hmfai;
> -    struct CPUEntry entries[0];
> +    struct CPUEntry entries[];
>  } QEMU_PACKED ReadInfo;
> =20
>  typedef struct ReadCpuInfo {
> @@ -142,7 +142,7 @@ typedef struct ReadCpuInfo {
>      uint16_t nr_standby;            /* 12-13 */
>      uint16_t offset_standby;        /* 14-15 */
>      uint8_t reserved0[24-16];       /* 16-23 */
> -    struct CPUEntry entries[0];
> +    struct CPUEntry entries[];
>  } QEMU_PACKED ReadCpuInfo;
> =20
>  typedef struct ReadStorageElementInfo {
> @@ -151,7 +151,7 @@ typedef struct ReadStorageElementInfo {
>      uint16_t assigned;
>      uint16_t standby;
>      uint8_t _reserved0[16 - 14]; /* 14-15 */
> -    uint32_t entries[0];
> +    uint32_t entries[];
>  } QEMU_PACKED ReadStorageElementInfo;
> =20
>  typedef struct AttachStorageElement {
> @@ -159,7 +159,7 @@ typedef struct AttachStorageElement {
>      uint8_t _reserved0[10 - 8];  /* 8-9 */
>      uint16_t assigned;
>      uint8_t _reserved1[16 - 12]; /* 12-15 */
> -    uint32_t entries[0];
> +    uint32_t entries[];
>  } QEMU_PACKED AttachStorageElement;
> =20
>  typedef struct AssignStorage {
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 20e909d997..8466051bc9 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -187,7 +187,7 @@ typedef struct VmdkMetaData {
>  typedef struct VmdkGrainMarker {
>      uint64_t lba;
>      uint32_t size;
> -    uint8_t  data[0];
> +    uint8_t  data[];
>  } QEMU_PACKED VmdkGrainMarker;
> =20
>  enum {
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index c420dc066e..2b5f37b6a2 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -31,7 +31,7 @@
>  typedef struct OprtnsCommand {
>      EventBufferHeader header;
>      MDMSU message_unit;
> -    char data[0];
> +    char data[];
>  } QEMU_PACKED OprtnsCommand;
> =20
>  /* max size for line-mode data in 4K SCCB page */
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index 1fa124dab9..5c7664905e 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -25,7 +25,7 @@
> =20
>  typedef struct ASCIIConsoleData {
>      EventBufferHeader ebh;
> -    char data[0];
> +    char data[];
>  } QEMU_PACKED ASCIIConsoleData;
> =20
>  /* max size for ASCII data in 4K SCCB page */
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 50cf95b781..64f928fc7d 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -193,7 +193,7 @@ typedef struct VirtioThinintInfo {
>  typedef struct VirtioRevInfo {
>      uint16_t revision;
>      uint16_t length;
> -    uint8_t data[0];
> +    uint8_t data[];
>  } QEMU_PACKED VirtioRevInfo;
> =20
>  /* Specify where the virtqueues for the subchannel are in guest memory. =
*/
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index c437a1d8c6..0e840cc579 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -347,7 +347,7 @@ typedef struct ChscResp {
>      uint16_t len;
>      uint16_t code;
>      uint32_t param;
> -    char data[0];
> +    char data[];
>  } QEMU_PACKED ChscResp;
> =20
>  #define CHSC_MIN_RESP_LEN 0x0008
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb


