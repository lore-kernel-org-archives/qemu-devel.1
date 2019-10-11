Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B42C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982AE20673
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EeQbfC8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982AE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzSV-00045n-9L
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iIyGT-0002ZA-RS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iIyGR-0002iD-Ql
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:59:41 -0400
Received: from mail-eopbgr750044.outbound.protection.outlook.com
 ([40.107.75.44]:15406 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iIyGR-0002hk-H4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:59:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhB06p9OA5OAI/JOP/ju+qh+tp2QtMZ7cVykW+8A+mJ02bb4YHyaSfij78hBn/h85DXsnomou4xXYKhUXEbMuVG/R/cy0CS9DGROPI9+9CG3OsJODwx+js1NkYtUmJjlRrmPcpHmBcPv/s8781X7TT/tMSbpgMEG1vN0j4b3/K2+0cpyxkCAwkJlBNT8USJub2XIrk9KYznfSsSpLjMpIm24YFbicVRZ27QjcfIaBu/TljMLR7dE6fRPlkktQSBtTALEUnpId8tZ8BCXMjk655MWeSYSSZIroZadVRYjd6byYeM+UEJj8SLzu1nx4Vbbq5BRW0gQhwLTRIGg7yAKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLRoCKIdYSQ3m8oXQFwCVicZJ+xxCGo4rKpyvfw4OBk=;
 b=eHHIGajvJE8OtdmFlBOhoPabeS+7UIkBYm92E8/EmeO8CYRddoJGYP6M73ha3hq1PwKnb+7J8+p/ZPOYl7Nbzp3ViawtwgIkv9PCBYPRrIGE1sbT3OYYViNl6KTCI3mEoYoAzG3po+kupMBNSe3NEvdkLuct04W5WiwYSkx3In4+6qcaSIDs82oOtF2BLohN5d7Ccl/mjIvGfbvKkUwmMiO5TFctvD015tADjrdWOpX/f0GST9bbNTzu2RuzV6qWdDbGLMjzUI/1TWYRLH4Z58NknfPSpmLnQX8hoPZ6ZLWdnRgNrmLRMQQM+HaTmY6JU6lVC28RPS73q+eUidvdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLRoCKIdYSQ3m8oXQFwCVicZJ+xxCGo4rKpyvfw4OBk=;
 b=EeQbfC8KTegSBwYCanNZvD4RyxmVMjJkSgvhsdkFCrpBsQnGdP3O2hiB09P5OZqFCkTFVlPg5LsS0kYh4BP//58WfSFKrSiQH1CpDBOQMYjnP1ehYiO/FlLRRZRKYaWNfEqJoxxCZ9EHq2EnCGSPvMqgFGiSYsB7DI0/kIf8SG8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2565.namprd12.prod.outlook.com (52.132.143.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 16:59:38 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9089:8467:a76c:6f9d]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9089:8467:a76c:6f9d%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 16:59:37 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 13/16] machine: Add new epyc property
 in PCMachineState
Thread-Topic: [Qemu-devel] [RFC 2 PATCH 13/16] machine: Add new epyc property
 in PCMachineState
Thread-Index: AQHVZOceIuce90DAyEeExN49RF5ewqdVBqUAgAB7F4A=
Date: Fri, 11 Oct 2019 16:59:37 +0000
Message-ID: <35f27ef1-a8ee-19e3-fa01-230135f1ed02@amd.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779718791.21957.9675425538561156773.stgit@localhost.localdomain>
 <20191011035906.GH29387@habkost.net>
In-Reply-To: <20191011035906.GH29387@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM5PR12MB2471.namprd12.prod.outlook.com
 (15.20.2347.014)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa19024-4939-43b1-0a43-08d74e6c6683
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR12MB2565:
x-microsoft-antispam-prvs: <DM5PR12MB2565113337E0C1D75CFE3D2595970@DM5PR12MB2565.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(6512007)(81166006)(81156014)(31686004)(25786009)(8936002)(6486002)(8676002)(6916009)(6436002)(66066001)(256004)(476003)(26005)(3846002)(6246003)(6116002)(4326008)(186003)(5660300002)(486006)(305945005)(7736002)(66556008)(66476007)(6506007)(102836004)(53546011)(66446008)(11346002)(2616005)(14454004)(64756008)(446003)(316002)(36756003)(31696002)(76116006)(86362001)(229853002)(478600001)(2906002)(99286004)(54906003)(66946007)(71200400001)(76176011)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2565;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6+Tai3SSoHvApoG7dquwvOz3XonL9y75pIizT4ljfPyCg+xs2Tqt8cU81+tf/HiI4V1DfQHZ6MrIOOyIPVAgB4PWpA5W91sgHQ7FKu+d7ynP/FqZcQ2MWzysV/SdkExXj7RlE7FORlB082vcNGS9N4ioRfhd7/E1gAw+qsyR6PXQ4REp/J/0k1kUrziEkabvURE8AJEHNryLyAn0dUNwEumXfhaquo1iqBVUWZW7CbRaDAEf+9np0L4KSj6DzLLPrV7uuSzW9IeS42z1KQJj6y7fPY5JcJfv8svt5dtC5iFtupvR2SRkxQlW7XePcDHoCIah759kgpfi0Dvf9s3dE+pizGImayIl30LSeI/HmmH1eLVvwFmrjX7kzK0Pfb5ldPwMeBM1APgZ8NvXHusQpxYIH9C9PWPBM2c5R8Rqzg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <239F897C92DE8541BCB9088A8B992985@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa19024-4939-43b1-0a43-08d74e6c6683
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 16:59:37.8693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQrBCLNU5J6GiMhEXwcSYiozRpZM+B0LErG0sxDMH294T7xz5B4GeKLb+DK15CQJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2565
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.44
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

=0A=
On 10/10/19 10:59 PM, Eduardo Habkost wrote:=0A=
> On Fri, Sep 06, 2019 at 07:13:09PM +0000, Moger, Babu wrote:=0A=
>> Adds new epyc property in PCMachineState and also in MachineState.=0A=
>> This property will be used to initialize the mode specific handlers=0A=
>> to generate apic ids.=0A=
>>=0A=
>> Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
>> ---=0A=
> [...]=0A=
>> diff --git a/include/hw/boards.h b/include/hw/boards.h=0A=
>> index 12eb5032a5..0001d42e50 100644=0A=
>> --- a/include/hw/boards.h=0A=
>> +++ b/include/hw/boards.h=0A=
>> @@ -299,6 +299,8 @@ struct MachineState {=0A=
>>      AccelState *accelerator;=0A=
>>      CPUArchIdList *possible_cpus;=0A=
>>      CpuTopology smp;=0A=
>> +    bool epyc;=0A=
>> +=0A=
> =0A=
> This won't scale at all when we start adding new CPU models with=0A=
> different topology constraints.=0A=
=0A=
Yes, I knew. This could cause scaling issues. Let me see if we could=0A=
do anything different.=0A=
=0A=
> =0A=
> I still have hope we can avoid having separate set of topology ID=0A=
> functions (see my reply to "hw/386: Add new epyc mode topology=0A=
=0A=
Yes. That was my hope too. Let me think thru this bit more. I will come=0A=
back on this.=0A=
=0A=
=0A=
> decoding functions").  But if we really have to create separate=0A=
> functions, we can make them part of the CPU model table, not a=0A=
> boolean machine property.=0A=
> =0A=

