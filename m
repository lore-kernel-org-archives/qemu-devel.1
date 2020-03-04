Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F4020838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcSefQps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F4020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Tuz-0000Hb-KT
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9TpU-0000CM-7h
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9TpS-0004y5-2W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9TpR-0004wX-Us
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583327568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3p/fFbxB5ezcsfdq9MHESgqC9UtCWJvZwUNOkF4Zu30=;
 b=bcSefQpsLtDUfcyjn/kGdotGvC+naPVGykV83i//iBfXtaR+YsyfiGOW09dcL0yOXIWttf
 KGrKFFkZv46TUo0DJMRZALJmPJ6Od1N4O8xYjA/nN6PfHQHuIC+ztslZXePS3mmU6PahMC
 MSVwu7+I4J3KAmLID1vuN0k9jE3DIiU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-C_ahjHcAN4-pIQEpcsNJmQ-1; Wed, 04 Mar 2020 08:12:44 -0500
X-MC-Unique: C_ahjHcAN4-pIQEpcsNJmQ-1
Received: by mail-ed1-f71.google.com with SMTP id k6so1558903edq.8
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 05:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wrv00mxDOOqpdemOYspMDZ/TSsZzjo/OCltlEBUziv8=;
 b=pU5Oh+uPgdq/L7iTn99I3qDAl7gA9TMhMKM0mJslhAIUS1rOa5FSd3bvFj5UUBA+wf
 ciPQtJvnAbIGww1sAAG11ThLpt3ZHEioapKqTy6ROtlDlLCMq022ABoTCqA5jEiWgcLV
 gqXNOgLzkJFtNzxuKWsVu5zxrTLJud63yoXERldoHzeLLPmCSOvQWCKSPGHr20jqowV7
 zFlpk3Xec8zWfDnwP41QeWv/4sqqnj0AscaEd4LMWAixSjO+C84z+jtxf7u7mwadufDb
 wc1/2HA3PwhtQIGwqqUf7a1VnFuidmBLooTbPfEC2Lr8xVZ0iLHxx6rOyqUIQvCQfz5W
 4A8g==
X-Gm-Message-State: ANhLgQ1poajzIvt2W/mftcY4Qa/SiwFZ1B5mBZJw+/72Sdg4lipfU7IM
 4jLRpHF0Kwe+FLWgw40ba/GqJNHNem0BYK7fFgVmvbqlUQSyLNO45KtocGHVp/TKdiBZcE2Jfqy
 AJD9foTmGAX3sCDg=
X-Received: by 2002:a17:906:bb0c:: with SMTP id
 jz12mr2497664ejb.298.1583327562972; 
 Wed, 04 Mar 2020 05:12:42 -0800 (PST)
X-Google-Smtp-Source: ADFU+vux30Ie4y9HmDhIL9dTaFYuWDhigFHYVeZSlamFHo2iRPgM7EwcNwT0sc/cInsQkQULDMwOLQ==
X-Received: by 2002:a17:906:bb0c:: with SMTP id
 jz12mr2497606ejb.298.1583327562540; 
 Wed, 04 Mar 2020 05:12:42 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id dm24sm296392edb.57.2020.03.04.05.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 05:12:41 -0800 (PST)
Subject: Re: [PATCH 1/2] misc: Replace zero-length arrays with flexible array
 member (automatic)
To: qemu-devel@nongnu.org
References: <20200304005105.27454-1-philmd@redhat.com>
 <20200304005105.27454-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e1a1491-15ca-29d4-8bd6-1bf14edb4ad5@redhat.com>
Date: Wed, 4 Mar 2020 14:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304005105.27454-2-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paul Durrant <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Description copied from Linux kernel commit from Gustavo A. R. Silva
> (see [3]):
>=20
> --v-- description start --v--
>=20
>    The current codebase makes use of the zero-length array language
>    extension to the C90 standard, but the preferred mechanism to
>    declare variable-length types such as these ones is a flexible
>    array member [1], introduced in C99:
>=20
>    struct foo {
>        int stuff;
>        struct boo array[];
>    };
>=20
>    By making use of the mechanism above, we will get a compiler
>    warning in case the flexible array does not occur last in the
>    structure, which will help us prevent some kind of undefined
>    behavior bugs from being unadvertenly introduced [2] to the
>    Linux codebase from now on.
>=20
> --^-- description end --^--
>=20
> Do the similar housekeeping in the QEMU codebase (which uses
> C99 since commit 7be41675f7cb).
>=20
> All these instances of code were found with the help of the
> following Coccinelle script:
>=20
>    @@
>    identifier s, a;
>    type T;
>    @@
>     struct s {
>        ...
>    -   T a[0];
>    +   T a[];
>    };
>    @@
>    identifier s, a;
>    type T;
>    @@
>     struct s {
>        ...
>    -   T a[0];
>    +   T a[];
>     } QEMU_PACKED;
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
>   bsd-user/qemu.h                       |  2 +-
>   contrib/libvhost-user/libvhost-user.h |  2 +-
>   hw/m68k/bootinfo.h                    |  2 +-
>   hw/scsi/srp.h                         |  6 +++---
>   hw/xen/xen_pt.h                       |  2 +-
>   include/hw/acpi/acpi-defs.h           | 12 ++++++------
>   include/hw/arm/smmu-common.h          |  2 +-
>   include/hw/i386/intel_iommu.h         |  3 ++-
>   include/hw/virtio/virtio-iommu.h      |  2 +-
>   include/sysemu/cryptodev.h            |  2 +-
>   include/tcg/tcg.h                     |  2 +-
>   pc-bios/s390-ccw/bootmap.h            |  2 +-
>   pc-bios/s390-ccw/sclp.h               |  2 +-
>   tests/qtest/libqos/ahci.h             |  2 +-
>   block/linux-aio.c                     |  2 +-
>   hw/acpi/nvdimm.c                      |  6 +++---
>   hw/dma/soc_dma.c                      |  2 +-
>   hw/i386/x86.c                         |  2 +-
>   hw/misc/omap_l4.c                     |  2 +-
>   hw/nvram/eeprom93xx.c                 |  2 +-
>   hw/rdma/vmw/pvrdma_qp_ops.c           |  4 ++--
>   hw/usb/dev-network.c                  |  2 +-
>   hw/usb/dev-smartcard-reader.c         |  4 ++--
>   hw/virtio/virtio.c                    |  4 ++--
>   net/queue.c                           |  2 +-
>   25 files changed, 38 insertions(+), 37 deletions(-)
>=20
[...]
> diff --git a/hw/scsi/srp.h b/hw/scsi/srp.h
> index d27f31d2d5..54c954badd 100644
> --- a/hw/scsi/srp.h
> +++ b/hw/scsi/srp.h
> @@ -112,7 +112,7 @@ struct srp_direct_buf {
>   struct srp_indirect_buf {
>       struct srp_direct_buf    table_desc;
>       uint32_t                 len;
> -    struct srp_direct_buf    desc_list[0];
> +    struct srp_direct_buf    desc_list[];
>   } QEMU_PACKED;
>  =20
>   enum {
> @@ -211,7 +211,7 @@ struct srp_cmd {
>       uint8_t    reserved4;
>       uint8_t    add_cdb_len;
>       uint8_t    cdb[16];
> -    uint8_t    add_data[0];
> +    uint8_t    add_data[];
>   } QEMU_PACKED;
>  =20
>   enum {
> @@ -241,7 +241,7 @@ struct srp_rsp {
>       uint32_t   data_in_res_cnt;
>       uint32_t   sense_data_len;
>       uint32_t   resp_data_len;
> -    uint8_t    data[0];
> +    uint8_t    data[];
>   } QEMU_PACKED;

hw/scsi/spapr_vscsi.c:69:29: error: field 'iu' with variable sized type=20
'union viosrp_iu' not at the end of a struct or class is a GNU extension=20
[-Werror,-Wgnu-variable-sized-type-not-at-end]
     union viosrp_iu         iu;
                             ^

Yay we found a bug! Thanks Gustavo :)

union srp_iu {
     struct srp_login_req login_req;
     struct srp_login_rsp login_rsp;
     struct srp_login_rej login_rej;
     struct srp_i_logout i_logout;
     struct srp_t_logout t_logout;
     struct srp_tsk_mgmt tsk_mgmt;
     struct srp_cmd cmd;
     struct srp_rsp rsp;
     uint8_t reserved[SRP_MAX_IU_LEN];
};

union viosrp_iu {
     union srp_iu srp;
     union mad_iu mad;
};

typedef struct vscsi_req {
     vscsi_crq               crq;
     union viosrp_iu         iu;

     /* SCSI request tracking */
     SCSIRequest             *sreq;
     uint32_t                qtag; /* qemu tag !=3D srp tag */
     bool                    active;
     bool                    writing;
     bool                    dma_error;
     uint32_t                data_len;
     uint32_t                senselen;
     uint8_t                 sense[SCSI_SENSE_BUF_SIZE];

     /* RDMA related bits */
     uint8_t                 dma_fmt;
     uint16_t                local_desc;
     uint16_t                total_desc;
     uint16_t                cdb_offset;
     uint16_t                cur_desc_num;
     uint16_t                cur_desc_offset;
} vscsi_req;

>  =20
>   #endif /* SCSI_SRP_H */
[...]


