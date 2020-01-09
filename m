Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554AFC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234CE206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RGkmM1dN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234CE206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipaQn-0006LG-5z
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 11:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipaPw-0005v6-5N
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipaPu-000788-Oy
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:12:15 -0500
Received: from mail-bgr052101129050.outbound.protection.outlook.com
 ([52.101.129.50]:35374 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1ipaPt-0006qZ-SO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:12:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW7Gu0uE5YJb912A1WFOMeRtbXQVF7uv4zhHgPencqWbiLcyOaqtsUhTyCln3X6BD/uiSzwPsrYn6i8dpTPWYJQ7ZTsNdFOydLYjExRnkHIE8T/mYHtp+ihKqkMmXXnp/fEVdCT2vXjNrpEcV0rW6sCzTrUIMJ8zeNwKAupxvUYm6XIBdw4LWRetcKgV0r4nYoxCYNVpRLr9ebx0KFQ7ejLCA4N+UpoNnRg45qEIpZ7Z6AGplv1oSHGaXhB1s1eXPnB7sEmm1AsXiDBkk/myx1alad+HG14yhF1ndRornaLa096CbaiZnglVECu2WmntnrbjaU2cl1xDlv99fWT6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8xJWx1Qd8pH+Hvd4PCZP0zliB+huO+JwyJkoMk21Lc=;
 b=hWLfhizGyRJoeFmfGQD0E6YRk9d+tw+p/UW1bfuOVCC0JpQFm87pbhecQoGUpSX4WTtwoGY60+XscekhGYJLj98PLmlXNifMzbzkgRnUBklG97eYIxKAw6AUtWtmSJt+uLYauHem6gTCOFiyQP6a6tb+HN54Ft9sleGYfZZcYqgqpPGsbkJHjnp1QyJUtviARtRzLqasGGEQLykWzECcioGKrExBUWJort5z4LqLNeuyonrCZ718PFZpaEsOiRGEJOKB2Y1f4KdA1gCls20IDyIDhJ5lWmGRgURIhFdqlQB7+cP4SAb/UAciD/CMOANU28UBMW5bHNRuynpOxeInFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8xJWx1Qd8pH+Hvd4PCZP0zliB+huO+JwyJkoMk21Lc=;
 b=RGkmM1dNIAt+Wrxvugr272otJWShOVyVQY9YeWmJZfFq6EIwmZ+ojKHbnBzr10MV5XlgP1N/702EI/N5JsmXJ4ve1X57RXOHDCjYHRejld/M/6exmW05qP5wWe1g5Meyxs/9dtkPmjz8r0iOubIxikcrVdTt8DSce5alwiE0D3w=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB3903.eurprd08.prod.outlook.com (20.178.81.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 16:12:00 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 16:12:00 +0000
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1PR09CA0085.eurprd09.prod.outlook.com (2603:10a6:7:3d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 16:11:59 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Topic: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Index: AQHVxityEM59bZyv8EecProoJvSi/6fiOPyAgAAFpACAAALigIAAARuAgAAKcgCAAAbbAIAAARGAgAAttAA=
Date: Thu, 9 Jan 2020 16:12:00 +0000
Message-ID: <20200109161156.GE3147@rkaganb.sw.ru>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm> <87r208rdin.fsf@vitty.brq.redhat.com>
 <20200109132432.GD3147@rkaganb.sw.ru> <20200109132821.GG6795@work-vm>
In-Reply-To: <20200109132821.GG6795@work-vm>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org,	jasowang@redhat.com, "Michael S. Tsirkin"
 <mst@redhat.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR09CA0085.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::29) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20762967-5604-4ee8-9c0f-08d7951ea842
x-ms-traffictypediagnostic: VI1PR08MB3903:|VI1PR08MB3903:|VI1PR08MB3903:
x-microsoft-antispam-prvs: <VI1PR08MB39037D5650D9442418071B24C9390@VI1PR08MB3903.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(39850400004)(346002)(376002)(136003)(366004)(189003)(199004)(36756003)(16526019)(86362001)(81156014)(8676002)(81166006)(4326008)(5660300002)(1076003)(2906002)(64756008)(66556008)(66946007)(66476007)(186003)(26005)(66446008)(6506007)(6666004)(316002)(9686003)(55016002)(52116002)(7696005)(6916009)(956004)(478600001)(33656002)(71200400001)(8936002)(54906003)(30126003);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3903;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKgkMS4dspbDZJMnR1OBo2JvPFzAVPc44dk6ZPxqXrP9qUgfuhNuLtakxQPY8jZcl5MjLi6HBIxse6a1IgW+Ohb0HaFa1/B+vAA1EGz3UFbeK0dYJYVnsdKxs4pdtPw0fMXiKHM1t8OKkuIXbGX7FkTknxRXXgkk5JzA0IMeVaxAltNh46MMnB+VcrYi3rGbrsljVEFfzw1obuWgnsT6Q8+a84OgP+EOCqQGyCD9UJTXK3j2K68Fgyl6GIABRbj5I13ymKH1k9tXupZl1ZPludxTHhvvFnj3RpIhOOxNNhSGXfGZBjqRKmcFxTaoMoDhhquSFwt2s0Qsiszy6eFlbuvxcWpVft3o+U/eTdqBL2xm2+gBvStL6vvEuj0ep3krNfF3p8duUpzptGPC6jMZgujkAWvxRdO1mNZ+7z05XY2yNGZzg8CoH0kQaTSBPueUUbyFVJ+Wi9QKfgcNvKCHj/IrDAuF5Ox8UjRU2+1u8QNZ0OyulkWci6k5WpOUYm+wxkmfEwL9R7mejzEJRyqRADbHPjUA8cArRywu8D4YB7e7Bx18l0Ix/l55+QteOZzRXSwbhp7mjPVrjGHElOEOClSsxJibtk2mRZnyPBHlPYAm4BrUIgJ+grZgNxNXRkYTlm7nlr27g4qkzpOoSnBnxXzBFljOIa8zUhYcSThQCY7OOyvp3ULsUKnzhE8Vl21VYT6+sNGPKzdcWkS3GQNtWfNMIbK6UPvVlYhujDY6GOehkpxdWTvIrO9dYV2CduG7CYGXmTBe7Qbs/4mpWSRL5Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C63CAB6173D214C93F192824A551FFB@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20762967-5604-4ee8-9c0f-08d7951ea842
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 16:12:00.2408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W39S3I7SbM25y78PR4bJ2MHbCz9pIXpSmopgI6I6RXiO6gERZ8o+T65Aq29GPYFdMP3Ksu69KTBiAyKJ8QbZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3903
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.129.50
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
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 01:28:21PM +0000, Dr. David Alan Gilbert wrote:
> * Roman Kagan (rkagan@virtuozzo.com) wrote:
> > On Thu, Jan 09, 2020 at 02:00:00PM +0100, Vitaly Kuznetsov wrote:
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> > > 
> > > > And I think vhost-user will fail if you have too many sections - and
> > > > the 16 sections from synic I think will blow the slots available.
> > > >
> > > 
> > > SynIC is percpu, it will allocate two 4k pages for every vCPU the guest
> > > has so we're potentially looking at hundreds of such regions.
> > 
> > Indeed.
> > 
> > I think my original idea to implement overlay pages word-for-word to the
> > HyperV spec was a mistake, as it lead to fragmentation and memslot
> > waste.
> > 
> > I'll look into reworking it without actually mapping extra pages over
> > the existing RAM, but achieving overlay semantics by just shoving the
> > *content* of the "overlaid" memory somewhere.
> > 
> > That said, I haven't yet fully understood how the reported issue came
> > about, and thus whether the proposed approach would resolve it too.
> 
> The problem happens when we end up with:
> 
>  a)  0-512k  RAM
>  b)  512k +  synic
>  c)  570kish-640k  RAM
> 
> the page alignment code rounds
>   (a) to 0-2MB   - aligning to the hugepage it's in
>   (b) leaves as is
>   (c) aligns to 0-2MB
> 
>   it then tries to coalesce (c) and (a) and notices (b) got in the way
> and fails it.

I see, thanks.  The only bit I still haven't quite followed is how this
failure results in a quiet vhost malfunction rather than a refusal to
start vhost.

> Given the guest can put Synic anywhere I'm not sure that changing it's
> implementatino would help here.

There would be no (b) nor (separate) (c): synic would just refer to some
memory straight from (a), regardless of its paging granularity.

> (And changing it's implementation would probably break migration
> compatibility).

I'm afraid I see no better option.

Thanks,
Roman.

