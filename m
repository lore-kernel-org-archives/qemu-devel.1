Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAB7C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE12F20656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZLCyPYuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE12F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWPG-0005xP-2N
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipWOE-0004oc-Ku
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipWOC-00073O-M5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:54:13 -0500
Received: from mail-bgr052101134109.outbound.protection.outlook.com
 ([52.101.134.109]:60384 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1ipWO8-0006yI-KQ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:54:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdrO1jGSoz6vjD+QLsHaf4x98vxeRmRPCFYneiDaofWn65xspH4ZDKiZnX69mar4iUfrrnjwJ0W8vZozzWazs0TGkyH0NpVYmMyQ1BIU4ERAXCxbDw5sLycjQMGBk93gP+0XmG4hWfNyfl+1eu5yKAbyvNzZiLGEG73Ih/pKFuot4C/qZRIzS5VoMA38r2EQ2RJqOSfIKcssdcUJKsEtbvDFEkz8SMGcydCKAuXKBZ1E85f+Hxa7HRUeD5SsH482dB+X0ftNNjbrrAnpsKpJcfQwx0zmlmMwyRxBq7dvkUJ05Yop9/yebKBFvPceE/ciUIDZmzsOZ4A6GrzWdXO3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkhth/vx4WKFpbn0G6/v2nX+dWlShlbZliAY76mYEg8=;
 b=l5jV/AD2Z79F7HGxJotnf+yL59nk8W1doNrRBiZ3CA0QrX478ZWHnCw0zhQrGkFyD9BE6Mcs6OL4TFklkxVb5iO25jghvE9Op0oHFN5PMCo4buKsGH+GgCfgW5Cn7EbE28nDVFcYo4dmxDkNrXLUErxZlirsro0p4BMBMw+z3YmutWSy8C35VGgenpJ7klCPqZ4V0QoHwmVRYi18ViSkaf7Z3MqWfjJNJrEbPcoxVvN+oJ2vbqxjBnkB+LV1esnU1IyROQDUJcNrPe0ZHUcXGsGum5mlODeMINW6k3iCPbPPxQ/fH4LrXIiM7LB0YJmYIM3C4xmND4u/QQ60syUf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkhth/vx4WKFpbn0G6/v2nX+dWlShlbZliAY76mYEg8=;
 b=ZLCyPYuyN682cpAMMhxvFnvo+2MuFzfPWuNBJrjGZP/ks2L6GeKIyKt68MKHxlMoOu4rp9LVwP5UxgOno92ciyQWna5pmUoUi0jqJbsmxIKZirL0hdmlPxFuN6qbaoJuC5mvk7Fq141pFoqaPxso+DUKUOQGUlt+cxaXe6fG7J0=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB3582.eurprd08.prod.outlook.com (20.177.62.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 11:53:57 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 11:53:57 +0000
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1P18901CA0010.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 11:53:55 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] exclude hyperv synic sections from vhost
Thread-Topic: [PATCH 0/2] exclude hyperv synic sections from vhost
Thread-Index: AQHVxis36D2VBxju70ihbHbpFaDU3qfiOpeA
Date: Thu, 9 Jan 2020 11:53:56 +0000
Message-ID: <20200109115353.GA3147@rkaganb.sw.ru>
References: <20200108135353.75471-1-dgilbert@redhat.com>
In-Reply-To: <20200108135353.75471-1-dgilbert@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert
 (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 vkuznets@redhat.com, mst@redhat.com,	jasowang@redhat.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P18901CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::20) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb62a4b0-6484-4eb0-9a31-08d794fa9b32
x-ms-traffictypediagnostic: VI1PR08MB3582:|VI1PR08MB3582:|VI1PR08MB3582:
x-microsoft-antispam-prvs: <VI1PR08MB35821C2CDAC5D6755B55FECBC9390@VI1PR08MB3582.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(376002)(136003)(39840400004)(366004)(346002)(189003)(199004)(55016002)(316002)(9686003)(81156014)(81166006)(66446008)(66946007)(64756008)(966005)(66476007)(86362001)(71200400001)(8676002)(8936002)(66556008)(36756003)(478600001)(2906002)(4326008)(33656002)(6506007)(26005)(1076003)(956004)(4744005)(6916009)(54906003)(186003)(52116002)(7696005)(16526019)(5660300002)(30126003);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3582;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKTmBwDF0x55KnG8cZB/YibXrVSdUCNu0zZJegZjI6rBKh2a+cPYX0xozd4HtgbzvL9fb4Na908E0GqVvvdTzc6GHj6bYrkv0F7KiHdQeEeta4LufX1FHqyXk2w21E0qSuFDttERZAxpLkiEbn80qt2Zkg2Phmx7AZN5cbwHroYmhYyPFlWAAClUNJ8DuJEzHqyZKbYhyHUsUgkQnJlO7dUZ9q29+61BUEfkMvuW+UB+KBPBS4xUCnWd6Xv5Bl8pMOCuZzmVWqmEfLHwNWEhXFgxT9k6DafI0al4GD41+1HcfZHuUhTXNNgytjlDZcjs9TcxVISn3pwN/WUPMq9r6bVukuOZK8lIFgGwL2vfhHDcaJDiCmFBxn5sPErT6jHlEmxzqNIqhOjLLSOl063GfJVcoiPWH/S5taamHPzEO+XuQ2f2QVV0D75qINT6lrv/sYPNH1a6CzbGkoQPrigu4qRr7y8qGCB9e9XoBo0P+F+7oJMxr963vt2m25cjUQsyHupbFdBcU1ANol7s7QP3GkyEtf+uzqa5KFErBjzRazwetZptlIXUU1Qv5U5ZODmdShsKCvBhy3SieODrFxh0I54++mJAe9RDUuIAz+Stw551Qkz4jJ6i7AKahOiBaDriZ7Z2CNSos7S5hbDKFm4zhZba95v8G3dTMRFP6FHNDcpZ3RDj/RVCQlxVFpmdPrf0SgUpQ3vdjcEiHMvdFc6++l5I+vjfHbWkGDChrqjcI07AWzvnQrSdqdObwCqZwVqIwSVXI29cpRQIkm1eDDh2azhesi3Z3GF/a375KIpzhxeXC0c1Zr17x976oi/iQCRtghsAnxNo+gshNHg8ahqDCw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4BCD8FCF75A8F45966C42A450060F3D@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb62a4b0-6484-4eb0-9a31-08d794fa9b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 11:53:56.8041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmFrWrwPTHalyx9B1jVNssuqnadwdFO07d+BwmHB44e89OfAY8VYewKcUBMJXsS4ayvRe9jvzm1xJElmRWieaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3582
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.134.109
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 01:53:51PM +0000, Dr. David Alan Gilbert (git) wrote:
> Hyperv's synic (that we emulate) is a feature that allows the guest
> to place some magic (4k) pages of RAM anywhere it likes in GPA.
> This confuses vhost's RAM section merging when these pages
> land over the top of hugepages.
> 
> Since they're not normal RAM, and they shouldn't have vhost DMAing
> into them, exclude them from the vhost set.

But they *are* normal RAM.  If the guest driver sets up the device to
DMA to a SynIC page so be it, and the guest deserves what it gets.

> I do that by marking them as device-ram and then excluding device-ram
> from vhost.
> 
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=1779041

I was pointed a while back by Vitaly at
https://bugs.launchpad.net/qemu/+bug/1811533 which appeared to be the
same issue, but failed to reproduce the problem.  Can you please provide
some more detail as to how it's triggered?

Thanks,
Roman.

