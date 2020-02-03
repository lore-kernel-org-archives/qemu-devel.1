Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F78C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA63A2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA63A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycLE-00055I-UX
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1iycK2-0003pQ-3g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1iycJw-0007VE-Vi
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:03:30 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:52110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <LYan@suse.com>)
 id 1iycJt-0007MH-MM; Mon, 03 Feb 2020 09:03:21 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY
 m9a0014g.houston.softwaregrp.com WITH ESMTP; 
 Mon,  3 Feb 2020 14:02:25 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 3 Feb 2020 14:01:05 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 3 Feb 2020 14:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZXsRrkUbddCCaxBqnhz9FnAjuFFJeqbqxzEOgAwvLTDSfpakOadkOpr0D1Xzk6NxC6/C0Ds2Rp1+xSP9E5f/BUNAnS0oBEj33mM28/yRvP1cK6HqfAUZV6hXOZhXCBir6W69Zm0o4wn4IFC2KcJCC/rfXNjE2UayYIGrSTRw7q6nE1NWn/cjVlnBOR+U/IOhklvd4C3oHGAHWQc0MB4BqxLmdFHGN72zbb5vtcw5u9qqJvz2CbYZZVxlikqTNLTVgo0Jw6KD6xlQDMDQsxkK8JVDTiBL7+LeUrU8lOE/FDXHg6cPtj+YooQ4TwNayqer/O5D7RMbwDXb74iXtePqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD3SPoRW1SuWpV4232l/ufoTjhDiWmmwq0qWNgM5BL8=;
 b=RWiXYo8nckUK8HlbiHFqg/5FuqnhtfoHOyHSsY9zqxV5jKtJHaGf9I6tu0TF8FmvmlQV63iZwn7jI1bkxFmC9paK9N+fI5Yh8FXue98n16zErkeL/dG81/itU+WeHymngDwyP6F4QIYQ8hBNkOodGI1GMTIddXEmYV9ciSuBREu94E6wIC8jqV7TYWhTxvDeq8pRlziX2K/TyEDwraiWSFdOXwLRrg3ObLv8zoYnPWEV+k4NjMKXSSl6UuLyPSoiNyB1dqbSJW3CADSYC6zq+tBtNrFyORKlUJuQxQzfKeKk7ZP7TsPJ6xFXg8S09CyH7xraR/xyLnXYjJzY4I1/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2696.namprd18.prod.outlook.com (20.179.58.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 14:01:04 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 14:01:04 +0000
Subject: Re: [PATCH v4] target/arm/monitor: query-cpu-model-expansion crashed
 qemu when using machine type none
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203134251.12986-1-lyan@suse.com>
 <CAFEAcA-CcNwozBBFWenjnBpRPYhxe_sDiKffwO+SZk38xtY4VA@mail.gmail.com>
From: Liang Yan <lyan@suse.com>
Autocrypt: addr=lyan@suse.com; prefer-encrypt=mutual; keydata=
 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
 yMQQ+LPXfanS4w==
Message-ID: <ae4957c5-01a9-fbbf-c3d5-a834e6b4cbc3@suse.com>
Date: Mon, 3 Feb 2020 09:01:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAFEAcA-CcNwozBBFWenjnBpRPYhxe_sDiKffwO+SZk38xtY4VA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
MIME-Version: 1.0
Received: from [IPv6:2605:a000:160e:228::5ca] (2605:a000:160e:228::5ca) by
 BL0PR1501CA0015.namprd15.prod.outlook.com (2603:10b6:207:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend
 Transport; Mon, 3 Feb 2020 14:01:03 +0000
X-Originating-IP: [2605:a000:160e:228::5ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df60fc5d-9d3e-41ac-6b96-08d7a8b1822c
X-MS-TrafficTypeDiagnostic: BYAPR18MB2696:
X-Microsoft-Antispam-PRVS: <BYAPR18MB269681DBAAB7C6288B2E2CCABF000@BYAPR18MB2696.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(54906003)(36756003)(6486002)(8936002)(4326008)(81166006)(81156014)(316002)(66556008)(478600001)(66476007)(186003)(16526019)(66946007)(52116002)(6916009)(2616005)(53546011)(31686004)(31696002)(8676002)(2906002)(86362001)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR18MB2696;
 H:BYAPR18MB2888.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Bq9zO7aw3QxEJ4qzjyrTN3r4ZrLSCBxBJIaiWqeTf7/uiEKGiUdLwqdOB82d3VIliT/m4rtefq/ci1DLSfXh3UkbJwM9OQ0mBUtvSNmuSz4X0wTrtuFDj0X7WMgPxU/QP4HuM4LPBzZdUwchWIaj00ZbYKyQnbpLspKeCfsvG3IRyttDEjqc+2F7/DbnX7vk4J/hbfc9j71cIQII8W7+5nwPfccRc/YKJY7ToitveyFxty+oqyeJqFwgpPt6ZimZTOAus6VOlpzpCiKeWhXy489a1XxenYDwW8yIzXbVsNA63AL8eEM0QsJPrqCPLfufLXiNc9m3/BwpSbL7NjrBTnpIA4CrY66LSGkBvs23TbMFVCYF21ob8D9vxGN3tiC07s4ilLzgfpCy/mxFQZxSCkGw/MqOobUmzqH2Cm/O4+GiGILAv9+yhiyJoeyGQN+
X-MS-Exchange-AntiSpam-MessageData: nenaBv4HB2ue0gg4mjcA4PriRpkjjVFzi8PuuH1ou3wGuW+sGQNRnyCSp3g+lA3bVaJQJ8cAjCRO1h+t6Yb+W0b4S8UV1VFKewVCal3bIKM5RPp/VYC3+lKHC4HfzIVQivwPN+tRM9B5wbTiT2ZDFssxMSXKsB+izSqFMYL3Pv4=
X-MS-Exchange-CrossTenant-Network-Message-Id: df60fc5d-9d3e-41ac-6b96-08d7a8b1822c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 14:01:04.4140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rHiTH3k0jAshGNVcMY4drNi/CrdmuTSGxY0irggh11yyWsqnqFXDDQLzkfcRZlY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2696
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.90
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/3/20 8:54 AM, Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 13:44, Liang Yan <lyan@suse.com> wrote:
>>
>> Commit e19afd566781 mentioned that target-arm only supports queryable
>> cpu models 'max', 'host', and the current type when KVM is in use.
>> The logic works well until using machine type none.
>>
>> For machine type none, cpu_type will be null if cpu option is not
>> set by command line, strlen(cpu_type) will terminate process.
>> So We add a check above it.
>>
>> This won't affect i386 and s390x since they do not use current_cpu.
>>
>> Signed-off-by: Liang Yan <lyan@suse.com>
>> ---
>>  v4: change code style based on the review from Andrew Jones
>>  v3: change git commit message
>>  v2: fix code style issue
> 
> If a reviewer says "with these changes, reviewed-by:", or
> "otherwise, reviewed-by...", then you should add those tags to
> your commit message, assuming you've only made the changes
> they asked for. That saves them having to look at and reply
> to the patchset again.
> 
> In this case I'll just add them as I add this patch to
> target-arm.next, but if you could handle tags across versions
> for future patchset submissions it makes life a little
> easier for us.
> 
Thanks for the tips, will definitely do in the future.

Best,
Liang

> Applied to target-arm.next, thanks.
> 
> thanks
> -- PMM
> 

