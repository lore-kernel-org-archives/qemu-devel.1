Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E9C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7005F20732
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pwcl9F6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7005F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9Y8-0002AB-6Y
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI9XA-0001Y1-9J; Tue, 15 Sep 2020 07:54:04 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:7059 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI9X6-00057E-60; Tue, 15 Sep 2020 07:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK+xbbg3GaorUC2bmBCPXpEwhaf0iddu/7cewK77WyiIc+57OVp8BrPjVF2Wp2J5koNOb0eHWsNd1g6ZQC+Z9TGxI/Xpj9TozHxpdFXwGRt0uO22qem2BesfPHwE09vtqIcrvh3QRiFHQLjA1if4+GIPOuZZ/J6xmNBjeDTsynnv90g62DJceYegTEXqZ2vpnJgBXF0qxPR2kaYkCM+qu/dlD8d92SNBfzrXSJndiPhdkXBEtBObhvCYhAy4A4RDBS5lu1pgUzB+Pwr1TNO4h3U/7Ze4x4GXxNr/Xnl3vCwew3kxqCTsOKqovDwPdAe0EyPtUiBKp5SJ8fS+4sNE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES5LEVyE7FMJa3uMLs6tjNhPt6daxOv3qTZ7/d/5YpU=;
 b=FnJ6vGMpPOFe9o/mjukC9eJyuynWwJRQ3pjCGLbLUZeWbXg1tkMxlL9cIpFE7Qi3LtMd6dmGI8Eib6/bismIrdV9G/WCTtQntN45YjjB32LVemXH+aikVa69Pkp1JslT6y3fsNX3I3Jos4vcKVPJueC9Hclz2XyReQRuDEz6iimaGtspfL+an31m3kzsfbYZYL2cUe4EJpNyjn5DT9RMRdjhCbn6zXx4JL4qMI1L0c9GOnYDWVMdau7RnZZ9cnOzCrbU9CJPoMxnFp40DlE5vTcYuep6LzVSYoor9zvrkfCi3WDbyAT3rqSQKe24mZOiAN/KXsVqE5LyrGzjFjxaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES5LEVyE7FMJa3uMLs6tjNhPt6daxOv3qTZ7/d/5YpU=;
 b=pwcl9F6yEC6auAHw5+Y/AVCSPnJIMvRSVQCOWn5AvpkYCZqlRoRduS/1TYX2yBJl8OxGFjQbb6gFzxVAOtB8QmoMjjRn8cqT9G9xbHrOCOwCH0WzfNno2RknFbPSzAGDYhqb1DW8QdwqH6b+0YmlBBPrfE78epFyoVJpqA2SqRo=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4600.eurprd08.prod.outlook.com (2603:10a6:20b:84::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 11:53:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 11:53:55 +0000
Subject: Re: [SPAM] Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <91774a03-3c70-4eab-8e02-137c6c151cb5@virtuozzo.com>
Date: Tue, 15 Sep 2020 14:53:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200915134340.0cc3f9eb@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0130.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR10CA0130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 11:53:55 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda9a7f8-b640-4c29-99b4-08d8596e05ed
X-MS-TrafficTypeDiagnostic: AM6PR08MB4600:
X-Microsoft-Antispam-PRVS: <AM6PR08MB46007D1D5231D6AADD9EC7BBC1200@AM6PR08MB4600.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YI3Beixj5NR19LAFCa3HX2k08L1MLyseLWzeIIAcKqGnak1oXQfQL7JI8NEWXHE+TT7xn1e7hgZuC1SMdS2PTTPEj/FRMSgH4XrjBIjOjhChrUjhcQn2iiEBledbwfJUlbu9tFjNwbrdMrA6WC9EwWHjfF1naSeAvTF9M+pPodwHP5V+Wl5k+TnMvRzKZZth2PNfa7jMcUbYTKtR7O9jdimKi9X8AAAH/Npz/3UR8egMLA8cfM9oqMipa8DffcwsLPbVBeTLq3XRI/CoPbxf9MLtxfgIUCbQAuHRfIUpRawkYqDIxb4dCxLbndaA5nscgz/x13V2Tj/688GL/G7vPvSD7CQBjVKH1YbgjHtoNAiedwDg633uVKjIzwD1YUzILlUedpBhXDPmT3N250IQAInIWCJL7VykbQT16EPdVL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39840400004)(66476007)(86362001)(36756003)(8936002)(54906003)(5660300002)(83380400001)(31696002)(6486002)(2616005)(478600001)(26005)(52116002)(16526019)(66556008)(66946007)(31686004)(186003)(956004)(8676002)(16576012)(316002)(4326008)(6916009)(2906002)(43740500002)(217643003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HcyOSvwAoIOp5xsNWNmM2+gWonAobTCuWGxP/o9LDcXKHJ5oYphOj8+jz6Ky3hed3myOIzZy8f055LuSAC0MeS27co4hYB6hzdfVnAZ7nrhYdXj6eOQr0xGm7qkXt5cEaLbDjAUFLzrQfdGvKDK/EOKBckOkVqNwt+Fyda92OIPbqlwwL294EPBbQBBdL8HWyFdml/1im0IWddE8Jd87oh9qPbvvVQqvVURdc+XuTJ414cPrlAc3I/FlUiKXCmeG7bneZ2payUi02ZPv2XLfl2PidiSkC01FL0mKg9qZlcrR3Y1HK0Mc60ZYDCruSvGYIPld0GWhX6RLVtD8UrEB29ELf+xmWNITglWNOvshRmrcDBOYNLuWeaf3U5FUmvUC0QAhgQyVDU01Z1JZSH/nv2olZ4GAPAsQ7V307MAY0DVD+i21goJqXPrTP6jND43B6qPq+lryKrBFEOByTQIqpc/i2UBPrDcfPNFiZHepEKZeU+F/MDsj4lhT4q+JaKPJrbcEfxOV5nXsF8maGTiaDp7t3dv7rO+96eIL4Bnp+3p5/dtvIGnvRIs1piXI16rm62K6UZMfOFVQdQHdMEOqk/ivxQj7sQbIJIB1G0S4lCDe6FREolH8KS8kf4z89rTL5ewIGk5MeoGX/gQ1fJGEgA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda9a7f8-b640-4c29-99b4-08d8596e05ed
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 11:53:55.5210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bekg0fs5307RvFlD1acZ9VTqFPdDrNRFzFeGE+CzNSn/s3NzkR+LeoVd9KMeyuhqnKDctDwlAk5jhH512diAnC0zyHoMzSypRsUcTRtHB1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4600
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 07:53:56
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

15.09.2020 14:43, Greg Kurz wrote:
> On Tue, 15 Sep 2020 13:58:53 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
>> 14.09.2020 15:35, Greg Kurz wrote:
>>> As recommended in "qapi/error.h", add a bool return value to
>>> spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
>>> of local_err in spapr_memory_plug().
>>>
>>> Since object_property_get_uint() only returns 0 on failure, use
>>> that as well.
>>
>> Why are you sure? Can't the property be 0 itself?
>>
> 
> Hmmm... I've based this assumption on the header:
> 
>   * Returns: the value of the property, converted to an unsigned integer, or 0
>   * an error occurs (including when the property value is not an integer).
> 
> but looking at the implementation, I don't see any check that
> a property cannot be 0 indeed...
> 
> It's a bit misleading to mention this in the header though. I
> understand that the function should return something, which
> should have a some explicitly assigned value to avoid compilers
> or static analyzers to yell, but the written contract should be
> that the value is _undefined_ IMHO.
> 
> In its present form, the only way to know if the property is
> valid is to pass a non-NULL errp actually. I'd rather even see
> that in the contract, and an assert() in the code.
> 
> An alternative would be to convert it to have a bool return
> value and get the actual uint result with a pointer argument.
> 
>>>
>>> Also call ERRP_GUARD() to be able to check the status of void
>>> function pc_dimm_plug() with *errp.
>>>
>>
>>
> 
> I'm now hesitating to either check *errp for object_property_get_uint()
> too or simply drop this patch...
> 

.. and the following. If no more reviewers come to look at it, you can just merge first 13 patches, not resending the whole series for last two patches, which may be moved to round 3.

-- 
Best regards,
Vladimir

