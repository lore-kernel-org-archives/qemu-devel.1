Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE501C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FF0214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B/2cjhms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FF0214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izj7p-0001xo-Lo
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1izj6g-00019r-6A
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1izj6f-0001yH-0G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:30:18 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com
 ([40.107.223.48]:6090 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1izj6e-0001vN-OI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:30:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG0MLPPxgCiICIT243wsIW7Ij+Gvn7Is8A7d4FIzu7g3Z8oQp7xVKzL9ArX3um6+EWW2LZJPul+cdEfYDeVXUAe/U43Gyw56eRxKUgzeaOsGef2A4mle9Tb63O59NnYXqlBAUSTua4/x+L6SSY+PmiXa5aoUfVLf9Rv4f/e8ZfdBKd+uraRrDf5P0B9ufKYU7U9RbRwklc7RLHYBbuzNfLsVxtevWYTSYNBBhpybxHpdvWKA0+46QQxCqlGPYl2P3uuVt9ft1FxvWFmF6pfrgV9f+PQ7CukJM1glhK+BquNCnIE3wf2Z/J2DS/vj7ieqAk7ANpVTHdnUI/A1/4rttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaRHAAGzzjKXK17zi6kvCSyXZ5a4yYTGsDUqqExx7vI=;
 b=Dzo5yfR47eWRW/oVTSN1icRfjG5Qdgq3Dq1Mo+Zurz20Jsye/9i+5bx1hizNNp3jVFZSbXS37A2J96eM+AI4IepJYnxdUhLdbOPwgXVmHO9JaBvD4ElG8EYKBSetYWGx3cSmoQdU/k/X0uMZ59JOMa2Monsp6USVS6ub5RvvL1XDRpOBSqr5L78hLLU3tCeGGZt/UZOCoHV00PUfClM7NAObKPCtuCe0uEJXZLYMTw4C17COTnvPH80zX/c6g5wdnT7cBp/IAzvMVzudLYW2aR69gcQRC9bBhZFCUpu8hAwvscCuBXUN0MdU7qUKjY9p+x2Ij76Kr/zzsbVwLUGjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaRHAAGzzjKXK17zi6kvCSyXZ5a4yYTGsDUqqExx7vI=;
 b=B/2cjhms53KkE72zA3NHZE6ifeelrtzL8Yh5D78xD5m+mRVBaGwVdJq+93HccAIoCYZtBt+VXDavPsAyxBZSupGc7xrx7/FbUfYH5ozgvhNi87ZXdTZgzaPklLNNbLn4f53tA7V0fNgAXhhg1ALRraZuzcECNEmJYKMYyzTPFQA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1208.namprd12.prod.outlook.com (10.168.167.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 15:30:13 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:30:13 +0000
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
To: Ani Sinha <ani.sinha@nutanix.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
 <20200205223731.GY25446@habkost.net>
 <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
 <FD52354F-2038-4829-A7D8-7513D601A2FF@nutanix.com>
 <60B21C9A-30BE-4DC0-8A1B-0BC7757BA9D7@nutanix.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <78f5dad9-5433-3f7c-69cb-db496b1c37a7@amd.com>
Date: Thu, 6 Feb 2020 09:30:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <60B21C9A-30BE-4DC0-8A1B-0BC7757BA9D7@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:0:50::20) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:0:50::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:30:12 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 523fe65e-1bcb-4a50-006e-08d7ab1975ad
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:|CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1208850E3ADE2CF1CCEC8D65951D0@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(52116002)(54906003)(6486002)(36756003)(31686004)(6916009)(16576012)(316002)(8676002)(81156014)(81166006)(8936002)(956004)(44832011)(2616005)(45080400002)(966005)(2906002)(86362001)(5660300002)(186003)(66476007)(66946007)(16526019)(66556008)(53546011)(4744005)(31696002)(478600001)(26005)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1208;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahX7WLrR1eDpFZHB/6ANtjFsHQtVx7+PRpIKnGpNO436A23brJidoc0ZwouIY+CE0HdAaxc+cZBzja+HSZ1SgdcvXQYl5BZon7gAIJ9Z4VRzyfQRvKML7ASgpucrdL/KZn/BoBlziOHD+eOE8RO0l1gMDajNu83+jeijxzqtDkeuDii8t+97E3/Ck8iD1I3jZjSv+N7YJ0c0SAu2qZafDbmc8RyoY0R23ObUrb8tjL+dMeIuKbZJLs9it+8qAxGhyXIi5a//6jvUiiSGJ34whAOpb7OCbnInLYd83VvG+eGskowFIF6LG95XUFRlbr9QlanvXJbTaQRv4waStmW+ceGS3RjF6Kjd2I0CTdy0azYy1979UioKMjsdTfuJd4SuM9Q07JR7R4zcV3avPmReN9JCEHXIFRSLBoT+u112HI45LUt7d6fHa9nTEQWUY8Zrug2zIgSWg9NZNKZ0O0j/nOOA7WmvsS0sfVauubnnE1LCmUef03Ti4q7i1YM30aZT01QvhETZ9tAwo8siCPOOMg==
X-MS-Exchange-AntiSpam-MessageData: B1+n9GS/EIRB8iKTSrjmEO6L+O5dO2HUDUd9jHslOo5WsYCYvahDJelLlFyxXum8g0g7yOK8cedy3r9v5AS8uO5ik1Rw3bXi1fd5CmTIHSmE7Ns7Ltnofpwlq03lsVFB21oXeF6Fh2sCkmR2YKI14w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523fe65e-1bcb-4a50-006e-08d7ab1975ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 15:30:13.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vt3NcZk0vsKHUoQBHHFLiFBFeAQd52wwnCujxkPb+HhuX4MH4vCsO2bcSGI5hfVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.48
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/5/20 11:53 PM, Ani Sinha wrote:
>=20
>=20
>> On Feb 6, 2020, at 11:16 AM, Ani Sinha <ani.sinha@nutanix.com> wrote:
>>
>>
>>
>>> On Feb 6, 2020, at 5:30 AM, Moger, Babu <Babu.Moger@amd.com> wrote:
>>>
>>> Ani, I am already working on it.
>>
>> Wow, I see a whole new AMD-Rome CPU model with it=E2=80=99s own cache in=
fo data :=20
>>
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore=
.kernel.org%2Fqemu-devel%2F157314966312.23828.17684821666338093910.stgit%40=
naples-babu.amd.com%2F&amp;data=3D02%7C01%7CBabu.Moger%40amd.com%7Cc566dc5c=
f3cc407b5ee608d7aac8d9bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63716=
5651955089264&amp;sdata=3DtlafWD6m5%2BZ12cqd4vqJcWh0%2FIgly%2FPVMgAbjxK5Mog=
%3D&amp;reserved=3D0
>=20
> Do you think the ROME specific guest cpu cache data will have significant=
 impact on performance?

I have not done performance benchmarks myself. Yes. Rome is expected to
perform better than its previous generations.


