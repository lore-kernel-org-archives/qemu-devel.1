Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C232BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9696F21848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9696F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdD1-0006KR-Vy
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAcEk-0003Oo-Tn
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAcEi-00054B-Bx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAcEi-00053x-4q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:51:20 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39F6381DFF
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 15:51:19 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id g82so201653wmg.9
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OX00KpXKew5qKtzGXKFCwzcoz/kjXHE5bEEVyNPYc9Q=;
 b=Golps9NMKQIIhXaQcoVjJPC8xZzKIAhriugcP+2j/HpgRrJNFD63eniTVTYtST1Oae
 OsntjccB9o5fjjHnx5VQ3LlLBngZiQ8MVATRtsqAzaPAiCjFp5Dq4URFqZ/XaCSaB3Ex
 cfphgGYH943/CRpRvYAAarFufM67ZjypWFo6oIkFiXD5H8p4ZJBIP5pEAwMhb6Mw5y3j
 diuTm8jyjU6ctfXoxMYeiGfMmdTdDBNhFZDKwldXaLzQyq7QVmWAgizfawfXmj22JEjk
 eKI8E8xMzjPLEeqk/0vaNdpPN+xPrsgqPHoB2HSsZhrw0n16OsHSJwEB1/uLE/9zwt7P
 lSog==
X-Gm-Message-State: APjAAAWwLX+BE3sAeyfrTL4fn8iQ0ZKQ22j05jhiRf2EXC9Wx0r3GjgV
 YfJbGM3bIODflQNTP3kG50xJjPahaYhaSjMbNvCGRvLKzM2McEscFwWfHAFhL/9VDHE9hnHb74t
 UlzGSOyNUEuVV8YI=
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr3676812wru.227.1568821877974; 
 Wed, 18 Sep 2019 08:51:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpZmk8Hd10A03+127mIJfkIrZoYJSvMabGOt/1rBufaRMrIZn21+8kHj/WzjyV7pTOuXfxHQ==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr3676797wru.227.1568821877732; 
 Wed, 18 Sep 2019 08:51:17 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id y13sm12887899wrg.8.2019.09.18.08.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 08:51:17 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190918132112.10418-1-stefanha@redhat.com>
 <20190918132112.10418-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3fc89857-c46b-dbe1-194e-89dcbe2cd679@redhat.com>
Date: Wed, 18 Sep 2019 17:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918132112.10418-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 2/3] trace: Remove trailing newline in events
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
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 3:21 PM, Stefan Hajnoczi wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> While the tracing framework does not forbid trailing newline in
> events format string, using them lead to confuse output.
> It is the responsibility of the backend to properly end an event
> line.
>=20
> Some of our formats have trailing newlines, remove them.
>=20
> [Fixed typo in commit description reported by Eric Blake

Thanks for this!

> <eblake@redhat.com>
> --Stefan]
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-id: 20190916095121.29506-2-philmd@redhat.com
> Message-Id: <20190916095121.29506-2-philmd@redhat.com>

Out of curiosity, how do you end up with 2 slightly different
message-id? Using two different tools in series? (Thinking about
unifying these tools format).

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/misc/trace-events | 10 +++++-----
>  hw/scsi/trace-events |  2 +-
>  hw/sd/trace-events   |  2 +-
>  nbd/trace-events     |  4 ++--
>  net/trace-events     |  6 +++---
>  5 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c1ea1aa437..74276225f8 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -118,11 +118,11 @@ iotkit_secctl_ns_read(uint32_t offset, uint64_t d=
ata, unsigned size) "IoTKit Sec
>  iotkit_secctl_ns_write(uint32_t offset, uint64_t data, unsigned size) =
"IoTKit SecCtl NS regs write: offset 0x%x data 0x%" PRIx64 " size %u"
> =20
>  # imx6ul_ccm.c
> -ccm_entry(void) "\n"
> -ccm_freq(uint32_t freq) "freq =3D %d\n"
> -ccm_clock_freq(uint32_t clock, uint32_t freq) "(Clock =3D %d) =3D %d\n=
"
> -ccm_read_reg(const char *reg_name, uint32_t value) "reg[%s] <=3D 0x%" =
PRIx32 "\n"
> -ccm_write_reg(const char *reg_name, uint32_t value) "reg[%s] =3D> 0x%"=
 PRIx32 "\n"
> +ccm_entry(void) ""
> +ccm_freq(uint32_t freq) "freq =3D %d"
> +ccm_clock_freq(uint32_t clock, uint32_t freq) "(Clock =3D %d) =3D %d"
> +ccm_read_reg(const char *reg_name, uint32_t value) "reg[%s] <=3D 0x%" =
PRIx32
> +ccm_write_reg(const char *reg_name, uint32_t value) "reg[%s] =3D> 0x%"=
 PRIx32
> =20
>  # iotkit-sysinfo.c
>  iotkit_sysinfo_read(uint64_t offset, uint64_t data, unsigned size) "Io=
TKit SysInfo read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
> index 452b5994e6..b0820052f8 100644
> --- a/hw/scsi/trace-events
> +++ b/hw/scsi/trace-events
> @@ -28,7 +28,7 @@ mptsas_mmio_read(void *dev, uint32_t addr, uint32_t v=
al) "dev %p addr 0x%08x val
>  mptsas_mmio_unhandled_read(void *dev, uint32_t addr) "dev %p addr 0x%0=
8x"
>  mptsas_mmio_unhandled_write(void *dev, uint32_t addr, uint32_t val) "d=
ev %p addr 0x%08x value 0x%x"
>  mptsas_mmio_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr=
 0x%08x value 0x%x"
> -mptsas_process_message(void *dev, int msg, uint32_t ctx) "dev %p cmd %=
d context 0x%08x\n"
> +mptsas_process_message(void *dev, int msg, uint32_t ctx) "dev %p cmd %=
d context 0x%08x"
>  mptsas_process_scsi_io_request(void *dev, int bus, int target, int lun=
, uint64_t len) "dev %p dev %d:%d:%d length %"PRIu64""
>  mptsas_reset(void *dev) "dev %p "
>  mptsas_scsi_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t f=
ound) "dev %p context 0x%08x: %"PRIu64"/%"PRIu64""
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 52971dc033..efcff666a2 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -4,7 +4,7 @@
>  bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size) "of=
fset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned size) "o=
ffset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  bcm2835_sdhost_edm_change(const char *why, uint32_t edm) "(%s) EDM now=
 0x%x"
> -bcm2835_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x\n"
> +bcm2835_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x"
> =20
>  # core.c
>  sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg) "@%s CM=
D%02d arg 0x%08x"
> diff --git a/nbd/trace-events b/nbd/trace-events
> index f6cde96790..a955918e97 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -61,8 +61,8 @@ nbd_negotiate_begin(void) "Beginning negotiation"
>  nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "adv=
ertising size %" PRIu64 " and flags 0x%x"
>  nbd_negotiate_success(void) "Negotiation succeeded"
>  nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uin=
t64_t from, uint32_t len) "Got request: { magic =3D 0x%" PRIx32 ", .flags=
 =3D 0x%" PRIx16 ", .type =3D 0x%" PRIx16 ", from =3D %" PRIu64 ", len =3D=
 %" PRIu32 " }"
> -nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attachin=
g clients to AIO context %p\n"
> -nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching =
clients from AIO context %p\n"
> +nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attachin=
g clients to AIO context %p"
> +nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching =
clients from AIO context %p"
>  nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *=
errname, int len) "Send simple reply: handle =3D %" PRIu64 ", error =3D %=
" PRIu32 " (%s), len =3D %d"
>  nbd_co_send_structured_done(uint64_t handle) "Send structured reply do=
ne: handle =3D %" PRIu64
>  nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void *da=
ta, size_t size) "Send structured read data reply: handle =3D %" PRIu64 "=
, offset =3D %" PRIu64 ", data =3D %p, len =3D %zu"
> diff --git a/net/trace-events b/net/trace-events
> index ac57056497..02c13fd0ba 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -17,9 +17,9 @@ colo_compare_icmp_miscompare(const char *sta, int siz=
e) ": %s =3D %d"
>  colo_compare_ip_info(int psize, const char *sta, const char *stb, int =
ssize, const char *stc, const char *std) "ppkt size =3D %d, ip_src =3D %s=
, ip_dst =3D %s, spkt size =3D %d, ip_src =3D %s, ip_dst =3D %s"
>  colo_old_packet_check_found(int64_t old_time) "%" PRId64
>  colo_compare_miscompare(void) ""
> -colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int=
 hdlen, int pdlen, int offset, int flags) "%s: seq/ack=3D %u/%u hdlen=3D =
%d pdlen=3D %d offset=3D %d flags=3D%d\n"
> +colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int=
 hdlen, int pdlen, int offset, int flags) "%s: seq/ack=3D %u/%u hdlen=3D =
%d pdlen=3D %d offset=3D %d flags=3D%d"
> =20
>  # filter-rewriter.c
>  colo_filter_rewriter_debug(void) ""
> -colo_filter_rewriter_pkt_info(const char *func, const char *src, const=
 char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%=
s p: seq/ack=3D%u/%u  flags=3D0x%x\n"
> -colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=3D%u\n"
> +colo_filter_rewriter_pkt_info(const char *func, const char *src, const=
 char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%=
s p: seq/ack=3D%u/%u  flags=3D0x%x"
> +colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=3D%u"
>=20

