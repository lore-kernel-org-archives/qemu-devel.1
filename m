Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8498BC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B3C20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErM8IvsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B3C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWNL-00006L-8b
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLWLo-0006rV-AR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLWLm-0000hJ-92
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:19:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLWLm-0000gR-5U
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586197197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/b0HIUQU65gI+YnkCYIXNAIGNM5Xcw+ma5CdERAy9FI=;
 b=ErM8IvsERXjFfda8rDBdyTaGVl3pp2TWegUpOhbHB9Jc8b9Hxmkpx4wQrh5+lTw8Iwqka6
 bNKajtA/faYqZ0PyPtACMtNqJ1aVtSVOt9KbHocJNofIEhwVm5oqwdqRkw1s6cuoAbfwvN
 73UBCpD5n3lk4FRBx+VaijjgzAlcEFs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-XP5BSzguNsG_BFYVaU5xBg-1; Mon, 06 Apr 2020 14:19:53 -0400
X-MC-Unique: XP5BSzguNsG_BFYVaU5xBg-1
Received: by mail-wr1-f69.google.com with SMTP id c8so220118wru.20
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 11:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JtzyrZgTvqbPdoez1uPhq1mRgqO12OBtkfBDfyx+LuM=;
 b=FRsTU8A/bfPTpIpmrWNp/q5uKQ+dkdg4o5wKTPg+eF0d/qslvwV25zq/t3WNyRpL/P
 0/u/Qk1LTfg1WI2PD2xWYIjzYNsKKfPvHOzsWaWqqAJAs6SX0z5b4l4Z0zHpjFp9HLnT
 pazbPUJBxmbH23tHzbhybaTGEQjPfU6pMZZOnI71bYJF9qa1RDuJmHL2rhxI95Mr3UEs
 FlumkiS7FkGAqtkotMdVYClomYcV2N2JYvymq06v3eOxPY6NcgFmeCqFJG9iltO9dlqb
 5mLUm/mPKEdcb2Yjm+UjKsCLISu5UeQMFKkGxBCebjgBPiphWEDYE2Mbecw2lNbUEbse
 6VBQ==
X-Gm-Message-State: AGi0Pub6BB3bPw7JshF2XmdDxgcWZoRvMphScCN42MiTQL2jWyL2Uh+D
 2sO162xPTHKO6F0MUpXMPMAa6EiSOJhAz/Y3gn8BpbIkqeQIfrOvhwlbJsBX7nWXpsgsCCO8o1l
 Aa2fqfWb1y76Vn/4=
X-Received: by 2002:a05:600c:204b:: with SMTP id
 p11mr328525wmg.92.1586197192462; 
 Mon, 06 Apr 2020 11:19:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ0TIYdnu+zc1xBv3Mm9DzlVGrPCNX9GwuntrSRlonkUZ5TmKDHWGl0GpthcLQM+LYjOfyHzw==
X-Received: by 2002:a05:600c:204b:: with SMTP id
 p11mr328440wmg.92.1586197192099; 
 Mon, 06 Apr 2020 11:19:52 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm243441wrg.21.2020.04.06.11.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 11:19:50 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 49/54] various: Use &error_abort in
 instance_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-50-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c907c26-1d12-e769-7f52-4cfb407627ff@redhat.com>
Date: Mon, 6 Apr 2020 20:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-50-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 "open list:Floppy" <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 "open list:Old World \(g3beige\)" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 7:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch created mechanically by running:
>=20
>    $ spatch \
>      --macro-file scripts/cocci-macro-file.h \
>      --include-headers --keep-comments --in-place \
>      --sp-file \
>        scripts/coccinelle/use-error_abort-in-instance_init.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   backends/cryptodev-vhost-user.c |  2 +-
>   backends/rng-egd.c              |  2 +-
>   backends/rng-random.c           |  2 +-
>   backends/vhost-user.c           |  3 ++-
>   hw/arm/bcm2835_peripherals.c    |  6 ++++--
>   hw/arm/vexpress.c               |  8 ++++----
>   hw/arm/xlnx-zcu102.c            |  8 ++++----
>   hw/block/fdc.c                  |  4 ++--
>   hw/block/vhost-user-blk.c       |  2 +-
>   hw/block/virtio-blk.c           |  2 +-
>   hw/core/machine.c               |  6 +++---
>   hw/cpu/core.c                   |  4 ++--
>   hw/display/vga-pci.c            |  7 +++++--
>   hw/display/xlnx_dp.c            |  4 ++--
>   hw/dma/sparc32_dma.c            |  2 +-
>   hw/gpio/aspeed_gpio.c           |  2 +-
>   hw/ide/macio.c                  |  4 +++-
>   hw/ide/qdev.c                   |  4 ++--
>   hw/intc/apic_common.c           |  2 +-
>   hw/mem/nvdimm.c                 |  4 ++--
>   hw/misc/aspeed_sdmc.c           |  2 +-
>   hw/misc/edu.c                   |  3 ++-
>   hw/misc/macio/macio.c           |  4 ++--
>   hw/misc/macio/pmu.c             |  3 ++-
>   hw/misc/pca9552.c               |  2 +-
>   hw/misc/tmp105.c                |  2 +-
>   hw/misc/tmp421.c                |  8 ++++----
>   hw/net/e1000.c                  |  3 ++-
>   hw/net/lance.c                  |  3 ++-
>   hw/net/lasi_i82596.c            |  3 ++-
>   hw/net/ne2000-isa.c             |  4 ++--
>   hw/net/spapr_llan.c             |  2 +-
>   hw/net/virtio-net.c             |  2 +-
>   hw/pci-host/grackle.c           |  2 +-
>   hw/pci-host/i440fx.c            |  8 ++++----
>   hw/pci-host/prep.c              |  2 +-
>   hw/pci-host/q35.c               | 23 ++++++++++++++---------
>   hw/pci-host/sabre.c             |  3 ++-
>   hw/pci-host/uninorth.c          |  9 +++++----
>   hw/pcmcia/pxa2xx.c              |  3 ++-
>   hw/ppc/spapr_drc.c              |  6 +++---
>   hw/ppc/spapr_rng.c              |  2 +-
>   hw/riscv/sifive_u.c             |  4 ++--
>   hw/s390x/event-facility.c       |  6 +++---
>   hw/s390x/s390-ccw.c             |  2 +-
>   hw/s390x/s390-skeys.c           |  4 ++--
>   hw/s390x/s390-stattrib.c        |  4 ++--
>   hw/s390x/sclp.c                 |  2 +-
>   hw/scsi/scsi-bus.c              |  2 +-
>   hw/ssi/xilinx_spips.c           |  2 +-
>   hw/usb/bus.c                    |  4 ++--
>   hw/usb/dev-network.c            |  2 +-
>   hw/usb/dev-storage.c            |  4 ++--
>   hw/usb/host-libusb.c            |  2 +-
>   hw/usb/redirect.c               |  2 +-
>   hw/virtio/virtio-balloon.c      |  4 ++--
>   net/dump.c                      |  4 ++--
>   net/filter-buffer.c             |  2 +-
>   net/filter-mirror.c             | 10 +++++-----
>   net/filter-rewriter.c           |  3 ++-
>   target/arm/cpu64.c              |  4 ++--
>   target/i386/cpu.c               | 23 ++++++++++++++---------
>   target/s390x/cpu.c              |  3 ++-
>   tests/check-qom-proplist.c      |  7 ++++---
>   tests/test-qdev-global-props.c  |  4 ++--
>   65 files changed, 155 insertions(+), 126 deletions(-)
>=20
[...]
> diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
> index 270c690479..09315f412c 100644
> --- a/tests/test-qdev-global-props.c
> +++ b/tests/test-qdev-global-props.c

Oops I forgot to commit this hunk:

@@ -27,6 +27,7 @@
  #include "hw/qdev-properties.h"
  #include "qom/object.h"
  #include "qapi/visitor.h"
+#include "qapi/error.h"


  #define TYPE_STATIC_PROPS "static_prop_type"

> @@ -151,9 +151,9 @@ static void prop2_accessor(Object *obj, Visitor *v, c=
onst char *name,
>   static void dynamic_instance_init(Object *obj)
>   {
>       object_property_add(obj, "prop1", "uint32", prop1_accessor, prop1_a=
ccessor,
> -                        NULL, NULL, NULL);
> +                        NULL, NULL, &error_abort);
>       object_property_add(obj, "prop2", "uint32", prop2_accessor, prop2_a=
ccessor,
> -                        NULL, NULL, NULL);
> +                        NULL, NULL, &error_abort);
>   }
>  =20
>   static void dynamic_class_init(ObjectClass *oc, void *data)
>=20


