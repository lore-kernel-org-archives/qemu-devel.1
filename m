Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E634020679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G/COvjzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E634020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjjP-0002vd-92
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkjik-0002Iy-Pa; Mon, 15 Jun 2020 03:39:55 -0400
Received: from mail-db8eur05on2127.outbound.protection.outlook.com
 ([40.107.20.127]:8737 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkjig-0006tz-Up; Mon, 15 Jun 2020 03:39:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbubUafMqDx30NkCHQ5BHGVxwrtnWd1kDxtgSgHOrhxOEEFDDkWRU5hvJyI3khqv7a/RU+WZLLX/wWXCZUskm9jwIic7HTD5Mi6bnyDpEEX6YsAKMERjMQ4yfFMvnpjd4bXzXbufHzYlI7t1yNPwgYmI78NL/LfgThSfSysLDM6YnhjPXf6HTlcVC/oIw2v1rHYgIHg15SAdfp3p4GiCRf8WVzbY0eD1N3ksRJCFLQ/ngRKRcufk9L6Odn9ESgVfB5IMvrwdiTs3Ug1g/kPfLT1De8D/9ijxqvzy99oeqmzHpKgvQ+DKjjBENTPBHXha3AP+kLX+xQG6f7CvgbwERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKXTo5pqkF2fHafqWAmr91Qq7/5FBTXUJZF2B5+KeWI=;
 b=TNLMLroqkxfTmO15J83H3BgpIkNDKipdXjxmFr/iqmigkuVqE9inrES21JyO80MZwnQ6MlKPwMwO/zPKgOhxdFqaKzxHr3Sie3JdHhXfg3bYFP5WUTIXLJBeW0112SmOwMVrLO0v5gjvupIxE+5JHqQyeV2wM2kqPHTBeXKKJUs+uqEnm8jY/2XDlpc3duKF57EEil8WGRArJRHjq1wi5w6DvC8XNtQuWN9cRW9CAgDtKQT0a4FBUy7lKGPmzP7YfaB7GlfSck6wRjk5bzpKL3qY/YstMd4vkxn0P34W0P4ytQ237mZ7zqC6WbMAvxMQoc4SMJeT53OllF9QLmqp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKXTo5pqkF2fHafqWAmr91Qq7/5FBTXUJZF2B5+KeWI=;
 b=G/COvjzNil0fDeJGYtFlVjL+vzROMBy5gIi1/8uJ7LL3DsbRsSlJMUD7qOV72Q1M38Zxpv5ZGbZfejqFh52RadagGEONbgSUtmQvgZbWFeIwp4w2cuaQ5phaxStsaG7vFax2ln+M7+4VbM7pC5y/UN4Klso5MPbWdMvxF6uGzbo=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 07:39:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 07:39:46 +0000
Subject: Re: [PATCH 1/4] migration/savevm: respect qemu_fclose() error code in
 save_snapshot()
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611171143.21589-1-den@openvz.org>
 <20200611171143.21589-2-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b85767b0-4c7c-8cec-30c1-c93f6c9e3a74@virtuozzo.com>
Date: Mon, 15 Jun 2020 10:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200611171143.21589-2-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR01CA0166.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Mon, 15 Jun 2020 07:39:45 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0256e302-01a2-42f6-30bb-08d810ff46b8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536783E8F03F8D7B868AE54EC19C0@AM7PR08MB5367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsYmev7/RJVtgxI/ncNSHZetUT2to/M4f2DkVo+zkSYCFtfXGLL7F4Jqjlm1mx2/CmwrXgnetThAHQAsvPnIdgIjcUylOn3w6ZxoZ1QZfg4eMd2Y6PwLFe58sfC4EL7sa8Gs6OKjjUnYKsmqrIgQCWKzgANsXtWNI1QRd6D8vJDUHC6aAV15MvnO7cZM/rK5qaUgkzdkRxZgGBkgaJpLHAQCeOsUJYNKGUgTzg21kV7nTsWlV27kjR/KA4YRcfumTTLnenyzYTY1tO0tTTEeHbtXcp0p0WK5tPwoefxcvDZLcoGJn7VpQMzQHJFWoDpqFyaKjfDADquPDVgBce6PhZkuC07v8345neyLtohI+tV3KUSefrVoNPlXUpgRmo0R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39830400003)(346002)(2906002)(107886003)(4744005)(54906003)(478600001)(316002)(6486002)(83380400001)(31686004)(16576012)(16526019)(8676002)(31696002)(26005)(8936002)(86362001)(66946007)(4326008)(66476007)(66556008)(956004)(36756003)(2616005)(52116002)(5660300002)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mzz4wtm6zZhXOSwEBIoZZ8DZeZPXT0hwJt4o+kELuAR92LwymtTGBimfWtcyf8wRcrPMm5CPRtBlUTwTJmvoQvPXxnfCBzMRHDcMhSG/W27hpa2HpLtE6Z7SBcMTHUEaCimOvnH7YLGFkFu1w+7UIdWFMWsCod+WyOZAD7paIdK8+fq7u1xeyLSd2d+m31xQxpaQv357EWDdaQHOHBY/AoGI70OE97VrVuuNjxIMk0d8W36GCTr3zaLEQCzXfuBHrfrU9Mp+rAGargo9e59M5A23mM9AaPRm+5BjVC+JDV5OLXQygoEr14k5ABHf14PR7ZVkqzOmbtRR+6x/LmZMN3hrCeYr+vRDlPxK7zXQnxEEeeSITPa87STadXY7Py8F2qDFcz0jfdxSUwCEwVPEWjnucISclZ6rOE97HVIgd6apSdySpa6gM+PZ5PlcdgvEdNU5R8mWC2Y4/xPWam4lwzfxgiHHq5V59/FBxiLa6yc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0256e302-01a2-42f6-30bb-08d810ff46b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 07:39:46.4097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVFOVxRiaDLDboBFOqEcy3/qOuSe/yxUhnnh36GxBGQvFsAbjWAQ+zeSPCoeW7Vy6nMRfgDd3Cy0YLaN3xcStYYSjSXU/kuX22qsffXPylk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
Received-SPF: pass client-ip=40.107.20.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 03:39:47
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 20:11, Denis V. Lunev wrote:
> qemu_fclose() could return error, f.e. if bdrv_co_flush() will return
> the error.
> 
> This validation will become more important once we will start waiting of
> asynchronous IO operations, started from bdrv_write_vmstate(), which are
> coming soon.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Kevin Wolf<kwolf@redhat.com>
> CC: Max Reitz<mreitz@redhat.com>
> CC: Stefan Hajnoczi<stefanha@redhat.com>
> CC: Fam Zheng<fam@euphon.net>
> CC: Juan Quintela<quintela@redhat.com>
> CC: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> CC: Denis Plotnikov<dplotnikov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

