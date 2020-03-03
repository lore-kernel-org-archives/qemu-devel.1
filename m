Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7DC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7B420863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JboIVcJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7B420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99ir-0003n2-Hp
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j99iD-0003Ch-Fw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j99iC-00048t-IO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:44:01 -0500
Received: from mail-eopbgr30095.outbound.protection.outlook.com
 ([40.107.3.95]:11136 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j99i9-00045O-7X; Tue, 03 Mar 2020 10:43:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdo2alGoyujkd38AGYeGf2/ZhG7O5JCnRrvIhBBc7waUrEIT6HzMoKQrAsYxM2/s7gyIB747DSoCtZCRqiQUSya6Y79ISjXIjWGMDAMZF//tOFtFR/z4ePjDfIP1YOYM1BEC9ifu9W0VtIZsePRwWSYIy3FwTL2ABZsBOH5TAGJucaJnOCNkDjx7MyeqnnelIGRgmIUMC6tYeDK6NQXuzH97iVgVUTkOm2fOyZwl1CKnt12DFakMl81sOXN4FR+74GuYxQaPl/5Flvp1wnV18IPmOuUI808dwm2TEibjOHz32WYiL3LN8if+tYOBDZTqW9C965mcjqM8+AbNKlBCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI0/Qb+nuFHFwOti1JY1AJ6JIPkk3Xku7PLalA/rCLA=;
 b=kB99I6Cj7T0jfDFLGj752ligcb8uG2TRtC4cCdxCuD/3biPv3ySAbbHEpFHHft8ltAO0ToY93FEOjYjKJQqqsPzLCTHMSnQRnDfACZDa85H0pp4FXOGgUZJJDBQWE59F+x0NnlyuLcDY5CoviLnhjeYZ4cTHztV5JdoGLgYKI42r7aWiQc0Mx5ciqVTMn7Ws2VtZK+bXQEWysbzrDm+9V60NiY6rlJPw3TKlkIILV+pM8v8Q1ru3IWsmtHMRMqK/IlvcOoc2bn73YcLTQ5n8i0xfjVTfMUroMg7OjN/wD2ZYgzv5uIsO7i7yw+lp4iakZ4MsBnek6CNjFDtlBdUjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI0/Qb+nuFHFwOti1JY1AJ6JIPkk3Xku7PLalA/rCLA=;
 b=JboIVcJDh4B0esp8nuOSjBwmXdx6o2RqKZzINm7869Lx+kSc/vFEszOXXr7j8EnmusvKqhqHXY6FPBI2f72tWTtcr3kZ4uDYIfL4vYzktAF6Vm4V/M5SXlPQUCPHWWyz6rvpAhehW9C3vcAoxGplswocZ7kBJUMRWfgAzkhyHj4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3941.eurprd08.prod.outlook.com (20.179.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 3 Mar 2020 15:43:52 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 15:43:51 +0000
Subject: Re: [PATCH v4 3/5] qcow2: rework the cluster compression routine
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-4-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200303184349359
Message-ID: <03792a79-831b-990b-76ea-302f5276a5b2@virtuozzo.com>
Date: Tue, 3 Mar 2020 18:43:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200303133425.24471-4-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0310.eurprd05.prod.outlook.com
 (2603:10a6:7:93::41) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0310.eurprd05.prod.outlook.com (2603:10a6:7:93::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 15:43:51 +0000
X-Tagtoolbar-Keys: D20200303184349359
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7bb76c4-524e-454d-a1da-08d7bf89ac32
X-MS-TrafficTypeDiagnostic: AM6PR08MB3941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3941A2D7EC831A0742D8D435C1E40@AM6PR08MB3941.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39850400004)(366004)(376002)(396003)(189003)(199004)(8936002)(81166006)(81156014)(478600001)(2906002)(66946007)(66556008)(16576012)(31686004)(5660300002)(8676002)(66476007)(52116002)(4744005)(186003)(31696002)(16526019)(6486002)(956004)(26005)(316002)(4326008)(86362001)(2616005)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3941;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RaqxKpx2zcQS0QB0iMK4JjBGr3RtVKzg4awrHJjAppqR825n9gjtxkqov5O4QNddS9fyFNgfw8nxZLAqBhtSQ/odtAKVPeKiegzf/naFQKRy7XfAmmwBoXV7OlXSUlC0V4XB5E6paHYz4/tSAVVDiFJ30CCUK7/gtJeGDk25VfHP7pW9R8W8LcpCRDUWuX7m+6TjScbDCOUDvppVCy8TqtcDs7X/E/3+ytW5lGeyxjFOXZZnJsviIsWBn3f6WFseHu0UdQAzuN4wCxwo15cIgH8KnufCWkK6q+bbp9B+ts9SQgzA9nIL0du/5t0yae+1+dkNSjxVBYMVKZjTXl9shyETXf/7E0dJ6/HUDYUr1ga65GNJ6h+98h90Npvi5/wcIMSBkFGKzxKYpTXZpSJe1nTzXDY0qgT3dJlwwNNX3t4B28UwBS3d5gIER9LhN0a
X-MS-Exchange-AntiSpam-MessageData: alGaB/GR3xXqG8qBCJiRRqZ0VXR9D1gQB81aDlGQTAhZLdCTexAdSMVyJoL1Q3XT1guEQqJ3bj94eJ33Qhp4b4cDQLXoS9qrRZ1NVJZEkyTqiaIvr54mTqpEjGITMmQTc9EF4dLTdcHwMcbciy1yqQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bb76c4-524e-454d-a1da-08d7bf89ac32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 15:43:51.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fix71//HRYzSK3BZtqnoruYP/R8IFUX+p5W5aSo9sy41liRe5SV5f/bnXhtIxGeojgrjSPWYtt4amxQ1NUEqO80l7C1cdTAikBCEwSCfGAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3941
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.95
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.03.2020 16:34, Denis Plotnikov wrote:
> The patch enables processing the image compression type defined
> for the image and chooses an appropriate method for image clusters
> (de)compression.
> 
> Signed-off-by: Denis Plotnikov<dplotnikov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

