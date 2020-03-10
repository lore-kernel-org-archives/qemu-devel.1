Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31BC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A093121D56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B41xE3gL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A093121D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBo19-0002ly-Pp
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 19:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBo0M-0001my-0Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBo0K-0005Bx-Rd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:09:41 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com
 ([40.107.220.48]:6268 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBo0K-00052y-G3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:09:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF9PEIAikrNSQROTAqwWwob0uH+IKAxtoO2JWCWlevt7aSZh3aXi9UHLRXceoo9O+ujNyUVocmgbvRAb7BEbi/J/4mP82O2zDIKb0SEujyLJBkLBSg1cNLbatPZNUWyYG/fredr6o/AhDHxuOt6x3NIUfqsPJCMbl8d+WX+gx70qtKf3TsaY27lAUg9o9O+Zj9KzO2IWSl2Sfuy12eK5XhPUZTvI/d6Os37K5PFbVfe+iQHB2a/6VWWuRwYXc0q3aSjTkFvJR/QdbpoODSyADrqJwyaWi/v1GT2ej+la4RfnsQJA1GWBVWTx/Q+E57vHnZqs8NvPopOkT4sBD1XZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWq+WRr84GihFQqyZSDha6+nwryZCpS9MLJ9lYUEPkE=;
 b=VzvXW9dZsDJNtS3jVp29r0Vl6o2ApdFi+XmV814/X1/Aq6ybi3qCjvyg/yKaru8PJg22ybT+DREq1RAt7rfl2aS/dRCmDFFPk66QPntGxwPzp1VC6ok23Ifv/B86yfx1A/RtNLscFJjw7Yho6xuiqoNVMU+djAO2peCQvFTcAXxyBT9JXoqjNU7tHu1owgnR6XCxIX9Hkrc4vx0vMQGoanNOot4uMmxMZaiIbbfcpZ7cbrPAaxvDN7rGsbUJ191eNUY9isEM6DUb/HADTqJHZdOSOyx8lzAQbYtH3o5CK+YYKFTGiirflR/fPS38FMq9lezb7QjHZMTaa8UJJ+/SIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWq+WRr84GihFQqyZSDha6+nwryZCpS9MLJ9lYUEPkE=;
 b=B41xE3gLneI9UIQsX+3aea8kYfVUfKvVxe2jCw0KLPqCR1jQIakB/M+CXgnh7VVcDSm5Yj0+0R/KH+Z6Kccvj+5evvRgw67fzpx4+qqtaxvQZabDukgg72hrazQU8AgFLAgW55zzRk8p3ubqCuR6E0sJ0VM/pbCpswcV1V4ULx8=
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2429.namprd12.prod.outlook.com (2603:10b6:802:26::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 23:09:38 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 23:09:38 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v5 16/16] tests: Update the Unit tests
Thread-Topic: [PATCH v5 16/16] tests: Update the Unit tests
Thread-Index: AQHV8ZYigZPtO9w7dEap0hOVTcXR1KhCfdeAgAAAeRA=
Date: Tue, 10 Mar 2020 23:09:38 +0000
Message-ID: <SN1PR12MB2560B8D4EB29B12F136903BE95FF0@SN1PR12MB2560.namprd12.prod.outlook.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326551802.40452.18371333088303667854.stgit@naples-babu.amd.com>
 <20200310230619.GK1187748@habkost.net>
In-Reply-To: <20200310230619.GK1187748@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-10T23:09:36Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e0f9b953-8b7a-48c8-b604-00000f9df104;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-10T23:09:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 94596b3f-f8c0-47d6-9c2a-0000bb725b71
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:555d:a95b:ad3:8b94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5919840c-119b-47f9-f013-08d7c5481b91
x-ms-traffictypediagnostic: SN1PR12MB2429:
x-microsoft-antispam-prvs: <SN1PR12MB2429125A1F0B77E092575F2C95FF0@SN1PR12MB2429.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(186003)(316002)(52536014)(66446008)(64756008)(66556008)(8936002)(71200400001)(66476007)(76116006)(478600001)(54906003)(4744005)(66946007)(5660300002)(2906002)(8676002)(86362001)(81156014)(4326008)(81166006)(55016002)(33656002)(53546011)(6506007)(6916009)(7696005)(15650500001)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2429;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wyvVbRVNKrVSI1/rirtK9NYS63S6bP71O2228c6djqTjiSyAzE/PxwdqYQ5KENyeUiikaoiaRPkybje1OFj7VJEZ5jctzwvXJbImSTWHBBVzZi/t3+NPU6VEO4dLhSFI80QBsZgqplDWwnP7KA8kdUE/w8u6obuFXKGG0Q/vks5EVlWcibnLK2XAUFgsJtKxLcwncgU+sEnjHnuKkuh1uTNYn/t36Bb4uvM+6N85te+AhyryzzHCEYc8v61dw/MYrFbEW1+OxakgnTkZyJ1C0QWqRkSbaBGw/HXcySbFBrnW5etKHe/UOqqEbGjVWV+hsqI5g/xWQ4GuvP29RnhrJPiQnLkxb1qkCZOiyTRAj90s9wWxFLl0hv1mO+gywZzs1XkAwTHPSNMQEnRDdvrXCA8wrU66BJHuyas3UwozQ7Fe4otPvol4Es3lYZIqmWg
x-ms-exchange-antispam-messagedata: dUVfdkHwgQzB9IilG2Rsr2tmaek0T1vQO00jJWjFFjsQZftbCfKxR6U8GVaL2FjW9GF1ZXBb3yMxgVal5J4lQ6KeLz0F4C+MhdK1jxK4PUqHhoWZhvwBhi1NAM+ZsPwTd1skEMFy9WeRKlNcpfYrRBxL/41pFDhj8txCz+mNbJkJVAlfk5+J5HFlFzOPdtKcHobxN7MhfKcgeEags4HDWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5919840c-119b-47f9-f013-08d7c5481b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 23:09:38.6081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9G/KOOFr9dc0Jj3EeFQZO7JiF0ETjBLMWHhnnubA97/ZLH8KhdCIblvJHAKu5zF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2429
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.48
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Tuesday, March 10, 2020 6:06 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
> mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v5 16/16] tests: Update the Unit tests
>=20
> On Tue, Mar 03, 2020 at 01:58:38PM -0600, Babu Moger wrote:
> > Since the topology routines have changed, update
> > the unit tests to use the new APIs.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> This has to be part of the patches that changed the function
> interfaces, otherwise we break bisectability.

Yes. That is right.  Will quash with other patch.

>=20
> --
> Eduardo

