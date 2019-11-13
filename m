Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AABFC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F3520818
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pcjyo9VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F3520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUpFw-0002r2-6I
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1iUpFG-0002KW-EI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1iUpFE-0001tT-Ju
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:47:26 -0500
Received: from mail-bgr052101131092.outbound.protection.outlook.com
 ([52.101.131.92]:59470 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1iUpFD-0001ru-Od
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:47:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dll9iQrqB5wtuUOm69VTYtGM2Pp0zK0jiD7awj7W6dG61eMrpLd5EWo5sHC793sUMQcHatVXCvCQl7MbCZfTecsDI00MV0Ni1b8zB34OaVktj+h6db4qS4HjV2QytrbiJmUaUOWDcxp5d+C6VNtnkhXeBIrfrMtWg2slFRx+1x3wE0MQksz+F4n2nsqAK0qwsDW33PqSBLJ4ObF+fU1vGIoQ3uxfN5DuH22FnsiZ1zruB1kO08FaF5uR/JP7hweD4VZjQWWdfFgu8Y0yYQ5X6XjDIC2RFo9QyBwXKbyTcaCVJA7iFiUVzQQqZRSjMli7sVqIRRAById+uW7dInVE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuJNqEKImry9VsRvZg6ctJ0Uqpoz1Qio/IQW3eYZeDE=;
 b=mTW63LC4w/08on/expfN7diHrGqFlwZqf4Y515/gC/ELHInm/FAurOtgZmUrUFzcCPF+tv9sx1wnGBS17dq2e2VorWN6kUhO3sEFXi5/ETTNHPMR+71U+5tB+jTyUZEBYRP1zObfsY/0qOrK/5tAw1KF2FEEsTr3phKd59uoa6r5CTc7TwJ1sfNWzZr4YSnHvopSyiaBmeeFU1JLrLIen8vS9tt4pWeFy4l1PAgdD3HSHsAcwauTNHnU1E+PHqGwYrjBXYLsEXSQWdMj9Ej1IvmHTV7R0Bmqy1iFi7t+2kEsoyk9S4uEUyuo/YUjIJ0yXwJnx03sLCZkEf0oTBo/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuJNqEKImry9VsRvZg6ctJ0Uqpoz1Qio/IQW3eYZeDE=;
 b=pcjyo9VKLxp+DDkm9JMoSLnc40cRkxcKtcv/aiPy/0gD5T8QE6cX05An5Be1nyg61ZHnNYm6TEv6ZXCxco2Wyjz1KvceLsj3EMYvCQHpY+FlAoKEl9OspFOjrmYYn/SpV7F8w+TC6lBstIsuv2wU1rELUSXP4pecj4i8/LBYTJo=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB3856.eurprd08.prod.outlook.com (20.178.81.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 09:47:20 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::9465:ec66:befb:e8b5]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::9465:ec66:befb:e8b5%3]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 09:47:20 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH V4] target/i386/kvm: Add Hyper-V direct tlb flush support
Thread-Topic: [PATCH V4] target/i386/kvm: Add Hyper-V direct tlb flush support
Thread-Index: AQHVmQooMjAMF4hMsk+z5W7t6cZOKaeHnsGAgAE4ugCAAAUaAA==
Date: Wed, 13 Nov 2019 09:47:19 +0000
Message-ID: <20191113094716.GA57998@rkaganb.sw.ru>
References: <20191112033427.7204-1-Tianyu.Lan@microsoft.com>
 <20191112144943.GD2397@rkaganb.sw.ru> <87eeycktur.fsf@vitty.brq.redhat.com>
In-Reply-To: <87eeycktur.fsf@vitty.brq.redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vitaly Kuznetsov
 <vkuznets@redhat.com>,	"lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,	"rth@twiddle.net"
 <rth@twiddle.net>,	"ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,	Tianyu Lan
 <Tianyu.Lan@microsoft.com>,	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e72a2892-6eeb-4454-d079-08d7681e79bd
x-ms-traffictypediagnostic: VI1PR08MB3856:
x-microsoft-antispam-prvs: <VI1PR08MB3856EDE137DCF2AED23FB438C9760@VI1PR08MB3856.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(346002)(39840400004)(136003)(366004)(376002)(396003)(199004)(189003)(54094003)(71190400001)(6246003)(71200400001)(386003)(26005)(1076003)(6436002)(6486002)(6506007)(66446008)(64756008)(66476007)(66946007)(6116002)(3846002)(66556008)(5660300002)(58126008)(66066001)(316002)(86362001)(99286004)(54906003)(33656002)(6916009)(36756003)(4326008)(52116002)(478600001)(25786009)(14454004)(7736002)(305945005)(11346002)(446003)(6512007)(9686003)(2906002)(102836004)(186003)(229853002)(8676002)(8936002)(476003)(486006)(76176011)(81156014)(81166006)(256004)(14444005)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3856;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-transport-forked: True
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FcX5gGQjuxE291ov9yGODd6iSNQr/bRrC4rfL1R5bIChe07eQEjNJD5cyjK7nNn5aephmndvVkmAWQyyNtADMpMkI6VTp9uuB/mu+qo43LA7K4waH1AvzJX8loKqu4/uZEfFSmDCNSwy0AMPk186YwIc+Vrxgwk3abjIi9qJzOzqUV6y8rMKA0utwPTgAz5P4tidoLfTpr+8tZMlh2dBWsj/ljt+5zWl+jzOvySnerb4OLFMkQ5GbxVtG/MB8hSlNg0uWPuMy0EzwchTLId3Cmsr61rYocgNUJUW2xxIxQfckDlD+rf+TYz/EnYCNzPu2rdziXqiEIb/7yGNbnzMqwDAkGUc2yIDJ344fZM4yQcvNBm03G4s2YmR+CHxbUgI
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1091FA2C9698344088F3D49BC33E02D9@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72a2892-6eeb-4454-d079-08d7681e79bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 09:47:20.0362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TA3XZ2yHzT0on4wa6jOgA5M1umuvhOjP5RSNMJ8+CavRfQqHHwiItaeVnu7mifnyM3osgMgSczAykpzlNtWU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3856
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.131.92
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 10:29:00AM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> > On Tue, Nov 12, 2019 at 11:34:27AM +0800, lantianyu1986@gmail.com wrote:
> >> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >> 
> >> Hyper-V direct tlb flush targets KVM on Hyper-V guest.
> >> Enable direct TLB flush for its guests meaning that TLB
> >> flush hypercalls are handled by Level 0 hypervisor (Hyper-V)
> >> bypassing KVM in Level 1. Due to the different ABI for hypercall
> >> parameters between Hyper-V and KVM, KVM capabilities should be
> >> hidden when enable Hyper-V direct tlb flush otherwise KVM
> >> hypercalls may be intercepted by Hyper-V. Add new parameter
> >> "hv-direct-tlbflush". Check expose_kvm and Hyper-V tlb flush
> >> capability status before enabling the feature.
> >> 
> >> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >> ---
> >> Change since v3:
> >>        - Fix logic of Hyper-V passthrough mode with direct
> >>        tlb flush.
> >> 
> >> Change sicne v2:
> >>        - Update new feature description and name.
> >>        - Change failure print log.
> >> 
> >> Change since v1:
> >>        - Add direct tlb flush's Hyper-V property and use
> >>        hv_cpuid_check_and_set() to check the dependency of tlbflush
> >>        feature.
> >>        - Make new feature work with Hyper-V passthrough mode.
> >> ---
> >>  docs/hyperv.txt   | 10 ++++++++++
> >>  target/i386/cpu.c |  2 ++
> >>  target/i386/cpu.h |  1 +
> >>  target/i386/kvm.c | 24 ++++++++++++++++++++++++
> >>  4 files changed, 37 insertions(+)
> >> 
> >> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> >> index 8fdf25c829..140a5c7e44 100644
> >> --- a/docs/hyperv.txt
> >> +++ b/docs/hyperv.txt
> >> @@ -184,6 +184,16 @@ enabled.
> >>  
> >>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
> >>  
> >> +3.18. hv-direct-tlbflush
> >> +=======================
> >> +Enable direct TLB flush for KVM when it is running as a nested
> >> +hypervisor on top Hyper-V. When enabled, TLB flush hypercalls from L2
> >> +guests are being passed through to L0 (Hyper-V) for handling. Due to ABI
> >> +differences between Hyper-V and KVM hypercalls, L2 guests will not be
> >> +able to issue KVM hypercalls (as those could be mishanled by L0
> >> +Hyper-V), this requires KVM hypervisor signature to be hidden.
> >
> > On a second thought, I wonder if this is the only conflict we have.
> >
> > In KVM, kvm_emulate_hypercall, when sees Hyper-V hypercalls enabled,
> > just calls kvm_hv_hypercall and returns.  I.e. once the userspace
> > enables Hyper-V hypercalls (which QEMU does when any of hv_* flags is
> > given), KVM treats *all* hypercalls as Hyper-V ones and handles *no* KVM
> > hypercalls.
> 
> Yes, but only after guest enables Hyper-V hypercalls by writing to
> HV_X64_MSR_HYPERCALL. E.g. if you run a Linux guest and add a couple
> hv_* flags on the QEMU command line the guest will still be able to use
> KVM hypercalls normally becase Linux won't enable Hyper-V hypercall
> page.

Ah, you're right.  There's no conflict indeed, the guest makes
deliberate choice which hypercall ABI to use.

Then QEMU (or KVM on its own?) should only activate this flag in evmcs
if it sees that the guest has enabled Hyper-V hypercalls.  No need to
hide KVM signature.

Roman.

