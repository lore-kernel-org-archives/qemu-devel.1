Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3F520791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="roVtXm2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F520791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAYt-00067M-9y
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kEAYG-0005iT-FB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:10:44 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com
 ([40.107.223.89]:31360 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kEAYD-0000x1-Im
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dISbfElbtkbUZ6V6tAyoydaw10tyB+3CwuGSj+7pSuxfkpCP4RkXFcnARKAMSj+b0O5EhwGJNERZ/KUlFI0/1EWREzFV4l9sLwA20uz4vtIHAhd3bii5ue3wCeNroNah8SvxSoHGSDJaknOo6qKbjm3j7C4+1C3UzkeWrGD1Qe5GUvG1rYxZ1c6XVm4VSoeFYJ/g5npaCH55XIRTVdEacpPO3k6mjR64pEundOYHmRAQ7ADOb7GWTBzwIF9E0AOzuZYastljHVqPlyfUgbrSJz+UUxzE+QA81JKK8br22UqdDSzftt3BP7qSF0nqWXw2iRyfxF/9ralGPzivVM6f9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2HSpHl5zzy22pTiD56DMAfsn4DVxNpvf3Y+pPotk7Q=;
 b=DlhFlJgXUYWJadS1/GRKOb93QmI+hUb3pUDPVGSAWhrVdL0Mv4PtfcZNRSVi5DHT/R26hMP5NrSU7JA5q+sq4T0PHOf3izAC0D7bD2Q8YM+kpcbO3LaO+COOoyJi37GsHoSROH2GvPWFzgdD8kppwlCYBDAdT3WvjkWxVj60iP9F6Wzm8oc1hbrKNW/rpFFr+ak6vzKVN2GCRBABAUa0c1cCssi8ciF6sQDrU3YfxxBnUNrzxRaKTgH+kG/yvgmsG0R1G2ca25njMp7z2Rs1wP5jTQUPl4z5Y2uudFP397rOyGWcDRrYo4AFcpJiwoXsmUOHeNELAKoDUeqHkXn+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=amsat.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2HSpHl5zzy22pTiD56DMAfsn4DVxNpvf3Y+pPotk7Q=;
 b=roVtXm2/YNeVtS5BdYmtv/dSGdsQesIviCQrXbbaeeIx4BUxVlL8kxLDonYaLC8EAKSRq0+qiJJbJtrQhhdieNxfMgt/EZ0ld4aoyN5k3FpeJUv02Rdx6rw8uOJ+OA1V0HR16GQGbvmT/9T5N8jxhj/UbAbnFAMjeDkRRaEvLXs=
Received: from SN4PR0501CA0089.namprd05.prod.outlook.com
 (2603:10b6:803:22::27) by BYAPR02MB5654.namprd02.prod.outlook.com
 (2603:10b6:a03:9f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 12:10:38 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:22:cafe::4c) by SN4PR0501CA0089.outlook.office365.com
 (2603:10b6:803:22::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend
 Transport; Fri, 4 Sep 2020 12:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Fri, 4 Sep 2020 12:10:38
 +0000
Received: from [149.199.38.66] (port=51962 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAY2-0006tf-R7; Fri, 04 Sep 2020 05:10:30 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAYA-0001LZ-6Z; Fri, 04 Sep 2020 05:10:38 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 084CAZaY016396; 
 Fri, 4 Sep 2020 05:10:36 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAY7-0001Ku-HU; Fri, 04 Sep 2020 05:10:35 -0700
Date: Fri, 4 Sep 2020 14:10:31 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 04/12] target/microblaze: Rename mmu structs
Message-ID: <20200904121031.GM14249@toto>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
 <20200903072650.1360454-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903072650.1360454-5-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ea571c-e35a-4cd5-4aec-08d850cb8950
X-MS-TrafficTypeDiagnostic: BYAPR02MB5654:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5654D802CF4C11979B21EA4AC22D0@BYAPR02MB5654.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6A2+jEp0de6MyqdxsOrSJDp7YGwYbxLqllBDRv7Oi6OIeuxp9BJNzEqFfDm6YGpYzj4uf/IZFFbNIsyNcDTB+SJoz1NXWYtSOMuBTFrT5HyHazirwmfx+9laJZllsgf4mrh8D4AJQjAqN+y7Wr54t7gKm3ScS5JEh2Jo6xkFL0zaX3bhXzOwjYPBzcxMWL8zdaJPF5egp3KQSuzYprK23fFcmuo6ufe3EGG/P/tt91XVJdA47YRztg2ouf3QHZdV5P1wOEhEhePbMcKC5nHCwSmpxq/kCL0/paMD9YlsXIyg6RcSq26psU0rtWvCuF8wSbOoSg2/bfBM+7M6MTrwMWzP/DMelSR32aQN6aAMCHv5lhpQWf0QX9uL58dYqG77xca+mU4TUf1s/8a6xS9ykQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(39860400002)(396003)(346002)(376002)(136003)(46966005)(2906002)(82310400003)(6666004)(47076004)(316002)(9786002)(33656002)(356005)(4326008)(33716001)(9686003)(8936002)(83380400001)(82740400003)(5660300002)(1076003)(81166007)(426003)(478600001)(8676002)(26005)(70206006)(70586007)(186003)(6916009)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 12:10:38.5189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea571c-e35a-4cd5-4aec-08d850cb8950
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5654
Received-SPF: pass client-ip=40.107.223.89; envelope-from=edgar@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 08:10:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 12:26:42AM -0700, Richard Henderson wrote:
> Introduce typedefs and follow CODING_STYLE for naming.
> Rename struct microblaze_mmu to MicroBlazeMMU.
> Rename struct microblaze_mmu_lookup to MicroBlazeMMULookup.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  target/microblaze/cpu.h    |  2 +-
>  target/microblaze/mmu.h    | 15 ++++++---------
>  target/microblaze/helper.c |  4 ++--
>  target/microblaze/mmu.c    | 11 +++++------
>  4 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 32811f773d..20c2979396 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -278,7 +278,7 @@ struct CPUMBState {
>  
>  #if !defined(CONFIG_USER_ONLY)
>      /* Unified MMU.  */
> -    struct microblaze_mmu mmu;
> +    MicroBlazeMMU mmu;
>  #endif
>  
>      /* Fields up to this point are cleared by a CPU reset */
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 75e5301c79..c1feb811b9 100644
> --- a/target/microblaze/mmu.h
> +++ b/target/microblaze/mmu.h
> @@ -63,8 +63,7 @@
>  
>  #define TLB_ENTRIES    64
>  
> -struct microblaze_mmu
> -{
> +typedef struct {
>      /* Data and tag brams.  */
>      uint64_t rams[2][TLB_ENTRIES];
>      /* We keep a separate ram for the tids to avoid the 48 bit tag width.  */
> @@ -76,10 +75,9 @@ struct microblaze_mmu
>      int c_mmu_tlb_access;
>      int c_mmu_zones;
>      uint64_t c_addr_mask; /* Mask to apply to physical addresses.  */
> -};
> +} MicroBlazeMMU;
>  
> -struct microblaze_mmu_lookup
> -{
> +typedef struct {
>      uint32_t paddr;
>      uint32_t vaddr;
>      unsigned int size;
> @@ -88,13 +86,12 @@ struct microblaze_mmu_lookup
>      enum {
>          ERR_PROT, ERR_MISS, ERR_HIT
>      } err;
> -};
> +} MicroBlazeMMULookup;
>  
> -unsigned int mmu_translate(struct microblaze_mmu *mmu,
> -                           struct microblaze_mmu_lookup *lu,
> +unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
>                             target_ulong vaddr, int rw, int mmu_idx);
>  uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
>  void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
> -void mmu_init(struct microblaze_mmu *mmu);
> +void mmu_init(MicroBlazeMMU *mmu);
>  
>  #endif
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 27a24bb99a..3c2fd388fb 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -52,7 +52,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>  {
>      MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>      CPUMBState *env = &cpu->env;
> -    struct microblaze_mmu_lookup lu;
> +    MicroBlazeMMULookup lu;
>      unsigned int hit;
>      int prot;
>  
> @@ -235,7 +235,7 @@ hwaddr mb_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>      CPUMBState *env = &cpu->env;
>      target_ulong vaddr, paddr = 0;
> -    struct microblaze_mmu_lookup lu;
> +    MicroBlazeMMULookup lu;
>      int mmu_idx = cpu_mmu_index(env, false);
>      unsigned int hit;
>  
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 6e583d78d9..0546cfd0bc 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -35,7 +35,7 @@ static unsigned int tlb_decode_size(unsigned int f)
>  static void mmu_flush_idx(CPUMBState *env, unsigned int idx)
>  {
>      CPUState *cs = env_cpu(env);
> -    struct microblaze_mmu *mmu = &env->mmu;
> +    MicroBlazeMMU *mmu = &env->mmu;
>      unsigned int tlb_size;
>      uint32_t tlb_tag, end, t;
>  
> @@ -55,7 +55,7 @@ static void mmu_flush_idx(CPUMBState *env, unsigned int idx)
>  
>  static void mmu_change_pid(CPUMBState *env, unsigned int newpid) 
>  {
> -    struct microblaze_mmu *mmu = &env->mmu;
> +    MicroBlazeMMU *mmu = &env->mmu;
>      unsigned int i;
>      uint32_t t;
>  
> @@ -73,8 +73,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
>  }
>  
>  /* rw - 0 = read, 1 = write, 2 = fetch.  */
> -unsigned int mmu_translate(struct microblaze_mmu *mmu,
> -                           struct microblaze_mmu_lookup *lu,
> +unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
>                             target_ulong vaddr, int rw, int mmu_idx)
>  {
>      unsigned int i, hit = 0;
> @@ -290,7 +289,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>              break;
>          case MMU_R_TLBSX:
>          {
> -            struct microblaze_mmu_lookup lu;
> +            MicroBlazeMMULookup lu;
>              int hit;
>  
>              if (env->mmu.c_mmu_tlb_access <= 1) {
> @@ -314,7 +313,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>     }
>  }
>  
> -void mmu_init(struct microblaze_mmu *mmu)
> +void mmu_init(MicroBlazeMMU *mmu)
>  {
>      int i;
>      for (i = 0; i < ARRAY_SIZE(mmu->regs); i++) {
> -- 
> 2.25.1
> 

