Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D87C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 01:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B732074F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 01:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B732074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMi4v-00024W-3u
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 21:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1jMi4K-0001fB-7n
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 21:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1jMi4H-0008FU-Un
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 21:02:51 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:50664)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1jMi4H-0008E5-OG
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 21:02:49 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY
 m4a0073g.houston.softwaregrp.com WITH ESMTP; 
 Fri, 10 Apr 2020 01:00:35 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 10 Apr 2020 00:59:23 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 10 Apr 2020 00:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilCyjd36FT9+uqgdbSob12n78yvRbvg4fXOwE/Lv539aEIfasmQbrDkduT9yq/hOW3rv1GTEB7sqmrZtjZzuLlybuTy2ChTEdd3PBId+pQSvl2v1MMu7ERFZWJodKTaOpidd915e/1RywxiwFudH4nZ/xWbQSgr3t3KXMdAGcqsB5NWdbLR3XBwFYx6Esd1ZGvUlTK67+kUm8VeMF2WwV9TXMoRBAIA0t1Ch4VI+BtgYrATq5lQWYQreiL3eppWkofgCdW/auj7uRBpyWbhtk38U3XRZCjY4LOP1L7F7kfAhh4nVHhPqpxNLdxSaTtxrPufsDEe6X9NNqWoKOcSPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQq+W2/PrBxVpAD25zi/eeqZQFUdm3sZCvl9+wvcSZM=;
 b=LNHSRKeOZ4jGV1bnkU/mFZu5Kg6UaKOyWgAnyJW+UnpCLqbhnXykEvvenobicxr/r0aLyIazeJSRKdUnzMPzcii+EzT/OdxsyCmPIB6Qpvjf3FF+2EN3z0QOgc/f1hio1HSk6IyuqQ6m6DAWR+1LDbzgMf2yjLDjaAHY57ywuk6kwznrElNlZnR/K37hUbUqgXZoaAUmC1G0Oj7nd11Wc0HuZfQwEpJQ0akoUcTN9TjQnBJ07dCgwKpN4OsxgDvDlc7RmaV/CWgSOJFjZ1QNPm2n4HDPn1nbYeLoFZaNfP8vnrh9Een1qS8tFZKkEX044G+izgJx+2V3LRGEn6pUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
Received: from BYAPR18MB3047.namprd18.prod.outlook.com (2603:10b6:a03:105::32)
 by BYAPR18MB2616.namprd18.prod.outlook.com (2603:10b6:a03:13c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 10 Apr
 2020 00:59:20 +0000
Received: from BYAPR18MB3047.namprd18.prod.outlook.com
 ([fe80::2d27:6a4b:3a2f:1ca1]) by BYAPR18MB3047.namprd18.prod.outlook.com
 ([fe80::2d27:6a4b:3a2f:1ca1%4]) with mapi id 15.20.2878.022; Fri, 10 Apr 2020
 00:59:20 +0000
Subject: Re: [RFC][PATCH v2 0/3] IVSHMEM version 2 device for QEMU
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1578407802.git.jan.kiszka@siemens.com>
 <e11366c8-44e6-2d58-7c0a-f49e497cc240@suse.com>
 <883ab460-77c2-a324-6c8b-eb2e74f6458c@siemens.com>
From: Liang Yan <lyan@suse.com>
Autocrypt: addr=lyan@suse.com; prefer-encrypt=mutual; keydata=
 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
 yMQQ+LPXfanS4w==
Message-ID: <e335c68c-c2a2-2012-f54c-20ec372dcb3b@suse.com>
Date: Thu, 9 Apr 2020 20:59:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <883ab460-77c2-a324-6c8b-eb2e74f6458c@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To BYAPR18MB3047.namprd18.prod.outlook.com
 (2603:10b6:a03:105::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2605:a000:160e:228::abc] (2605:a000:160e:228::abc) by
 CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Fri, 10 Apr 2020 00:59:19 +0000
X-Originating-IP: [2605:a000:160e:228::abc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59080cd4-150b-45d3-8faa-08d7dcea66d9
X-MS-TrafficTypeDiagnostic: BYAPR18MB2616:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2616C69050FE8BBBC07555B9BFDE0@BYAPR18MB2616.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR18MB3047.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(4326008)(81156014)(16526019)(316002)(66476007)(36756003)(8936002)(66556008)(110136005)(66946007)(54906003)(81166007)(478600001)(2616005)(8676002)(5660300002)(966005)(53546011)(186003)(31696002)(52116002)(6486002)(2906002)(86362001)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52FJtwCLYx7xQidVVYfxSc0tsD/G5L3hfcWTXWCqRNROFzlxeX7uwE6O2/Hy6++O3iwhxSOxtmc3XNr8vI/4kXHoaObeBbaGN++ToFmOlDyAIt0XHB03Sg/S9yrIlZjMmJ+rJy1MM6pZhtmzr5lfFP/vhTwcIQUAwRRkXJ6biuEAsiXxN9p/RrsQEXfxkJLe78qDUEFr6SphlFPMDZsGbC1NkiKlaX1TDRC2dkgP4VKWpqT4civUF14kXe6xgSVPXTSWAoWokR3ayazGa9vBBdQuNsSTS9pajk9upjOhDDPI0cJ/zwpg0ipPZmqcpu3h+ZlhGuSHBAzFIVRuTAjh8Oc6rU3S0azyuoO0F4NlSkhtf7Pp4DEfCiBea+YevBMyJM5rtY4bhvpidue45qhatdP4Wf3fr0VJ6558ffRd41vadn5NUf6qWX+TjRHo5y6ZnRZFmRwajHYdj+kqP/lrOpJvUN0ZY0mH40/DScGAmt6ceXkh7z5SEDYgWqLjuxTQFe1Og/mcEpTFEVwH/xWczw==
X-MS-Exchange-AntiSpam-MessageData: rk8e9MeWaNxliFfqWbhN3wIY9UPIdqe4o9oDDwyFHog5nDfvtVTKiAOlg4Ie43GGLzt+koSR4efCPJI54Pe5ZOsivbfhZtnGKrP7G6IwMjAH0hvsateLi/7dMV78wM9uahHBzPHrQnxdmTNtEd0vp6h07Ox5OkqahAOzA1h10rA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59080cd4-150b-45d3-8faa-08d7dcea66d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 00:59:20.4555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p9g0Pk3Z/OgQ8MLRvbs1MQ5E5fiW46DDQb/CBt7v4h1ZEQizJoqlZEF1HRu52qp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2616
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.2.131
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/9/20 10:11 AM, Jan Kiszka wrote:
> On 09.04.20 15:52, Liang Yan wrote:
>>
>>
>> On 1/7/20 9:36 AM, Jan Kiszka wrote:
>>> Overdue update of the ivshmem 2.0 device model as presented at [1].
>>>
>>> Changes in v2:
>>> =C2=A0 - changed PCI device ID to Siemens-granted one,
>>> =C2=A0=C2=A0=C2=A0 adjusted PCI device revision to 0
>>> =C2=A0 - removed unused feature register from device
>>> =C2=A0 - addressed feedback on specification document
>>> =C2=A0 - rebased over master
>>>
>>> This version is now fully in sync with the implementation for Jailhouse
>>> that is currently under review [2][3], UIO and virtio-ivshmem drivers
>>> are shared. Jailhouse will very likely pick up this revision of the
>>> device in order to move forward with stressing it.
>>>
>>> More details on the usage with QEMU were in the original cover letter
>>> (with adjustements to the new device ID):
>>>
>>> If you want to play with this, the basic setup of the shared memory
>>> device is described in patch 1 and 3. UIO driver and also the
>>> virtio-ivshmem prototype can be found at
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0
>>> http://git.kiszka.org/?p=3Dlinux.git;a=3Dshortlog;h=3Drefs/heads/queues=
/ivshmem2
>>>
>>>
>>> Accessing the device via UIO is trivial enough. If you want to use it
>>> for virtio, this is additionally to the description in patch 3 needed o=
n
>>> the virtio console backend side:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 modprobe uio_ivshmem
>>> =C2=A0=C2=A0=C2=A0=C2=A0 echo "110a 4106 1af4 1100 ffc003 ffffff" >
>>> /sys/bus/pci/drivers/uio_ivshmem/new_id
>>> =C2=A0=C2=A0=C2=A0=C2=A0 linux/tools/virtio/virtio-ivshmem-console /dev=
/uio0
>>>
>>> And for virtio block:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 echo "110a 4106 1af4 1100 ffc002 ffffff" >
>>> /sys/bus/pci/drivers/uio_ivshmem/new_id
>>> =C2=A0=C2=A0=C2=A0=C2=A0 linux/tools/virtio/virtio-ivshmem-console /dev=
/uio0
>>> /path/to/disk.img
>>>
>>> After that, you can start the QEMU frontend instance with the
>>> virtio-ivshmem driver installed which can use the new /dev/hvc* or
>>> /dev/vda* as usual.
>>>
>> Hi, Jan,
>>
>> Nice work.
>>
>> I did a full test for your this new version. QEMU device part looks
>> good, virtio console worked as expected. Just had some issue with
>> virtio-ivshmem-block tests here.
>>
>> I suppose you mean "linux/tools/virtio/virtio-ivshmem-block"?
>=20
> Yes, copy&paste mistake, had the same issue over in
> https://github.com/siemens/jailhouse/blob/master/Documentation/inter-cell=
-communication.md
>=20
>=20
>>
>> Noticed "ffc002" is the main difference, however I saw nothing response
>> when run echo command here, are there anything I need to prepare?
>>
>> I build the driver in guest kernel already.
>>
>> Do I need a new protocol or anything for below command line?
>> ivshmem2-server -F -l 64K -n 2 -V 3 -P 0x8003
>=20
> Yes, you need to adjust that command line - didn't I document that
> somewhere? Looks like I didn't:
>=20
> ivshmem2-server -F -l 1M -n 2 -V 2 -P 0x8002
>=20
> i.e. a bit more memory is good (but this isn't speed-optimized anyway),
> you only need 2 vectors here (but more do not harm), and the protocol
> indeed needs adjustment (that is the key).
>=20

Thanks for the reply. I just confirmed that virtio-ivshmem-block worked
with the new configruation, a "vdb" disk is mounted to fronted VM. I
will send out a full test summary later.

Best,
Liang



> Jan
>=20

