Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05682C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43F92073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXgIppP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43F92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0w3-000208-VK
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jK0uh-0000KN-V5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jK0uf-0000nt-Qp
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:33:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jK0ud-0000gs-UJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:33:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so4519888wrm.4
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mHZ6ym8A69U7vZrPntJZpcPKtAWrjDoU5MWj9xz1hFQ=;
 b=EXgIppP/qsw9mOGUuibjk9vEGyXPmf+v8jJ1ceEVog1Ckw1cxxKAe4EENSmbytNowa
 CzVqRaYmdvVGpu3PrhuiLh+qEMNwZQgDny7EoqHzLKBFshVo/yoRcE1pWJQkLqbiyb0O
 hsRYs/NSF4SV3TIepR14Cwj6GSBqvfFQRRwuoAX2ABbbFCR7J480oQItLNdTSyQ5Mmqo
 6E6KPsKKBm+bDwirkYM5D1fwDSYRE+8G4S2X/keJh7iyguTdIWOqArq9KiZdJl76fHBH
 hGbkYSjIMhfiPbcGe6ttt+IInVe8g+vswHPjk59usC/WY3zlAeEmMyohyOwWy0oOPT37
 0iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mHZ6ym8A69U7vZrPntJZpcPKtAWrjDoU5MWj9xz1hFQ=;
 b=J6E31MLfOdDkwt/cO1IBjvzze//pfe0PeQNW4AfcggLJ43BHYTCN+/WX5Zif5naK3H
 6H4fmDyCbc3QhBHNJHx+PD0U+ofwJIp4h2lvCF8W7XD7EinTnvKQnsFvsDUj1guQcdas
 kJ0X/id5fWhoQupJluSF8rPtvbp01UXDj/b7UMJUw+4SkDNBdfKKCy7kabFYLJbos6a+
 5Ofgn80THgHsUQMs/GPAQKbEdaPx26VDWTqDpUtYGWUCGmFo+mXApQlJuLpbj7MSeadq
 3BvMQv7WxlPHJquzjFNakJkqqK9kmSH7sZbYVMiIVICJuqdvMxW542/47AZGRXFKiXl2
 flFA==
X-Gm-Message-State: AGi0PuY+YNo64+wnWtsKC2h3xocxIrVaPyEp6l3zu2MQJ624Xte+S9qz
 yMZHANif+RNpKkWcNRLVCq1qbC87nbTi2wXFoPA=
X-Google-Smtp-Source: APiQypL1jAdROH6sJefg4YEvXDijNSlMYF1zyNCHD7rzGez+fvfMe5JSMVEb/fFwHgxY+bU1EBazVjXEdCDWOFj9YQM=
X-Received: by 2002:adf:c442:: with SMTP id a2mr1317414wrg.381.1585838022300; 
 Thu, 02 Apr 2020 07:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200402100302.833267-1-lvivier@redhat.com>
In-Reply-To: <20200402100302.833267-1-lvivier@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 2 Apr 2020 16:33:29 +0200
Message-ID: <CAJ+F1CLejBjX7Q6Ttb4jh96juPdWAGx8fvc3FRVSY-TfXJcoUQ@mail.gmail.com>
Subject: Re: [RFC 0/5] hmp, qmp: Add some commands to introspect virtio devices
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Apr 2, 2020 at 12:03 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> This series introduces new QMP/HMP commands to dump the status
> of a a virtio device at different levels.

Looks nice, but my feeling is that we are growing qemu with debugging
facilities in general with HMP/QMP.

If this is only for debugging purposes, why don't we compile it only
when --enable-debug?

A guest that would need to be debugged could have its state loaded in
a debug version of qemu.

Alternatively, I think most of the data you provide here could
probably be introspected via gdb scripts.

Just some thoughts

>
> 1. Main command
>
>  HMP Only:
>
>      virtio [subcommand]
>
>    Example:
>
>     List all sub-commands:
>
>     (qemu) virtio
>     virtio query  -- List all available virtio devices
>     virtio status path -- Display status of a given virtio device
>     virtio queue-status path queue -- Display status of a given virtio qu=
eue
>     virtio queue-element path queue [index] -- Display element of a given=
 virtio queue
>
> 2. List available virtio devices in the machine
>
>   HMP Form:
>
>     virtio query
>
>   Example:
>
>     (qemu) virtio query
>     /machine/peripheral-anon/device[3]/virtio-backend [virtio-net]
>     /machine/peripheral-anon/device[1]/virtio-backend [virtio-serial]
>     /machine/peripheral-anon/device[0]/virtio-backend [virtio-blk]
>
>   QMP Form:
>
>     { 'command': 'query-virtio', 'returns': ['VirtioInfo'] }
>
>   Example:
>
>   -> { "execute": "query-virtio" }
>   <- { "return": [
>          {
>              "path": "/machine/peripheral-anon/device[3]/virtio-backend",
>              "type": "virtio-net"
>          },
>          {
>              "path": "/machine/peripheral-anon/device[1]/virtio-backend",
>              "type": "virtio-serial"
>          },
>          {
>              "path": "/machine/peripheral-anon/device[0]/virtio-backend",
>              "type": "virtio-blk"
>          }
>        ]
>      }
>
> 3. Display status of a given virtio device
>
>   HMP Form:
>
>     virtio status <path>
>
>   Example:
>
>     (qemu) virtio status /machine/peripheral-anon/device[3]/virtio-backen=
d
>     /machine/peripheral-anon/device[3]/virtio-backend:
>       Device Id:        1
>       Guest features:   0x0000000130afffa7
>       Host features:    0x0000000179bfffe7
>       Backend features: 0x0000000000000000
>       Endianness:       little
>       VirtQueues:       3
>
>   QMP Form:
>
>     { 'command': 'virtio-status',
>       'data': { 'path': 'str' },
>       'returns': 'VirtioStatus'
>     }
>
>   Example:
>
>   -> { "execute": "virtio-status",
>        "arguments": {
>            "path": "/machine/peripheral-anon/device[3]/virtio-backend"
>        }
>     }
>   <- { "return": {
>            "backend_features": 0,
>            "guest_features": 5111807911,
>            "num_vqs": 3,
>            "host_features": 6337593319,
>            "device_endian": "little",
>            "device_id": 1
>        }
>      }
>
> 4. Display status of a given virtio queue
>
>   HMP Form:
>
>     virtio queue-status <path> <queue>
>
>   Example:
>
>     (qemu) virtio queue-status /machine/peripheral-anon/device[3]/virtio-=
backend 0
>     /machine/peripheral-anon/device[3]/virtio-backend:
>       index:                0
>       inuse:                0
>       last_avail_idx:       61
>       shadow_avail_idx:     292
>       signalled_used:       61
>       signalled_used_valid: 1
>       VRing:
>         num:         256
>         num_default: 256
>         align:       4096
>         desc:        0x000000006c352000
>         avail:       0x000000006c353000
>         used:        0x000000006c353240
>
>   QMP Form:
>
>     { 'command': 'virtio-queue-status',
>       'data': { 'path': 'str', 'queue': 'uint16' },
>       'returns': 'VirtQueueStatus'
>     }
>
>   Example:
>
>   -> { "execute": "virtio-queue-status",
>        "arguments": {
>            "path": "/machine/peripheral-anon/device[3]/virtio-backend",
>            "queue": 0
>        }
>     }
>   <- { "return": {
>        "signalled_used": 373,
>        "inuse": 0,
>        "vring_desc": 864411648,
>        "vring_num_default": 256,
>        "signalled_used_valid": 1,
>        "vring_avail": 864415744,
>        "last_avail_idx": 373,
>        "queue_index": 0,
>        "vring_used": 864416320,
>        "shadow_avail_idx": 619,
>        "used_idx": 373,
>        "vring_num": 256,
>        "vring_align": 4096
>        }
>      }
>
> 5. Display element of a given virtio queue
>
>   HMP Form:
>
>     virtio queue-element <path> <queue> [index]
>
>   Example:
>
>     Dump the information of the head element of the first queue of
>     the first virtio device::
>
>       (qemu) virtio queue-element/machine/peripheral-anon/device[3]/virti=
o-backend 0
>       index:  67
>       ndescs: 1
>       descs:  addr 0x6fe69800 len 1536 (write-only)
>
>       (qemu) xp/128bx 0x6fe69800
>       000000006fe69800: 0x02 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>       000000006fe69808: 0x00 0x00 0x01 0x00 0x52 0x54 0x00 0x12
>       000000006fe69810: 0x34 0x56 0x52 0x54 0x00 0x09 0x51 0xde
>       000000006fe69818: 0x08 0x00 0x45 0x00 0x00 0x4c 0x8f 0x32
>
>     device[3] is a virtio-net device and we can see in the element buffer=
 the
>     MAC address of the card::
>
>       [root@localhost ~]# ip link show ens4
>       2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel =
state UP m0
>           link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
>
>     and the MAC address of the gateway::
>
>       [root@localhost ~]# arp -a
>       _gateway (192.168.122.1) at 52:54:00:09:51:de [ether] on ens4
>
>   QMP Form:
>
>     { 'command': 'virtio-queue-element',
>       'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
>       'returns': 'VirtioQueueElement'
>     }
>
>   Example:
>
>   -> { "execute": "virtio-queue-element",
>        "arguments": {
>            "path": "/machine/peripheral-anon/device[3]/virtio-backend",
>            "queue": 0
>        }
>     }
>   -> { "return": {
>           "index": 109,
>           "len": 0,
>           "ndescs": 1,
>           "descs": [
>               { "flags": 2, "len": 2048, "addr": 853145600 }
>           ]
>        }
>     }
>
> Laurent Vivier (5):
>   qmp: add QMP command query-virtio
>   qmp: add QMP command virtio-status
>   qmp: add QMP command virtio-queue-status
>   qmp: add QMP command virtio-queue-element
>   hmp: add virtio commands
>
>  Makefile                   |   2 +-
>  Makefile.target            |   7 +-
>  docs/system/monitor.rst    |   2 +
>  hmp-commands-virtio.hx     | 148 ++++++++++++++++++
>  hmp-commands.hx            |  10 ++
>  hw/virtio/Makefile.objs    |   2 +
>  hw/virtio/virtio-stub.c    |  32 ++++
>  hw/virtio/virtio.c         | 313 +++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio.h |   1 +
>  include/monitor/hmp.h      |   4 +
>  monitor/misc.c             |  17 ++
>  qapi/Makefile.objs         |   2 +-
>  qapi/qapi-schema.json      |   1 +
>  qapi/virtio.json           | 302 +++++++++++++++++++++++++++++++++++
>  tests/qtest/qmp-cmd-test.c |   1 +
>  15 files changed, 840 insertions(+), 4 deletions(-)
>  create mode 100644 hmp-commands-virtio.hx
>  create mode 100644 hw/virtio/virtio-stub.c
>  create mode 100644 qapi/virtio.json
>
> --
> 2.25.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

