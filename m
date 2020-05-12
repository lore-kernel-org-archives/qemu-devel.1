Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4745C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4CC20673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="efYXyjqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4CC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWVT-0005hI-Ht
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYWOK-0002Xd-Dk; Tue, 12 May 2020 11:00:20 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
 ([40.107.1.128]:47236 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYWOI-0008Kz-KY; Tue, 12 May 2020 11:00:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEKyORnLZ9GuArvrSQ+4KlFeR+UssQeOllpVULZ3m3lcf7l+tuWlfHG0vy0bcpam0c8AlHPClQCUoyR55MlvZWHTKj5XyR2rdiodhACLBGoHadmXCXxzMa8tOwEBc5v/Z0RQrsrj7z66FI+cQXxNUrEGFvKrN1sN5FILK7PyhUgpA2nsOfo1crH4w1TwQ4bX6QHBUxShOtNVd0qi0jdwSC2FHbQAYlv8gH4WKMH2nL39uQfUdq30IBTRpNVJ8M18EhqZrermZXdlM30iSTuT/3XAFy9GRkYpYzCqjgeQE3gL1Zx4rdqSwKyu8v/WiCDsw9Fuk4DnuJPwCTH52rXAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T55h4UxxUnju8M10Wws2zLgSVoRZm7uNAsUg5KokPRc=;
 b=mIjzrLiQ4KHlRhVBqFBZkb2ZZ6sHdXYf0N22wPHtRpVltVXURabZx/m/TARvUV4sG6cRlaM4esO/iP1I/r4qgepaRkerspse26b2XVrGY4Cw9z2+Svb68n0Y75KWEZA9MVTWDROI5Bdzaf29U0uSSNwEFmprqoI48W1aMTOccKa41rtBvtjs9RtJg2yNfBiPLmMdMm+2/bb65fBj+r9+uN8LHcTbEv70c7V/QDzgvEbm02J1LdwMPV1Pl1Qr0L2r7Uzb9rga4tbQZeWPM4gsD+XV58eMfzDpDCNleu7gR3tFbmSQrTh0gSO10ThjegdLxD8o4SLZUAdvjcV1/ncn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T55h4UxxUnju8M10Wws2zLgSVoRZm7uNAsUg5KokPRc=;
 b=efYXyjqhthzquVPupGPiWkORlFepQolqx+AX4oTAmSSAmtF9MvwmdApNMmmUaMu5hmkd+fTEGu52DGaBKlTJbYm62J8OIeZaBf7TauPMxm4X5MFW6DSCOMVwill/4hU4fOU2XTfnXoWyVx8lMlA+r8FP+wDR9ALntt2iod/DWqk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5414.eurprd08.prod.outlook.com (2603:10a6:20b:105::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 15:00:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 15:00:13 +0000
Subject: Re: [PATCH v2 1/4] iotests/109: Don't mirror with mismatched size
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-2-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200512180011934
Message-ID: <63a7d35a-6bc3-2925-5b50-f398e05fc660@virtuozzo.com>
Date: Tue, 12 May 2020 18:00:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200511135825.219437-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0090.eurprd02.prod.outlook.com
 (2603:10a6:208:154::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.163) by
 AM0PR02CA0090.eurprd02.prod.outlook.com (2603:10a6:208:154::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Tue, 12 May 2020 15:00:12 +0000
X-Tagtoolbar-Keys: D20200512180011934
X-Originating-IP: [185.215.60.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e64f9ad6-2e0d-4dc5-465c-08d7f6852c6b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5414:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54143AAA45409FE0BC4AD6CDC1BE0@AM7PR08MB5414.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJAHaJGIi9o/H9YSy6g8HYIZALmZBAoKXI29lgL8EXSfpavcoNCkoA2jqEzU9BPpxCk1ZwlMPR/xzAAwiusxgk7IXKmRwfUEmn3F7f+65Z/z665PB8Ybi9RKsU/lNgeDrU+Lg7b2aJx2Riqk0cPvLTt7L6DGXjBdeOJXvT3Whfyn7lkVERmf5l5W+WJnU7alhmeZ6/cJUUmE2RJOKAMmrhThtIn7EQQh8UCK0Q+8aek/xev7vzHKrKhOjmq1QTS9I4+nDY9fwsSczzPT35zbueL64jAXnn40c5rZUA0J8OxfYoxsMttSXQvw3RiC12j2rT+TnW3y6alwy0VvleXqrQWVe6nhHd9rkhgM1/Qrhk/EraHm4Y+zkIsfyX1NAB8MK90KLfyJUjOJecOSx4C7aa9gc1TsMXVZC0iDXMMeRyhQcWmHCzah4MLQFKjcHSXUs+CVCc+gM5F5YSA1S/4/q36ueligeixtd9V1POG7o8baUW7YM3FzJ7XlFUJBKy6FGHG9qupURCmIIc7WLrg5a/0SZA8Gy77kCsVM7R0BDWBsDBhteYk2UKHEsdaXsK6i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39840400004)(346002)(136003)(366004)(33430700001)(66946007)(16576012)(8936002)(66476007)(31696002)(316002)(4326008)(33440700001)(31686004)(8676002)(478600001)(2906002)(66556008)(26005)(36756003)(4744005)(86362001)(186003)(5660300002)(52116002)(956004)(2616005)(16526019)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kmwE8I2DFetCFgSYVC6u++Ggx+4CXSsmA2uresbh4ST6ibd7TcbvJQK+DupUTd6ks9+JZbZHDvRp4HF3vAZBrqVUfhO4VyvRlCG1cu4Db/We7k4GIipI0rywkEjDD9Mzmpw8EJfb3HaumJaNvuFvNRI0qkEbEQPAX1CVW0jtb2ezJBOO1jM3iS3K8E7BXD4jFZLCmwj51SdezKAIt+xnVYvZSqAyn0rPq8yRcTZjYer119k30VXz0zSimrJcfKV7O+ih407+mqbna9uIRwLyPrPp674JMWZcxUlgOcmZAr7lRRGawTZYzNhNYSRDbT6LWK83HtINfrJHgU71r0YUV52lFXlZKvFE4j8xIPtSp+hDsJvCqtXFfAO+vJrIrayBVfN6P182PVyFUqwbWtRsUn4/DbPoTcoUzfeVZGLgUYweL87lJ9/Fs02A2+PJq5gmsQS8kf3PDuDFTkj79Arh0i0a0lugQYjXeUWaSRDwPy4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64f9ad6-2e0d-4dc5-465c-08d7f6852c6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:00:13.6632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fd1/meokHhUqcW9JR9d6ZH8240ZRh8bWXOg6lO5tlWi0wSmQb3mLJYY/5PuUd3ks3/+xtd5tbNis3waegcCh4kvk7HM7hIvUdDNbsG49KRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5414
Received-SPF: pass client-ip=40.107.1.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:00:14
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.05.2020 16:58, Kevin Wolf wrote:
> This patch makes the raw image the same size as the file in a different
> format that is mirrored as raw to it to avoid errors when mirror starts
> to enforce that source and target are the same size.
> 
> We check only that the first 512 bytes are zeroed (instead of 64k)
> because some image formats create image files that are smaller than 64k,
> so trying to read 64k would result in I/O errors. Apart from this, 512
> is more appropriate anyway because the raw format driver protects
> specifically the first 512 bytes.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

