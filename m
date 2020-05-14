Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0818D205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c1H8JeVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0818D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFVS-0002j7-3z
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZFUK-0000jg-UB; Thu, 14 May 2020 11:09:32 -0400
Received: from mail-vi1eur05on2126.outbound.protection.outlook.com
 ([40.107.21.126]:65120 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZFUI-0000oY-EV; Thu, 14 May 2020 11:09:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpqJMbeFwexHNFgGvWQvtMsi7HPPrhtza65LGKJV7TJC8vb6RrphqHOrhqHZiiwTi3eUZZQtLQI+dqVldYWLAufYQvBGQLwBfIrlk3X9zeBPRJUprnEZvGX+I0yQHMNb1iPFEdEOZb/LiPGo2UjSFCekctHn0ssKIP/6Xn63kOWblzyIYLTk7nkSGDAB3+HF0pdkGvsWW1/dL0vhU7is6e3XTVPTwldPwc7gVmE2u36wtJ5Yci/Y5hUrqq9CCUs+KlIX3qEHte2hsLG3woqwprl0ZAFoqF7H9QZvM4i6HuEwa8qflFwy/YJESyLDRkFOstnwDk8lcbbEA8YVa4L8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQFTmFhLrDfZMp/XbSGKfN7AZM6IKdnastP5OnCXi7s=;
 b=HVIP1+xz6ECq934Z50AVxUcGBZvbu39DjCdX4WB0noTQiieYcASAxuoZEbRgvayLQjAwFtk+6h+L+FPd7wYvY3Miph6AoQo6lEL9NsTQy4NhvGVMIUUhydTqEHFH5IFRHGanChM8inp4ilWnvZI1tlvfhVCtOVyPbR9d1PsvITC3OK9vDJxUnoZgI9kZatLr/9KJMwcWfdFhy0fWET+HuY9D+OwhrndsYFOjs2WMyY6ALELFIXWe91UDGSjMPXN6j3P3NQpVeOyfkbrhThrVwMni1249sZWJyOsfltzKTSBkMY3wtzzIZfvjLJ73PVbU+ERXCk8tAKyySDiA8iO60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQFTmFhLrDfZMp/XbSGKfN7AZM6IKdnastP5OnCXi7s=;
 b=c1H8JeVi8+ERvI173LgOdtpQj3ZzZRuhUZ8MeqWn1fVRfGmsJhM8P1nCpPkiVvNmW8JXoQ30ZVCP9lmAAd6ZCihPDRPpnYNGvm9wLntXLJ9p4Q4CNTIOmDGWEc0nBc/csv9Bs5jBjZ70qQN3HJ2BBfSKJFeHHGfmxURqVY5M/NQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 14 May
 2020 15:09:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 15:09:25 +0000
Subject: Re: [PATCH v4 6/9] qemu-img: Add bitmap sub-command
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-7-eblake@redhat.com>
 <ef44c5c0-1032-76e3-a3ce-ad0cc43d297c@virtuozzo.com>
 <0542a587-424c-a596-1778-e7aaf494298c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a76362b3-b237-6b40-7ce9-3935649c7609@virtuozzo.com>
Date: Thu, 14 May 2020 18:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <0542a587-424c-a596-1778-e7aaf494298c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 15:09:24 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52dffe8-aeee-44b2-faf0-08d7f818ca21
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512BD0D5F03B844698EFFECC1BC0@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lg7MtA7fu6KNRq3NUB8ia9ty7M5NXaYJYPEWA7Pbl7SDtBaWBWn22PkCwExGpeTZITQxoicy4tpzZASVZ5OvtuSn2VuIiTAVzQqLHnKuT4sGo1kp3iLqsntJ9YIY5gb7lQUkvEvIFCN+F94ifv0B+tej+BnJ2VMhQknkJyxqcq2v2ShVXwHU7o5cOR2epo7+22l5SDwV341WwYenv6u1NhsRMK6I45X2+itHEYrtsU7ebuqxmR0FLSArzUSfLkgZsyTP2dOJ1Taj82Yt9H1hg0x6Jq9Q0OQzeY3F2sN0qy0A5gSMNhgjqwv/9rBQRv6uTKAcUMOceV7X9NQShZ2h36bgTPfeOWAh5M8/R56m+KSGoq2PlZbELHBlDQLn7j2jtCX9W2kUqDE/6xuP1/U0zgAABL28CjGpa4EMWsDbxzBj1eZ59UxGjNn9/Mm+Fkm2CIVIRlBY7T96Y9GI56AKMoClcxFUyLZMMeRxSwLx7W5SHJ3hdIL8JHTq5sIPZZw+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39840400004)(478600001)(36756003)(2906002)(16526019)(8676002)(186003)(53546011)(6486002)(4326008)(5660300002)(26005)(8936002)(31686004)(66476007)(66556008)(316002)(956004)(16576012)(52116002)(2616005)(66946007)(31696002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UzjQ8SD5RDoRRUcfKQoQ/p00Y3ooEOL5cZlnDVuRyXO4avzPzPNEgf7S6tovavUcGbrPGEfz62ys4H1KLvvUt1o76oefEuAmlNQD8y2pYraWejRxyELvrkMY2uHIIQ2/1GY9eE89J2Jt4ydB8SU/JwTtE/gpZpcu5nuhuKFfIVmKHdorg4fyiC8CUBenbHdE59zyLpB5IWgAfITJDEvaeXp8JNKS+xnatowNLZr9Fneq4EgEoukhYjwlujHfSIF2Q9yfLpu9FuVcmXdOKwxJirpX9rbMN0bY0e2kVOEmJdRVmlxpx8eyiCHbkqyj0LPBE07l4NJ3dawsiSOHi5gq3gzM4KEwUZECuQryi3Mb8wzFIoJjWvPHgdnLAVkJ9zeJ/kdTZvvZzYkckwQLbmvhuV4JtupOEigD3JhhM3hNWHghIj4Q+MZLRfJFjHUPwWJ4sFxZvQVYAGllf0og+xYcitbr7/E2EUvdVgsZ3Ov1ELPh1cB15xaMWhU9VrHVDCQF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52dffe8-aeee-44b2-faf0-08d7f818ca21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 15:09:25.1696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/YGKjmpjO9Y4K3RIaxvJn9WBWmh9O7cIKZTJ0JNMoK9YcNIKedy76G3tYQ+6khJ9+JKtBiOwaGIX6z/aoT0etBDOUj+ZcXc/wtt8WVq+3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.21.126;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:09:26
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

14.05.2020 17:20, Eric Blake wrote:
> On 5/14/20 1:45 AM, Vladimir Sementsov-Ogievskiy wrote:
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
> 
>>
>> I'm sorry for asking it only now on v4.. But still. Why do we need it? 
> 
> Ease of use.
> 
>> We can instead run qemu binary (or even new qemu-storage-daemon) and just use existing qmp commands. Is there a real benefit in developing qemu-img, maintaining two interfaces for the same thing?
> 
> If it makes someone's life easier, and is not hard to maintain, then yes.  A command line interface that calls into QMP is not hard to maintain.  And _I_ certainly found it easier to write iotests with this patch in place, so it already has at least one client.
> 
>> Of-course, just run qmp commands from terminal is a lot less comfortable than just a qemu img command.. But may be we need some wrapper, which make it simple to run one qmp command on an image?
>>
>> It's simple to make a python wrapper working like
>>
>> qemu-qmp block-dirty-bitmap-add '{node: self, name: bitmap0, persistent: true}' /path/to/x.qcow2
> 
> This _IS_ such a wrapper.  The whole point of this patch is that it is now simpler to run one (or more) QMP command on an offline image from the command line.  Just because I wrote it in C instead of python, and attached it to an existing tool instead of writing a new tool, doesn't change the fact that it is just a wrapper around the existing QMP commands.
> 

OK, that's right.

The thing that I didn't like is that we have to make cli-to-qapi interface mapping by hand. But I see now that interface you implementing is prepared to make several actions with same bitmap-name, which can't be achieved with some kind of automatic interface matching anyway, so my proposal don't match your needs, sorry for my haste)


-- 
Best regards,
Vladimir

