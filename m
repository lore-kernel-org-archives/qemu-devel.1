Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E53C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947E621D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UQgB3vxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947E621D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHuP-0001NJ-0f
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJHrO-0008JU-BK; Fri, 18 Sep 2020 10:59:38 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com
 ([40.107.1.123]:1102 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJHrK-0006yB-Nz; Fri, 18 Sep 2020 10:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImwXSniQROFzzgr8KSGKYTxOuPGCewZ4sBYyVugBR/5ANXU18cVjARZN11nHaUDTkrL6lxxjb/2DeK0qDv6MZn1DJ5smsdjYfZurnpNBSBllg2i9irt3prGdEDmxzFPvoEBsvfOfe00m9NtO05d4Cp+AkUCoWbzq6OZbCDvCH3BThZAm9vynytFNb75gUgP53V/Y10PgIuNWJctklpLQSIMf1wQY7+3QxXjuY6vE/TkSjkusN45QPYlT6cRvLGHpXljjVH7guQV8Tfpxk2NKIE9ZiBwRioonrDwm6ha1oBqY5n+wE9BjdiFNlTx3sy94qBO0654YlWW68zuuKUMERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSLIXs3b9gEFDEUtwvXrmGWtLEkmhmHXQp8xGM7qeV4=;
 b=Mjf/sB1on++K5e1BcpCQlLQBPAAnrFxIP5S/WtI+loYx5dLCkTV9KCfWOw+XvbkklsJYm3j+fvkZ8Cp5OYk10KKf3BwcuoQz98m+9zeeTklTCG0A6lXhTFCDRZDQGfwNDGLuXHRZJ1MZiWf44MzaZLf74OZ6HBL3QLpwmoIeoYryaQ7LOO1Wpt73V56PX/S01mJr6SXEAugs8R+n+4WqK/08owz59wAny1SHQ9E+QcYgfz/OO4iJBCxG+dr9uQdAA2Ifbi+V2gDPzKRsWG7/boDsm4cE5EuFwXA90K8gBT9zoYNbo40g5VMCwtgtzWN0tMa1LwX0HjvyQonAVehp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSLIXs3b9gEFDEUtwvXrmGWtLEkmhmHXQp8xGM7qeV4=;
 b=UQgB3vxoGRY+09SE3FRplfrrTzNJXgl21hu96SwhTFkQWRkAPA8IzRVGp9dOB3crFkmcqCu9RqMKC5cxiXXOI6C3ZeNzkGdsTFm67/B9CXSr6xoI4E7ku4QinD6HBwzC8y7QxJ5O8U9X9kZNt8v64IDV6dInuj3iiC0LnkSyMIA=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2531.eurprd08.prod.outlook.com (2603:10a6:203:a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 14:59:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 14:59:31 +0000
Subject: Re: [PATCH v2 09/13] block/qcow2-bitmap: improve
 qcow2_load_dirty_bitmaps() interface
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 pavel.dovgaluk@ispras.ru, ari@tuxera.com, mreitz@redhat.com,
 kwolf@redhat.com, groug@kaod.org
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-10-vsementsov@virtuozzo.com>
 <w51wo0r2l08.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f52d9f89-4781-664d-d8e3-5a6c8a93fc0b@virtuozzo.com>
Date: Fri, 18 Sep 2020 17:59:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <w51wo0r2l08.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:208:55::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.106) by
 AM0PR04CA0113.eurprd04.prod.outlook.com (2603:10a6:208:55::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 14:59:30 +0000
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfbd3b2f-2443-4a8a-9fb9-08d85be37269
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2531:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB25315DAA40DCE55527C1ED0EC13F0@AM5PR0802MB2531.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1T8zBWYYo+nQ7AE7Sk7WyJHl+BdmHycz3odBw+cvnydkmX7zPfW4KhIBakQBQ9lkugkwO1S9FjgtXoqPnbEss8rXchivjiycqFuo1NG13MQi7SLXteKAx/oV48OudPF0QKjz9FT+Lpv0Wz23ktTCZ0syulqmTtF0IERMRYUQHtHrF4GalER2INZVHA0Y7hKKt8rLhjjVkDlBuo1sQGDh4Ttzp+knV6AMJKWNfxyqs0m67swZuml/XRKacaApOBLYsa/eu9tIT6JfOE5MJVYQNst/0qvkKTXSw0bic+3aR7dPkMO3vLtpig4Ie9TOtChbSFhfHOCUGSGksV5OMuEHUpqTfjQFG5jfkh56/SZvTXuBzOedXxgDT7nveMcCWCHWEGUK7MEzgDD2AKQq5uU9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(83380400001)(5660300002)(36756003)(4326008)(86362001)(16576012)(16526019)(2616005)(186003)(26005)(2906002)(478600001)(52116002)(31696002)(4744005)(31686004)(7416002)(316002)(66946007)(8676002)(66556008)(66476007)(956004)(6486002)(8936002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gX/sN4XvD1FDRnoK2zhRxXjr0tpTenMnRDkobkbI8EO9U9JxQXXoiQgkJurmJ3gwe7ilbM/96Ya7j8xcDBkcwA7F9foZIxtnfKsLPWH7Qulnyfei8aasXQrE38KlqZaBvhx9AwhbtJJf3IvhOb0QTpIjWyg+eyJKHSQ9XGyrt7So4lQYrBbXP4ZsZffbeZcToJbBfDgJLPMpHpREAbXzKb+ANpIJUiXOji9TyCrjOeYiOzxFT1niYJx929C28t6RKKhZRvtUdrLyt17Nx6vWzbUNKC5Pp8koRDfyo8M5sfoVQOZYSUcimt0URyGCHKT2kcCa31K3Jx+6dqbSBlpT+iH/yLNO8U1wBeIWXGsLAwByVMVMIvU8DMy5+1vn81Gi4dr8KQTIGtTF2Z8GoeXuILsDwdOq9nFLufmRQ/4dGGhFKf1i6WZxTphJ1zfKIiGOjc1fQYpksJeqkNZsdiY3bKTgYB5GRhVloEKhi3o3Prshb31GX0QN08GVyJnAu25NdR2txNbYsdqEOMKLYJUcoRzif2FRu+HJ3vXrsx3Z+GVw+RhyUBOTmqSlrInFFbS7czj77gQ6WGDvkl5jdGvZ5cuf5yqj0yGc+agXo2+fc5ZEcjavAXHxFiqpl20eiSxrS/hAmN7z6psXvOdT+3yZSQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbd3b2f-2443-4a8a-9fb9-08d85be37269
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 14:59:30.9009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmS3dfdO5LGRwqDpCWyIt5xAkGaXGAELcSz/A99zXUobKinklJmvhdM/UnuCRZGv3c01x2xTyIN9/vgkz2xCC0hsYOTMqWOeeQaQbMQqPVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2531
Received-SPF: pass client-ip=40.107.1.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 10:59:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_LOW=-0.7,
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

18.09.2020 17:54, Alberto Garcia wrote:
> On Thu 17 Sep 2020 09:55:15 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> It's recommended for bool functions with errp to return true on success
>> and false on failure. Non-standard interfaces don't help to understand
>> the code. The change is also needed to reduce error propagation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
>> +/*
>> + * Return true on success, false on failure. Anyway, if header_updated
>> + * provided set it appropriately.
>>    */
> 
> I'm not a native speaker but it sounds a bit odd to me. Maybe "If
> header_updated is not NULL then it is set appropriately regardless of
> the return value".

That's better I think, thanks.

> 
> But I'm fine with your version, so
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> 
> Berto
> 


-- 
Best regards,
Vladimir

