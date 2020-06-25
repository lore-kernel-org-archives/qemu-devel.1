Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C89C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1830C20720
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ffQV9IBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1830C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joM84-0001j5-CR
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 03:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joM7N-0001EP-7v; Thu, 25 Jun 2020 03:16:17 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com
 ([40.107.2.104]:6830 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joM7J-0000xI-4B; Thu, 25 Jun 2020 03:16:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJBwNziMyFXftvk44SnpjSZt5GQ1HEWRrZN6CWwpZHpyBXU1pcX+jdfCs7ZKlF09IykCHBQIwYCsmtTRR2suOLdfa4fURR0jVtSrK8CBV4UxSP3zdfZLjdVZjQ8++l6RBuH18h+o6r/FC22NssbXIrXGsF0xQWXVVptvR8bl5Md6RuRHZU6qNl5vZgCZ/Li43QLn8pmt2NvvaYw+xOJYZ0rYiGnEe0v2VNQbRpzbUj6I86d72HA0A1BMsBHj57fc6TCsIRGj8U3ayECdRKk0WPZTgMWBpwgsSh96DGkAk7XYoK57yrCKOiDxyIIZEEPCvwF02IAHq9ierGcFxwtx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffIVD8A3IlQEYxtP+uXuPFY1ReUvBpv6W0JTOQRmJIY=;
 b=UOEphwowtc6hwNZC6YEhjJW7vQ6hEUn+qdbHG+ZHb0rVR7VXXo0Yq4hxuSA3RXlrAoMGRurrzf0HkPc9sNneCRcA1xc9h6+GsSOcELbrkClPKysLEXgZaGX0N+13ASNt7GuBgMzUMQNc6s9L1eoV988wv+yX5xq1IeylHz4CgQIvC/6yGXBsw1HAvp3W6NOxzTkfynmZDLumlnj33WvRUTa4CiTJ+yVbHCpR/Gk0XqjDBH3Jxywm5VGyyaHtPeFxL2EK9nThAHfz8LFOGHcQ0Y/yot0iB09Z41/Xip/Ont4+2mbxibS9xyAEbyVbImEAktZv3j3iOb2Ec0QVBxtmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffIVD8A3IlQEYxtP+uXuPFY1ReUvBpv6W0JTOQRmJIY=;
 b=ffQV9IBDGUJpwLj7m4b76DDekWPxD78W44bNtq58a5sLIzE7gcBNo+egJaPklXeBMKPq3fBfmS+zC/O8bbSF97hzcRErrEjR7iYmffZHGG63/NZsPR6V5h42dNP9epWwqMhr8Jg/S/De+umtgyCnXXU7jCRl91r3qTWZS9iVBrA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1842.eurprd08.prod.outlook.com (2603:10a6:203:3c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Thu, 25 Jun
 2020 07:16:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 07:16:08 +0000
Subject: Re: [PATCH 02/46] error: Document Error API usage rules
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-3-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <db1af786-075d-b656-b280-d25ad34bbbe6@virtuozzo.com>
Date: Thu, 25 Jun 2020 10:16:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.69) by
 AM0P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 07:16:07 +0000
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fcaea2-09c2-4cdc-9258-08d818d7a157
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1842:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB184252A6F9075ED50951AA96C1920@AM5PR0801MB1842.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayQZb1HcDrrqPx9boR/pfIpYdDaIU4KFuVFmHbKsFvGRz+XQYtNB4FMCeoqiBnfRz1fI0vIlTuU1Aa55m0cTK32W17qfKUDbxbqBEV91dZL9kqyHNezXk39josgnffu2JLC4gZq8T6eb5NOOH8x/868o00YsDKicgHOe0KWGaM5LOkLAuRyxPg+eIIoK9KjS7TKHRHnMBhjtQzIM6axc426SqKTJRT+2jVT3z3dmFJqd7pndJh9ZOyNnEI5SRPhEc03RyHwm8am3W8GPYbe2OhOCz/c9XsOaOaCxUhMl9oEExJ5Egyl5og5Hev2P+L44tj/Vfjz563rTQ3k+GzDppUxJoaPM05QTzrEsw0zvtf9u963KdCJg93IjAk1/Q6pf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(66946007)(31686004)(26005)(66556008)(66476007)(52116002)(16526019)(4326008)(83380400001)(478600001)(186003)(36756003)(31696002)(2906002)(86362001)(5660300002)(8676002)(16576012)(956004)(6486002)(8936002)(2616005)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mEfSYGiz5SZdQWXCWwwkY3k9E+ZwqBkdL41UE0o8ARJIpMZdttbug3M2GQN74/zAGcdGvU90T/1E+xn6+ZxjLCelXKyxhndBD8GhPeYvs7FyRwc9BeTn/ntHHG0T9yK0PylPQVzlp9tRjHCJ/0cJK5y/2ytXiDDnWzxSMgBkEf3uzhndbTMpKjdZAjd0cxWt/VwzZwHa17+5ZDI9ks7U3Gcrh+34eqDPUNWrOF+LwlWof/u4M0quJCNrj47W09mUE2odpK6lnomNpKFv4mSb/pJlu6CXHBqw7klaYSawCEocLsX79SVSudDyG5NCKLNDxW5lvZcHwcbou5J7Cl5ws5Ee25tjJ/wmEqy9eqsNbe35kYxTX463gT1JDIMnM1oSO8towL+U6CHTzoIGQ70mV44NdVsqda98d2q//1poqfLl4n/GK107JJxULpoWob/hpLhoVcSPOzwji/pOu+ydenBW1iknon/TuYTiZU4neeo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fcaea2-09c2-4cdc-9258-08d818d7a157
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 07:16:07.9230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t32qY5KrYGmDqzesb5f72WKCW9F9YvaSnQsbS89qr9llk5gb4u0jSGwtOmFKsOKuGoCEGyGyqX6/g7bAqpgBQl8RelxA2yFmuu+bqSlG2VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1842
Received-SPF: pass client-ip=40.107.2.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 03:16:09
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> This merely codifies existing practice, with one exception: the rule
> advising against returning void, where existing practice is mixed.
> 
> When the Error API was created, we adopted the (unwritten) rule to
> return void when the function returns no useful value on success,
> unlike GError, which recommends to return true on success and false on
> error then.
> 
> When a function returns a distinct error value, say false, a checked
> call that passes the error up looks like
> 
>      if (!frobnicate(..., errp)) {
>          handle the error...
>      }
> 
> When it returns void, we need
> 
>      Error *err = NULL;
> 
>      frobnicate(..., &err);
>      if (err) {
>          handle the error...
>          error_propagate(errp, err);
>      }
> 
> Not only is this more verbose, it also creates an Error object even
> when @errp is null, &error_abort or &error_fatal.
> 
> People got tired of the additional boilerplate, and started to ignore
> the unwritten rule.  The result is confusion among developers about
> the preferred usage.
> 
> The written rule will hopefully reduce the confusion.
> 
> The remainder of this series will update a substantial amount of code
> to honor the rule.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/error.h | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 1a5ea25e12..c3d84d610a 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -15,6 +15,32 @@
>   /*
>    * Error reporting system loosely patterned after Glib's GError.
>    *
> + * Rules:
> + *
> + * - Functions that use Error to report errors have an Error **errp
> + *   parameter.  It should be the last parameter, except for functions
> + *   taking variable arguments.
> + *
> + * - You may pass NULL to not receive the error, &error_abort to abort
> + *   on error, &error_fatal to exit(1) on error, or a pointer to a
> + *   variable containing NULL to receive the error.
> + *
> + * - The value of @errp should not affect control flow.

What do you mean? Incoming state of errp, or *errp after some call of another
function? Should we then update this paragraph, when introduce
ERRP_AUTO_PROPAGATE?

> + *
> + * - On success, the function should not use @errp.  On failure, it
> + *   should set a new error, e.g. with error_setg(errp, ...), or
> + *   propagate an existing one, e.g. with error_propagate(errp, ...).
> + *
> + * - Whenever practical, also return a value that indicates success /
> + *   failure.  This can make the error checking more concise, and can
> + *   avoid useless error object creation and destruction.  Note that
> + *   we still have many functions returning void.  We recommend
> + *   • bool-valued functions return true on success / false on failure,
> + *   • pointer-valued functions return non-null / null pointer, and
> + *   • integer-valued functions return non-negative / negative.
> + *
> + * How to:
> + *
>    * Create an error:
>    *     error_setg(errp, "situation normal, all fouled up");
>    *
> 


-- 
Best regards,
Vladimir

