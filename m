Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835F3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4A92467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4O2DYdAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4A92467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwU0T-0004yu-Gl
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwTyw-0003LT-AO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwTyv-0001gS-Av
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:44:54 -0500
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com
 ([40.107.243.56]:32488 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwTyv-0001e3-5r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:44:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8ChDUCSPFNABi5s0GRSLNDuoMTcjc9WgZsY2rTs+hKmeoTciByeNtGfrvqBXeMrZzWrbcGNB5QhNxtcHhYP9ErL4/cSDEJ5J0Gm3OhMb3f6jWxQmdtslIGAhSu4+a35BAouZ6/C2/vqwaa475to6i7J7nETxXkZPi8j9uz4LmhgDE3pnO5lwU2ypWihSEGIeadkDGo+YQ4JyIpD/vjtxY1qjBeYhVjv/I2V548w7vu6blpFEeDm+HBCPJvPbydfZQgiAJ1jSaakFH4R6PE71NcnI5G5W5pDP+pErpP7Q32apcbjAXVNVEboHoZYYWrblAqe8pi2unoEPIoI0Xbk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7+o7A61E2nWqUQewDUp1fKwwhmici+U8M8GNDo4Cyg=;
 b=buU6t40T/LBWK6VJMaJtSVADnFNNzyAFhMy/2i5wkLuE9JnxYuXoGSyEd1nWF9yW+6VZCuvZKfflagk3TXwlExcmtJ4++LcRxB9nTPtt4sbNbwCRsPPvbxxcsSPA35Mg2XX18NTS2sBKdYq/oQ6fz1hB7NTZo6W807hlntw9vw+cs1WIzyZS/s/bh7uGB2exbskyfA1by7F3mTOikA12gac3cDVElu7JigeVKswBOh2sfkN5SmMnqHEqkMwCd5C35eWoz1C4JXmhHrl5CNYLZ/THQfQDBTFiaA+UB0hvhQnSP59xNdnzRs9XXsNY2lDoIA9admvp+QeF4m665+H1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7+o7A61E2nWqUQewDUp1fKwwhmici+U8M8GNDo4Cyg=;
 b=4O2DYdAuM94ROKD2q7N3hJqMEzzkcQxnB92TH+sL+EJPhmoL6upfLOcgwdipCHRzceka2HNxq5t+suOm1t0Q1zHO22k0oaImihBYKJRMBZ09eTGDEy18FKehEV4DJKLOiCOuFH65fttJnWfbzRj6ForWdJ4yWM1q+n7iUCSz22k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 16:44:51 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 16:44:51 +0000
Subject: Re: [PATCH v3 06/18] hw/core: Add core complex id in X86CPU topology
To: Eric Blake <eblake@redhat.com>, ehabkost@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, armbru@redhat.com, imammedo@redhat.com
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541985531.46157.16935250205964640126.stgit@naples-babu.amd.com>
 <b06a0db8-928f-34d4-1175-ceaa28e47d4d@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <19056d02-5ea7-28d6-5f25-3346166683db@amd.com>
Date: Tue, 28 Jan 2020 10:44:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <b06a0db8-928f-34d4-1175-ceaa28e47d4d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN6PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:805:ca::47) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 SN6PR16CA0070.namprd16.prod.outlook.com (2603:10b6:805:ca::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24 via Frontend Transport; Tue, 28 Jan 2020 16:44:50 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8591f4b1-09c2-4397-fa43-08d7a41164f5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1653:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1653896DEE0D5E077401B46E950A0@CY4PR12MB1653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(8936002)(5660300002)(53546011)(66946007)(66556008)(186003)(6486002)(8676002)(36756003)(81166006)(81156014)(66476007)(31696002)(16526019)(44832011)(86362001)(956004)(2616005)(26005)(4326008)(316002)(16576012)(31686004)(2906002)(478600001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1653;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bF1OglFXhXAgBf1IL+GO8lJCexHJJYQ77w34Ml7l/wzwzOREo81kG/FsuI1Moynu/Zo0Nm86zOkyHYZ+wBQNU2ZYqEKW/4FHGA8kOomvRmVETFcq3scldXjkEM/Un0hA7I4zgh8uPbGuVPBqw6D6rdNakJ5YT39j7/5RdHYxXWelricOXFmoOzdSTnt/2ozD4sQId669Uxi5x/XQ5RFQiAoKNXbxokznBKmwz9QrABZIXbaF9AhNY5yc8lCVx92ueW8ZWzEPnxeGm50+SeBqa1S/X0nHN/PcXo01T4xgEs0uiHAKkO4GQDVOSBllrQrilitwrlqy8m8oaxws4TZ8mdKnVVeyClb7PCFXwXMzYPG3Vs/XzFjnHFFLlztAhUMBkIy8NNBSi9vbcxK3z+SxIqCf6/4uWuAd7oqKptf8IaeCP0giq88cpyJLVLDi41oI
X-MS-Exchange-AntiSpam-MessageData: UQxl7qipi00X3+4xp9ubWdR6NOYEAJk6gOQjzItu/5NWfQPlwbyPDsvmqVykk81n4MJDsHxKKohnbZXwnwbTANeE0lZf/OpyK+Ejkzn/6h6C45p6JXqe3j+Jpi51+cVcCT85eZpMM8cS5AsCnrH7eA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8591f4b1-09c2-4397-fa43-08d7a41164f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 16:44:51.2945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbFeZmMnhGBsHVBRNE8h589eby3odxNDFdEyBmMarK2RLCQ4XBR4tU4s8hdvp+tg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.56
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/28/20 10:31 AM, Eric Blake wrote:
> On 12/3/19 6:37 PM, Babu Moger wrote:
>> Introduce last level cache id(llc_id) in x86CPU topology.=C2=A0 This
>> information is
>> required to build the topology in EPIC mode.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>=20
>> +++ b/qapi/machine.json
>> @@ -646,9 +646,11 @@
>> =C2=A0 # @node-id: NUMA node ID the CPU belongs to
>> =C2=A0 # @socket-id: socket number within node/board the CPU belongs to
>> =C2=A0 # @die-id: die number within node/board the CPU belongs to (Since=
 4.1)
>> -# @core-id: core number within die the CPU belongs to# @thread-id:
>> thread number within core the CPU belongs to
>> +# @llc-id: last level cache number within node/board the CPU belongs to
>> (Since 4.2)
>=20
> s/4.2/5.0/

Sure. Will change it. Thanks

>=20
>> +# @core-id: core number within die the CPU belongs to
>> +# @thread-id: thread number within core the CPU belongs to
>> =C2=A0 #
>> -# Note: currently there are 5 properties that could be present
>> +# Note: currently there are 6 properties that could be present
>> =C2=A0 # but management should be prepared to pass through other
>> =C2=A0 # properties with device_add command to allow for future
>> =C2=A0 # interface extension. This also requires the filed names to be k=
ept in
>> @@ -660,6 +662,7 @@
>> =C2=A0=C2=A0=C2=A0 'data': { '*node-id': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*socket-id': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*die-id': 'int',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*ll=
c-id': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*core-id': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*thread-id': 'int'
>> =C2=A0=C2=A0=C2=A0 }

