Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F570C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 07:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7BB2083B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 07:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h2OwSkM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7BB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc1S7-0006RT-3y
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 02:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc1RH-0005zn-KU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 02:18:07 -0500
Received: from mail-am6eur05on2107.outbound.protection.outlook.com
 ([40.107.22.107]:43329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc1RD-0007Su-9p
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 02:18:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtLfrGNQV/lLvbJ3aBLv/Pho5QaAgdlVqRt8qEVREcsowMqH+3ga4YFcWDh4L11/fQPloLFaqdzSEYudR9e2y9aGxxyz0w+cHAS2joTwg00RJ5SZ8o90e8JQvjPxjj/7rl1+eJjpgdTNh0oDOCKCnri7DF4IBKQmtsbF3D4iH/rZ6BWJ2n+AEDiet1MYjK8xLo/sTFYugjaP5WJRnPueWRPVv2woUGpfR4yKh2RtwZ9gtwcwj8OyhIBDCpnuCQ8O/PayraDAznGiKndxYu41k2pkJYufIROcVLR7IZtiY6aPp8hN+WSxKFOHiTQnH8n7H3aKuEQ1HNfAjqB+qJkMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MndffgY2vq2UpxWU+/OeZ7pVzm9P8eFP6/NRzRylFA0=;
 b=iSjrgMlNXcvNKD4SLu6SF6gKRXx8og/38lPB+YNdbxmrnOdW4dFFQPSh8fba3oRAYt9CxYpq7i6A33NYVE5C5i4voVhVg3NA+pWEdF9qvGm1dmdi0GV5N0VJL/QOdq/kmx7nHi+jwWrX8/1oNA/ngYcCgGwgvM7qH3exO3TzI+oyM6olZyc7LvRIXYgTXXmG8O6gJYTgmDLGWFpqj94d9/ALIYSrseB3bn8rvaVzKXN5IM8sT1AsdmhFcvWnBJJsCmUTw81uy880PTL1K9dKhceflG6PXk8fZSN83C/UDr28mj85pNWK4G+7snftl+COtsFpu7+cRvIB0FVrUhlUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MndffgY2vq2UpxWU+/OeZ7pVzm9P8eFP6/NRzRylFA0=;
 b=h2OwSkM+IilkH7Sz1A+V+CxaHKw2L6sH6i+L+vFBtGFSujt60K+M5yjnMNo/gBz4g8rwquNBOSsJJaJQ7uWtyRR0X0Qpill2zcrkIKPa0jJfF9IDSEf/2orYm8VD8+DnB3mFsi3WNjp2XMe0bVJZiWjv2J6cDcBGA1eJ9PqWOPY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4691.eurprd08.prod.outlook.com (2603:10a6:20b:cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 9 Nov
 2020 07:18:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 07:18:00 +0000
Subject: Re: nbd: bitmap_to_extents() calls nbd_extent_array_add() without
 checking return value: coverity false positive?
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8keTZEW3MLky3_HKh5cu2HR1O0iBax2c0hs0qSosNYSw@mail.gmail.com>
 <9ff386a7-c334-30ed-da79-341d75ed39b2@redhat.com>
 <CAFEAcA8Po-V6+b-AVxSdwrEJ7Zy2Pm7xf8Ss4fsUtWDMG=ziQw@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2c778baa-8829-4dcd-ebc2-8d6b35ca87ae@virtuozzo.com>
Date: Mon, 9 Nov 2020 10:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CAFEAcA8Po-V6+b-AVxSdwrEJ7Zy2Pm7xf8Ss4fsUtWDMG=ziQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM9P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM9P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 07:17:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ef6cda7-a917-420b-2917-08d8847f96d3
X-MS-TrafficTypeDiagnostic: AM6PR08MB4691:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4691B3997536AEF7A7AEE33EC1EA0@AM6PR08MB4691.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOZZ62IEZiyIt/LW2RNYQr/Ix7sblCALsW6gjsVs3f7Z+i3uxmSp5Q68SM5Zb8VGHHiYz9Fq2pH6/eOz0A/l6MUeINdDw5cy6/0WGS0ku+LHlVeD/ztgXftdCesqIfJle7DV41rl45fBs2YO0YFmoo4PSH+s1wk5F8NVaEosNGZrLv3GeBZaAwLFVgn2M4b/icvXN9KkumqipmQkheiOdYPYFnRf8eYWTfOJAYNBT+EjBs9MUeapaQrnFG006FReAl9KAyF2FBBrgAITWxoKF8eqJGUZOOFc+jzm1SDrGby2q1+OGC5gxKyWO9M3sI+vOkZHFYa62ZVeGAP01KTrcTlgSE3x8pmLhf7GSbzdEk/BNe/jAyEAm/ku1HcXIDLj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66556008)(2906002)(31696002)(86362001)(8936002)(26005)(8676002)(956004)(2616005)(5660300002)(66476007)(478600001)(36756003)(53546011)(110136005)(316002)(83380400001)(52116002)(31686004)(66946007)(16526019)(6486002)(186003)(4326008)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zfoG4/uUkSvqOlExRSqaL96LQWegIObqn655eKpdsUmy7B4PGaL1YxhIR2YFq82vI3UTwOJiE8H7LPBn1vRA096dlWYRqsMt8xmUmEoHl3tGycqZCVy13paPKvXuFEDNKP/X5TBeYP90kt1Vjt74GJpbIRaYa1DGoBRKBArp8ARkvzWl0HfReI2i+LKHF+2Xyu61Uvjkx0Xbs9JA6/pNcVn9Uezqqfo8BFDvq0XUKZmHypkHabmjC0Tm1Jlkf3/Dvt9D1GjBnvq98F9dSNRTKB0dn/dj3XbT5yaV4gkCtGCK2LsTZlh0rONhPIx+DBhn+rp/kX305WcIAMfdkeHzpv/asOcmaWLM9IqKOMaTP1+N53xCwV0q8me0M88h3T1z/oNWBUzbWT65Vc30F2DeELIIV093uuHliCxVdxpO+tnbk30ij0y0JmHGUepPobRgsFuJSETyqIfiFUSH73/epWauj3RRf64KmIPVK46EG13p88oy+w+rVtErz2BEUgzqa7zMm3yTfjcFKNe5a3g74OIrxs6n6pcY1sAq4B0IwLudbSZ1RuxMfmI6iZpnmgyIC1NOjssLXaLHGznfe6OZ0STIOiKUhqXXjOpPrvz4Zp1MCXjkO938Do5R1FhQsIm4GXy3XDEZMZU3W/pyhoVQEA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef6cda7-a917-420b-2917-08d8847f96d3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 07:18:00.0702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hfd5TIeOmRNsytuFX/SYpZppY3LdtgjMEyJ1Fl1jDwMG62HQfP9zBfOtu+Plw5PwBUcb2aq/g6RHfNvXpWRfUWO1jGRSI15hypKYV0SjZSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4691
Received-SPF: pass client-ip=40.107.22.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 02:18:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.11.2020 01:53, Peter Maydell wrote:
> On Fri, 6 Nov 2020 at 20:36, Eric Blake <eblake@redhat.com> wrote:
>>
>> On 11/6/20 11:22 AM, Peter Maydell wrote:
>>> Hi; Coverity's "you usually check the return value of this function
>>> but you didn't do that here" heuristic has fired on the code in
>>> nbd/server.c:bitmap_to_extents() -- the function nbd_extent_array_add()
>>> is called five times in server.c, and the return value is checked
>>> in four of those, but not in the final call at the end of
>>> bitmap_to_extents(). (CID 1436125.)
>>>
>>> Is this a false positive, or should the caller be handling an
>>> error here ?
>>
>> False positive, but I don't mind tweaking the code to silence Coverity.
>> This should do it; let me know if I should turn it into a formal patch.
>>
>> diff --git i/nbd/server.c w/nbd/server.c
>> index d145e1a69083..377698a2ce85 100644
>> --- i/nbd/server.c
>> +++ w/nbd/server.c
>> @@ -2128,9 +2128,8 @@ static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
>>           }
>>       }
>>
>> -    if (!full) {
>> -        /* last non dirty extent */
>> -        nbd_extent_array_add(es, end - start, 0);
>> +    if (!full && nbd_extent_array_add(es, end - start, 0) < 0) {
>> +        /* last non dirty extent, not a problem if array is now full */
>>       }
>>
>>       bdrv_dirty_bitmap_unlock(bitmap);
> 
> Hmm; that looks a little odd but I guess it's a bit more
> documentative of the intent. Up to you whether you want
> to submit it as a patch or not I guess :-)
> 
> thanks
> -- PMM
> 


update_refcount() in block/qcow2-refcount.c is defined as

  static int QEMU_WARN_UNUSED_RESULT update_refcount(..);

May be, use such specifier for nbd_extent_array_add()?

-- 
Best regards,
Vladimir

