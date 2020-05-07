Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C24C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DCF215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AIAKy2AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DCF215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlAb-000864-3F
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWl9s-0007bY-0s; Thu, 07 May 2020 14:22:08 -0400
Received: from mail-vi1eur05on2133.outbound.protection.outlook.com
 ([40.107.21.133]:42432 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWl9p-00087l-Pw; Thu, 07 May 2020 14:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyNlmG8lJGnVq6wTp1mxGnXxGeoQfDEeBflj5fjJvUxbEGtWI/5dixtihgvbpApDcPp0tz4gGSHs9YpnJCvxPsHmiX6yUebEpnQXoiIzu0NqrRsi/cNCOe24kxiQPFi6fk00x5UhHNbFuvOVzEHyvdZj0ARYLgizNlwddzrFXZgZEf4uFjVC2b353zSkXXOpjo3xV3cFQuP4EehP0L99ZPDgUHBFToQaE6ySxyOIi+qbNDzoaGGetVdaxWC0DQQ64Ke9BButlN10jNlH0WdYGgJ2YXhsGABz8bVWlArmMrG2uysFoFFWqA6xcDWqRPe5U/XG2rzqBSjxY3Jgr68PoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMbh1X5DfgOcGYqcQDxYaSzsKN70ZfhNWe6inROa/ps=;
 b=OIFrxAWc7BKSNQNwRMuZqyxUI7xpoxFO8Rh7hITR2dDZUzHqQidmI75BfqTN3GUn0p5Mlmabljenrai/RZiYcmQzEIhHrcxlPD+scsZt6QZr4s9tVJhfiF8h2rpSvokBeBNdQtkWj0xpsz/jwHg7ijF292ERQJGr9SOyM6DOD/6fUWQYodcwzB3NunW/icdLtpwOvqq4yoZ5BYR8z2Oq0h0F2/Hhb8oDRu7ogzDAGjAoj87qJgOEdcRGHhumb8uKx5g0OzulZO5e8T/PVpqAQ+aib6gM8IzQPpau1dWJvak2+D0QvTVsyFA1rHCvD6o24aJ3d5DPIRc4k1YsLRw5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMbh1X5DfgOcGYqcQDxYaSzsKN70ZfhNWe6inROa/ps=;
 b=AIAKy2AUCaD+NjGx65eeESIHqMJ+UOtO5ji61nNYEJKcyPEhVw/Uo1f703m3n2vQLxy/1iE/x0isnvNEkMXN7RnNtSXbJleCgddoKt8R8x4g9YOBS4pF/toL6WlrZGUUnNqaijH8c24n8Bnjg4DHr2PBq2to1X9JFj1MNSKCP/s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 18:22:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 18:22:02 +0000
Subject: Re: [PATCH v2 10/9] qed: Simplify backing reads
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
 <20200507144513.348470-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507212200850
Message-ID: <a38cc167-2d60-9841-6dc2-79966d8b4812@virtuozzo.com>
Date: Thu, 7 May 2020 21:22:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200507144513.348470-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29 via Frontend Transport; Thu, 7 May 2020 18:22:01 +0000
X-Tagtoolbar-Keys: D20200507212200850
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b703abbd-61e2-4d19-f732-08d7f2b389f4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-Microsoft-Antispam-PRVS: <AM7PR08MB536606F49363A6F7E1F573ADC1A50@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zy9CqjXt6YIgJnB6IwZx2y9ad3+fTeIwyGvo3NWwmv+/aE1Ij2MXGyoXa95X6UKhTVyKwHtDtPvmfan7K1tielfuaJZNyyk4/MCbBLUJt7wcfFnXGxu9+dfH5zPGzm4+Tj73FytD7rqrgtsXLO9F73YixzHPIz6oyl3Jue4fvHL1KHSW1rX/C3T57K6ntnQPkwJzzc/9aYm9oDVCpjyJhV/XnFlIYQn8OwbqGs572tYAEAC02+lYBFQ60Cg27vvao+EdfxL56pG8T1oRCKqmxhl0Phvto/OyZ1fLZFViXDWBIjuDiUn9lns6m5mQdrsiY47AFdohxlci8/K3Sp53UIpgvN6dKtNR4O86cEC7SWOYqu5RRQw3kF2Mh7OcwTEUa2zA6LvOsv895asxtynj6woXK2suvccF77kAprN0tvopTFXJPWb8gV9dkvY3tKcEZERowPaztAH6BJZJpwP1Mu1q1GQNqF6iwQoDDrSIypGmnnmOUi////lmnyXaTFnyJtp0y/B/5x4CW8wcEnubLRd6hCLW/Sj7OMIm9kRHVaMEvsuTyP52ULeZRnbpQJsZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39850400004)(346002)(376002)(366004)(33430700001)(2906002)(16576012)(8676002)(316002)(66946007)(52116002)(4326008)(31686004)(66556008)(86362001)(2616005)(4744005)(186003)(956004)(26005)(66476007)(31696002)(478600001)(16526019)(8936002)(5660300002)(83310400001)(6486002)(36756003)(83280400001)(83320400001)(83290400001)(33440700001)(83300400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MSajB5rOJZI8YlGenutA5xL1astXxyLv+hgf3kPH0GHs6E/swsd+LxQ/EiIXsTeYp7uTC8bJPDTW/AhGnY5QhQAT0yoJuOX5QDkryscFBA5tRXaLq4unptVnRvmMCNITZyKis7l1cXayoySmEWarICqb5i69Wn337zm1NfkdvR+NTww5ztjIdj4o1vgT6jV9TFfo/3VSWXP/C7EeUf/Vn0khRMhjZvKX1DTzLRhSllw/mcScqBTkW92Iws/EV/MyvT/PonL1s4rQRsO40foVZreJ2SEJZr873kridXJmWfa2XVGd+/+nGF/cFvp2g+r1d3PWOzVeegbBJ/zbTNweGTmDk63MqCX2go378SxbcPZ+5YgcWzE4b1jFULqfQvKkiduBCxsimlYyT8fulYowT1uUt2JCib0A7aaR3+4XWraHAtYyrwdltwSxBuL6NRm/79oDFL8UCTlyNNPUDQfrS+bufNZzaV6Ka83waIZve7OQmIULRgr8bEnGKzCAOdrzOni+8yNHprHaO0/QkxIAzCVw1QiFjJ0haBoaK3KdIVDfWTBffwRdA432QV4skmZo9dVFHhIyM4VsXUgcXqGDe1Q+mHxxOrPRq1CG3tGeihWf+s6G7gUA9Cl+Ev6zXfMQypDFyIO0/r0WhmqoQ/UmFfzXJ7e+Zq8fjaggC+RBX8JuyApRyLKUM++3Ntctj1trzgspUSjYJLLxGioonydTQkDjQm/o32lAmJnmqhHfvmtAogtj8kINn0tKIp8GE+rOgrIUjHEDQhM9kQut2neh7LriJXcjGaV92QawfU7tF2U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b703abbd-61e2-4d19-f732-08d7f2b389f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 18:22:02.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1RxwejI/ZwNZ13miL6gJNfUtayE87rbj7cj7GPkOKu8CLp0bxnjO1DMMQp8M08VXAYOwMMxbBjXaS51d3k/eMYZrLkJECFKTUaJnMncXFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.21.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 14:22:03
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
Cc: kwolf@redhat.com, "open list:qed" <qemu-block@nongnu.org>,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.05.2020 17:45, Eric Blake wrote:
> The other four drivers that support backing files (qcow, qcow2,
> parallels, vmdk) all rely on the block layer to populate zeroes when
> reading beyond EOF of a short backing file.  We can simplify the qed
> code by doing likewise.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

