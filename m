Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C03C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144962067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 17:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cxnfDd3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144962067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipbQP-0008Ly-9r
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 12:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipbNU-0004AV-Pl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipbNT-0003FI-4N
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:13:48 -0500
Received: from mail-db8eur05hn2210.outbound.protection.outlook.com
 ([52.101.150.210]:11133 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1ipbNS-00034p-DC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 12:13:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN9I+aq2StGhD+1HM2EJx/HluSUpEwI5yIrJl8ahJ7H3WYrb/iuXHfXqJriKiVO1ld6fyWarjamt4zw9ZU2ogu1BQlGB6EIojD/7GNhqE2AAPSX6sPUW8g0s7Y7O9KbGW3YM1EAILElRVxpwECfU9E4X1QwHOFJTEL4rB6eMfJMctxgwoYAWn6zHqTsPTYtbaQvY5QlkOm4udhU25qYoxsv2VKlbB8cL1H0xUfDkK7BKMEecJRik6P5ckqy7Dj5NmJWxOVNp/aeJZXhLFVXLYDEtyRgt8iZMxDyih4XDqSyScOIzeyoU2Uo7+U1AQdoqKOjZYM5JcLW4TPk33eA1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDXfIWENsq61wHUDPg4311OrUe8PJBK0gpnxG4yQWy0=;
 b=H04+4deL7nZyG13bbcASo7m1tHcYjbm7YJuKKBSC/HdXH8LzZHuZEI9ijzeUYXcTeYhlzuCwG+bGcR8YiDFnhQOOxjbMjdxJycD6aJMyOUvEHtRCq5QL294p50nhwz35snp02AuHiezyDc33kNnW+9ThGAiFgf9hdPTrVKqDouZg43vroWpRtoaDOoAqJZBPT3ecZg/QTd/4oOCNdtjFsB/TUsGIdt5dH09OQQXtIyYLJWKrINuzURbfoGdY2Uj5jAR1OWkfYFPkf37MzhQ3Y7xjMMgy/O/ZKpgdGxQhFEH6A5jXvj4uzI8CJG18SXBye5vI1zSLGPA5Xzy0G7T1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDXfIWENsq61wHUDPg4311OrUe8PJBK0gpnxG4yQWy0=;
 b=cxnfDd3Gc3t8PF2vkQenx/p/Q4wH+/UcuHiFBgXmgdRIcd8ZvHgHmltfEK+hTJijCgYFY4C103cyQcub83JP6pj2Gq+SuZBc7f3KkvQCD8pIMQ5xTwQABxW9llZB6K7Qsl96XLYtpfG6Nms/eh0aR2b0d4/fwhFyZCG9Ls1lsUM=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB3071.eurprd08.prod.outlook.com (52.133.15.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 17:13:35 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 17:13:35 +0000
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1PR0102CA0025.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Thu, 9 Jan 2020 17:13:34 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Topic: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Index: AQHVxityEM59bZyv8EecProoJvSi/6fiOPyAgAAFpACAAALigIAAARuAgAAKcgCAAAbbAIAAARGAgAAttACAAARsgIAADMmA
Date: Thu, 9 Jan 2020 17:13:35 +0000
Message-ID: <20200109171331.GA2291@rkaganb.sw.ru>
References: <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm> <87r208rdin.fsf@vitty.brq.redhat.com>
 <20200109132432.GD3147@rkaganb.sw.ru> <20200109132821.GG6795@work-vm>
 <20200109161156.GE3147@rkaganb.sw.ru> <20200109162745.GL6795@work-vm>
In-Reply-To: <20200109162745.GL6795@work-vm>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org,	jasowang@redhat.com, "Michael S. Tsirkin"
 <mst@redhat.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::38) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 632e15d0-a3c0-488f-4f2c-08d7952742c9
x-ms-traffictypediagnostic: VI1PR08MB3071:|VI1PR08MB3071:|VI1PR08MB3071:
x-microsoft-antispam-prvs: <VI1PR08MB3071E698DFA4D6B33422E710C9390@VI1PR08MB3071.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39850400004)(199004)(189003)(36756003)(86362001)(33656002)(6916009)(81156014)(4326008)(2906002)(81166006)(66556008)(66946007)(5660300002)(16526019)(186003)(8676002)(66476007)(66446008)(64756008)(8936002)(1076003)(52116002)(7696005)(54906003)(71200400001)(26005)(316002)(478600001)(6506007)(956004)(55016002)(9686003)(30126003);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3071;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkQ5an6zshpVmDvoUCUpdhz4M/xhZpoKuSpnkG6hJlwNwyBNOIHAOlf3PYeDhRIZvsU2BnCXYuQ4yoKEt3JZTRbzd3C8rJCWdocYE8d0YgaIcaFd+rZ9cbb/oQRV7y404HC5u8xhcGeAGMxeVKuqoq/8ZOzSxK2T+kFfUiaZUTcovIeL/GM7O138Zn50XgEWohcxpMNUnmUwjBOABtOexYrZZZRFSDAw1u94t1jL2zXEpM4lhTmfTU9VAvVj65Plr+O8RpuJgx9HnCRWMk4/xjWs6dBDwlyrpwid/GDTlHdO/XF5FHsNW8jOHMFg0gejX+8ZM76cTPW2AVHjEX9Tb5xlQhN8fnpLMXtWvMV6ZNNKuKwtlP9LNXZgqUX27XUFn4SUHpJfYo9cikFzINXpm+nyr1jqypHLNKCGMNUIXhUnHRqIYqkrhuXpewBGMbyrlg3UtQaHEfawSU1KS58c6GhYNvljUPNC7T87e6PcW6GAh8QIcweOwWLsYzbK0rYUhixGq9/lba7bz+XbWmanCfNb033wXfeVIbRQLq+Fo8+XuO7xWCnWaAgeYed5hk49xJlgF/0NgwwZdynY6BKsoRgkakkQ3YvFB0bVdTcOsI1DHX9SyTw3X+Dvu/3cvx06BAcRsJzp+Xd5LKX/9LmGFVsCYgLSMoQcXRf7NILvDBfEzb7+Rr3FqsVBVWyIldYb0/FDvEXyKY6WmA+sPAzjcQxgEQ/MpYrJHPLc6HdDV3JaTaNuyiaQok6x8RWV1iMdyglFGFDBruTro96uVDtJwA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DC7879A9EEE54479628270ECAA61002@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632e15d0-a3c0-488f-4f2c-08d7952742c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 17:13:35.4965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rr1owRjA4jEsCfjpTCbwC6ICKlm1+hPV0KhfyMHxlao2YXogPi9abyylqC3QQys3w8rAer0UNcErLPjv2AtEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3071
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.150.210
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

On Thu, Jan 09, 2020 at 04:27:45PM +0000, Dr. David Alan Gilbert wrote:
> * Roman Kagan (rkagan@virtuozzo.com) wrote:
> > On Thu, Jan 09, 2020 at 01:28:21PM +0000, Dr. David Alan Gilbert wrote:
> > > * Roman Kagan (rkagan@virtuozzo.com) wrote:
> > > > On Thu, Jan 09, 2020 at 02:00:00PM +0100, Vitaly Kuznetsov wrote:
> > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> > > > > 
> > > > > > And I think vhost-user will fail if you have too many sections - and
> > > > > > the 16 sections from synic I think will blow the slots available.
> > > > > >
> > > > > 
> > > > > SynIC is percpu, it will allocate two 4k pages for every vCPU the guest
> > > > > has so we're potentially looking at hundreds of such regions.
> > > > 
> > > > Indeed.
> > > > 
> > > > I think my original idea to implement overlay pages word-for-word to the
> > > > HyperV spec was a mistake, as it lead to fragmentation and memslot
> > > > waste.
> > > > 
> > > > I'll look into reworking it without actually mapping extra pages over
> > > > the existing RAM, but achieving overlay semantics by just shoving the
> > > > *content* of the "overlaid" memory somewhere.
> > > > 
> > > > That said, I haven't yet fully understood how the reported issue came
> > > > about, and thus whether the proposed approach would resolve it too.
> > > 
> > > The problem happens when we end up with:
> > > 
> > >  a)  0-512k  RAM
> > >  b)  512k +  synic
> > >  c)  570kish-640k  RAM
> > > 
> > > the page alignment code rounds
> > >   (a) to 0-2MB   - aligning to the hugepage it's in
> > >   (b) leaves as is
> > >   (c) aligns to 0-2MB
> > > 
> > >   it then tries to coalesce (c) and (a) and notices (b) got in the way
> > > and fails it.
> > 
> > I see, thanks.  The only bit I still haven't quite followed is how this
> > failure results in a quiet vhost malfunction rather than a refusal to
> > start vhost.
> 
> Because there's no way to fail in vhost_region_add_section other than to
> abort;
> 
>             if (mrs_gpa < prev_gpa_start) {
>                 error_report("%s:Section rounded to %"PRIx64
>                              " prior to previous %"PRIx64,
>                              __func__, mrs_gpa, prev_gpa_start);
>                 /* A way to cleanly fail here would be better */
>                 return;
>             }
> 
> > > Given the guest can put Synic anywhere I'm not sure that changing it's
> > > implementatino would help here.
> > 
> > There would be no (b) nor (separate) (c): synic would just refer to some
> > memory straight from (a), regardless of its paging granularity.
> 
> Oh, if it's actually memory from main RAM, then sure, but I guess you'd
> have to reserve that somehow to stop the OS using it.

It's up to the OS to use it.

> > > (And changing it's implementation would probably break migration
> > > compatibility).
> > 
> > I'm afraid I see no better option.
> 
> Migration compatibility!

Hmm, good point!

I think I should be able to achieve that, by keeping the current scheme
of allocating a one-page RAM memory region for every synic page, but,
instead of mapping it on top of the general RAM, swap the content with
the page being "overlaid".  Let me see if it works out (and hope the
QEMU gang won't shoot me for such an (ab)use of memory regions).

Thanks,
Roman.

