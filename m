Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B35DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A6320848
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eTQFfvyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A6320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsM5-0002O1-QA
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsK5-0000zp-Js
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1ibsK3-0003NG-82
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:29:33 -0500
Received: from mail-eopbgr820040.outbound.protection.outlook.com
 ([40.107.82.40]:9856 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ibsK3-0003Ms-1p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:29:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhsn82ozylENoxMJ/BRTCHbgzA0DlI9PIoqIxsUW5zlFo8O4kfikWb/Lz+ciVrpdysi0ymfL+KMlV63+ZpOG9FV6YcjZtZsMrT14SffEwVZ0OdWia+2weGwizBWawKlVGoXLABqcPp+Q7TWMnTdulnEguQdWPZO+DFnPR5n0B2J3GtKADbVw/qoZwlm3qGXodW+mQ4s6YlGdP/fEfYZqoD5eCJF3Yv2XjKe2LvKXHX4KdwVYTMmepcELO/lEtjt2gUPAdnmUVtPC5u1YkEzoz8Ed84u8CEudm+BSCjTufglZMibmOsH+wI52rCrjCL36DeFDPbDIcUvZt+cd7tCaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUggp1TLu+LjLqraI5ANW6214BPhPu5clQEHrPJWMI0=;
 b=oCj0W99ZoUzYxEivdMEVhgVMEK2ivTJsLD4PTBzx0osiZnHkOdpGW6OgLUClOCqlLqVpU3fgoEgoz9DSi5wz0Jgtc59qhmZXijykIyo3BPIpKacVHZ9xL6SFrXkIHy/UJczKF1tMqieVNHYxolzT4Dus3Tw27NTxBWcS0LKxBo0J4wBm1w1pG+mQFRSqV8icTTeDw5dtlHUTHTl5haESZtvrZGN1cDLzd3qmDlEz8g+WrCes+xMVOv41530W+svXBWq9Aiv8tuI5akA8bAPnjlgSA9V15LRVj0+wg7DL0rk3uSyf0F40yO2TgAySlIgFnx0HgKO/7XdJfellx8nFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUggp1TLu+LjLqraI5ANW6214BPhPu5clQEHrPJWMI0=;
 b=eTQFfvyhVLb1y5Z3hVSvjMgOVp0b6HxQSasAB46J8GnoPkZW8qwULCPlsazykmsFJEZPoEO7eVbKb5RlZZXlqi1CWtozTx7HTuRNtngUfGADtfD08dcVwG1usesxzkPW9LS1GFkU67APez+tSpKtUq7Y8aHwyKQY39gVYQ9Pl4k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1514.namprd12.prod.outlook.com (10.172.39.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 20:29:28 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 20:29:28 +0000
Subject: Re: [Qemu-devel] [RFC 2 PATCH 05/16] hw/i386: Simplify topology
 Offset/width Calculation
To: Eduardo Habkost <ehabkost@redhat.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779713027.21957.5884599223662351252.stgit@localhost.localdomain>
 <20191011023225.GC29387@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <bc285849-588b-3592-f52b-57ef129bc157@amd.com>
Date: Mon, 2 Dec 2019 14:29:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191011023225.GC29387@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0067.namprd02.prod.outlook.com
 (2603:10b6:803:20::29) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 246a7b48-6c55-4caa-69b4-08d777665438
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-Microsoft-Antispam-PRVS: <DM5PR12MB151458555194CADF5C881B3495430@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(5660300002)(7736002)(50466002)(6486002)(81156014)(47776003)(8936002)(6436002)(2906002)(478600001)(230700001)(58126008)(54906003)(36756003)(25786009)(66476007)(66556008)(14454004)(66946007)(316002)(3846002)(6116002)(6916009)(99286004)(229853002)(305945005)(186003)(6246003)(81166006)(26005)(31686004)(6512007)(11346002)(44832011)(8676002)(446003)(31696002)(2616005)(53546011)(4326008)(2486003)(52116002)(23676004)(76176011)(66066001)(65956001)(65806001)(386003)(6506007)(4744005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1514;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EFYOC2m9XRqXQqo00EIrL+dRXm5o/HCPee7XZ3u/PvaTx9tmgT5faX4o2cfzoSDx5qwQNlU/Vpr0CGLsuU68mv33fSPzT3JMbOffSQHUJ/Fke1rZRZgRz4xwiu8qL3BnfTxBEDw462KW2Cg6JXSulFeOwoPG+hzmndU5VTqyYheJMRbRYn1Hhq/sUEakE8msxUYt5o+iAJ0EPlO1VggOPV7CsjzwXxRcsu9bG8ho4qbinVYnG2ByeKeZ19RunJipMJwpsnW3Df40W+U3+n2h+sMLIhur7K693pQRfF24O2R7C0VCAvxG8p9W4TJSw0AaXTxq8PvAwceDsjsw/S1+15xGwNYsMXaNqJLKhjYNkWMQWsMNkBybJKunmxzbmVTgxjsisXdNmFE+OCA9jzzHdrbssa9meP4Z6Gf2+tC0xwqI0IPrzhiONWlx7KXwTGL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246a7b48-6c55-4caa-69b4-08d777665438
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 20:29:28.1316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8vFOQ/lejVnfESPaJOPzeQWbj+Tm0bms7X2+6nhpvzrvVa7IXeK1RbTKfpEOFqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.40
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



On 10/10/19 9:32 PM, Eduardo Habkost wrote:
> On Fri, Sep 06, 2019 at 07:12:11PM +0000, Moger, Babu wrote:
>> Some parameters are unnecessarily passed for offset/width
>> calculation. Remove those parameters from function prototypes.
>> No functional change.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> Isn't it simpler to use the new X86CPUTopoInfo struct, to make
> hard-to-spot mistakes less likely when calling those functions?
> 

Yes. Passed X86CPUTopoInfo for all the offset and width calculation.

