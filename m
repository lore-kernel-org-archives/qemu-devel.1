Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B287C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7705206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQD9kTyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7705206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqTV-0006EI-1K
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 16:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqSe-0005Qi-8n
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqSc-0003M3-U7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:59:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31444
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqSc-0003H4-PK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584129550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDHdKV0wlPtyr/TWG9u/6tzcG0O+0qYGKdarG5VsMxo=;
 b=jQD9kTySBEUZZwGKyAOvUW1a1mwINPQBllNcEBZb0/6jcD5rk7b+T+VQKu3VVAt+3KoeLx
 V5h+0yjCB6th35NqQLhk6ku23IgVBVJGexnZtT4Se5n4x0sMc+I60Vk69qRvIc1oAm57D0
 gQXxIIdLlS7merS6johvdsHZXlBbHwc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-JzEAfRYWMMi7HKJRvfNPSA-1; Fri, 13 Mar 2020 15:59:08 -0400
X-MC-Unique: JzEAfRYWMMi7HKJRvfNPSA-1
Received: by mail-wm1-f70.google.com with SMTP id a13so3837640wme.7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5DqvIPq3MOLZGkPLrRt61Rus1GrqoXd6RNXYTJIbdks=;
 b=WaRur1m/Sm6qwgmpZ8/kKUuhhCfslOhmP3Ku5FA6BGZsyQmt3UTWWJNqUt0JUOXuD9
 n8t4ImZ6KvzJqSF3AW9SABacUdGy40DvxPzb1DQJuBueejczejHeS/iGsV1wFwUpo3Pq
 8+MwKWMWWO/ukW9fh3ZuvwUGcULo2phnXq9hHYCyQw8++rqiUwrlwD7ZLP+vzRDkzgzN
 Y/Er6aBuM2NmdW1QvEuKavHsW6sMeTw15GytJWm1bo3kDIgme0k1383+XpMF//5RhuJk
 U4eUaAu8qQ1IrW5GypZ0gOzHlxGG1W2S1hEgMMrDUPvcBlbocv4OHAOiXGRDcgVMqmET
 cYgg==
X-Gm-Message-State: ANhLgQ08buBbQkFlFO5gaOjIMBcz1q3vTqkbHtkN7ImlnHJYYwNTM0sD
 wLBZCmB1jMAH69Re25YYc+/dGzjzX8daOqPijCJamBhxHrHYchSYrDYynh4gDKCIt7m0amsDVjw
 vLPFgST2my91YCUs=
X-Received: by 2002:a5d:68c1:: with SMTP id p1mr5592201wrw.198.1584129547051; 
 Fri, 13 Mar 2020 12:59:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuY+OlXDHT5860GLSQD9AAyFjwI0TVsNNEl2NgR9IqxYVEPG4F/m2mR+IPmYRy2qbqvQzCl1Q==
X-Received: by 2002:a5d:68c1:: with SMTP id p1mr5592161wrw.198.1584129546693; 
 Fri, 13 Mar 2020 12:59:06 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id 19sm18749730wma.3.2020.03.13.12.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 12:59:05 -0700 (PDT)
Subject: Re: [PATCH v3 08/16] hw/i386/vmport: Define enum for all commands
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-9-liran.alon@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3dbe8a7f-73e3-691b-2e14-c287cafd9e7c@redhat.com>
Date: Fri, 13 Mar 2020 20:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-9-liran.alon@oracle.com>
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
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 5:54 PM, Liran Alon wrote:
> No functional change.
>=20
> Defining an enum for all VMPort commands have the following advantages:
> * It gets rid of the error-prone requirement to update VMPORT_ENTRIES
> when new VMPort commands are added to QEMU.
> * It makes it clear to know by looking at one place at the source, what
> are all the VMPort commands supported by QEMU.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   hw/i386/vmmouse.c        | 18 ++++++------------
>   hw/i386/vmport.c         | 11 ++---------
>   include/hw/i386/vmport.h | 11 ++++++++++-

Please setup scripts/git.orderfile to ease reviews.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   3 files changed, 18 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 49a546fd3bb6..afb8e9e09a30 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -34,12 +34,6 @@
>   /* debug only vmmouse */
>   //#define DEBUG_VMMOUSE
>  =20
> -/* VMMouse Commands */
> -#define VMMOUSE_GETVERSION=0910
> -#define VMMOUSE_DATA=09=0939
> -#define VMMOUSE_STATUS=09=0940
> -#define VMMOUSE_COMMAND=09=0941
> -
>   #define VMMOUSE_READ_ID=09=09=090x45414552
>   #define VMMOUSE_DISABLE=09=09=090x000000f5
>   #define VMMOUSE_REQUEST_RELATIVE=090x4c455252
> @@ -197,10 +191,10 @@ static uint32_t vmmouse_ioport_read(void *opaque, u=
int32_t addr)
>       command =3D data[2] & 0xFFFF;
>  =20
>       switch (command) {
> -    case VMMOUSE_STATUS:
> +    case VMPORT_CMD_VMMOUSE_STATUS:
>           data[0] =3D vmmouse_get_status(s);
>           break;
> -    case VMMOUSE_COMMAND:
> +    case VMPORT_CMD_VMMOUSE_COMMAND:
>           switch (data[1]) {
>           case VMMOUSE_DISABLE:
>               vmmouse_disable(s);
> @@ -219,7 +213,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uin=
t32_t addr)
>               break;
>           }
>           break;
> -    case VMMOUSE_DATA:
> +    case VMPORT_CMD_VMMOUSE_DATA:
>           vmmouse_data(s, data, data[1]);
>           break;
>       default:
> @@ -276,9 +270,9 @@ static void vmmouse_realizefn(DeviceState *dev, Error=
 **errp)
>           return;
>       }
>  =20
> -    vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read, s);
> -    vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read, s);
> -    vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
> +    vmport_register(VMPORT_CMD_VMMOUSE_STATUS, vmmouse_ioport_read, s);
> +    vmport_register(VMPORT_CMD_VMMOUSE_COMMAND, vmmouse_ioport_read, s);
> +    vmport_register(VMPORT_CMD_VMMOUSE_DATA, vmmouse_ioport_read, s);
>   }
>  =20
>   static Property vmmouse_properties[] =3D {
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index e9ea5fe7f765..6ab094311d6c 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -38,10 +38,6 @@
>   #include "qemu/log.h"
>   #include "trace.h"
>  =20
> -#define VMPORT_CMD_GETVERSION 0x0a
> -#define VMPORT_CMD_GETRAMSIZE 0x14
> -
> -#define VMPORT_ENTRIES 0x2c
>   #define VMPORT_MAGIC   0x564D5868
>  =20
>   /* Compatibility flags for migration */
> @@ -72,12 +68,9 @@ typedef struct VMPortState {
>  =20
>   static VMPortState *port_state;
>  =20
> -void vmport_register(unsigned char command, VMPortReadFunc *func, void *=
opaque)
> +void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *=
opaque)
>   {
> -    if (command >=3D VMPORT_ENTRIES) {
> -        return;
> -    }
> -
> +    assert(command < VMPORT_ENTRIES);
>       trace_vmport_register(command, func, opaque);
>       port_state->func[command] =3D func;
>       port_state->opaque[command] =3D opaque;
> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> index f0c1e985ca08..0501ccac6ddf 100644
> --- a/include/hw/i386/vmport.h
> +++ b/include/hw/i386/vmport.h
> @@ -4,12 +4,21 @@
>   #define TYPE_VMPORT "vmport"
>   typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
>  =20
> +typedef enum {
> +    VMPORT_CMD_GETVERSION       =3D 10,
> +    VMPORT_CMD_GETRAMSIZE       =3D 20,
> +    VMPORT_CMD_VMMOUSE_DATA     =3D 39,
> +    VMPORT_CMD_VMMOUSE_STATUS   =3D 40,
> +    VMPORT_CMD_VMMOUSE_COMMAND  =3D 41,
> +    VMPORT_ENTRIES
> +} VMPortCommand;
> +
>   static inline void vmport_init(ISABus *bus)
>   {
>       isa_create_simple(bus, TYPE_VMPORT);
>   }
>  =20
> -void vmport_register(unsigned char command, VMPortReadFunc *func, void *=
opaque);
> +void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *=
opaque);
>   void vmmouse_get_data(uint32_t *data);
>   void vmmouse_set_data(const uint32_t *data);
>  =20
>=20


