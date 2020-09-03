Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF38208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bRdZjP8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF38208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpes-00065h-OY
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kDpeF-0005NO-1Y; Thu, 03 Sep 2020 09:51:31 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com
 ([40.107.243.40]:45024 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kDpeC-00027i-ME; Thu, 03 Sep 2020 09:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOub1vHe+/JKsWLmrIYksWf6OjjqgOUGRbqg4ntSQ83rCMofKpqCsu+7VQ1nijVgpkW+jpXSnzgm8PK6lmcENx65dj5yFuYzZqhtABmsFgY/kCZfNuSWdsb7b1wLeksswkDnP2Nlv1JSWNYIl+l71isMBEuWc2aWr6+3KRIB3l/SHbkbciKGEsJ4TCMKBvhf5jJJAAhCmN2YmwVSLwH12EXC+rckkBSaVIB6OoqRS+1WMkvwhFhofNT8CtEzQdHqMPDYkEuqlI37Z3WguZosfllI82AquL/ONCPKlv35YPfgUQcrIU1crWjn1TxVAnJE4HkjztsoZzwfSbOLumQCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fjQrzWQevoHzbWicAcpRWe1XFh1MgLFOuVuBnw33bk=;
 b=G3zEeYYBYr9/FaLNPUl7f1Bc16XNH1RzGfj5LHMovYwPehyb0DhffDq5HIAukIpkEImchbB7KSBtOfhTSgsaVawgaHDzeiHifqItz/B4y5UB4wa+/IXBb++wFdiDyi+v2hZ+xxld2Umx01fSRBXvQZHGtGmNnYTmKY0XC2yhaCb0aLNrpsKLTJDsLB/yvlJ3+QXPtBq9/p1/Oa+Z9LC1P5QeeXYgwuFy8GA7+zZYcIx9Slwt7yn97XlV50711UFg2En12EK8Q7+9vuvZwcoi+DIJWdV0pb7TN1ZKOvtxpJtY3XwyoOIlS34mQfCF17aL7E7eCgJdo9SZwLbTEfUbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fjQrzWQevoHzbWicAcpRWe1XFh1MgLFOuVuBnw33bk=;
 b=bRdZjP8rE7OH4cYH+/GiYIBZZJIqX/bpK031LwVDIrqUIRB9JyS4kvNvblZyDbN7c6YxpEZ98pt4ihGEgnhvH0D9LkrNbLEqkchIOdoFtWZ6rOFV1gecOLtik0gAspPwkMo2fRhqUXPxoIcD1Qtp1mxYC/6dKmCnjRCbE6Us/1o=
Received: from SN6PR08CA0009.namprd08.prod.outlook.com (2603:10b6:805:66::22)
 by BN8PR02MB5940.namprd02.prod.outlook.com (2603:10b6:408:b8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 13:51:21 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::7c) by SN6PR08CA0009.outlook.office365.com
 (2603:10b6:805:66::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 3 Sep 2020 13:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 13:51:20
 +0000
Received: from [149.199.38.66] (port=50448 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kDpdy-0003KW-Dm; Thu, 03 Sep 2020 06:51:14 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kDpe4-0000aN-8I; Thu, 03 Sep 2020 06:51:20 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kDpe3-0000a9-Nx; Thu, 03 Sep 2020 06:51:19 -0700
Date: Thu, 3 Sep 2020 15:51:15 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 12/12] dma: Assert when device writes to indirect
 memory (such MMIO regions)
Message-ID: <20200903135115.GZ14249@toto>
References: <20200903110831.353476-1-philmd@redhat.com>
 <20200903110831.353476-13-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903110831.353476-13-philmd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce54a71e-a91d-42e1-dc42-08d85010704d
X-MS-TrafficTypeDiagnostic: BN8PR02MB5940:
X-Microsoft-Antispam-PRVS: <BN8PR02MB594044072C9AECFD7B5CE28DC22C0@BN8PR02MB5940.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQgzUxJVYaFRxkO+glVWpzc4Q0OlwLt3e4WQ97T67vvkZKH8A7OObgOpT244t4Ysa8XwWfTOTeHNWvPBQjHbqMxUpS/c66T7FAnyIRCrM0+GgYF9CbM99RY4iTNyWH2imEzpP7owQaRJcWAdrnKGuPld4lzoIv0haISQXd1KE0Jj+xzziAssezYcuRbb64FJ3AybEvIpPqHqbeTR6VuGgCM8DbTiFePV9C49U24Ojcx6IwFWxGMSghwVzS1PMcLw+IPNl39BOXvOzsUXOtsGBgLrlmUiIcobjQO/+nLTw4db6zD9gpOs3JYHQkL35XZdoIRCWhCqtsn+slRkeoWFm0xjUo6X8cN6TqnyAFNrXgIGJQRMHwsueNsJC6QIe9wim0uZcDPC3msB9xOS1rNh2w==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(39860400002)(346002)(376002)(396003)(46966005)(33656002)(4326008)(83380400001)(54906003)(82310400003)(7416002)(7406005)(336012)(186003)(426003)(316002)(6916009)(478600001)(81166007)(356005)(26005)(70206006)(70586007)(6666004)(2906002)(47076004)(82740400003)(9786002)(33716001)(8676002)(9686003)(5660300002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 13:51:20.6315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce54a71e-a91d-42e1-dc42-08d85010704d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5940
Received-SPF: pass client-ip=40.107.243.40; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 09:51:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Klaus Jensen <k.jensen@samsung.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 01:08:31PM +0200, Philippe Mathieu-Daudé wrote:
> Assert DMA accesses are done on direct memory (in particular
> to catch invalid accesses to MMIO regions).

Hi Philippe,

Is the motivation for this to make it easier to find DMA programming errors?
Shouldn't guest SW use the IOMMU/DMA-APIs to debug those?

There're valid use-cases where DMA devices target non-memory, in particular
in the embedded space but also on PCI systems.

Also, since guest SW programs the DMA registers, guest SW would be able to trig this assert at will...

Cheers,
Edgar




> 
> Example with the reproducer from LP#1886362 (see previous commit):
> 
>   qemu-system-i386: include/sysemu/dma.h:111: int dma_memory_rw(AddressSpace *, dma_addr_t, void *, dma_addr_t, DMADirection, MemTxAttrs): Assertion `dir == DMA_DIRECTION_TO_DEVICE || attrs.direct_access' failed.
>   (gdb) bt
>   #0  0x00007ffff51d69e5 in raise () at /lib64/libc.so.6
>   #1  0x00007ffff51bf895 in abort () at /lib64/libc.so.6
>   #2  0x00007ffff51bf769 in _nl_load_domain.cold () at /lib64/libc.so.6
>   #3  0x00007ffff51cee76 in annobin_assert.c_end () at /lib64/libc.so.6
>   #4  0x0000555557b48a94 in dma_memory_rw (as=0x7fffddd3ca28, addr=4064, buf=0x7fffffff7780, len=16, dir=DMA_DIRECTION_FROM_DEVICE, attrs=...) at /home/phil/source/qemu/include/sysemu/dma.h:111
>   #5  0x0000555557b487e0 in pci_dma_rw (dev=0x7fffddd3c800, addr=4064, buf=0x7fffffff7780, len=16, dir=DMA_DIRECTION_FROM_DEVICE) at /home/phil/source/qemu/include/hw/pci/pci.h:791
>   #6  0x0000555557b47373 in pci_dma_write (dev=0x7fffddd3c800, addr=4064, buf=0x7fffffff7780, len=16) at /home/phil/source/qemu/include/hw/pci/pci.h:804
>   #7  0x0000555557b340b4 in e1000e_write_packet_to_guest (core=0x7fffddd3f4e0, pkt=0x61100006c740, rxr=0x7fffffff7cf0, rss_info=0x7fffffff7d10) at hw/net/e1000e_core.c:1609
>   #8  0x0000555557b30739 in e1000e_receive_iov (core=0x7fffddd3f4e0, iov=0x619000060e80, iovcnt=4) at hw/net/e1000e_core.c:1709
>   #9  0x00005555576e2069 in e1000e_nc_receive_iov (nc=0x61400000a060, iov=0x619000060e80, iovcnt=4) at hw/net/e1000e.c:213
>   #10 0x00005555572a3c34 in net_tx_pkt_sendv (pkt=0x631000028800, nc=0x61400000a060, iov=0x619000060e80, iov_cnt=4) at hw/net/net_tx_pkt.c:556
>   #11 0x00005555572a23e2 in net_tx_pkt_send (pkt=0x631000028800, nc=0x61400000a060) at hw/net/net_tx_pkt.c:633
>   #12 0x00005555572a4c67 in net_tx_pkt_send_loopback (pkt=0x631000028800, nc=0x61400000a060) at hw/net/net_tx_pkt.c:646
>   #13 0x0000555557b70b05 in e1000e_tx_pkt_send (core=0x7fffddd3f4e0, tx=0x7fffddd5f748, queue_index=0) at hw/net/e1000e_core.c:664
>   #14 0x0000555557b6eab8 in e1000e_process_tx_desc (core=0x7fffddd3f4e0, tx=0x7fffddd5f748, dp=0x7fffffff8680, queue_index=0) at hw/net/e1000e_core.c:743
>   #15 0x0000555557b6d65d in e1000e_start_xmit (core=0x7fffddd3f4e0, txr=0x7fffffff88a0) at hw/net/e1000e_core.c:934
>   #16 0x0000555557b5ea38 in e1000e_set_tctl (core=0x7fffddd3f4e0, index=256, val=255) at hw/net/e1000e_core.c:2431
>   #17 0x0000555557b369ef in e1000e_core_write (core=0x7fffddd3f4e0, addr=1027, val=255, size=4) at hw/net/e1000e_core.c:3265
>   #18 0x00005555576de3be in e1000e_mmio_write (opaque=0x7fffddd3c800, addr=1027, val=255, size=4) at hw/net/e1000e.c:109
>   #19 0x0000555558e6b789 in memory_region_write_accessor (mr=0x7fffddd3f110, addr=1027, value=0x7fffffff8eb0, size=4, shift=0, mask=4294967295, attrs=...) at softmmu/memory.c:483
>   #20 0x0000555558e6b05b in access_with_adjusted_size (addr=1027, value=0x7fffffff8eb0, size=1, access_size_min=4, access_size_max=4, access_fn= 0x555558e6b120 <memory_region_write_accessor>, mr=0x7fffddd3f110, attrs=...) at softmmu/memory.c:544
>   #21 0x0000555558e69776 in memory_region_dispatch_write (mr=0x7fffddd3f110, addr=1027, data=255, op=MO_8, attrs=...) at softmmu/memory.c:1465
>   #22 0x0000555558f60462 in flatview_write_continue (fv=0x60600003f9e0, addr=3775005699, attrs=..., ptr=0x6020000e3710, len=1, addr1=1027, l=1, mr=0x7fffddd3f110) at exec.c:3176
>   #23 0x0000555558f4e38b in flatview_write (fv=0x60600003f9e0, addr=3775005699, attrs=..., buf=0x6020000e3710, len=1) at exec.c:3220
>   #24 0x0000555558f4dd4f in address_space_write (as=0x60800000baa0, addr=3775005699, attrs=..., buf=0x6020000e3710, len=1) at exec.c:3315
>   #25 0x000055555916b3e0 in qtest_process_command (chr=0x55555c03f300 <qtest_chr>, words=0x604000058150) at softmmu/qtest.c:567
>   #26 0x000055555915f7f2 in qtest_process_inbuf (chr=0x55555c03f300 <qtest_chr>, inbuf=0x6190000200e0) at softmmu/qtest.c:710
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/dma.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 8a7dbf0b0f3..a4ba9438a56 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -108,6 +108,8 @@ static inline int dma_memory_rw(AddressSpace *as, dma_addr_t addr,
>                                  void *buf, dma_addr_t len,
>                                  DMADirection dir, MemTxAttrs attrs)
>  {
> +    assert(dir == DMA_DIRECTION_TO_DEVICE || attrs.direct_access);
> +
>      dma_barrier(as, dir);
>  
>      return dma_memory_rw_relaxed(as, addr, buf, len, dir, attrs);
> -- 
> 2.26.2
> 

