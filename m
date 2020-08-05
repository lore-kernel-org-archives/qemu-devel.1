Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65931C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340F122D3E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Z9iyLLK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340F122D3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3JBA-0003KV-Fo
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiri@mellanox.com>) id 1k3EWr-0002qD-Qs
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:12:05 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com
 ([40.107.8.87]:34369 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiri@mellanox.com>) id 1k3EWo-0004RD-QG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:12:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5ZXAqUVbQZGaRwyYWJEuvD3kj+MdBEQcot6O3nWhD2HVEF5H8xU8AGGHfnXukHI9Rsa9bmNI19Mhj5Am1fLEnTcA/IG6Cv/QQwbPIXe/c/fAzSNWFaLrXd5P35TnA8wTlo2FpqChwRT6PDLp+setKg5A1stY9fiKqTRK2G0obZlVmOEPxTeWy0tPjVvIeh7WbhCBrInDjTTpfgnl5do7cICZPbV1wGmgeaWP/V8IUWhfsyDRXgKNETpNfO+/btbIWv91HubmGMLAzhu/wTBVi3xmXNyHNMHHhYELCC0kRGGXcw2DzhoKNBRpCZ4BplAs1bhJfJBFUHBtzqP2hMSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbNPv1R+k2nbLYPV+shm9GIPARgusFUsHOINDiQiyy4=;
 b=JCQK8adGovbwXCPiVKpY2Jds12bTt0AkzF/ehIG1iCbrNuRCn/8mysVYT9bchKW2Bb1h4daaJ683pFiX0DXAU/873ZROsNACzXIbvnMFSXaDAIRFqHyMPKTAnHVNkS0c+olnNs236msOqRJrv9PoyOGYr8oYDUBlal8pz1qmTMcTeF0zVJhZOhGawf54+X21BB7WWHU2DNv3TlUTqwQpSHBoYjOx16ZkWl50I1pWkI1pCY0J/xXkqDd+oyvsMVu7V038OSy+ghOM7TxHCm84f6oR8dXFUPlVDLNHwr41c84cg+BTd/zT2xw0iFsG99B3ao6zLO/wuO3FeNN9ko3y6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbNPv1R+k2nbLYPV+shm9GIPARgusFUsHOINDiQiyy4=;
 b=Z9iyLLK8mfy6YafufrIqaHUYJtPy8fFSYlj2UbBKdBZBZbI9ULD7zGm7YkZG0SQMRu4dzkBbPaZhg+mZXLSKwKkf1UKFxZOflCO5FUdj8hZvRMMQN/EZO8cI4MKTWTU/qY1yC2El1TWhC6pGuiaDxQ6ztaJKFWOBAGr0HqL3NxQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from DBBPR05MB6364.eurprd05.prod.outlook.com (2603:10a6:10:cc::22)
 by DB6PR05MB3175.eurprd05.prod.outlook.com (2603:10a6:6:1a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 07:56:50 +0000
Received: from DBBPR05MB6364.eurprd05.prod.outlook.com
 ([fe80::6510:4e88:1d64:18ae]) by DBBPR05MB6364.eurprd05.prod.outlook.com
 ([fe80::6510:4e88:1d64:18ae%6]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 07:56:50 +0000
Date: Wed, 5 Aug 2020 09:56:47 +0200
From: Jiri Pirko <jiri@mellanox.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200805075647.GB2177@nanopsycho>
References: <20200716083230.GA25316@joy-OptiPlex-7040>
 <20200717101258.65555978@x1.home>
 <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
 <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
 <20200805021654.GB30485@joy-OptiPlex-7040>
 <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
X-ClientProxiedBy: AM3PR05CA0111.eurprd05.prod.outlook.com
 (2603:10a6:207:2::13) To DBBPR05MB6364.eurprd05.prod.outlook.com
 (2603:10a6:10:cc::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nanopsycho (85.163.43.78) by
 AM3PR05CA0111.eurprd05.prod.outlook.com (2603:10a6:207:2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18 via Frontend Transport; Wed, 5 Aug 2020 07:56:48 +0000
X-Originating-IP: [85.163.43.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0f298bf-b4dd-480f-3113-08d839151c24
X-MS-TrafficTypeDiagnostic: DB6PR05MB3175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR05MB3175BD23467E065328E83AB6BD4B0@DB6PR05MB3175.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDvHMIHpv7EzsvyTJFYjdzyFCSe5U4rMCmPH3+sO9MB6RNO0rU6neBKGygKTlLEkqREIsqXo0ocLBwHHm/Dp2yInyswCjBFYq+Ja/U1eM6fooyp3OJKjFCTnnNWOsVPBqoRnWJLke8y4GT5zyG00QclXVVo8Q/K01V2cNEHyWROoBc1ijPbGnWkvK16Uo/MEKNq4ObTF4YXy9ZJnsWJzyL4BJIyf+yYnCu6f0awahZ4dfhMmaPxVxHPBUdij3GeKK6xrrp/fw0mb45nD+zC8+F40nAwPlsxIqRZywUA/RIo2zFME/Nor5RFIRHSmOKbqD78FTGAgccVAXnLP2donBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR05MB6364.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(52116002)(1076003)(6496006)(33656002)(186003)(6916009)(16526019)(83380400001)(33716001)(4326008)(7416002)(8676002)(66946007)(107886003)(66556008)(9686003)(316002)(55016002)(956004)(54906003)(9576002)(26005)(66476007)(8936002)(478600001)(2906002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6S3J6wgGvb7OcvIZ6WtR8asRmOocJVJf7f7lxACv4LrrxUXoif1AQhIgmUbMgrlwxHQHBJGuTVlM++1PF9excntvpyjzPqLi0kUYwS9YZRjpmI8aEafAt03IguZcSn5QkcjAIAVySUDDJbc5X8G1QcAtyPcPxjwfflX+aL8dz5lNhSIUiglEwS2f0FNuzcwddkUgUiU3t5Zemf8ZS7bVWW6TpdPAzOoq7kcysyxs7UNVpIbmqNuac0lMVnsuHwE73VdPGgvk11dRNtmYd1kadsgsN02V4YiFZTaQs9R1Y7KNNLe+rXcV9GZ2fwu1bCY9utyL1MC+q1UP78aDwzGPCQ6xvnFy7q/Mruhagy4j2LO5PjWsxEGuuhAuVccFwMfNATizNmbBWUVvBAROZZdfmSS7JKw/+yaEY22hfVBWW+76NJXytPnBq8bDxWJajrfZrhUwf0YJj6iqEc/JwXg3tg9arooqa3uVXSpR42nQrwnmfGIcg2qpcINV/zUhiZkJkIB8zxCJBA16S8dIOHP8LL9TLaNI3lx51Mol7Cy0Y9l5nH916s8MHPfrO7zCWss1MW85qFgYPmmVTWguNjkY/JSnF18nyKQWtrSNM2YDz0ZaYoANj3wgSweXMQw3Uc3fGIyD3qiVDDvmNRyX9ZB3Gw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f298bf-b4dd-480f-3113-08d839151c24
X-MS-Exchange-CrossTenant-AuthSource: DBBPR05MB6364.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 07:56:50.5503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYLNiFI0+SasNmxGipEiqY1WF4rX7pS5y+aEjtjG/X6ZHAdtg0JLUE/s+YgPCW80yyGti26ruNiFV1hibH6V0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3175
Received-SPF: pass client-ip=40.107.8.87; envelope-from=jiri@mellanox.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:11:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Aug 2020 09:09:12 -0400
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
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, eskultet@redhat.com,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
 Parav Pandit <parav@mellanox.com>, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, Alex Williamson <alex.williamson@redhat.com>,
 smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com,
 corbet@lwn.net, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wed, Aug 05, 2020 at 04:41:54AM CEST, jasowang@redhat.com wrote:
>
>On 2020/8/5 上午10:16, Yan Zhao wrote:
>> On Wed, Aug 05, 2020 at 10:22:15AM +0800, Jason Wang wrote:
>> > On 2020/8/5 上午12:35, Cornelia Huck wrote:
>> > > [sorry about not chiming in earlier]
>> > > 
>> > > On Wed, 29 Jul 2020 16:05:03 +0800
>> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
>> > > 
>> > > > On Mon, Jul 27, 2020 at 04:23:21PM -0600, Alex Williamson wrote:
>> > > (...)
>> > > 
>> > > > > Based on the feedback we've received, the previously proposed interface
>> > > > > is not viable.  I think there's agreement that the user needs to be
>> > > > > able to parse and interpret the version information.  Using json seems
>> > > > > viable, but I don't know if it's the best option.  Is there any
>> > > > > precedent of markup strings returned via sysfs we could follow?
>> > > I don't think encoding complex information in a sysfs file is a viable
>> > > approach. Quoting Documentation/filesystems/sysfs.rst:
>> > > 
>> > > "Attributes should be ASCII text files, preferably with only one value
>> > > per file. It is noted that it may not be efficient to contain only one
>> > > value per file, so it is socially acceptable to express an array of
>> > > values of the same type.
>> > > Mixing types, expressing multiple lines of data, and doing fancy
>> > > formatting of data is heavily frowned upon."
>> > > 
>> > > Even though this is an older file, I think these restrictions still
>> > > apply.
>> > 
>> > +1, that's another reason why devlink(netlink) is better.
>> > 
>> hi Jason,
>> do you have any materials or sample code about devlink, so we can have a good
>> study of it?
>> I found some kernel docs about it but my preliminary study didn't show me the
>> advantage of devlink.
>
>
>CC Jiri and Parav for a better answer for this.
>
>My understanding is that the following advantages are obvious (as I replied
>in another thread):
>
>- existing users (NIC, crypto, SCSI, ib), mature and stable
>- much better error reporting (ext_ack other than string or errno)
>- namespace aware
>- do not couple with kobject

Jason, what is your use case?



>
>Thanks
>
>
>> 
>> Thanks
>> Yan
>> 
>

