Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43957C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8052080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VOhlBXLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8052080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMr04-0002ws-CY
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kMqyT-0002Lm-O8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:05:41 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com
 ([40.107.92.68]:49427 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kMqwW-0000Qs-Oc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:05:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivuIsVLT24Km39xpAKRJNocrgMLsQl45ilm8bGWAXG2i0fSdYwvuDYLA7vyXho+QydP/crw8LNQP14ehupGweNnq+cEAtRZoHVk1DicOMg3zf5/IomCsIxI6z7rPjS4DE2+vxx5pGVtaj9JDSL/DxeuREEIQ9tdqDkZU7TsoR5vcNfSzBJFbcw/kFbdmUuIx8vtM0WQFjLn4+tKgm1g7Bd9ilW3WBIWW6ZkBfueZrr9h1y6FhCwe1VMDyMdSiTzWJZA4vx+78CsaWTy+n0/Zy6jd7eSn2XJ3mHSXQzHEYu9Hbv7fSX+c2R72olO7pdm6QU7T3cnji8yS9z4a+i9tEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqbKCwUU+A8z0WMAqIE9kmcm0g3ERfKUhWxARMe8ojI=;
 b=UaGz9iXrKNbRvYSfsFfhTEHSAs3Rbt5Lxucov8Q/jQ3ouj22f4tu4HboSPpQ1wz0TNu7rEsEqv4tFO+5xW7OrmyItqvaZDUpTa8Ff5iIB6Yvpzghx3pCV1+c4//mAod353MaxMrgFUfwnON8zc062t1m/srfFfeUw+IIlAB+2WJ5WCE0LqbPJ24SQvNYxGSyXqz71VWadr7bbU98Kapb9lsLMU+T0Oq9vTPzRkpfcS8XE0igMfUGJ1vUexoXkoViumrteo//zCQX9cqMxtT0D8Mkr9m7cnk9pGm46TX6iP68ajKY5Oy5suytecs8utjpPlhFPEWa+48FOq/AYwoF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=greensocs.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqbKCwUU+A8z0WMAqIE9kmcm0g3ERfKUhWxARMe8ojI=;
 b=VOhlBXLsenluAoqLQ0S5KUydWYvE8qenmSJvnUwKvPacqkT99Ukz+Z87+dJ14d922FtdfYoRKumpqiG0UkakgTEkBBRkNeGZCDtAengEYE64IarFNr9wa2zMHtNBBTBDZEgRDTbhZACoW/4fBRycigvI2kbtEbHZf/1inrLcclE=
Received: from MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19) by
 SN6PR02MB5072.namprd02.prod.outlook.com (2603:10b6:805:6f::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Mon, 28 Sep 2020 10:48:35 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23f:cafe::b1) by MN2PR01CA0050.outlook.office365.com
 (2603:10b6:208:23f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Mon, 28 Sep 2020 10:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; greensocs.com; dkim=none (message not signed)
 header.d=none;greensocs.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 10:48:34
 +0000
Received: from [149.199.38.66] (port=42926 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kMqhX-0004Pp-Jt; Mon, 28 Sep 2020 03:48:11 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kMqhu-000315-BG; Mon, 28 Sep 2020 03:48:34 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kMqht-00030y-S5; Mon, 28 Sep 2020 03:48:34 -0700
Date: Mon, 28 Sep 2020 12:48:33 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH 3/3] hw/qdev-clock: Display error hint when clock is
 missing from device
Message-ID: <20200928104833.GE17122@toto>
References: <20200927090820.61859-1-f4bug@amsat.org>
 <20200927090820.61859-4-f4bug@amsat.org>
 <20200928075300.q5ngcywiz5fyu6du@sekoia-pc.home.lmichel.fr>
 <20f0ab00-8ca4-1a8f-43de-3b86dacc2124@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20f0ab00-8ca4-1a8f-43de-3b86dacc2124@greensocs.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1472bc33-adbc-4214-e1b2-08d8639c0c68
X-MS-TrafficTypeDiagnostic: SN6PR02MB5072:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50722914C9A2F6CE8BE28316C2350@SN6PR02MB5072.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb1R5gGXMTF8+ch+U5LkhXnyTNZukPo3ProxypEZPXxT5NLN793CNolEIRD1lbJ6877Sj+kSrZ/5itv0JRy2I5AbdSsVr2kFoBUxNQNcelZPa+80abfNQHAY3C0zHD96aFzf3HLIyeS/+7TfvcVNxNkhQanr0Ki9AgyrIDfiUaN6ALZVXHPEV10HnWot6ohr6RIzQ+6OXtrH8ZDdtAKaLZpJ8Q6gvtsrP5dcscmyMrXUBHWnUdH8dNtcSP1nqmCviPa4/IgKGRCxQ8hW6ml97oBUEgRIb10E2J/C9dI+2Gfa+TUcRjvwJu3k7xTUhx3Xw1+sJKfgkTI4e1r2uSiEpk7EMD2ewwigFp1PfawvQnGnDstxziQ0m0UFAFMtap8ZJnMuQd+TNK1vXSj5peSsWJZqW2k+4n07PQQqb6V+XSsYimq8Q8RKALBUzUofW58C
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(346002)(396003)(376002)(39860400002)(136003)(46966005)(53546011)(54906003)(83380400001)(426003)(356005)(8676002)(26005)(6916009)(2906002)(9686003)(4326008)(70586007)(70206006)(9786002)(5660300002)(82740400003)(33716001)(33656002)(47076004)(1076003)(8936002)(81166007)(82310400003)(316002)(336012)(186003)(478600001)(7416002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 10:48:34.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1472bc33-adbc-4214-e1b2-08d8639c0c68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5072
Received-SPF: pass client-ip=40.107.92.68; envelope-from=edgar@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 07:03:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 12:45:15PM +0200, Damien Hedde wrote:
> 
> 
> On 9/28/20 9:53 AM, Luc Michel wrote:
> > On 11:08 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
> >> Instead of directly aborting, display a hint to help the developer
> >> figure out the problem (likely trying to connect a clock to a device
> >> pre-dating the Clock API, thus not expecting clocks).
> >>
> >> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > 
> > Reviewed-by: Luc Michel <luc@lmichel.fr>
> 
> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> > 
> >> ---
> >>  hw/core/qdev-clock.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> >> index 47ecb5b4fae..33bd4a9d520 100644
> >> --- a/hw/core/qdev-clock.c
> >> +++ b/hw/core/qdev-clock.c
> >> @@ -12,6 +12,7 @@
> >>   */
> >>  
> >>  #include "qemu/osdep.h"
> >> +#include "qemu/error-report.h"
> >>  #include "hw/qdev-clock.h"
> >>  #include "hw/qdev-core.h"
> >>  #include "qapi/error.h"
> >> @@ -153,6 +154,11 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
> >>      assert(name);
> >>  
> >>      ncl = qdev_get_clocklist(dev, name);
> >> +    if (!ncl) {
> >> +        error_report("can not find clock-in '%s' for device type '%s'",
> >> +                     name, object_get_typename(OBJECT(dev)));
> >> +        abort();
> >> +    }
> >>      assert(!ncl->output);
> >>  
> >>      return ncl->clock;
> >> @@ -165,6 +171,11 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
> >>      assert(name);
> >>  
> >>      ncl = qdev_get_clocklist(dev, name);
> >> +    if (!ncl) {
> >> +        error_report("can not find clock-out '%s' for device type '%s'",
> >> +                     name, object_get_typename(OBJECT(dev)));
> >> +        abort();
> >> +    }
> >>      assert(ncl->output);
> >>  
> >>      return ncl->clock;
> >> -- 
> >> 2.26.2
> >>

