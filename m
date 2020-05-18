Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718ADC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BA220643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KgYSLkfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BA220643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalbg-0007kE-2T
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jalal-0006t5-SD; Mon, 18 May 2020 15:38:27 -0400
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:52238 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jalaj-00036I-Ot; Mon, 18 May 2020 15:38:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSruu5JXsLAZsXUCyMseuAkvlmCMm5d1JlQ48ZT89ui4R3H4umsO6ZjGj97Gz8BymChTG4XEp7zVELmeC62oKV+Htz3X7FQNDEkR1xuW5RLoDQVgtA7Cd/WqZ9qL+LkaSJ0/ClpervzBR4X7Amo7buZO40LCLURwnPipPOsBdhh+GXmDZPoyKCL5XjiVlToM+N5lNCX7gV3ZzQd2nIF7uxMFBfPKJICWCXxE3lz071+oG8C/F2BaFRuTGGTZtP3UOatqilFSH33PeDp1qUq4ZJTRqkQC9MjpCrjSuiisg8CtNfzsQproJjFLxQBOmtQdyADAAZ8G/ob4S8PjqcMQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O5TDXEE61T6/nrj/p8v5y4C70AhOGaDtjlWQjXad5g=;
 b=GiAKRHMUcMAuOVFqz8qJ4WeMi3d6SUAlf/ys++rNweyTgwqyMIUymbpEGm8j3guAauUcbTrB+TZElmERrhs49pGVfWH/FOUnaYPpM4SGhWVHwHv1BgSp2APqwb5NBYwhCnflOBKBW67kYwe/XSjg4758b4iSpiUAZeYwmdwVZlpdHL7RXAMVhTcDpBz8EqfeLJNWSKk/FGruwco0vVquDsnRkBsKFl6ch7WjrxLPV0Mm7LMr0z+sTTVCSz6HVSKN6wqFa16INSi241YcTIBzRUp8NC6q8XPWsClbL9ovu9J54eF4LG8z7Wk0xRpTTcXL92lZ1BBy3JtmhY+YXnmxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O5TDXEE61T6/nrj/p8v5y4C70AhOGaDtjlWQjXad5g=;
 b=KgYSLkfajGmNsXXm16+ivIq3WXeSGqZjT0RuDPxyVXhl7sQQdYV12Ag7UfEAhR8JX7nBXtCP0YsZbeRAj1g+OX0t4B90vyuj/8qQK1wUtMsJ7wZAI+n6sdVMleCMP1AhTM8ZFhzB+doVtNUss4V+sgWUfDosCF+7exTkiqNKEZs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 19:38:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 19:38:22 +0000
Subject: Re: [PATCH v4 6/9] qemu-img: Add bitmap sub-command
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-7-eblake@redhat.com>
 <92016f3f-a7c1-5384-5968-b89de5f01ecb@virtuozzo.com>
 <54ab6b66-d22d-820b-f4ad-2859f856de92@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <29b1eb6e-a60c-d4a5-dace-042746d15f5b@virtuozzo.com>
Date: Mon, 18 May 2020 22:38:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <54ab6b66-d22d-820b-f4ad-2859f856de92@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0153.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0PR01CA0153.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Mon, 18 May 2020 19:38:21 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a9404b2-95c1-460d-feb8-08d7fb63062a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430D1EB5E10AA0C57D5CC15C1B80@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sT7KziPnUcURHJk0sFJ5rktJgaU+d+k/ToX0HqN5zLcLaBr9ZarlNtsbACMKdNXG4eYYWraCAq3F4L+C2sBmYyxTVrJOK2jPGTcVSQFd4/V6gbFupn1hYDkD3b6jpyzSzEulNTZbAJHxDZcTyb4Jkh9IJ99uS/wp90V6aQpw/qzvhtRIPX/WN4rGB4p7WoQYft4vSoZjX9Dq25NV59TYU+pJfaKhKNKAzS45jTV4HhDENtUe6BaIiyXaY9Q3ePIL7QbVp7CI19l2xcpvar7HNdLy1CGFyoVYjybUpk3oJVkFoMxpDQrT48oI+Jbk43SKhDddKJrsHioZ+dBFebmiogXjpq3V8eqj10WVJSP97LD36p1LPpBBDdNnSso7TSDQ07mPMdaDj/D1/cfa5EtqPPJIbTm5ScF0DcoJc8N3ZBlyQzowb/9HAOeRR91DLAt7x+BI00XzvBUpbP5DFBAkNHroSb9j2ef3E7a2j+RcuGSzmXB7muUjH8voJ2IyplsQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(366004)(346002)(136003)(396003)(52116002)(31686004)(16526019)(186003)(26005)(8676002)(2906002)(66946007)(53546011)(8936002)(2616005)(956004)(6486002)(36756003)(316002)(31696002)(66556008)(5660300002)(86362001)(16576012)(478600001)(4326008)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0+tRJ5kLs2yRN6w3nN4wYUgIhvUpQ9WzDVrNI4yC/aOXC1x/sdwA7ce7ByYNkJqWjkJkHll2BfSbYp2t/YeGQ/PhchvmPxXI1Vf6eVYs3YjMcaB7IToL28nr6jNG29PE/DpgDnexjJFFxAArEBxMHhuwLOFRJLPHu3gkB8lMXn1Pkdlm1AQI87QNZYFWJ3JGtZR03l5Gl63Ip2X4EzDsslQo0OS9dOp54rlBQXUZXA6CkiduS5VkrGIqRCzQie4qDO5t9X95OBMo+E1N7FGC68jn5wgjTx5Q9p2Nd7dWQ4zT3SaHIi418LFJ8qFBRtmHY8h/5g726eD6PojlhKW8xmdl/5TjOvwvciq+4GkShjG/O1CPM/E/WLxaAMZM8eWGyCT6CRzF5k3EesEDb+5JHG0k/3RdjXMsvQI/JSFkuqtBqwexCUi3qAlz5htEfCVSEoW4hkquoJy5hft89UDxHeoYS0DPcahlpWOdi+8mp1P0+Qd+yo0PKtfd1oRxEJMV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9404b2-95c1-460d-feb8-08d7fb63062a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 19:38:22.1343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m63tZiHMozt0WergfRcjd1BFTBwkwbKx2Ys1MKcS+sdnZuz3v7CZcOLMGkrB6jrjizQzIsCXoy5lmMGpRCy9k05k3p2IqVqv06aKqNm+4u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.15.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 15:38:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.05.2020 22:07, Eric Blake wrote:
> On 5/18/20 6:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 13.05.2020 04:16, Eric Blake wrote:
>>> Include actions for --add, --remove, --clear, --enable, --disable, and
>>> --merge (note that --clear is a bit of fluff, because the same can be
>>> accomplished by removing a bitmap and then adding a new one in its
>>> place, but it matches what QMP commands exist).  Listing is omitted,
>>> because it does not require a bitmap name and because it was already
>>> possible with 'qemu-img info'.  A single command line can play one or
>>> more bitmap commands in sequence on the same bitmap name (although all
>>> added bitmaps share the same granularity, and and all merged bitmaps
>>> come from the same source file).  Merge defaults to other bitmaps in
>>> the primary image, but can also be told to merge bitmaps from a
>>> distinct image.
>>>
>>> While this supports --image-opts for the file being modified, I did
>>> not think it worth the extra complexity to support that for the source
>>> file in a cross-file merges.  Likewise, I chose to have --merge only
>>> take a single source rather than following the QMP support for
>>> multiple merges in one go (although you can still use more than one
>>> --merge in the command line); in part because qemu-img is offline and
>>> therefore atomicity is not an issue.
>>>
> 
>>> +
>>> +    blk = img_open(image_opts, filename, fmt, BDRV_O_RDWR, false, false,
>>> +                   false);
>>
>> fit in one line
> 
> That line would be exactly 80; I tend to wrap at 79 or earlier rather than exactly on 80.
> 
>>
>>> +    if (!blk) {
>>> +        goto out;
>>> +    }
>>> +    bs = blk_bs(blk);
>>> +    if (src_filename) {
>>> +        src = img_open(NULL, src_filename, src_fmt, 0, false, false,
>>> +                       false);
>>
>> s/NULL/false/
> 
> D'oh.  And yet it still compiles.  Fixing.
> 
>>
>> also, fit in one line
> 
> Yes, this one's shorter.  Fixing.
> 
> 
>>> +
>>> +        if (err) {
>>> +            error_reportf_err(err, "Operation %s on bitmap %s failed",
>>
>> s/failed/failed: /
>>
>>> +                              op, bitmap);
>>> +            ret = -1;
>>
>> dead assignment: you never set ret after first initialization to -1.
> 
> Fixing both.
> 
>>
>>> +            goto out;
>>> +        }
>>> +        g_free(act);
>>> +    }
>>> +
>>> +    ret = 0;
>>> +
>>> + out:
>>> +    blk_unref(src);
>>> +    blk_unref(blk);
>>> +    qemu_opts_del(opts);
>>> +    if (ret) {
>>> +        return 1;
>>> +    }
>>> +    return 0;
>>
>> Hmm, as it's the only usage of ret, you may initialize it to 1 at function start, and here just "return ret;"
> 
> Yep, done.
> 
>>> +DEF("bitmap", img_bitmap,
>>> +    "bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b source_file [-F source_fmt]] [-g granularity] [--object objectdef] [--image-opts | -f fmt] filename bitmap")
>>> +SRST
>>> +.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
>>
>> Not about this patch, but it's a pity that we have triple duplications (triplications ?) of such lines..
> 
> Yes, it is annoying.  But as you say, it's a cleanup for another day, for someone who is interested.
> 
>>
>> With at least s/NULL/false/ and s/failed/failed: / (or with all my tiny suggestions):
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Thanks; squashing in:
> 
> diff --git i/qemu-img.c w/qemu-img.c
> index 8c99e68ba8aa..f940137cb0e5 100644
> --- i/qemu-img.c
> +++ w/qemu-img.c
> @@ -4493,7 +4493,7 @@ typedef struct ImgBitmapAction {
>   static int img_bitmap(int argc, char **argv)
>   {
>       Error *err = NULL;
> -    int c, ret = -1;
> +    int c, ret = 1;
>       QemuOpts *opts = NULL;
>       const char *fmt = NULL, *src_fmt = NULL, *src_filename = NULL;
>       const char *filename, *bitmap;
> @@ -4641,8 +4641,7 @@ static int img_bitmap(int argc, char **argv)
>       }
>       bs = blk_bs(blk);
>       if (src_filename) {
> -        src = img_open(NULL, src_filename, src_fmt, 0, false, false,
> -                       false);
> +        src = img_open(false, src_filename, src_fmt, 0, false, false, false);
>           if (!src) {
>               goto out;
>           }
> @@ -4695,9 +4694,8 @@ static int img_bitmap(int argc, char **argv)
>           }
> 
>           if (err) {
> -            error_reportf_err(err, "Operation %s on bitmap %s failed",
> +            error_reportf_err(err, "Operation %s on bitmap %s failed: ",
>                                 op, bitmap);
> -            ret = -1;
>               goto out;
>           }
>           g_free(act);
> @@ -4709,10 +4707,7 @@ static int img_bitmap(int argc, char **argv)
>       blk_unref(src);
>       blk_unref(blk);
>       qemu_opts_del(opts);
> -    if (ret) {
> -        return 1;
> -    }
> -    return 0;
> +    return ret;
>   }
> 
>   #define C_BS      01
> 

Great, keep my r-b with this.

-- 
Best regards,
Vladimir

