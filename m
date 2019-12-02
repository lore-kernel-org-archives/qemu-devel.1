Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA1C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B527217D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="isW9/rx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B527217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsIs-0007dZ-7B
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsGg-0006VS-6G
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsGf-0001sY-6Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:26:02 -0500
Received: from mail-eopbgr740078.outbound.protection.outlook.com
 ([40.107.74.78]:31392 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ibsGf-0001s8-1v
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:26:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFskjzRjTtos42vmWz15ZLgDN6JPQUbZnJHw7F5DH0AxB6w5v2+Z5b57y96TNY7Qoxcin3cCxGO5KfXb1IJE+K4/o/xxp0VD5NiSZiUVQlj+mHjdFGBtg4LcazHkUvLjwqa9KMI7qcquM43kCGbyLQGwEx/E8tmWkO7blYiQikAVdSQCvk1pZLrR4luMh7pRw3Sd/9jzUZUctCAvdgkWup77JK3unYehJLOL3lBvowr9tqfaE3T8bHtiAEfEnp0CJJXN4GmEoloaX1kRqnK8PRK0fXl2Reb3olrOtJYMT6oZVdbSV9+gjeU+FEM+Kh/uLAe8JWJZhZswvBWcVglsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ekwpb1AZLkOM7dfnyw6jkml5/6NUqQzTmPr0HZhFbg4=;
 b=bjQJ1Jj9vQRnBzecdChYS2xjxeRrsGpEceLKnS8FDNz4I02EUilCkGBqpqDI+iPKcffXnr6ENRnuDHFLhXmp4Vy8L0QdWJgBrUkNRGDiFs1P9/KjQXkBUdY7hbDtJ0bod7PycIxWg4CZtvKs6YMHDJpTFK23B7+Gfqnw2yncyLKJXFZpyZHpnAqL+0WdYg28PkrT4Ly0WwlECO3rXF4Vj/jh0FYQHdlb4HqxpZ20/D9hGJW83GKInr+/+Zk013pDglchScu10cx29AWxnjq+CwKSyq+KLuS4TUs2ta1IT9W8Pp3sQpld2eTqAkhmTVdjTHWFMYnl8uYZZFiaLjaPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ekwpb1AZLkOM7dfnyw6jkml5/6NUqQzTmPr0HZhFbg4=;
 b=isW9/rx9LvLWVIgDDjOSJEVgj+t8vWJsHLyLepShsmt/Eqcok5duwxeduCWVFhSk2qV6S+4MXyq3U48vpA02fZRY6xuGZrQWrqyXnSKh5mK9+BjwMc+kI89RVH2k5qV405Ws2Io1xfrZ4wmgZIzqN3IhrcXJXuJfvs4+WvJssWk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1401.namprd12.prod.outlook.com (10.168.235.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 20:25:58 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 20:25:58 +0000
Subject: Re: [Qemu-devel] [RFC 2 PATCH 03/16] hw/i386: Introduce
 X86CPUTopoInfo to contain topology info
To: Eduardo Habkost <ehabkost@redhat.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779711572.21957.10722611828264773686.stgit@localhost.localdomain>
 <20191011035406.GF29387@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <57684c75-0760-9ca8-47f3-ff8f00903668@amd.com>
Date: Mon, 2 Dec 2019 14:25:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191011035406.GF29387@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:5:bc::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb6eca74-0180-4705-f591-08d77765d6f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1401:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1401BC2C9BCD790F1B78846995430@DM5PR12MB1401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(66066001)(6436002)(65956001)(2486003)(65806001)(4326008)(47776003)(7736002)(229853002)(66556008)(66946007)(23676004)(52116002)(5660300002)(2906002)(8676002)(186003)(58126008)(54906003)(6512007)(2616005)(53546011)(66476007)(36756003)(386003)(31696002)(86362001)(6506007)(44832011)(26005)(76176011)(446003)(11346002)(6486002)(305945005)(81166006)(81156014)(230700001)(14454004)(8936002)(99286004)(6246003)(6116002)(3846002)(316002)(50466002)(478600001)(25786009)(31686004)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1401;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0B95jZ419WEaqmPXBkqD4dqwD1KfAjAn9VAVaZlHy0H2izcRNWp1n6x8AN+SAFXbDvzWTJ/2UuxgfKXBIb1/XJ+E8P3UyU6huUCG1GkUkDYeIpPU8b4Pv6/uiTbgfbfhPZxU6xeN3TJSRzkEaSW4HU8w0bYU6tt/KzGTDZBCnallq6FT8VnyG/lzuLsinkl5Jc+EHG7HlmDpGI9Piv6yKxEvIw8TvV03I/adQfzhNR0rQFH8lvWJxZWM0I2kwzTP+V8SAvDhivEYPtuEbUOUmQ0z5x5jwFLlYjuu+V+26IZDrNFhWIWBDy4VuVwd9awy/J+6H68ysix7uohCLvZl9sH0Kam1rIkgVMIcJI+QBQ+/ggJxDK+k6c40hb/hbNyQcAjcmH7QniyBGceoybbfNwUsYnvnVkehVbrJQ4DfpgRLtYSC8v6NaQojn3+LQ8Yr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6eca74-0180-4705-f591-08d77765d6f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 20:25:58.0890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u61pej4Ahnd7jvz4PmQucGQddskWHMi9wdYZVkrpA8lEcxdpJK5MsuTPFiqoToPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1401
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.78
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/10/19 10:54 PM, Eduardo Habkost wrote:
> On Fri, Sep 06, 2019 at 07:11:57PM +0000, Moger, Babu wrote:
>> This is an effort to re-arrange few data structure for better
>> readability. Add X86CPUTopoInfo which will have all the topology
>> informations required to build the cpu topology. There is no
>> functional changes.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> [...]
>> +typedef struct X86CPUTopoInfo {
>> +    unsigned numa_nodes;
>> +    unsigned nr_sockets;
>> +    unsigned nr_dies;
>> +    unsigned nr_cores;
>> +    unsigned nr_threads;
>> +} X86CPUTopoInfo;
> 
> With more complex topologies, the meaning of each of those fields
> may be ambiguous.  e.g.: is nr_cores cores per die, cores per
> ccx, or cores per socket?  Maybe we should use this opportunity
> to use more explicit names like threads_per_core, cores_per_die,
> dies_per_socket.

Yes. Changed it to

typedef struct X86CPUTopoInfo {
    unsigned nodes_per_pkg;
    unsigned dies_per_pkg;
    unsigned cores_per_die;
    unsigned threads_per_core;
} X86CPUTopoInfo;

