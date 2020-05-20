Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C615C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCD62072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="beoVVINu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCD62072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQFY-0001S6-9K
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbQEB-0008TN-DN; Wed, 20 May 2020 11:01:51 -0400
Received: from mail-db8eur05on2123.outbound.protection.outlook.com
 ([40.107.20.123]:55356 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbQE8-0005f0-HO; Wed, 20 May 2020 11:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqFMSzvBoUeznyijyIxrbRgOFOrAxOsEo6XIMemoOcNKzEOoo3JyryVAohohldHn9Vpj1hiJ1pweHJm1+f01Izvel73k9yA3W+vFkCS069oEgss0OrueCFuPjy7lSU9EObKoPeV9P7Hmc9nCkV4Z0r2rrjrR8FgbSeqkb95xn2jQvROZdoZfOl8BkrT+XX7Jwr6d1ZJMEXxuDdr6dKfBvxGlYB4hcd9mbXeS+9/TvVO3E3e6VrJ2ZWvZAyBQXfXD10RdCfUG+Vqc96/cFRVmu2vY970x3JcGErp14MIOpiOXI0x4qVeH0F3mbsK2kCQri9mUGlIN2tMh0iD+DA6W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYTU6qB30VEQGaTYWE929FGLWHvF0+z3V5YNcEmuMO0=;
 b=Y3wqoiBgtosZDRKEuZBZDTurOHsDTCuKfHuHE4Hk3NSp2erPPTwOaAKc5k8Pt8mmbVhwv3wdtzS2cGKJaW2tz6+blE0qc6NK5Sjnp6qM1aCVANJl9BoKgVEWSq//MRBBXytWOO/qzdpc3VS9AbiGMNX589lBk8WbQ05N3m63thvnSw7IJ6hW8wfBwSs13SW9TLvlNPliooGohcD6VAsaoJVt56gLIVwPYNvnxGdtQ41v/AAfaaeRxovhyEpA4lklg5qwdeEjInkSVzKfKnx0LEKnQc6BBCtHT/klMXmgBr6+19txrgDTAA1mNdSJ5T2nzKfhVZaIyyFihTYab2lzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYTU6qB30VEQGaTYWE929FGLWHvF0+z3V5YNcEmuMO0=;
 b=beoVVINurU7Ao6LIuRvfIS9Z97tMArvxd4VO4YVuoYl1GX3AB7uFBksbWax7w4CrSKkHceBCALP5jCOt8Otcwq/FpWN/8WdXIvMJdra3r5lZ6wDOkW4D3pgskPNX90Duqkvntq4Y6mBI+TtDOXNk+OgukPcVvzSk1G8DEciQeTg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 15:01:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 15:01:45 +0000
Subject: Re: [PATCH v2] block: Factor out bdrv_run_co()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200519175650.31506-1-vsementsov@virtuozzo.com>
 <20200520140500.GB5192@linux.fritz.box>
 <20200520144928.GC5192@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <972c3c74-4128-18ff-28b8-00d10232988f@virtuozzo.com>
Date: Wed, 20 May 2020 18:01:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200520144928.GC5192@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:208:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.147) by
 AM0PR03CA0008.eurprd03.prod.outlook.com (2603:10a6:208:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 15:01:44 +0000
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00deec8b-31d3-4b9a-a976-08d7fcceb6a5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5496F52DF15A94B6502291EDC1B60@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYPSnSvcOyJUiFYCzZq8XkXY/hF4BHPxRNYyRwPSIKJjuynInYVOLahohfvdMIU1h94WlGqJNeyxIb4El5mLsUXx28JA6fbcFBiobdrdFe/KAY1RPUACZ2SytsjSEM5f4UYz23e2gPRdvl1cRS4bziOK1Z286I1Ay71BiqxkqJrZkHL0CgPEnX0KstOXG342wADUbL+LMkqjEgQ7g+FH6UAneTlR+hOZyPAn79IQd7LleI5XQzev2i78nbpUA/0OKOg95EUAE25wH+zJcb8l/KRdwkF1AJj6tjjn3A3ogz4GGqxpiJAco9ry2WnuYgnRrsyMeTGonVVqaYjTG1U4KbJuAl/RFEFiMkumuLAD89KnbKN9wiiLjTU8yseryFuFUayYaE3Ct6SgtzQhR7SBfPxfCFzoA4rUgUqOGPCnuPutVaL03JaONGkVvFr7y0PPIxs+tapnBUtDpOOBlwf9vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39850400004)(346002)(396003)(366004)(136003)(6486002)(956004)(2616005)(4326008)(6916009)(8936002)(36756003)(8676002)(2906002)(31686004)(66946007)(66556008)(186003)(31696002)(16526019)(107886003)(86362001)(26005)(316002)(966005)(16576012)(66476007)(478600001)(5660300002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eZPBwDio8BWXUW+ZXpehQiPVSR/S7m/b0IutZuh/qQ7Efqmm7QnMud7PM/qP2CT3XPSmlk7RTbviTgDtAtiCuGqibd4oMJ+myIyaPHHXdf1Nc7kUVp4JgOz/w4hy7xtM5JOqPKSJyA29nEQNTYgO5o0W3nUpbm5QwjYeT0ziT54SGczSVqCzoMNMVoI2MX/kPw0iLtzXAGY9AXx3+JFco7BUurY8ONUt/jiR60s3l1xozy2SQqLB9Pg1z8UB9LJCs1DZ8QKOLFYSGPlR2mn+tAJ7KKUSSbuuCpThM8zeYeHtuzRLd4G+DD3M4/9X7QBQbz2ikxKPkrg+mbG+quPIi4zVaJFFe32nOluIo+N9/ZRIRp/laZpbZTOJRRrBREPZ4TbikIW+RsVEzTjho9312vgri8x8cIHVQvpydR6OChXRA0luaOslnpAXNKgzFfxTTPvsGjrpGOTf3fLo9YZcJdjg/dDKpNFRCJSsB6iEfda0+pe6jn4C0DurKyZ0foUG
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00deec8b-31d3-4b9a-a976-08d7fcceb6a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 15:01:45.5172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fqqA2aLTJ3PoLJIfA8WU8QUolKbioKCLYdCTy6z1LQbLmNWNeNwASl0JZ64qzqKf5VrnVLIitd0pUHJOvXBAKw+tepIio9zXzsE59VRH0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.20.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 11:01:46
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.05.2020 17:49, Kevin Wolf wrote:
> Am 20.05.2020 um 16:05 hat Kevin Wolf geschrieben:
>> Am 19.05.2020 um 19:56 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> We have a few bdrv_*() functions that can either spawn a new coroutine
>>> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
>>> alreeady running in a coroutine. All of them duplicate basically the
>>> same code.
>>>
>>> Factor the common code into a new function bdrv_run_co().
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>     [Factor out bdrv_run_co_entry too]
>>> ---
>>>
>>> Hi!
>>>
>>> I'm a bit lost on rebasing "block/io: safer inc/dec in_flight sections"
>>> (is it needed or not?), so, I decided to send just this one patch:
>>>
>>> I suggest to go a bit further, and refactor that bdrv_run_co don't need
>>> additional *ret argument neither NOT_DONE logic.
>>
>> Hm, this approach adds another indirection and bdrv_pread/pwrite still
>> seems to be on some hot paths. But maybe this is just the right
>> motivation to clean up qcow2 a bit and use explicit bdrv_co_*() where it
>> is possible. I might take a look later.
> 
> Still not easily possible it seems. We can add a few coroutine_fn
> markers here and there (and probably should do that), but the
> interesting I/O is in the Qcow2Cache, which is used from basically
> everywhere.
> 

Hmm. Calling *_entry on in-coroutine path is also an extra inderection.

I've posted another solution for this think: auto generation of coroutine wrappers code, which produce no extra inderection.

RFC was here, a year ago: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05322.html

May be, it's time to resend it, as your point gives it a point.

-- 
Best regards,
Vladimir

