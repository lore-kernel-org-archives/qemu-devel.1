Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E920C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D5720760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="keqwzSbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D5720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKMR-0008Cn-8z
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKLO-00077c-Nq; Thu, 11 Jun 2020 06:21:58 -0400
Received: from mail-eopbgr20099.outbound.protection.outlook.com
 ([40.107.2.99]:6406 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKLM-0000mo-AJ; Thu, 11 Jun 2020 06:21:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM6TdfBrIXzH7qHIJgx1gjUfbTxsQtD1kzM6/AsUVwKpxNIBf8NdpCWhPuqaznt84RblC6NtqT0+6j+e6Ob6P6FQ5e8Ud0vMCk06PomQL/3LcfP7iMWV1DJz35k24w2puovQ9eNQn+/TgZogDcgpPNtH6cx35YBowr7yA8nrxToqEPNtwmlLFaYDyfBj9T/hnnhpnOnfNbVKLDRfbcnA2olvRXqStu9JEJVgH/vXitKND+4m1q+Ah6txm4NR+j9XhX9Nim/iyQ1tv69MXqmEeTxcQm1pq2DizQGhnYe+zgLE3gCJezkPGdHUh9GGjMcgKy5EAwaLT7fH5RLdHRZnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coXkuJbLANpNtfYtRY9Os3vwYjCjNyCbHhpR5IkWRI4=;
 b=mgeD23n5o9ZIybPkKGHtOgdeq0iLFe0FyE/PV/jjCNl4am4Cc61wdquTfxa/VEfy2aSxgO3mnxKlo7Czvyswrtg7/EVCz0to9cX6jXPCWNf1u4w08QxwivWE7ir+04FEWYoXr+MH5LdT3wB8TqjVHQBLnx1WzxSjmPFFb/Qo6g0cbyC201OJ0aEWec/7jyhxXd3c61q5usZJQYgw3fu10Lwen9AQjsk69UKXJOH9SsavvCeaOuGUTcZQw0cSjnF6n9OI01ravJUpGZJtOTRAuv421JcwDLqtJS7eMreEJ+daPKcR/oOs5XBrxFgqzA53oPSLCkxTD0c/sCDi151kzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coXkuJbLANpNtfYtRY9Os3vwYjCjNyCbHhpR5IkWRI4=;
 b=keqwzSbP34qkgFgNtsbAqI4URI1E3Ns6AWzvT+JrI/p6Dvc6KS65gD4aI9E0MUTPxpyt0akFEiFBHVJ6SC571T9Q6clKiS4rJP2F4vLW01BQ+mT0amoKTKxK0/zZkCgjUJTQdfmHSjwh7yiIJaAQWYoKwqIqAz/9s/8oxdQ+vzo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5413.eurprd08.prod.outlook.com (2603:10a6:20b:10a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 10:21:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 10:21:52 +0000
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
 <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
 <20200611121354.0a4d2939@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
Date: Thu, 11 Jun 2020 13:21:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200611121354.0a4d2939@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 10:21:52 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0b1ad72-5321-4b40-57a5-08d80df1428d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5413608F4550D1707A698FA3C1800@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Td7uIJ3tF0fOojOMsXp8mVWKpuU5u8XnElURy+j+KyEnR8mvpGjkQE4bpWXzPm1ZOBjAzwV4K9XNP0AwvEs/mETZN/tofIqFPJNOde1QNmTF43h/aRM3BmxJGbqqDEchLvO9wHd3j93DsL8udqPHseMMDvvfIM447KPgFm2HzltlsXyLDXj2PXtrLeS5WWlcSPZVaAMPlSq7WidyZmAZuyCoeYa9tE/Hz+BMAN1deoShx2S1uGvFuBkL4M1hDK8q48pQi9vNTDBzQeenTly4XOA/mzP7lij8D9cNr/E8sfXgubl7hMejjD3ZTlPTDgAU7olqZnQi0grDtPi7UzS+RSXUVlPiy1ULbMYnX1NRoIf1S4zqNg8UzzMXwuYH07AQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39840400004)(396003)(366004)(136003)(478600001)(186003)(66946007)(26005)(2616005)(66556008)(66476007)(956004)(31686004)(2906002)(36756003)(53546011)(5660300002)(8676002)(16576012)(52116002)(8936002)(6486002)(110136005)(31696002)(316002)(16526019)(54906003)(4326008)(86362001)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vMNtT5Vs57bK/x+EbUDv2mEMj8VXQ0aH/eN/mUuTPuCa/7dotOglb8HvAsmzDfHYiBeUBUVoEKABba9CbAGiRWSdo3Yvpjb+SLYYrzggigMcWrqhLJ9RvA0xHTn2K4BBYYRPoStx75eLdu9Ukw9ks4FugyusWmEC6onlefjgCQG7PhDo5p5Le+Kfq/oFKxAzdhlpcZ8H6tTT3c4hyNgqUni3RPjuMWzmsnM+eKV8ANXSnyTuAa98GcXssKuAQk9itW4xrwWirGNbjv3ypE3V0X5wwcVi+pcKZMEgfZfVk0iw8yg0fKsgBXD70FfxBrBPI5InkBYZR2s42Tt4XoIM7At11dpsmJReNkqZZu2qgJtCrR/g9dp+bsHgH6/8n+e9ViLZnbX/kyaJQNextDaOGQ1GU40h1bkGGlc/TtLodu6GYH0ZCzab+cFOzL2LJtxe02Zl9khUZ0CT1SoHpddAF14IH5tNwoMXHhl83yNwx19lbWgzmpuzxiY5u8yh26Ud
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b1ad72-5321-4b40-57a5-08d80df1428d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 10:21:52.8729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGa3P3IfpcTU92e4ccJReCKYCXiC38zKintYwsq0uVI/6F3neNSI9d0g5/c3zxwNUOugZHGPdvOQoVW8iozCUcFOZXRTCcJrnTw0V4+yC7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
Received-SPF: pass client-ip=40.107.2.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:21:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 13:13, Greg Kurz wrote:
> On Thu, 11 Jun 2020 11:50:57 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> On 11/06/2020 11:10, Greg Kurz wrote:
>>> We have a dedicated error API for hints. Use it instead of embedding
>>> the hint in the error message, as recommanded in the "qapi/error.h"
>>> header file.
>>>
>>> Since spapr_caps_apply() passes &error_fatal, all functions must
>>> also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
>>> to be functional.
>>>
>>> While here, add some missing braces around one line statements that
>>> are part of the patch context. Also have cap_fwnmi_apply(), which
>>> already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
>>> well.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>   hw/ppc/spapr_caps.c |   95 +++++++++++++++++++++++++++++----------------------
>>>   1 file changed, 54 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>> index efdc0dbbcfc0..2cb7ba8f005a 100644
>>> --- a/hw/ppc/spapr_caps.c
>>> +++ b/hw/ppc/spapr_caps.c
>> ...
>>> @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible = {
>>>   static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>>>                                    Error **errp)
>>>   {
>>> +    ERRP_AUTO_PROPAGATE();
>>>       Error *local_err = NULL;
>>
>> I think you should rename it, something like "local_warn" to not be
>> confused with the _auto_errp_prop.local_err...
>>
>> or don't use ERRP_AUTO_PROPAGE(), use the local_err instead and move the
>> warning inside the braces of the if.
>>
>> Same comment for cap_safe_bounds_check_apply() and
>> cap_safe_indirect_branch_apply()
>>
> 
> Hmm... local_err isn't useful actually. It looks like we just want
> to call warn_report() directly instead of error_setg(&local_err)
> and warn_report_err(local_err). I'll post a v3.

something like this I think:

--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -250,24 +250,23 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
                                   Error **errp)
  {
      ERRP_AUTO_PROPAGATE();
-    Error *local_err = NULL;
      uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
  
      if (tcg_enabled() && val) {
          /* TCG only supports broken, allow other values and print a warning */
-        error_setg(&local_err,
+        error_setg(errp,
                     "TCG doesn't support requested feature, cap-cfpc=%s",
                     cap_cfpc_possible.vals[val]);
+        if (*errp) {
+            warn_report_err(*errp);
+            *errp = NULL;
+        }
      } else if (kvm_enabled() && (val > kvm_val)) {
          error_setg(errp,
                     "Requested safe cache capability level not supported by KVM");
          error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
                            cap_cfpc_possible.vals[kvm_val]);
      }
-
-    if (local_err != NULL) {
-        warn_report_err(local_err);
-    }
  }


Or, we need to implement warn_report_errp() function, as I proposed in earlier version of auto-propagation series.

=====

side idea: what if we make Error to be some kind of enum of pointer-to-pointer and pointer-to-function?

Than, instead of passing pointers to error_abort and error_fatal as special casing, we'll pass pointers to functions,
which do appropriate handling of error. And we'll be able to pass warn_report function. Not about this patch set,
but seems interesting, isn't it?

-- 
Best regards,
Vladimir

