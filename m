Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24526C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB20220729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tNq+l+XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB20220729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09QB-00042c-7H
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k09PR-00033Q-Lt; Mon, 27 Jul 2020 16:07:41 -0400
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124]:24596 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k09PO-0006u7-2Y; Mon, 27 Jul 2020 16:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8opmvtZyIaighQA6G3zQZ1DWMlllsnGS9+R55g33W4cPnQN4jkHBZ1SIa+2Cueq9upBVR+sEG6AgtKk9zAStDq1enthfqBiKD8rWKe6FtlcfLM8gASQtLjJFQBl37b6ekv62GMfcH4PDmi2k5sOklF95e7NlnSrbmyIrPuzDHoqU8LVWEfP3wkA2sYfxtbS7+qYSKiKfb1sYzNIITNsWeB15C0w6UcJfWX++xr1RCq8R38He0ILia3nbM0Yabgd2BuI2RhvJQZDsqkOpO9FpJNoGMeEp0EFUQJ1ZKzcg5BdQ+ieywrR485H1KJX1U4GdW2aiKW8qiJr6Z+gFcSukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWr6Bnc6t1LxtPGIGCLJoLWkohMJtfRczXR1X3jGG0o=;
 b=RWNseaJTS5Ri0E+OVnAWp+cUpby113Vdszgkaj1Nizg1o98ZtqSRe9jOgc0FmvWn/qg+HSiXqYP1kqWUdR9rC7vjSjPloU3l0vqqDPrJqt/NQnBi2fdjk5Ar37Dj9wiTTFBo9iLWFtxdFEfcDfl7b2BDq0URzNGpc4y48ly+9TNI/DAh2xW6bEEOUR8sUxSp2AMFauKUdOhSamCtZIDhWOM1nf12fFkpFOqYjxthD/HOpe0Gou58YwUcV9LXmLhig65RxAgLcUHVTo7spAqsdAGsRPUa/FL35Ly0NymXYm1GRmh7dyNQamaZDMCvIDjRqAY38b3EKxGlQGEe0Ptsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWr6Bnc6t1LxtPGIGCLJoLWkohMJtfRczXR1X3jGG0o=;
 b=tNq+l+XCvN4zDDGFOKhoLAW6NxUSwGUYmNRAp8DbVMpBHL7FlCZNRV0zbjr1gl+O9exYJsCnuvA62RV1W9pv1eeEGbMacIWkw/4Mjqy1go73DPmyNm+dsHva4OoTEyd7+AKVJcqR3CfocQc7ZXprlqCVT0zIEUXbzY+EotEjulk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4024.eurprd08.prod.outlook.com (2603:10a6:20b:a5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 20:07:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 20:07:35 +0000
Subject: Re: [PATCH for-5.1?] iotests: Adjust which tests are quick
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200727195117.132151-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f304c499-0c4a-a179-c20e-af7fb8940b20@virtuozzo.com>
Date: Mon, 27 Jul 2020 23:07:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727195117.132151-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0137.eurprd04.prod.outlook.com
 (2603:10a6:208:55::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:208:55::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 20:07:34 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6638ec5-4519-4411-52e1-08d83268b3e9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4024:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4024EF3645189AF6F5FC201CC1720@AM6PR08MB4024.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntIOVVVxjOyhXK7mN5tlJDS30Oqx174SUNj2hmhJJieM+rlqtQsDy3/4cqFnrXntRj3QS7gp6DCV8VVsI6e5DUwpZWlvJAV++g2K9zcXeC67j38u+SDR9ehq7t640IU705T7ocHV3XtkqruQ/uX6ovGN7GvyUlPs+fNpWxP5/uXeRIqumOH76ta37nv5vzI8p/ArdxY7kumwraH9ahlAcaheA+oVtTko8zSkBk6zL3NPWjVuqIZc07TEy57jxAwUUBDMGbhJoJh4o+ix6NcA23z32WMyqm6+gPYtX/QnwmxGrBISqxey5VznjX6y3ZrhaZMQYEC6rwkHuxQM/ThiMHgRYMO8O1qiTb/126FlHXILP3xgyqUrsA68glQ9OriD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39840400004)(366004)(16576012)(4326008)(316002)(6486002)(52116002)(956004)(16526019)(2616005)(186003)(26005)(36756003)(86362001)(31696002)(8676002)(31686004)(5660300002)(66476007)(478600001)(4744005)(2906002)(66946007)(66556008)(8936002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: i30GeE9PLkZZE5uzmB86d0zy79Lctm07zELtXXT3xnOpOoKUHLRUjwiR66ic7yu8RmXzxGsZdjLRe1aGxqgwWyYgy3o4wYvlVxBxJ+wrrp0UAaJJRupkJ/iyXxQgNjUKVZhKvVYFOnjY/+Aq7wj0TfsnDQ+Y8DttmyKlM+IUuSJwkHurDRYOJ6QPHBlO8nAafv870fUEC01Vevvc0pXAS6dCLY74Rody8dxDgnI722AVkDiAcN+6+B8kKOrQm+Dm8K0zanWZqHn7PV7AUYbYbIkv06WggIRBPeXc1NBQw4idQgms0WdDzdVoyOmlPZlYtnGspdg/EEBwmpVss4ZaW1dXnyGm9OzyLOtfesPqUYKFfo19W3+bQ08yIMwWC1mjfHvARXeUlI4XRXLBn6RMIRJ/4CdoLTtjKp941J9gxLnbkn+xgQSFnUpsPwHUePevMOErySUYpItPSfPkIyAybaZHWMdXXHKtD4rzw8YT994=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6638ec5-4519-4411-52e1-08d83268b3e9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 20:07:35.0818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YihPAKswUG7JWzePV2VmGRWH+I7PQ8wzFDDzcEWrQnwnPhNTp+VMC2X4QiTqzSDJaxq59AeVv5UjRh0+vhnfKV+X0wYb28nZKZU/U48DeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4024
Received-SPF: pass client-ip=40.107.7.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 16:07:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, dgilbert@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 22:51, Eric Blake wrote:
> A quick run of './check -qcow2 -g migration' shows that test 169 is
> NOT quick, but meanwhile several other tests ARE quick.  Let's adjust
> the test designations accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Still, why do we need quick group? make check uses "auto" group..
Some tests are considered important enough to run even not being quick.
Probably, everyone who don't want to run all tests, should run "auto" group,
not "quick"?
I, when want to check my changes, run all tests or limit them with
help of grep. I mostly run tests on tmpfs, so they all are quick enough.
Saving several minutes of cpu work doesn't worth missing a bug..


-- 
Best regards,
Vladimir

