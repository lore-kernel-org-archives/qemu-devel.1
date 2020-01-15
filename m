Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C6CC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F902077B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jP84fRzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F902077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhYa-0001Nx-Qo
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1irhXq-0000f0-Pz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1irhXp-000431-9n
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:13:10 -0500
Received: from mail-db3eur04hn2109.outbound.protection.outlook.com
 ([52.101.138.109]:38246 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1irhXo-00041F-Gl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:13:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jppuCfh9oh2m35XFIjg+FCEmRKZTkjsL5EzWolRBUtqx5ROzaQ9TQpEyp38+vwMGbXoVLnZNzthhL+F1fpb/Y5prvky45V2FI+BXZbKcHDjeryJlnUeiT5XtsDVHNiE1ufsB6uPbVKrKAfA+SC6gCKVgpYHA2wZDpEdT+Bq+HX/HYKgRDOHLBoMrCfTT9dWRurheHbV6QboWXwUI+M6mXfsPmqaGGdp85sjRcnta8BvJUaSOoIDBauvnCOOqYJ1ARBdRbEomwKpWzHzq7Rwmdp6Dm9cNt/Bb0XBTIfLSAl9NzLI9/s8KPpQEzNWH0K9XaphVgc+vbGhHZmws3fJlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DUfPK9+Hrt/s+L8f/yjpryBTRwh4KNdPLFQ3nK+NKc=;
 b=BaaG+LOPrWPZ68YKYcrRR3I//35IgUyJ1qne3qWFU82kjdrR4WJom+cuss6+WFXp2cpX7S3w1m5BdetqcdWPB62rA417jZu7lddCs0o1CfXYCc0qb0BYFJuoB1WlTj1vADRmHl9glg8UywQvF7mGLiDEp6wANl8vSLPBy9h8ygOo2SvsfiKJ1pmbZjXbPB7scaWaw99ayutu6Nlj4ULEAvG992LoPAXXQV3aK19y51jt64Nu2RwvWlEoXtquy8vxgHE2ZhT2CzRxsNYhPslP3LfDLnCmso/cQMkTRF5AUR7gF3w13en79nnvRaYPT90XWnh31VMj1YRRiw7CHr6y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DUfPK9+Hrt/s+L8f/yjpryBTRwh4KNdPLFQ3nK+NKc=;
 b=jP84fRzxLaM/+twAfUg52tGmfwWWCb+A8UvHOwCKplCmtJ760a72DMBk8AqQgdUE1ESfXiqFRfKumyuQiQ+HBiqd+fnA2cRDPZwVPcRJsFUt8jeFrOkb6QMR0lyhMAkzkfxv5rEht8xs6Ue6pzpUwGfVp8iC5LeBVLKp6iOKmtU=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 AM0SPR01MB0069.eurprd08.prod.outlook.com (20.178.83.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 12:13:00 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 12:13:00 +0000
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1P195CA0016.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 12:12:58 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/3] exclude hyperv synic sections from vhost
Thread-Topic: [PATCH v2 0/3] exclude hyperv synic sections from vhost
Thread-Index: AQHVyjgzSKLqN+GqXkue0pexN2SudafrpcwA
Date: Wed, 15 Jan 2020 12:12:59 +0000
Message-ID: <20200115121256.GA33252@rkaganb.sw.ru>
References: <20200113173647.84842-1-dgilbert@redhat.com>
In-Reply-To: <20200113173647.84842-1-dgilbert@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert
 (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 vkuznets@redhat.com, 
 mst@redhat.com,	jasowang@redhat.com, pbonzini@redhat.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P195CA0016.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::26)
 To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce1cd79d-9462-408c-3fe8-08d799b4430c
x-ms-traffictypediagnostic: AM0SPR01MB0069:|AM0SPR01MB0069:|AM0SPR01MB0069:
x-microsoft-antispam-prvs: <AM0SPR01MB0069C0AC2A31B987C7FFA3E1C9370@AM0SPR01MB0069.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(366004)(136003)(39850400004)(346002)(376002)(189003)(199004)(1076003)(16526019)(54906003)(66556008)(64756008)(66446008)(66476007)(316002)(2906002)(71200400001)(26005)(81166006)(66946007)(4326008)(4744005)(6916009)(6506007)(81156014)(86362001)(52116002)(33656002)(478600001)(186003)(55016002)(9686003)(7696005)(8936002)(5660300002)(36756003)(956004)(8676002)(30126003);
 DIR:OUT; SFP:1501; SCL:5; SRVR:AM0SPR01MB0069;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQdd2ALdQonzmfY8L4PMNSYU4WznNZ7kOCJhL2L+8xVJFUrq+xFhuVdNBYKbs138ZK34x4tpBxenKq3gpkk/S8HvLx7Kxyw1qVmwO76et0i/9pE+x3xR/ZxpbiISf0ginAeSAfFsCqkrnMzffwlMB0FXq4/RF13WxQCEPdx01ppJaR2YGeo6GpXZtwKGpZ3muQrxhWREYNwnWqWxukoX0hdK6OFNRs9oEnnjPETmX152PE2lloF0AWmDrCYWfCLlQG4Ri2VQjMXpda4R5um3vc4LbkuV34DDTrhkeSdExmmhl2ydN/FX/B3i2T1Km2Sab7fIZuETVqaCvB6osTS65ejjmKt2JzchApLIMgrPlH+g65hfn8Ym76BTLTTayB/tDZzL7uXPBAuvvfl8MhwKnKJN62XhSGs9T4PF+Q7UCvF9zsE8x5lM2/AsbntQlLWi3P9KoREGABfoWFq4zWzjcLe0fd6qSGWG9dCPuWKwFb06QzDw9j6ttU1znptaB7xUw6UPmdaCr/HIf8u3nmGGRqlGy8K4kpmNtdBwAI56tas06gZ++oAJOjRXC9EKORYONn2HtgJZNEotq+NjAaz2JVRwoAodMz2IkDFhr4b2qeCGwOhez+srVbmJunOKAkNhFLntvKAxgLf46LO7yj9+wiwwKgIUgQVj+k7UTUXa19124ijBw4LRjOprwP4ItKSk+2J3Ia7hX3OFB/BZILYe6R9EZuPv36b0K861WbDAf8iDtGEJqagG7PWeyvupw7MjF61C1Ry7OBpRq/+CfrTCAA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30DB569476A81C4885CE5574DCD4C798@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1cd79d-9462-408c-3fe8-08d799b4430c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 12:12:59.6872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tUFpu1qHRFWbcHrbQcF4xgoOh0aZmCn7yYo3caltV5dvPB4qG1JeDYhY/sPkbC8m44Ctc1L+fIp1RTCo9Xj9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0069
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.138.109
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
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 13, 2020 at 05:36:44PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hyperv's synic (that we emulate) is a feature that allows the guest
> to place some magic (4k) pages of RAM anywhere it likes in GPA.
> This confuses vhost's RAM section merging when these pages
> land over the top of hugepages.
> 
> Since they're not normal RAM, and they shouldn't have vhost DMAing
> into them, exclude them from the vhost set.

I still don't think this is correct assessment.  These pages are normal
RAM, perfectly eligible for DMA and what not.

It was a thinko to implement them this way, taking the Hyper-V spec too
literally.  Among the downsides is the excessive consumption of KVM
memslots, and unnecessary large page splits or conflicts with
unsplittable ones.  I'm working on an alternative approach that doesn't
suffer from these issues; struggling to preserve compatibility ATM.

Thanks,
Roman.

