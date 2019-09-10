Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E35BC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0542089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GpUt+bNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0542089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7iqG-0007wu-Ps
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@os.amperecomputing.com>) id 1i7ioY-0006SU-Ds
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1i7ioX-0006Mv-BJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:16:22 -0400
Received: from mail-dm3nam03on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::713]:9888
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1i7ioW-0006Lx-UV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:16:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLG+6oPySZD/vwgG2DI30q/mE80DzMvgikKOE89afCM6gbM0Ljp+P4NhMOpYSv2R+fwepFhcLV1dAHZaPuFtlTo/GGbXwEwPHQAQDHga1j5rsETT4kyVwcuOluZBjxdEMP/znmnaTqsU6FdG3MUidMJa2Zbmzz9MaGGHqDoyACkPtwFdw/auAZNaFDRMgfF3qHvD4u08OQh9RSNhjGC/9r7+iVfvLYXJq4SGTubJjT0xU40IEt7P09ex58MTqyU8ASSv4Ro/VDS2J5Q3hpz0nEg2hDNbcI8s7NDsb6AiRda8UNhdQnQi7NQ9nDvUhGG9Gq2byrlQco6xGdFEbSEKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK9NlP/z+C7vVBYC2HvNWTGbjjqEYvqjbuwIBy67BOc=;
 b=JGrqTKZ7XNONIZ0FKqKmcinJ2cBfZslZ3QE2xvpbtZlE/jml2US56JjEgWGXALsKCWc1MzsvMMPBlNckcYtnDi1lJoogLOjMx53JnjqYee9OKYY3a2llnmvwUt8eb5IBXraWlLn2FEMqTRIjoLYdbHvwAV84uiglRPIgazbxRcZHtedOn+cv4xysHG6HVR9WhDedJZUSlWCuaQfct+CIti4JZUiwF2LJ9YRmIR9tPpQEycuKbtsMg7ImLC6EDelpa/XNcWVq4+AmVwiXZ0jBEL4Kv7xcm9e9hQS3Y5gLWnzu93K9Z2eU3Z4vGbU85/fjzC9ETsbXYii3waVC/bK6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK9NlP/z+C7vVBYC2HvNWTGbjjqEYvqjbuwIBy67BOc=;
 b=GpUt+bNjK3j++wKbgqkZ3+drr/07IljIdj2OCVr95JKhPwDlX5Fmgb6uBkqVdjWP1b77a2DFFi0mIz1MomTTYasuPWcUZtIWwGDrkD55rRsDOFGjjUzhA1k3y9HPPASeJi/SFxXi3TxVD0J9kj+vVUiB1YX3PR0UyBgWv81BfmI=
Received: from DM6PR01MB6027.prod.exchangelabs.com (52.132.249.89) by
 DM6PR01MB5146.prod.exchangelabs.com (20.176.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Tue, 10 Sep 2019 16:16:16 +0000
Received: from DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::e15d:8a0d:11cc:cb95]) by DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::e15d:8a0d:11cc:cb95%7]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 16:16:16 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH  v4 00/54] plugins for TCG
Thread-Index: AQHVR7oKDi2UmAnU9ESAxN4sONh176blsS39gDmYj4CABgzzgA==
Date: Tue, 10 Sep 2019 16:16:16 +0000
Message-ID: <20190910161615.GA20976@quinoa.localdomain>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
In-Reply-To: <875zm5yzgq.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:903:102::29) To DM6PR01MB6027.prod.exchangelabs.com
 (2603:10b6:5:1da::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.190.6.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6fe4c1e-718f-45d8-8e7f-08d7360a34f6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB5146; 
x-ms-traffictypediagnostic: DM6PR01MB5146:
x-microsoft-antispam-prvs: <DM6PR01MB5146C52D474BAD48B2662F8D8AB60@DM6PR01MB5146.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(39840400004)(396003)(376002)(346002)(199004)(189003)(2906002)(66446008)(64756008)(256004)(305945005)(6436002)(1076003)(33656002)(66946007)(66556008)(7736002)(6512007)(9686003)(5660300002)(6116002)(66476007)(52116002)(8936002)(316002)(54906003)(561944003)(99286004)(8676002)(81156014)(81166006)(26005)(66066001)(76176011)(86362001)(6506007)(11346002)(446003)(486006)(476003)(102836004)(386003)(53936002)(3846002)(25786009)(4326008)(186003)(6246003)(478600001)(71190400001)(71200400001)(6916009)(14454004)(229853002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB5146;
 H:DM6PR01MB6027.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YgyiVhQ/2qlLnDXhqIb6EGsxoT2hoxrfY8NKNnr9lUMNKtGshg43pA51Jn5IEDLZlzOSIHHLdDUgFpqnhB+U2hNIqt+8cWsJI2+IU0Y1iP1ie6zmLfPSGZMZJG059rVxt8zjmCuyY5hZW1wAm4QmVlm7zhMgPGPbgvRXA84M7jo8IoX/RjlRKSsjhtCn0oa2l0Ji35rfkLKN6Ag88dmwzSIVzE+Nlov6+aNCvw4iLP5bXCDWDpamHhitrUllatJ47wuOIuQVjYoJ8WtvKfDFKHFdGzULt4Q5+7fr4C00If7ARwJTi+p+YnSQWeAjR13C9TntLj1RJUveOqa4yovCPs3S0ckFmQ+s1QzKH08dzEnyrrdB+DiJ1r2FmRaa3nhfKcTkAYEx7v/dp9a/wNGZGX9Z9AmZRVvOnWglztQFQPs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7B9F1D598F362C41BE55B25443DE1743@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fe4c1e-718f-45d8-8e7f-08d7360a34f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 16:16:16.5498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljxPjyd0r7VPIaIsy+uxqQ75gazJS/OdQeJ5cL52ODHOKelCneAD6TyeZPHa5n/cG5VLkmep6fdq08GVKoDvyFWuj5vKB4rOnVrOsYTAkns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5146
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::713
Subject: Re: [Qemu-devel] [PATCH  v4 00/54] plugins for TCG
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sep 06 20:52, Alex Benn=E9e wrote:
>=20
> Markus Armbruster <armbru@redhat.com> writes:
> > Please advise why TCG plugins don't undermine the GPL.  Any proposal to
> > add a plugin interface needs to do that.
>=20
> I'm not sure what we can say about this apart from "ask your lawyer".
> I'm certainly not proposing we add any sort of language about what
> should and shouldn't be allowed to use the plugin interface. I find it
> hard to see how anyone could argue code written to interface with the
> plugin API couldn't be considered a derived work.

I am not a lawyer, but I would not have expected software merely using a
well-defined API to be considered a derivative work of the software
defining it. Unless, of course, it is a derivative work of another
plugin using the same interface in a way that is not necessitated by the
structure of the API.

What's your reasoning for why it would be a derivative work? Is your
belief that the plugin API is complex enough that anything using it has
to be a derivative work, or something else?

That said, I'm not sure I understand in what way adding a plugin
interface would undermine the GPL, so maybe I'm missing the point.

-Aaron

