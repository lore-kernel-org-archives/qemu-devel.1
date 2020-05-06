Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD83C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 05:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F195D206F9
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 05:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g50F1+rH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F195D206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWD3D-0005Ya-2n
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 01:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWD2Z-00058V-L7; Wed, 06 May 2020 01:56:19 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com
 ([40.107.22.111]:17697 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWD2X-0002vZ-DF; Wed, 06 May 2020 01:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap/7xHIr3hbxhQxiEIUa60nCoSryeHsrcX06bKfvegFn+pvruDAwI+JPZTuWTR9mXlftJE4amn1qmvMTJoEqHqFsvnZEwJ25LEPHxEMFvfBsXEKHnRyZk2lkJYrZQzevrFCgM80MKkyILZwiWQnXvE6Trn3UDRXowQbABZjBqGx0T5KWNcXlAfHI6dxbqF2BL5o7tvoD1QehquLiHP4d/KBTYDN/OhfrMjZQTNWyA4q42cASQahoj+7kkZwi4fXLek1CWcSeC35f0EUo5a/OuiCh6m0eP13esG/sDeHQhWFjwg6TOAWVTCrU/qNhXDFIWDQIWCphrjANe3tZGpskNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWpWdv7KtTWMlq6WfOU5FIAp4u9lyMlzchuBtVU5VJY=;
 b=Zs2cnTsR27Qc1TyfnoCOt2sWiTQjSn9edS5W3I8yMAj5v6p+noDXrJdf+RZctH8XIOUqkxOvaXBLbtLJpAzFZOusCyi/eXHc8LBLWk7NXEbW2/vjAtS0Elx3HgHedGghoGQqEGisHPG/0B8TsEmUGS9D0fiZKT622jOPhFiIeLVNdVUBIqCorIGL8IHmp+4xSBFI7+HLJI1yPU2u96svHV9VS2PQ/b6XKHa8M3rdR5h31sT5Is4tmMxu4yHG+Pe9ZsSZP+kgSmW9HKQA7xs/fdopKEgVdIXX4/pgxjfjZWGvlAJo2F8SHoghUThulvHdu3dTQeJcvnx/4OIAZfdebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWpWdv7KtTWMlq6WfOU5FIAp4u9lyMlzchuBtVU5VJY=;
 b=g50F1+rHgsmoBLz7MUsJCgXPfEhEEMTH1CTnxK5uO5quqvp8XLBDZqox4gQTgv8eEcX3qODVje8VfplbFsKmxTuLKJ5T4AG14VasrTV2QoZV5/voUr1CmP00vmdEM8/akO+WPlLokFCJRTz5XEoW/RZ5kzJw35lffi9P0hnwnbA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 05:56:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 05:56:12 +0000
Subject: Re: backing chain & block status & filters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>
 <f1220430-1d37-3cc4-0484-3e26fb7e4b84@virtuozzo.com>
 <VI1PR0802MB22061BC34FBEC5953ADBD50DF4AB0@VI1PR0802MB2206.eurprd08.prod.outlook.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506085611001
Message-ID: <f5988e20-4d7d-092e-fc88-59cad65bddc4@virtuozzo.com>
Date: Wed, 6 May 2020 08:56:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <VI1PR0802MB22061BC34FBEC5953ADBD50DF4AB0@VI1PR0802MB2206.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 05:56:12 +0000
X-Tagtoolbar-Keys: D20200506085611001
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b9d9e4-1b5b-42d4-561b-08d7f1822e79
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544832E3569BCAC52F8860CCC1A40@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Np9bJOA0J0YToMwidNpD+cASg72LSonYJlHhu5cLNrpZ0SZ0e6+zhatMUyQfPt1Jop2m83ta6LNJT2GcfQ67vyPzeLr0F5MdG4StXLHohwn0k4zwLD9ofppHoMmQL1QGfVrlF4x/U9AJyk9nqMGokEjUzXGXZra5BSducV1Q6N+8JAR+QveA8CPtDextR/nynk2iIaa+mQ3JbRVxWHCbfYq5WeaBr40CSNhyWgkZnqHwBw1hXs4DTnPCCOTu0hNFouoBlPVOgJFFxsH+iCwu/47biJZ1Ka49hkl7Gl553UhiA90k3Xre5cK5ZwoV6bZsJXtoAxFZM/2JySb5h6uBuyfVY9x6gper9URQ2eZTUuC1BvuQfHQNgiRdOLIET1a584bSNq1ilcZ2LF7z+2mV05aR1CYuMR/EhcfZtHTLJdMvT+mMvThaJM61SLSorPzjdBPa3GEWVH9mhNH7swOZzvvowovu7RNAdWjQcklZ3uGRUufZzZPs5K2ZjjAZJQoWhI95Dpt7DO/Zt+FKQ4EpLsn+xpuVn2Uha90pPJhEUQKeebXeyVWIrIOnSiwKLt/I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39840400004)(396003)(33430700001)(33440700001)(66556008)(66476007)(36756003)(66946007)(8676002)(2906002)(86362001)(4744005)(110136005)(5660300002)(31696002)(8936002)(54906003)(316002)(16576012)(4326008)(52116002)(31686004)(478600001)(186003)(6486002)(16526019)(956004)(26005)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LqCfGeIDg6nbciLGfd+f2TKCi1sY/fMZjmQJKMbEKjaL+8rOuqNLDdVl9nok7gtlAgDb89DkGgXaQ5ih0OSBVpeeRIsKQTWB4XDApbCreuhy9hKA2aaYbaBBnz2qV3r5jUo4/pQJLmXExknpuz/ceKV6/4tiJylZ8Swk9RC29G3LoTCSGTFJWLGfDdstW1VeGs7FbiiELtAeYlmpYYsPaiVewvlZSzDZqGSuNoykYFSh2EwK/XdHltPExFOF9kP1LJTO7YfikLCSFQjeLJVyTRHcW8FCNNSZIR2hwyHa2d29Kc9qeh15yLa4y+wdPJxsa9JvdxDrISxbetLwwKPdBdTTJiBTCu22v5kk3YkNi3HZuKikpNr8rY0tN3vfn3h12pKmex9gFUzfl+oxr6rtQyJkGKcbV/ga+1iM4yEZUbzdc47dCBfKR+kdlA+P1ertxM0Vq+bxL/QmTbPuvFO2PD1V1a2U1upyem5fWFrLKj5j+1uP+UbuRJkEiO7gSN9qEVJXdSy210WJjbbv4vgQ1Me0A9C6R/v8F58q+QFkICRBeNnCn28FbZZME5+8sMHsUMXiFXl2jUVysvsPYhIPDE9cx8PhbsSxU1SL7MmPTrnSsNukrfAacPeyhBOM8fOYiZ9gF7ra/iLID4BSEJGG+cd0OTqKnGTVIsoli6nMHADQ9hJPgnQGH/BMyfHcd8xW+x4YxssyK2MWmxRbQi/Chj4TxTXtjEkPWKkxzP17rSxFbwng3Wf4ZjFMJtlTEH1J46oPwbL5B9us/u5jcqPZr4C0NKj1J3Mp6kpVQ3w9vdY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b9d9e4-1b5b-42d4-561b-08d7f1822e79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 05:56:12.5374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP5Aa5QGiiNrMffsz1Nv8BQRQetAYdQDKmrgu9mC/1+0Lh5qoSbD4e9J1BfSsw81Tqoju90iXRb371XBT9PkKPFMrHNYFXPwIYEbLTlS1Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.22.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 01:56:13
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.05.2020 6:04, Andrey Shinkevich wrote:
> Sounds good to me generally.
> Also, we need to identify the filter by its node name when the file names of a node and of the filter above it are the same. And what about automatically generated node name for the filter? We will want to pass it to the stream routine.
> 

As I understand, there should not be auto-generated node-names in blockdev era. All nodes are named by libvirt with full-control on them.

-- 
Best regards,
Vladimir

