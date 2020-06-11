Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8BF2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O6Il7GBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8BF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKmd-0006sx-6R
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKlW-000658-4y; Thu, 11 Jun 2020 06:48:58 -0400
Received: from mail-eopbgr10132.outbound.protection.outlook.com
 ([40.107.1.132]:30550 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKlU-0006X9-SE; Thu, 11 Jun 2020 06:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSDNx+NnBxg4XyHWZFlgZgF059A9G8LJeMo0xEHXiUN0tEzoj0Y0COzhY5jyDkdbQ0/KH24yLYiXgb615vK3usmKqP6u1gubey2aMHzm+KZVQoV5rPLizQ2SDlMfvpl/hVt0ocgHrV0ZxRWPYbA8LAN3A8ANgmBOMX2pHiYRoHSS/WJ1apdCTrS3Z43/Q3yHyaTY/zx/tUjmyfrKL17iS7KALY8QVmvvaNz//J9BlgyiLYEPTMEdgSsD+g9xzKMLAfDXzK90DlmPNrtw/Htq5lj6YTCezWa0eXuM2WJCRkVnswANpw6yIx2CFg4OlxL5u5juU9aFQmoIFQeg6Zl9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G0txxP7ccgXVt4f1qMr96mSTfmhEi7F9Bj2SWSM4Gw=;
 b=PzrSZvyC89XRaXpctd6JtxeCkblSnjqMEpmW+uqXktObN0Jqpg4RFNhiZWZymzgru1mP/chRR+FAXxPUZiBcjX9b5I1f/18U28ImyQoYmU7IhR87wceqcfT4aAHHbXv/9OecuxPyUTNNcONrhmW+pmAkd5iEdqKwqCvu8WayuBD5yJB2Y00o2oLsC6cszee1ovC274Ryx+Ic8bWRPwcPjhD0dxoL9+l9eo4xiiA1MZG54PUiOtNMODxvjev0laIC0sNv22jGO8feUm+lNPfJtKzH+PVWi2V5Wtuf845XqivVGzk6bYUhW1nlMF9I+hC42mqBR83bvfrJj+x1gSc5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G0txxP7ccgXVt4f1qMr96mSTfmhEi7F9Bj2SWSM4Gw=;
 b=O6Il7GBCGqKOL3hfp1KXthilGXOHa/ztNNwm7LgAIiLFnLifdjPyP35igc+rG3xI46yi1enu7EwfGxpFiAZNoOsohQ6jnavsjUE/q7KIr/tVbdgQHNOUgmNDSyUtzTUe0nhjpixks5P4TbsiJmwpUufbpV+0+BrVTSrndtAsw4I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 10:48:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 10:48:54 +0000
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
 <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
 <20200611121354.0a4d2939@bahia.lan>
 <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
 <20200611123952.15f465dd@bahia.lan>
 <d28a8fdf-842b-dfca-d6d9-8b8535273920@virtuozzo.com>
Message-ID: <080ce1c9-d9eb-fd74-7dca-8b2f77fc3b71@virtuozzo.com>
Date: Thu, 11 Jun 2020 13:48:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <d28a8fdf-842b-dfca-d6d9-8b8535273920@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR01CA0141.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Thu, 11 Jun 2020 10:48:53 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 192e9bce-1fda-4a97-292e-08d80df508d6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-Microsoft-Antispam-PRVS: <AM7PR08MB549694B1925298488D5B9332C1800@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrNhsj6LAJ/xDNEfTgoUTuE0B42sKEVPhKY/PAli9Dxid5uP3TyMYEOJp73viJGlN+ehrm0OVS8qPII6ijcrD6VRdTQXlWpB04xrf22Ql15VsAzCsdLRGIPnjZ/1d1s9tPpczZFmLmvE4YJmCaOV/K10SnDaRkVp4PhxPf0NAz6K+RgGQqgnlkltUUJXMQPfE7yGqH8KHjNlTZBrzDj84/nd1eofYYf7EISHHfxNUVubZ5v2If+bYz8p/S64RigMLEUQdQABVr0C9+9+u7isrrXQCC3TlLEt+i/nMbCV73YzbEKHvoai3ioVux91vBecx99tBON/SGXRvsILXpnjLNTOSnUlEdWBBTvXXV5CQ9roVSFBv9zI7o2ELoVZnF2Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(366004)(478600001)(83380400001)(31696002)(86362001)(956004)(66946007)(2616005)(66556008)(66476007)(36756003)(53546011)(26005)(16526019)(52116002)(186003)(2906002)(5660300002)(8676002)(316002)(8936002)(16576012)(4326008)(6486002)(54906003)(6916009)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iMUJKkSwLAxeUDtwwj4YP7LZ5l2Kh34xvx0GCay2pXEAZbCw/UCrcNOZdMMf4DLZ9S6G/9ahiVHXQxlrY9S7dNKNSfsg7uY3ftkbyRYWkm6q/00GsAqpYZFKVhaFJoq65LWNyob5CVXX4MDRiMh8mKbaCIjpUc7ontUKw5xn8XtSgMkm2qZNKt76XkNEDP4wHM2c924J5Er/IygJVjk837rS2tFCnketpY3ylZ2zE01l6v5aQO20305RwrfoZ0tFmMUClIH7BUek0lyyKKzTNwOw8tvxsaBDlktH4SU9PYfTacKpRAtwNUXElcfWwbdyzqPWzLT20PXiTSgOXRGldCsXJTgYOyQmsqLP3rzaR+LXfSPp0tkT8eRbM8LWfC8VoA50qJM9sM7LrO2+3TjEj03Fbjpro70u8JbmxC2uPYwXdBmNV9rwFL0wOPRSPJMkm0wYanYB6YEk7afYFNxe9YIXF06nN5RDnnmJ82tueEgCQ2Becpx5LmUZQJ/X361S
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192e9bce-1fda-4a97-292e-08d80df508d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 10:48:54.0830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjr4XwHDhPGzhGvQ3H6+iu6ncaTA9C8h9QItq4/sEwVzMAevZ9Be6BMcgKFxd3f2DR0VQ+0HZBIB8DIJvL2flh63bYzb3Ve9+L1Qsg6f1mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.1.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:48:54
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
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 13:44, Vladimir Sementsov-Ogievskiy wrote:
> 11.06.2020 13:39, Greg Kurz wrote:
>> On Thu, 11 Jun 2020 13:21:51 +0300
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>
>>> 11.06.2020 13:13, Greg Kurz wrote:
>>>> On Thu, 11 Jun 2020 11:50:57 +0200
>>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>>
>>>>> On 11/06/2020 11:10, Greg Kurz wrote:
>>>>>> We have a dedicated error API for hints. Use it instead of embedding
>>>>>> the hint in the error message, as recommanded in the "qapi/error.h"
>>>>>> header file.
>>>>>>
>>>>>> Since spapr_caps_apply() passes &error_fatal, all functions must
>>>>>> also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
>>>>>> to be functional.
>>>>>>
>>>>>> While here, add some missing braces around one line statements that
>>>>>> are part of the patch context. Also have cap_fwnmi_apply(), which
>>>>>> already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
>>>>>> well.
>>>>>>
>>>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>>>> ---
>>>>>>    hw/ppc/spapr_caps.c |   95 +++++++++++++++++++++++++++++----------------------
>>>>>>    1 file changed, 54 insertions(+), 41 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>>>>> index efdc0dbbcfc0..2cb7ba8f005a 100644
>>>>>> --- a/hw/ppc/spapr_caps.c
>>>>>> +++ b/hw/ppc/spapr_caps.c
>>>>> ...
>>>>>> @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible = {
>>>>>>    static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>>>>>>                                     Error **errp)
>>>>>>    {
>>>>>> +    ERRP_AUTO_PROPAGATE();
>>>>>>        Error *local_err = NULL;
>>>>>
>>>>> I think you should rename it, something like "local_warn" to not be
>>>>> confused with the _auto_errp_prop.local_err...
>>>>>
>>>>> or don't use ERRP_AUTO_PROPAGE(), use the local_err instead and move the
>>>>> warning inside the braces of the if.
>>>>>
>>>>> Same comment for cap_safe_bounds_check_apply() and
>>>>> cap_safe_indirect_branch_apply()
>>>>>
>>>>
>>>> Hmm... local_err isn't useful actually. It looks like we just want
>>>> to call warn_report() directly instead of error_setg(&local_err)
>>>> and warn_report_err(local_err). I'll post a v3.
>>>
>>> something like this I think:
>>>
>>
>> Not even that... we have one path (KVM) that directly
>> uses errp and the other path (TCG) that does:
>>
>> Error *local_err = NULL;
>>
>> error_setg(&local_err, ...);
>>
>> if (local_err) {
>>      warn_report_err(local_err);
>> }
>>
>> It really looks like we just want to call warn_report().
> 
> yes, I also came this)
> 
>>
>>> --- a/hw/ppc/spapr_caps.c
>>> +++ b/hw/ppc/spapr_caps.c
>>> @@ -250,24 +250,23 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>>>                                     Error **errp)
>>>    {
>>>        ERRP_AUTO_PROPAGATE();
>>> -    Error *local_err = NULL;
>>>        uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
>>>        if (tcg_enabled() && val) {
>>>            /* TCG only supports broken, allow other values and print a warning */
>>> -        error_setg(&local_err,
>>> +        error_setg(errp,
>>>                       "TCG doesn't support requested feature, cap-cfpc=%s",
>>>                       cap_cfpc_possible.vals[val]);
>>> +        if (*errp) {
>>> +            warn_report_err(*errp);
>>> +            *errp = NULL;
>>> +        }
>>>        } else if (kvm_enabled() && (val > kvm_val)) {
>>>            error_setg(errp,
>>>                       "Requested safe cache capability level not supported by KVM");
>>>            error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
>>>                              cap_cfpc_possible.vals[kvm_val]);
>>>        }
>>> -
>>> -    if (local_err != NULL) {
>>> -        warn_report_err(local_err);
>>> -    }
>>>    }
>>>
>>>
>>> Or, we need to implement warn_report_errp() function, as I proposed in earlier version of auto-propagation series.
>>>
>>> =====
>>>
>>> side idea: what if we make Error to be some kind of enum of pointer-to-pointer and pointer-to-function?
>>>
>>> Than, instead of passing pointers to error_abort and error_fatal as special casing, we'll pass pointers to functions,
>>> which do appropriate handling of error. And we'll be able to pass warn_report function. Not about this patch set,
>>> but seems interesting, isn't it?
>>>
>>
> 

Just for record: probably, we'll want at lest something like this (not needed in this series):

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 30140d9bfe..25b5da0733 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -475,4 +475,10 @@ extern Error *error_abort;
   */
  extern Error *error_fatal;
  
+/*
+ * Special error destination to call warn_report_err.
+ * See error_setg() and error_propagate() for details.
+ */
+extern Error *error_warn_report;
+
  #endif
diff --git a/util/error.c b/util/error.c
index b6c89d1412..928eb4cc7a 100644
--- a/util/error.c
+++ b/util/error.c
@@ -27,8 +27,9 @@ struct Error
  
  Error *error_abort;
  Error *error_fatal;
+Error *error_warn_report;
  
-static void error_handle_fatal(Error **errp, Error *err)
+static bool error_handle_special(Error **errp, Error *err)
  {
      if (errp == &error_abort) {
          fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
@@ -43,6 +44,12 @@ static void error_handle_fatal(Error **errp, Error *err)
          error_report_err(err);
          exit(1);
      }
+    if (errp == &error_warn_report) {
+        warn_report_err(err);
+        return true;
+    }
+
+    return false;
  }
  
  static void error_setv(Error **errp,
@@ -70,8 +77,9 @@ static void error_setv(Error **errp,
      err->line = line;
      err->func = func;
  
-    error_handle_fatal(errp, err);
-    *errp = err;
+    if (!error_handle_special(errp, err)) {
+        *errp = err;
+    }
  
      errno = saved_errno;
  }
@@ -283,7 +291,9 @@ void error_propagate(Error **dst_errp, Error *local_err)
      if (!local_err) {
          return;
      }
-    error_handle_fatal(dst_errp, local_err);
+    if (error_handle_special(dst_errp, local_err)) {
+        return;
+    }
      if (dst_errp && !*dst_errp) {
          *dst_errp = local_err;
      } else {



-- 
Best regards,
Vladimir

