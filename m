Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EF020772
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EF020772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYgp-0001cf-Cb
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpYg9-0000zn-O2; Sun, 28 Jun 2020 10:53:09 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:58507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpYg6-0000Mc-Gy; Sun, 28 Jun 2020 10:53:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C6550746307;
 Sun, 28 Jun 2020 16:53:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 81F8074594E; Sun, 28 Jun 2020 16:53:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7FE9B7456F8;
 Sun, 28 Jun 2020 16:53:02 +0200 (CEST)
Date: Sun, 28 Jun 2020 16:53:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 09/11] macio: Add dummy screamer register area
In-Reply-To: <alpine.BSF.2.22.395.2006281627240.21756@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006281633240.21756@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <ecaaee4ba802b7a53de03e401c4d68e94de554f5.1592315226.git.balaton@eik.bme.hu>
 <3012998c-8345-f654-1de1-dd623ef375e8@ilande.co.uk>
 <alpine.BSF.2.22.395.2006281406340.95193@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006281555030.21756@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006281627240.21756@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With increasing screamer buffer size (you may want to fix this and 
prevent buffer overflows, maybe should allocate it dynamically based on 
what the guest programs?):

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 75f1853a7b..05b289e086 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -108,7 +108,7 @@ typedef struct Core99MachineState {
  #define TYPE_SCREAMER "screamer"
  #define SCREAMER(obj) OBJECT_CHECK(ScreamerState, (obj), TYPE_SCREAMER)

-#define SCREAMER_BUFFER_SIZE 0x4000
+#define SCREAMER_BUFFER_SIZE 0x8000

  typedef struct ScreamerState {
      /*< private >*/

it now plays the startup chord and goes further but ends up accessing some 
unassigned memory (I think it probably wants to map framebuffer or detect 
PCI devices but something is not yet right, I don't see it talking to PCI 
devices yet):

SCREAMER: Processing deferred buffer
SCREAMER: DMA TX transfer: addr 58100 len: 8000  bpos: 0
SCREAMER: DMA TX defer interrupt!
SCREAMER: ########### AUDIO WRITE! 0 / 32768 - 11152
SCREAMER: ########### AUDIO WRITE! 11152 / 32768 - 4128
SCREAMER: ########### AUDIO WRITE! 15280 / 32768 - 1104
SCREAMER: ########### AUDIO WRITE! 16384 / 32768 - 7024
SCREAMER: ########### AUDIO WRITE! 23408 / 32768 - 4128
SCREAMER: ########### AUDIO WRITE! 27536 / 32768 - 4128
SCREAMER: ########### AUDIO WRITE! 31664 / 32768 - 1104
SCREAMER: Processing deferred buffer
SCREAMER: DMA TX transfer: addr 60100 len: 2b60  bpos: 0
SCREAMER: screamer_write: addr 0000000000000001 val 1280
SCREAMER: screamer_codec_write: addr 0000000000000001 val 280
SCREAMER: setting mute: 0, attenuation L: 0 R: 0
SCREAMER: screamer_read: addr 0000000000000002 -> 403100
SCREAMER: screamer_read: addr 0000000000000001 -> 1280
SCREAMER: screamer_write: addr 0000000000000001 val 6002
SCREAMER: screamer_codec_write: addr 0000000000000006 val 2
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_data_send send: 0x01
cuda_delay_set_sr_int
cuda_data_send send: 0x22
cuda_delay_set_sr_int
cuda_data_send send: 0x8a
cuda_delay_set_sr_int
cuda_data_send send: 0x01
cuda_delay_set_sr_int
cuda_data_send send: 0x6f
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_packet_receive length 5
cuda_packet_receive_data [0] 0x01
cuda_packet_receive_data [1] 0x22
cuda_packet_receive_data [2] 0x8a
cuda_packet_receive_data [3] 0x01
cuda_packet_receive_data [4] 0x6f
cuda_receive_packet_cmd handling command GET_SET_IIC
CUDA: unimplemented GET_SET_IIC write 0x45 3
CUDA: GET_SET_IIC: wrong parameters 4
cuda_packet_send length 4
cuda_packet_send_data [0] 0x02
cuda_packet_send_data [1] 0x05
cuda_packet_send_data [2] 0x01
cuda_packet_send_data [3] 0x22
cuda_delay_set_sr_int
cuda_data_recv recv: 0x02
cuda_delay_set_sr_int
cuda_data_recv recv: 0x05
cuda_delay_set_sr_int
cuda_data_recv recv: 0x01
cuda_delay_set_sr_int
cuda_data_recv recv: 0x22
cuda_delay_set_sr_int
cuda_delay_set_sr_int
pci_cfg_read grackle 00:0 @0x8 -> 0x6000140
pci_cfg_read grackle 00:0 @0xa8 -> 0x40e0c
pci_cfg_write grackle 00:0 @0xa8 <- 0x40e0e
pci_cfg_read grackle 00:0 @0xac -> 0x2000000
pci_cfg_write grackle 00:0 @0xac <- 0x82470284
pci_cfg_write grackle 00:0 @0xac <- 0xc2470284
SCREAMER: ########### AUDIO WRITE! 0 / 11104 - 11104
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0xb000000
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0xb000000
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0xb000000
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0xb000000
Unassigned mem write 00000000f3011190 = 0x9000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem read 00000000f3011190
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem read 00000000f3011190
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem read 00000000f3011190
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem read 00000000f3011190
Unassigned mem write 00000000f3011190 = 0x1000000
Unassigned mem write 00000000f3011190 = 0x3000000
Unassigned mem read 00000000f3011190
[bunch of more accesses to this address...]
Unassigned mem read 00000000f3011170
Unassigned mem read 00000000f3011170
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_data_send send: 0x01
cuda_delay_set_sr_int
cuda_data_send send: 0x25
cuda_delay_set_sr_int
cuda_data_send send: 0xa6
cuda_delay_set_sr_int
cuda_data_send send: 0x00
cuda_delay_set_sr_int
cuda_data_send send: 0xa7
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_packet_receive length 5
cuda_packet_receive_data [0] 0x01
cuda_packet_receive_data [1] 0x25
cuda_packet_receive_data [2] 0xa6
cuda_packet_receive_data [3] 0x00
cuda_packet_receive_data [4] 0xa7
cuda_receive_packet_cmd handling command COMBINED_FORMAT_IIC
CUDA: COMBINED_FORMAT_IIC: wrong parameters 4
cuda_packet_send length 4
cuda_packet_send_data [0] 0x02
cuda_packet_send_data [1] 0x05
cuda_packet_send_data [2] 0x01
cuda_packet_send_data [3] 0x25
cuda_delay_set_sr_int
cuda_data_recv recv: 0x02
cuda_delay_set_sr_int
cuda_data_recv recv: 0x05
cuda_delay_set_sr_int
cuda_data_recv recv: 0x01
cuda_delay_set_sr_int
cuda_data_recv recv: 0x25
cuda_delay_set_sr_int
cuda_data_send send: 0x00
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_packet_receive length 1
cuda_packet_receive_data [0] 0x00
cuda_packet_send length 3
cuda_packet_send_data [0] 0x00
cuda_packet_send_data [1] 0x00
cuda_packet_send_data [2] 0x25
cuda_delay_set_sr_int
cuda_data_recv recv: 0x00
cuda_delay_set_sr_int
cuda_data_recv recv: 0x00
cuda_delay_set_sr_int
cuda_data_recv recv: 0x25
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_data_send send: 0x01
cuda_delay_set_sr_int
cuda_data_send send: 0x01
cuda_delay_set_sr_int
cuda_data_send send: 0xff
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_packet_receive length 3
cuda_packet_receive_data [0] 0x01
cuda_packet_receive_data [1] 0x01
cuda_packet_receive_data [2] 0xff
cuda_receive_packet_cmd handling command AUTOPOLL
cuda_packet_send length 3
cuda_packet_send_data [0] 0x01
cuda_packet_send_data [1] 0x00
cuda_packet_send_data [2] 0x01
cuda_delay_set_sr_int
cuda_data_recv recv: 0x01
cuda_delay_set_sr_int
cuda_data_recv recv: 0x00
cuda_delay_set_sr_int
cuda_data_recv recv: 0x01
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_data_send send: 0x00
cuda_delay_set_sr_int
cuda_data_send send: 0x2f
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_packet_receive length 2
cuda_packet_receive_data [0] 0x00
cuda_packet_receive_data [1] 0x2f
cuda_packet_send length 4
cuda_packet_send_data [0] 0x00
cuda_packet_send_data [1] 0x00
cuda_packet_send_data [2] 0x02
cuda_packet_send_data [3] 0x01
cuda_delay_set_sr_int
cuda_data_recv recv: 0x00
cuda_delay_set_sr_int
cuda_data_recv recv: 0x00
cuda_delay_set_sr_int
cuda_data_recv recv: 0x02
cuda_delay_set_sr_int
cuda_data_recv recv: 0x01
cuda_delay_set_sr_int
cuda_delay_set_sr_int
pci_cfg_read grackle 00:0 @0x3c -> 0x0
pci_cfg_read grackle 00:0 @0x3c -> 0x0
pci_cfg_write grackle 00:0 @0x3f <- 0x0
pci_cfg_write grackle 00:0 @0x3c <- 0x0
pci_cfg_write grackle 00:0 @0x3d <- 0x0
pci_cfg_write grackle 00:0 @0x3e <- 0x0
cuda_data_send send: 0x00
cuda_delay_set_sr_int
cuda_data_send send: 0x00
cuda_delay_set_sr_int
cuda_delay_set_sr_int
cuda_packet_receive length 2
cuda_packet_receive_data [0] 0x00
cuda_packet_receive_data [1] 0x00
cuda_packet_send length 3
cuda_packet_send_data [0] 0x00
cuda_packet_send_data [1] 0x00
cuda_packet_send_data [2] 0x00
cuda_delay_set_sr_int
Unassigned mem read 000000000fefe7b0
Unassigned mem write 000000000feffffc = 0x0
Unassigned mem write 000000000feffff8 = 0x0
[...]
Unassigned mem write 000000000febe018 = 0x0
Unassigned mem write 000000000febe014 = 0x0
Unassigned mem write 000000000febe010 = 0x0
Unassigned mem write 000000000febe00c = 0x0
Unassigned mem write 000000000febe008 = 0x0
Unassigned mem write 000000000febe004 = 0x0
Unassigned mem write 000000000febe000 = 0x0
Unassigned mem write 000000000fefe908 = 0x0
Unassigned mem write 000000000fefe90c = 0x0
Unassigned mem write 000000000fefefbc = 0x0
Unassigned mem write 000000000fefefb8 = 0x0
Unassigned mem write 000000000fefefb4 = 0x0
Unassigned mem write 000000000fefefb0 = 0x0
Unassigned mem write 000000000fefefac = 0x0
Unassigned mem write 000000000fefefa8 = 0x0
Unassigned mem write 000000000fefefa4 = 0x20000
Unassigned mem write 000000000fefefa0 = 0x2
Unassigned mem write 000000000fefef9c = 0x10000
Unassigned mem write 000000000fefef98 = 0x0
Unassigned mem write 000000000fefef94 = 0x0
Unassigned mem write 000000000fefef90 = 0x0
Unassigned mem write 000000000fefef8c = 0x0
Unassigned mem write 000000000fefef88 = 0x0
Unassigned mem write 000000000fefef84 = 0x0
Unassigned mem write 000000000fefef80 = 0x0
Unassigned mem write 000000000fefef7c = 0x0
Unassigned mem write 000000000fefef78 = 0x0
Unassigned mem write 000000000fefef74 = 0x0
Unassigned mem write 000000000fefef70 = 0x0
Unassigned mem write 000000000fefef6c = 0xfee5e8
Unassigned mem write 000000000fefef68 = 0x3fb97a0
Unassigned mem write 000000000fefef64 = 0x3fb97a0
Unassigned mem write 000000000fefef60 = 0x0
Unassigned mem write 000000000fefed5c = 0x0
Unassigned mem write 000000000fefed58 = 0x0
Unassigned mem write 000000000fefed54 = 0x0
Unassigned mem write 000000000fefed50 = 0x0
Unassigned mem write 000000000fefed4c = 0x0
Unassigned mem write 000000000fefed48 = 0x0
Unassigned mem write 000000000fefed44 = 0x0
Unassigned mem write 000000000fefed40 = 0x0
Unassigned mem write 000000000fefed3c = 0x0
Unassigned mem write 000000000fefed38 = 0x0
[...]
Unassigned mem write 000000000fefed64 = 0x0
Unassigned mem write 000000000fefed60 = 0x0
Unassigned mem write 000000000fefe630 = 0xfff0d000
Unassigned mem write 000000000fefe5b0 = 0xfff16880
Unassigned mem write 000000000fefec4c = 0x100000
Unassigned mem write 000000000fefe634 = 0xfeff000
Unassigned mem write 000000000fefe638 = 0xfebe000
Unassigned mem write 000000000fefe63c = 0x10000000
Unassigned mem write 000000000fefe640 = 0x0
Unassigned mem write 000000000fefe644 = 0x0
Unassigned mem write 000000000fefe648 = 0x6806e740
Unassigned mem write 000000000fefe64c = 0xfff10000
Unassigned mem write 000000000fefe650 = 0xfff11400
Unassigned mem write 000000000fefe654 = 0x68fff100
Unassigned mem write 000000000fefe658 = 0xfeff100
Unassigned mem write 000000000fefe65c = 0xfeff100
Unassigned mem write 000000000fefe670 = 0x200000
Unassigned mem write 000000000fefe678 = 0xff9fffff
Unassigned mem write 000000000fefe674 = 0xe00000
Unassigned mem write 000000000fefe67c = 0xfeff070
Unassigned mem write 000000000fefe680 = 0x7c
Unassigned mem write 000000000fefe688 = 0x12
Unassigned mem write 000000000fefe684 = 0xfefe920
Unassigned mem write 000000000fefe66c = 0xfefeab8
Unassigned mem write 000000000fefe910 = 0x0
Unassigned mem write 000000000fefefc0 = 0x5fffefc0
Unassigned mem write 000000000fefefc4 = 0x0
Unassigned mem write 000000000fefefc8 = 0x5fffeb20
Unassigned mem write 000000000fefefcc = 0x100
Unassigned mem write 000000000fefefce = 0x80
Unassigned mem write 000000000fefefd0 = 0x5fffeba0
Unassigned mem write 000000000fefefd4 = 0x102
Unassigned mem write 000000000fefefd6 = 0xa0
Unassigned mem write 000000000fefefd8 = 0x5fffef60
Unassigned mem write 000000000fefefdc = 0x101
Unassigned mem write 000000000fefefde = 0x60
Unassigned mem write 000000000fefefe0 = 0x5fffee60
Unassigned mem write 000000000fefefe4 = 0x101
Unassigned mem write 000000000fefefe6 = 0x100
Unassigned mem write 000000000fefefe8 = 0x5fffed60
Unassigned mem write 000000000fefefec = 0x100
Unassigned mem write 000000000fefefee = 0x100
Unassigned mem write 000000000fefeff0 = 0x5fffec40
Unassigned mem write 000000000fefeff4 = 0x105
Unassigned mem write 000000000fefeff6 = 0x120
Unassigned mem write 000000000fefeff8 = 0x5fffef60
Unassigned mem write 000000000fefeffc = 0x101
Unassigned mem write 000000000fefeffe = 0x60
Unassigned mem write 000000000fefff00 = 0x426f6f74
Unassigned mem write 000000000fefff04 = 0x20476f73
Unassigned mem write 000000000fefff08 = 0x73616d65
Unassigned mem write 000000000fefff0c = 0x7220302e
Unassigned mem write 000000000feff184 = 0x6806e6f4
Unassigned mem write 000000000feff194 = 0x68fff000
Unassigned mem write 000000000feff19c = 0x68080000
Unassigned mem read 000000000fefe648
Unassigned mem write 000000000feff15c = 0x0
Unassigned mem read 000000000fefe640
Unassigned mem read 000000000fefe640
Unassigned mem read 000000000fefec10
Unassigned mem write 000000000fefef60 = 0x80301
Unassigned mem read 000000000fefe64c
Unassigned mem write 000000000fefef90 = 0x0
Unassigned mem write 000000000fefef8c = 0x0
Unassigned mem write 000000000fefef88 = 0x0
Unassigned mem write 000000000fefef84 = 0x0
Unassigned mem write 000000000fefef80 = 0x0
Unassigned mem write 000000000fefef7c = 0x0
Unassigned mem write 000000000fefef78 = 0x0
Unassigned mem write 000000000fefef74 = 0x0
Unassigned mem write 000000000fefef70 = 0x0
Trying to write invalid spr 0 (0x000) at fff10d38
Unassigned mem read 000000000fefe64c
Unassigned mem write 000000000fefe37c = 0x44e0
Unassigned mem read 000000000fefe37c
invalid/unsupported opcode: 00 - 00 - 00 - 00 (00000000) 00000000 0
Unassigned mem read 000000000fefe37c
Unassigned mem read 000000000fefe37c
Unassigned mem read 000000000fefe37c
Unassigned mem read 000000000fefe37c
Unassigned mem read 000000000fefe37c

Then hangs here. Any idea what should be at 0xf3000000 and how that should 
end up there and why it pokes 0x0fexxxxx (is that where it thinks the 
frame buffer or some other devices should be because of something not read 
correctly from 0xf3000000 area? Should that be the PCI devices but those 
are expected to be at 0xfe000000 not 0x0fe00000. I stop here now waiting 
for contribution to fix this up, this needs more knowledge about the 
hardware that I have or want to learn at the moment.

Regards,
BALATON Zoltan

