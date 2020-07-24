Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39F6C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974B720656
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974B720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fel.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyE2-0002D6-RV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1jyuIm-0001Fj-HW
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:47:40 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:51619)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@fel.cvut.cz>) id 1jyuIj-0001f4-PC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:47:40 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 06O9kU6Y056629;
 Fri, 24 Jul 2020 11:46:30 +0200 (CEST)
 (envelope-from pisa@fel.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 06O9kUsR008463; Fri, 24 Jul 2020 11:46:30 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 06O9kUWI008460;
 Fri, 24 Jul 2020 11:46:30 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@fel.cvut.cz using -f
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v1 5/6] hw/net/can: CTU CAN FD IP open hardware core
 emulation.
Date: Fri, 24 Jul 2020 11:46:29 +0200
User-Agent: KMail/1.9.10
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <4e61e618c56fdb2034f3875f8b19635d33d2efbf.1594725647.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <4e61e618c56fdb2034f3875f8b19635d33d2efbf.1594725647.git.pisa@cmp.felk.cvut.cz>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202007241146.29424.pisa@fel.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 06O9kU6Y056629
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.841, required 6, autolearn=not spam, BAYES_00 -0.50,
 KHOP_HELO_FCRDNS 0.00, NICE_REPLY_A -0.34, SPF_HELO_NONE 0.00,
 SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@fel.cvut.cz
X-FELK-MailScanner-Watermark: 1596188792.11758@9F6R/Wyq/ZNmYzItmmKIuw
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@fel.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 05:47:30
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2020 09:54:21 -0400
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
Cc: Marek Vasut <marex@denx.de>, Jiri Novak <jnovak@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Ondrej Ille <ondrej.ille@gmail.com>,
 Jan Charvat <charvj10@fel.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello everybody,

I have tested Linux kernel and driver build on big-endian system
(MIPS MALTA) emulated on x86_64 host.

qemu-system-mips  -m 256 -M malta \
      -kernel vmlinuz-malta \
      -initrd ramdisk.cpio \
      -append "root=/dev/ram console=ttyS0 nokaslr" \
      -object can-bus,id=canbus0-bus \
      -object can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \
      -device kvaser_pci,canbus=canbus0-bus \
      -device ctucan_pci,canbus0=canbus0-bus,canbus1=canbus0-bus \
      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
      -nographic \

The emulation seems to be correct but driver has predicted issue
on big-endian system.

Next patch solves driver issue

https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/-/blob/master/driver/ctu_can_fd_hw.c#L581

diff --git a/driver/ctu_can_fd_hw.c b/driver/ctu_can_fd_hw.c
index 95c98bf5..de7f89c7 100644
--- a/driver/ctu_can_fd_hw.c
+++ b/driver/ctu_can_fd_hw.c
@@ -580,7 +580,7 @@ void ctucan_hw_read_rx_frame_ffw(struct ctucan_hw_priv *priv,
        /* Data */
        for (i = 0; i < cf->len; i += 4) {
                u32 data = priv->read_reg(priv, CTU_CAN_FD_RX_DATA);
-               *(u32 *)(cf->data + i) = data;
+               *(__le32 *)(cf->data + i) = cpu_to_le32(data);
        }
 }

@@ -733,7 +733,7 @@ bool ctucan_hw_insert_frame(struct ctucan_hw_priv *priv,

        if (!(cf->can_id & CAN_RTR_FLAG)) {
                for (i = 0; i < cf->len; i += 4) {
-                       u32 data = *(u32 *)(cf->data + i);
+                       u32 data = le32_to_cpu(*(__le32 *)(cf->data + i));

                        ctucan_hw_write_txt_buf(priv, buf_base,
                                        CTU_CAN_FD_DATA_1_4_W + i, data);

If there is not some stronger argument to use __cpu_to_le32p or __le32_to_cpup
for the kernel I plan to adapt userspace debug and test build of the driver
to accept __le32 and le32_to_cpu in the sources. QEMU helped to confirm need
of the endiannes swap on big-endian systems.

As for QEMU, I expect that when run on big-endian host there would be the same
problem in the emulation part.

So we need to decide where to swap endianness. If at the time to memory write into
Tx buffer reflecting workds on the PCIe card or when data from the CTU CAN FD IP core
buffers are copyed to the CAN frame send into QEMU virtual CAN bus. The location
in the source is higlighted inline in a patch

On Tuesday 14 of July 2020 14:20:18 pisa@cmp.felk.cvut.cz wrote:
> From: Jan Charvat <charvj10@fel.cvut.cz>
>
> The implementation of the model of complete open-source/design/hardware
> CAN FD controller. The IP core project has been started and is maintained
> by Ondrej Ille at Czech Technical University in Prague.
>
> CTU CAN FD project pages:
> 	https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
>
> CAN bus CTU FEE Projects Listing page:
> 	http://canbus.pages.fel.cvut.cz/
>
> The core is mapped to PCIe card same as on one of its real hardware
> adaptations. The device implementing two CTU CAN FD ip cores
> is instantiated after CAN bus definition
>
> 	-object can-bus,id=canbus0-bus
>
> by QEMU parameters
>
> 	-device ctucan_pci,canbus0=canbus0-bus,canbus1=canbus0-bus
>
> Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

...

> +static void ctucan_buff2frame(const uint8_t *buff, qemu_can_frame *frame)
> +{
> +    frame->can_id = 0;
> +    frame->can_dlc = 0;
> +    frame->flags = 0;
> +
> +    if (buff == NULL) {
> +        return;
> +    }
> +    {
> +        union ctu_can_fd_frame_form_w frame_form_w;
> +        union ctu_can_fd_identifier_w identifier_w;
> +        unsigned int ide;
> +
> +        frame_form_w = *(union ctu_can_fd_frame_form_w *) buff;
> +        frame->can_dlc = can_dlc2len(frame_form_w.s.dlc);
> +
> +        identifier_w = *(union ctu_can_fd_identifier_w *) (buff + 4);
> +
> +        ide = frame_form_w.s.ide;
> +        if (ide) {
> +            frame->can_id = (identifier_w.s.identifier_base << 18) |
> +                            identifier_w.s.identifier_ext;
> +            frame->can_id |= QEMU_CAN_EFF_FLAG;
> +        } else {
> +            frame->can_id = identifier_w.s.identifier_base;
> +        }
> +
> +        if (frame_form_w.s.esi_rsv) {
> +            frame->flags |= QEMU_CAN_FRMF_ESI;
> +        }
> +
> +        if (frame_form_w.s.rtr) {
> +            frame->can_id |= QEMU_CAN_RTR_FLAG;
> +        }
> +
> +        if (frame_form_w.s.fdf) {   /*CAN FD*/
> +            frame->flags |= QEMU_CAN_FRMF_TYPE_FD;
> +            if (frame_form_w.s.brs) {
> +                frame->flags |= QEMU_CAN_FRMF_BRS;
> +            }
> +        }
> +    }
> +
> +    memcpy(frame->data, buff + 0x10, 0x40);

The place where content of sequence of 32-bit card registers region
is transformed into SocketCAN like QEMU CAN frame.

> +}
> +
> +
> +static int ctucan_frame2buff(const qemu_can_frame *frame, uint8_t *buff)
> +{
> +    unsigned int bytes_cnt = -1;
> +    memset(buff, 0, CTUCAN_MSG_MAX_LEN * sizeof(*buff));
> +
> +    if (frame == NULL) {
> +        return bytes_cnt;
> +    }
> +    {
> +        union ctu_can_fd_frame_form_w *frame_form_w;
> +        union ctu_can_fd_identifier_w *identifier_w;
> +        frame_form_w = (union ctu_can_fd_frame_form_w *) buff;
> +        identifier_w = (union ctu_can_fd_identifier_w *) (buff + 4);
> +
> +        frame_form_w->u32 = 0;
> +        identifier_w->u32 = 0;
> +
> +        bytes_cnt = frame->can_dlc;
> +        bytes_cnt = (bytes_cnt + 3) & ~3;
> +        bytes_cnt += 16;
> +        frame_form_w->s.rwcnt = (bytes_cnt >> 2) - 1;
> +
> +        frame_form_w->s.dlc = can_len2dlc(frame->can_dlc);
> +
> +        if (frame->can_id & QEMU_CAN_EFF_FLAG) {
> +            frame_form_w->s.ide = 1;
> +            identifier_w->s.identifier_base =
> +                                    (frame->can_id & 0x1FFC0000) >> 18;
> +            identifier_w->s.identifier_ext = frame->can_id & 0x3FFFF;
> +        } else {
> +            identifier_w->s.identifier_base = frame->can_id & 0x7FF;
> +        }
> +
> +        if (frame->flags & QEMU_CAN_FRMF_ESI) {
> +            frame_form_w->s.esi_rsv = 1;
> +        }
> +
> +        if (frame->can_id & QEMU_CAN_RTR_FLAG) {
> +            frame_form_w->s.rtr = 1;
> +        }
> +
> +        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {  /*CAN FD*/
> +           frame_form_w->s.fdf = 1;
> +            if (frame->flags & QEMU_CAN_FRMF_BRS) {
> +                frame_form_w->s.brs = 1;
> +            }
> +        }
> +    }
> +
> +    memcpy(buff + 0x10, frame->data, 0x40);

The place where QEMU CAN frame data are used to fill sequence of 32-bit card registers
region.

> +
> +    return bytes_cnt;
> +}

...

> +void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
> +                       unsigned size)
> +{
> +    int              i;
> +
> +    DPRINTF("write 0x%02llx addr 0x%02x\n",
> +            (unsigned long long)val, (unsigned int)addr);
> +
> +    if (addr > CTUCAN_CORE_MEM_SIZE) {
> +        return;
> +    }
> +
> +    if (addr >= CTU_CAN_FD_TXTB1_DATA_1) {
> +        int buff_num;
> +        addr -= CTU_CAN_FD_TXTB1_DATA_1;
> +        buff_num = addr / CTUCAN_CORE_TXBUFF_SPAN;
> +        addr %= CTUCAN_CORE_TXBUFF_SPAN;
> +        if (buff_num < CTUCAN_CORE_TXBUF_NUM) {
> +            *(uint32_t *)(s->tx_buffer[buff_num].data + addr) = val;

Location where CPU write is transformed into IP CORE state changes, transmit
buffer write


...
> +uint64_t ctucan_mem_read(CtuCanCoreState *s, hwaddr addr, unsigned size)
> +{
...
> +    case CTU_CAN_FD_RX_DATA:
> +        if (s->rx_cnt) {
> +            memcpy(&val, s->rx_buff + s->rx_tail_pos, 4);

Read of Rx FIFO buffer data as response of CPU read request. The FIFO holds
sequence of frame control data, frame identifier and actual data in consecutive
32-bit words

> +            if (!s->rx_frame_rem) {
> +                union ctu_can_fd_frame_form_w frame_form_w;
> +                frame_form_w.u32 = val;
> +                s->rx_frame_rem = frame_form_w.s.rwcnt * 4 + 4;
> +            }
> +            s->rx_cnt -= 4;
> +            s->rx_frame_rem -= 4;
> +            if (!s->rx_frame_rem) {
> +                s->rx_status_rx_settings.s.rxfrc--;
> +                if (!s->rx_status_rx_settings.s.rxfrc) {
> +                    s->status.s.rxne = 0;
> +                    s->status.s.idle = 1;
> +                    s->status.s.rxs = 0;
> +                }
> +            }
> +            s->rx_tail_pos = (s->rx_tail_pos + 4) % CTUCAN_RCV_BUF_LEN;
> +        } else {
> +            val = 0;
> +        }
> +        break;

...

The next problem is forgot printf in the PCIe integartion

> diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
> new file mode 100644
> index 0000000000..accc7f0fd9
> --- /dev/null
> +++ b/hw/net/can/ctucan_pci.c
...
> +static uint64_t ctucan_pci_id_cra_io_read(void *opaque, hwaddr addr,
> +                                          unsigned size)
> +{
...
> +    printf("addr=%lx,size=%x,tmp=%lx\n", addr, size, tmp);
> +    return tmp;
> +}

Please send me hint how to move project forward. What is preferred
endianness solution for QEMU a if I should resend whole series
or the first three patches extending QEMU CAN bus support
to CAN FD support can be accepted as they are (there has been no issue
or even formating problem reported) can be accepted as they are
and  resent of patch 5/6 and 6/6 is enough.

Best wishes,

                Pavel Pisa
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/

