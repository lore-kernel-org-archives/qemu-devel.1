Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51838C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296E820721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296E820721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyboP-0003ed-CG
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1iybnU-0002k2-ES
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1iybnR-0003Pw-Th
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:29:51 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:59408)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <LYan@suse.com>)
 id 1iybnR-0003Kg-Lk; Mon, 03 Feb 2020 08:29:49 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY
 m9a0013g.houston.softwaregrp.com WITH ESMTP; 
 Mon,  3 Feb 2020 13:28:43 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 3 Feb 2020 13:29:33 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 3 Feb 2020 13:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeeVew633w3V9RQam8Rav07FLOB8Reirg0tVjo6AfKceLV6fCYin5wwXN7HJcyn3hdnMvIPLVNDS9K0YAxrCyOkQu1cRdLga3LkM0H5tim/PlMkPxIWhKJFFl0PV4tfrwhMspvLTt1mHQ5mZJHAp8w9zY1M337uNLbavLkM0rPNHa56QTdrsZRDPpmZXpncvsxXzslJ3NzdIPLI9J/Bp6XrBWgvGajmA5fQCLY7C5SvS8xN9tWv3yWGWyFmLDt+Pg4BrqoNvtdj8ZoDcrw6fjbhUhUcLEArkSkyTUduQIUubkndy0HgRqBstDR3WwhVSXqwNucZWEX6IFYBv/eVPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbYiIoXLdlzVyjpwXPEp5CPxIW3FNBKA1zLdWQO/KSw=;
 b=JDIJccRGnE5Bd0Rl/MKvtemMQrWBYDWPHFKQR0Gmlteggd7SKC5DNCCiZAbnJrMPvWcl6cZpenK/Cs/EkiXyAA8XoaXrMVLqwbp2K4r1EVGjPa8Ex/xC8YyodK/b/EqyAxXt8Uli3U9aW6GitmGVhKFH+xVXnw2Wn33URtnLTBnPoW2T6gzalMLqngNfk4+xF0X/RE+JrYer3x4hwk9OZ0nbsDWgog9NBZdiFUkpj1p7myd3rW5oyJSCwdknV4/io2/aJ5aDMQ6aSY/VjQ3/+nZj1eYlqg/TPfKeFY1NnsAKjB3R+YRTzi7R7BqqR/vp9/QPUKJsa4G1w0yKOfeL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2950.namprd18.prod.outlook.com (20.179.59.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 13:29:31 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 13:29:31 +0000
Subject: Re: [PATCH v3] target/arm/monitor: query-cpu-model-expansion crashed
 qemu when using machine type none
To: Andrew Jones <drjones@redhat.com>
References: <20200201034649.26815-1-lyan@suse.com>
 <20200203130846.gihtrf72inyf33wh@kamzik.brq.redhat.com>
From: Liang Yan <lyan@suse.com>
Autocrypt: addr=lyan@suse.com; prefer-encrypt=mutual; keydata=
 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
 yMQQ+LPXfanS4w==
Message-ID: <f608c744-b416-5815-2b35-9a8b72556259@suse.com>
Date: Mon, 3 Feb 2020 08:29:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200203130846.gihtrf72inyf33wh@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:208:35::22) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
MIME-Version: 1.0
Received: from [IPv6:2605:a000:160e:228::5ca] (2605:a000:160e:228::5ca) by
 BL0PR02CA0117.namprd02.prod.outlook.com (2603:10b6:208:35::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Mon, 3 Feb 2020 13:29:30 +0000
X-Originating-IP: [2605:a000:160e:228::5ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2842c562-7b31-4cec-319e-08d7a8ad19e3
X-MS-TrafficTypeDiagnostic: BYAPR18MB2950:
X-Microsoft-Antispam-PRVS: <BYAPR18MB29504874699DBA04E807C37DBF000@BYAPR18MB2950.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(189003)(199004)(52116002)(2906002)(31686004)(86362001)(36756003)(16526019)(81156014)(81166006)(8676002)(186003)(2616005)(4326008)(8936002)(316002)(53546011)(478600001)(5660300002)(66946007)(66476007)(66556008)(6486002)(31696002)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR18MB2950;
 H:BYAPR18MB2888.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gf1YiNPU81Kv8OsZW1CkmqVL4zB6y5EQotosU3yQ+Nmo/NdJVG48uNvMcXe/uTvtMu/oK5ufNERQn0rLLylM0aOZeMLnkMcCRJU9ebPOfLoZRX6ju3eckBY2myJni80jvzLiIa5j77aZ5Z2iCFZP9O8EVPzCe3Qh274h6aIPkp0+PuijGLG3L8NE047bfO8eesbschyz61WlATgsdPdnbn/PH8ClkDM1Q/HRZdxqvtk84rMoUYWB4J1dPRhxegi/lxKvpDTscXRJkl81X99gNkSgLaqXl3A0ADojHd5wV7e8mb4+ePWK5xk7vvpIDl+OXz5QhLbXcM1/4gq6QnTr0JUff1NyokrrUKcv2nMmHOLNpBfwTI/6NmyXicmkRuzqOd0r5Z1NN2b+SQyaHmDJlV0sXFZoXKbQUsRWwE5ZLMEkaygM69BcjYlIyT0akiZ
X-MS-Exchange-AntiSpam-MessageData: 1ina8rf3rUd+Rw1qK/eY0XBmDQb4WPGz9/IwncfT135t4dpY8V1qhCkyAih359k2GGe0z2cNGmImsvq6JrKRqdM0u0CmJ8PZXnQzG0I+j2YoMShmREHYjXvECEopHg0oHTx9Z0PdoaNHOuztA/2asMqhqa3MW5l9+gN2occQIPU=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2842c562-7b31-4cec-319e-08d7a8ad19e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 13:29:31.5061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 398+Qna8jU8gzx3HH0Ji5LeqJr0GgW5Pzy1nHcmRKwO6uF/DDnogwb41wBNyfa77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2950
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.91
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/3/20 8:08 AM, Andrew Jones wrote:
> On Fri, Jan 31, 2020 at 10:46:49PM -0500, Liang Yan wrote:
>> Commit e19afd56 mentioned that target-arm only supports queryable
> 
> Please use more hexdigits. I'm not sure QEMU has a policy for that,
> but I'd go with 12.
> 
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
>>  v3: change git commit message
>>  v2: fix code style issue
>> ---
>>  target/arm/monitor.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
>> index 9725dfff16..3350cd65d0 100644
>> --- a/target/arm/monitor.c
>> +++ b/target/arm/monitor.c
>> @@ -137,17 +137,19 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>      }
>>  
>>      if (kvm_enabled()) {
>> -        const char *cpu_type = current_machine->cpu_type;
>> -        int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
>>          bool supported = false;
>>  
>>          if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
>>              /* These are kvmarm's recommended cpu types */
>>              supported = true;
>> -        } else if (strlen(model->name) == len &&
>> -                   !strncmp(model->name, cpu_type, len)) {
>> -            /* KVM is enabled and we're using this type, so it works. */
>> -            supported = true;
>> +        } else if (current_machine->cpu_type) {
>> +            const char *cpu_type = current_machine->cpu_type;
>> +            int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
> 
> Need a blank line here.
> 
>> +            if (strlen(model->name) == len &&
>> +                    !strncmp(model->name, cpu_type, len)) {
> 
> Four spaces of indent too many on the line above.
> 
>> +                /* KVM is enabled and we're using this type, so it works. */
>> +                supported = true;
>> +            }
>>          }
>>          if (!supported) {
>>              error_setg(errp, "We cannot guarantee the CPU type '%s' works "
>> -- 
>> 2.25.0
>>
>>
> 
> With the three changes above
> 
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Tested-by: Andrew Jones <drjones@redhat.com>
> 

Thanks for the review, I will update soon.

> 
> It'd be nice to extend tests/qtest/arm-cpu-features.c to also do
> some checks with machine='none' with and without KVM.
> 

Will do it later, thanks for the suggestion.

Best,
Liang

> Thanks,
> drew
> 

