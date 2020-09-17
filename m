Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276662087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BtH89zI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276662087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIz1v-0004Se-BL
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIz1J-0003np-2H; Thu, 17 Sep 2020 14:52:37 -0400
Received: from mail-eopbgr50138.outbound.protection.outlook.com
 ([40.107.5.138]:54921 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIz1F-0004U7-GY; Thu, 17 Sep 2020 14:52:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXv7KXgLuEYXTBqR0Sp2xXCfW8CWsztbeafrCPiwbaGkHMJkAXwq/aRsHI3AKbAbsrzsU0/q7s0av9wqDLUqN7IhbYqIIkqReUNUCMKUCViLz94xADsVi0h4u0QiSjV6PPX7imX/sKmYKzgl4Jg9vEI0G+cVUY5PBlKgJLz0K2PpSCgI1F2xH5g2eoL92P2GqXDAhYx56uIFHDyUizqQdJlUPsgEPLenGRQX2X9oXXkAKJKcu6xb/cbef8TfDKSjG1JyXCheAeW8KiGb21QO/zhqXXJfUwQKru8i2HHlcBXnEGnObab0gx5saxw4p5s/ausPdOZg/3uORIVCK5/ELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRoBWnpk1UqHHpdeLbKh50d57sMB23zqVXWsTUjh/54=;
 b=HLd5aCjSjhKo+HfOZHwDtlE1JFstNfWjB1XKUnuJhntfx8x0Q5Vqb7u10UfrqXCTuKgAMkC5qHFGV+8IWUPRqOUcIsn1GYX+4dyrgibu/AhSGuifzsLBf6oM/MmtCbPkvcs+DOsiqwgrABZE38ZW1dCPBVy9xA0aSPoobGs4KtHUjTmHorHDk8Tyb4LJqBGLa0zLEU0wj5cFZvyytk6Cpd0kxi+ae2QxTpd9/2E8EVtmhaxLFLElL0H+boqlm5LhP1wb6TOLSyDgjgV99HYPnNFRpEYDKm1XuxfkCPGWa76R/IQieg6dfDymmSEjCfYDdGjQvKmEU6E9n9UqOrwCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRoBWnpk1UqHHpdeLbKh50d57sMB23zqVXWsTUjh/54=;
 b=BtH89zI1hdH6DhAEr3XnjM5shOPSmax2rqYYqz8uH698ZYKW6U5+6KF+8aPiN2qeWGJ3mDJZcncDLqIrZM4vyfUQRNBEApYNhDCt3voG4s9L8d5wKPnPyAa1iUNLUd7rT31aWuCmVreeHF/+o9wBcaFttMatMd/xDz4JzvmuNmM=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3718.eurprd08.prod.outlook.com (2603:10a6:20b:81::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 18:52:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 18:52:29 +0000
Subject: Re: [PATCH 09/14] block/qcow2: qcow2_get_specific_info(): drop error
 propagation
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 pavel.dovgaluk@ispras.ru, ari@tuxera.com, mreitz@redhat.com,
 kwolf@redhat.com, groug@kaod.org
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-10-vsementsov@virtuozzo.com>
 <w51y2l85pon.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d0d7bb04-d6a5-5b7b-17e6-6b659026054c@virtuozzo.com>
Date: Thu, 17 Sep 2020 21:52:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <w51y2l85pon.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 18:52:28 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f4e09a-49f5-4918-6a56-08d85b3ad3c1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3718:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3718C79D0D5996FB5F8F8267C13E0@AM6PR08MB3718.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vrbnPa1yYjN5pgEIG2U2qCP8ifpSWJkkQo7ypSWM8PaV+z3EoJn93YElIUd95nGwxXQDGz2YQRmg8dywUkYAy6unCPwVEEqDTcdQCsHqZSyNERHi5ou1ls/CD4eObe5H0rP2X0NUj7IHtzHSA7MycsYa31PEe5OqLzeZSCkPlnWxRTqGTjUoOMTdjzbXAc0RiHIVC2Ju18N9M2qqFFQWxB6ikfU1bWBq+g+f6FgpqeAsz2NdgXcSdeh3nr+DGG2iPJzU8sYH9bdbYR1uq6o/G9eccg96k8WrmEUHuHRSNvS+BxDeOGH8a5T3CRbO6M3omWtF31nuFfPnSFKb/sIydch/sQ4VliCBUVzUO91g22GxprNJAm7WM8IRR2hz/XH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39840400004)(396003)(6486002)(19627235002)(316002)(26005)(478600001)(52116002)(5660300002)(8676002)(31686004)(36756003)(2616005)(956004)(2906002)(7416002)(8936002)(83380400001)(4326008)(16526019)(66946007)(86362001)(186003)(66556008)(16576012)(66476007)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: K5mT4J59UaqifaJanCSISbCems9lZxwKKHxPLvLdCRve3EMrk/LBM6LybxfDQdzV9CaVeT8UpTY78hAbhCR6LOa/yxHzvUQXiI1BuGCeaH8fC5ImTtLneeqyO5yEbaqwVYg72P3ykB5IDNF03PXM/t9eFsrE2azLX5sIHRYGdHdGpJFNJ5NpYLBmbC8mX4Nfvki9ogSZE0Q4qoI2UhxHZsIyxFExmnu9T7HZzVwTIAm78iLdoV8Gn3LvfS0JnOOPF0OirIke4fvOHctyePcdR8sB3mohQ1llmQTN62xE4olUXPiwb+/JhIerh3eOuV+T9YufyRwd7qqUccg17rYR9hcOZ5Y/BMVkQZLZSMJGmHkRMwQBi/rYZ9rtYUsZw9uFEB0ogt0V934FlwNGkAq5QwtlJh05gucw+QeiRope2pDvD+/BtBVogtX6WMK9qiOD6/sCxXYe93OHmlpFGHvdNm4NJ7cvypSNaxO8bArwuwDAS5LeKK4eWUQ/IG/xEwqhDx3V48GcsK+t8FBpnDVdRN3oZha0yI0fj7wcJ8MWGxx0OVNtpQ3Rgi6ch5MMkHjD7AohKLpmPeZlr+NMkVWSSRqPy2CFc3WS1Pcq/vyvRFJ4JCssRr2jG1yhaViJqbKX2fdd3b9+McblFaTFWSIDeQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f4e09a-49f5-4918-6a56-08d85b3ad3c1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 18:52:29.2909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdcu9j5bThP2LYYFhrzK0RzR0MLGZCYRN8d5dHQAnwET10yyg2zZZ1sNpL3uPoz3Bdr0Gx7utDAPdxj9H2GQtWsQ5+njljwujAeDGi7Y83U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3718
Received-SPF: pass client-ip=40.107.5.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:52:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

17.09.2020 19:32, Alberto Garcia wrote:
> On Wed 09 Sep 2020 08:59:25 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
>> + * On success return true with bm_list set (probably to NULL, if no bitmaps),
> 
> " probably " ? :-)

I note this as "set to NULL" is not obvious thing (is it "unset" ? :).. And by "probably" I mean "may be", i.e. NULL is just one of possible cases. Probably I use "probably" in a wrong way?

> 
>> + * on failure return false with errp set.
>>    */
>> -Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
>> -                                                Error **errp)
>> +bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
>> +                                Qcow2BitmapInfoList **info_list, Error **errp)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       Qcow2BitmapList *bm_list;
>>       Qcow2Bitmap *bm;
>> -    Qcow2BitmapInfoList *list = NULL;
>> -    Qcow2BitmapInfoList **plist = &list;
> 
> So here 'list' points at NULL and 'plist' at &list.

Hmm, to be precise, list _is_ NULL (and points nowhere), and plist points to list.

> 
>> -        *plist = obj;
>> -        plist = &obj->next;
> 
> In the original code 'plist' is updated when you add a new element, so
> it always points at the end of the list. But 'list' is unchanged and it
> still points at the first element.
> 
> So the caller receives a pointer to the first element.
> 
>> +        *info_list = obj;
>> +        info_list = &obj->next;
> 
> But in the new code there is only one variable (passed by the caller),
> which always points at the end of the list.
> 

No: at first "*info_list = obj", we set the result which user will get, users pointer now points to the first object in the list.
Then, at "info_list = &obj->next", we reassign info_list to another pointer: to "next" field of first list item. So, all further "*info_list = obj" are note visible to the caller.

Actually, the logic is not changed, just instead of plist we use info_list, and instead of list - a variable which should be defined in the caller. Look: in old code, first "*plist = obj" sets "list" variable, but all further "*plist = obj" don't change "list" variable.


-- 
Best regards,
Vladimir

