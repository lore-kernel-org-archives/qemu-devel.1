Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6545B20700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hBP//5t+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6545B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuzL-000855-40
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iMulm-0006aN-F0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iMulk-0001TQ-7j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:04:18 -0400
Received: from mail-eopbgr790137.outbound.protection.outlook.com
 ([40.107.79.137]:22737 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1iMulg-0001R5-UT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:04:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/UZglFXOACAzzTLbEzJb5v6DW4Ffh7HPvYqhlW+P/CI4XvDZW+uorlTjgn8hQZxU2NaINFQWbxYkUXDOF++SnG7Qu9RlUcNMe9hS/FNVFwpcLTGUBz91FwWZ53A9pmAJ2XxIq1xujQFTPry9BYCdM3ID4ohjxKbuDv2Af8fyaUqyX2fEJU5DlsbJF3minq6BR0WPjab4QFGkjuV4mgilGRj4zNckeXRplQWHDr5xbM9ouLFZKYgDn5OSZSqjYdnDUVA/EjQ6xgRjnmCIvJFcZbB2LS4mpl3wOp3OES6Q9xlC/IB0yOLpu6Cw9xw0K8zhxGCQQ79G++dpzv20t5ehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2jBDyaRtnGCCoDiUJg5tCU29pGGkDV2BOffIq0Lr10=;
 b=QBRlpWYPapUF5saA3/FzAj7amReu7bPC/WOm/t+Ea7ErcOwPNpenGoDVZCCJO1lboIrc1vsLIKTcxyA79V4BlQBgtyYTiF52jEZ7KVPE2ifUnYdDoW6UQGMgmFK8a5TP6if0NwEEp9ibZiqjUaiwO1hUd2NgBg6s628NUnw8PfIipgL8xjXMJUt/d6o4/5JqdFly0E7J3sXIoCDOYpZ0fyjAykQD9QHgWNQCpfkUbEpYKfZgQvkR7MWQEsY6wlL+y1ZyQM0qDOCGlolVkZLb/nASHvp3MWxTYyN27DBvQT99bbPeSW1xbAua4L83sOHddE8vqhsQkBF9/VvaXf2lgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2jBDyaRtnGCCoDiUJg5tCU29pGGkDV2BOffIq0Lr10=;
 b=hBP//5t+eJhbzzvyarh8IgHe8kiHclHeENp2cDPnSZN82JHN/120NpFm6uH64riWdCGxewJuROXjQUYTWtKaqAsmT7h+evbUKtrJukHT/l9kFcknl003QjMpVNgvAQ0fVvwqmVlpvAntyOyqSU7dYedKDBVuvxVDEv2kbECrUXA=
Received: from DM6PR01MB6027.prod.exchangelabs.com (52.132.249.89) by
 DM6PR01MB5404.prod.exchangelabs.com (20.179.55.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 22 Oct 2019 14:04:08 +0000
Received: from DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60]) by DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60%7]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 14:04:08 +0000
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cota@braap.org"
 <cota@braap.org>, "peter.puhov@futurewei.com" <peter.puhov@futurewei.com>,
 "robert.foley@futurewei.com" <robert.foley@futurewei.com>
Subject: Re: [PATCH  v6 37/54] plugin: expand the plugin_init function to
 include an info block
Thread-Topic: [PATCH  v6 37/54] plugin: expand the plugin_init function to
 include an info block
Thread-Index: AQHVhO5ZtkD22KgDqEOJovKpMAx4f6dgiJEAgAAGPgCABipfgA==
Date: Tue, 22 Oct 2019 14:04:08 +0000
Message-ID: <20191022140347.GF42857@RDU-FVFX20TUHV2H>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
 <20191017131615.19660-38-alex.bennee@linaro.org>
 <20191018153214.GE42857@RDU-FVFX20TUHV2H> <87wod2nj5x.fsf@linaro.org>
In-Reply-To: <87wod2nj5x.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:903:101::13) To DM6PR01MB6027.prod.exchangelabs.com
 (2603:10b6:5:1da::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d690d347-53c9-4f14-db66-08d756f8b4c6
x-ms-traffictypediagnostic: DM6PR01MB5404:
x-microsoft-antispam-prvs: <DM6PR01MB5404905EDED06BE96DB7B51B8A680@DM6PR01MB5404.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(7916004)(136003)(346002)(366004)(376002)(396003)(39840400004)(189003)(54094003)(199004)(4326008)(3846002)(6436002)(102836004)(478600001)(316002)(256004)(14444005)(5660300002)(8676002)(6916009)(229853002)(66066001)(81156014)(9686003)(81166006)(6512007)(6486002)(52116002)(33656002)(99286004)(2906002)(6116002)(71200400001)(71190400001)(8936002)(86362001)(66446008)(25786009)(1076003)(76176011)(66574012)(54906003)(6246003)(14454004)(476003)(446003)(11346002)(386003)(66556008)(6506007)(64756008)(33716001)(66476007)(186003)(486006)(26005)(7736002)(66946007)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB5404;
 H:DM6PR01MB6027.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eLgfqX7N5ZtYHVXXHF9es5iHMWrCNgQT9Il1Sg2W+HFsrS785tqD5eJSuK8CpCeqP5EI/1gFPUA1P+AryfAbWfePy5TeCUKyx0dtYFwLcGgEcZg420dKHteHpEHII2hQIXXRdDr4ufUb2xtp8qAcQnhQPc0I6Yqa3DyEdm1NXmwuOfLlexrcuDHLURPjxHhR3197CIKOKj810TKbY4aiXK2355qbI6T7EGA4u4mDkr2LokPduZahG23ksmikhgWqt+aqPkb/yvlCXr45/qLk2NU6kwedX3PLVqWJRnpnyc//NYh7um/iqMJYwPt8pPDnby/W7UbkjgsPfyjmrRdg50IZ5cQZ9Gcch4UVyFiWAZFdllXQ68fJ9os/EziEhAzkrkGFM2gfVCeHWYX6Mqe6dOUb3aTC7AmW/7qXg3NGhbkTCz1cnh3qUcn/x94ws5H
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <81118864C785D94BABBA338CA07EFB74@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d690d347-53c9-4f14-db66-08d756f8b4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 14:04:08.2163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLg3n0zvPs9Xi+e4YG3KGz6Lxbrr6TnaR64jAN/TWUP8s6Uba0CC9eY9HXigrbiuz7z+jMMuUY/0OIJW1VvYP2HqOz+TsT+Qpzyp851FpLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5404
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.137
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Oct 18 16:54, Alex Benn=E9e wrote:
>=20
> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
>=20
> > On Oct 17 14:15, Alex Benn=E9e wrote:
> >> +    const char *target_name;
> >> +    /* is this a full system emulation? */
> >> +    bool system_emulation;
> >
> > It seems that 'system_emulation' is meant primarily in opposition to
> > user-mode. I'm wondering if this could/should this be an enum of the
> > execution mode being used to allow for future expansion? Or, if your
> > intention here is mostly to allow the user to detect when the *_vcpus
> > variables are valid, could it be renamed or commented differently to
> > make that link more clear?
>=20
> The only other operating mode that's ever been mooted is softmmu-user
> (and no implementation has been done so far). Even then I don't think
> that is a distinction that should be reported to the plugin as we are
> trying not to leak implementation details.
>=20
> But yes the practical upshot is for system emulation you at least have
> sort of bounded size for how many threads you may have running.

Fair enough. My fear was that any other operating modes might require
different plugin behavior, but it sounds like you think that unlikely.
If we're attempting to keep the implementation details hidden, should we
name this variable in terms of what it means for plugin implementations
instead of what it means for QEMU? (Not sure this is a winner, but maybe
something like "hardware_threading_model" )

> >> +    info->target_name =3D TARGET_NAME;
> >> +#ifndef CONFIG_USER_ONLY
> >> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> >> +    info->system_emulation =3D true;
> >> +    info->system.smp_vcpus =3D ms->smp.cpus;
> >> +    info->system.max_vcpus =3D ms->smp.max_cpus;
> >> +#else
> >> +    info->system_emulation =3D false;
> >
> > Thinking "out loud" here - I wonder if it would be helpful to set the
> > *_vcpus variables even for user mode here. It might allow unconditional
> > allocation of "per-cpu" structures that the plugin might need - without
> > first needing to check whether the *_vcpus variables were valid.
>=20
> but what too? It would certainly be wrong because any user-space process
> could create (and destroy) thousands of threads.

Hmm, right. To make sure I fully understand, does this mean that for
user-mode, `vcpu_index` in the callback function pointer type below is
actually the thread index?

typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
                                             unsigned int vcpu_index);

If so, do we have some max number of threads we support? I suppose we
could set max_vcpux to that number, and smp_cpus to 1, though I'm not
sure if that would be helpful or not.

> We could consider just asking plugins to deal with threads with their
> own __thread variables but in that case we'd need to expose some sort of
> thread exit/cleanup method so they can collect data from threads and
> safely place it somewhere else - but I suspect that is a hairy
> programming model to impose on plugins.
>=20
> So far all the example plugins have just used locks to serialise things
> and it's not been too bad. I guess we could do with an example that
> tries to use this information to get an idea of how grungy the interface
> is. Perhaps exposing the vCPUs at this point is pointless and we should
> just stick to TARGET_NAME for now?

I'm not sure. I liked the idea of exposing the vCPUs because it
theoretically allows you to allocate per-cpu things up front, which can
be helpful... but maybe forcing users to deal with dynamically
allocating everything will make for more resilient plugins anyway?

-Aaron

