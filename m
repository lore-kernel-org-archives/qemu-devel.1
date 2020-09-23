Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0936CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3407E2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PoqojON6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3407E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL96g-0005yh-3t
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kL94F-0004t2-DX
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:00:35 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com
 ([40.107.237.80]:10081 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kL94C-0005QE-N9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvK6OB+/xlDnWwmBq0zWnLODg9YsRoUQfjnvjfqsHJY8O9/UmSTG/38v0s16mGkw9LgPqaxj/oWbovdZ906udUs8Fn5l3mDl0rpL01pDj5CjRLHNeSdIHH7m7cTXEUuaWrTChW1Z2gwCO1MN5MRTHyOUnz9NHnIHvaGOjJ83MCOFxgEJ0a17nK+IiQnwk8SJWS78/yQ3bzW4NNcxtxaUwmEfpSrkKLbs5WqOcghV1/LznTl2V+t9VpQa5pYvbhq/R7STukK2Xb7NOWkgi77WSbSO5yxbHw9AQDLX2DMMYshHSWGFE53CXaNQMWjgSVtrdZr/z67ZWYgo3JO4rHFInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMoidshf0656gCJsv8BW3Y+VafNsWKc5HDyf1r1jQUY=;
 b=bYfdVE+dW0apInTGdvEA3+jYgYD6fHDbCdrqSMC0dDDUQVnXRAbHjNsI01TqbGIlIb+/ywTRvlhSFHY+dc4aNdIbzIuRJksf1wREIPV43IiVteh+YP0YzRiU/TLY7Aod6359RWPw04NivrLbglej/0Gr1oP7oJW1MvP1xU9AzHRki2aELieQoTdhxWciTy0sD+k2kVNhWAbRm7EsZ2hcaGo0ekc23lR+2prcm3SAtmLbkNC0IaTApJ0PkaEdMj5mz9cn9NIyirL78a5trrTKyAagvHfQHSyRV0KH/GetfBtKOi0/H9xxrihWZ4UMSpq17+dl/aJ8Kp1hF3z3wdFCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMoidshf0656gCJsv8BW3Y+VafNsWKc5HDyf1r1jQUY=;
 b=PoqojON69XMK9e10YzUIDMfclLykuFVIQT419diLq/kYHMsZ2YAjOQcrsQgxxN3OnLzBNgbMtj11oKFsy0/olDKe2o07x9ioBrN8poyYiDUDBe2ZUDmk6vwT6msOh4pS/kKfvvo5rCmWrgYFnzf3gfVCfBdmq0N9Gs8xUI/J3R8=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5895.namprd02.prod.outlook.com (2603:10b6:a03:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 17:45:28 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 17:45:26 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v8 3/7] usb/hcd-xhci: Split pci wrapper for xhci base model
Thread-Topic: [PATCH v8 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
 model
Thread-Index: AQHWkOLKk1Cu3IDKWEiZvWkxL9ktaal2At4AgAB25VA=
Date: Wed, 23 Sep 2020 17:45:26 +0000
Message-ID: <BY5PR02MB67721C6F6152DBA2AD4E3663CA380@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600780837-8231-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200923101428.zilaxig5yi5u45rn@sirius.home.kraxel.org>
In-Reply-To: <20200923101428.zilaxig5yi5u45rn@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5f583b2-e44f-438c-f64f-08d85fe874a4
x-ms-traffictypediagnostic: BYAPR02MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB58952358D046C13954EF82A8CA380@BYAPR02MB5895.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1S3KClY/f/EP2oxT6p41IG3bRIuPnPiDYu/pbW0N/ranmr0Jgoi33d2Cvw3M4mQEmse6sGkkHGZutEgvZLiZQo7W8yitySKDytI1iMQ1XhON0FpIufkomZ1zTLrm077lhh7CrSmz9kr0XrLbatzD7/Ve/RsC2W3xXyGjw71I6/wSeh9SRHHz1/zuRanrnXplTzQ7R1oU2ML0K2vx8B5KTnjm73++hfJAegtPKpIb5IwJBmY6uxDVnGLnabU6kjckxZTgexWBT/wDyWt7QWr32f4NXltaNdHxLec7oAflAbJ5TGEIOV6I0mDTMhP+dtYv6I+c6MDpkp1abeZsEkGQJXsnR/DBsVr7Y3d10o2knHU7d6UmVoLKh91Q//BrayL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(8936002)(83380400001)(316002)(52536014)(9686003)(2906002)(186003)(7416002)(55016002)(54906003)(76116006)(5660300002)(86362001)(33656002)(66556008)(66446008)(6506007)(64756008)(7696005)(8676002)(66476007)(71200400001)(4326008)(26005)(53546011)(66946007)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5Cj+YGWQTc8ejD8wnjFKROBV/SZLVcVxeLnmZk48mepmIMKhvWztO0eNHcKtwgbETLtjvNKRuBRf41HaweQ5lV/+v9oU9UfMl1kVGoPOuilqYP4UCwrrVtbrRkEUgadIEZ8tPpW2Zj9OLdP5dwcgTbreznJUwiw0klJZR+usKupI9Bd0YonJb49XZLg89dcW+wzN4Sg/cNxFeX86H+cp/DOYuquh2F6hpgFCIwx3qJcFUB8c+F2FdCMLD1/HwpqyXXSRzmRd6VCIm1t5BdOaA2bfUhskoiO0JElLKNGyMCPc79c9zBvTFZ4Bpg60H22/9OElc87ui1cDicFwEEQqLBxrez2hgGiGM6gvhPTuEp2+6xfjAc6dnccixHglCSgShxD0dZY5mbQT7JfEwuGKfuBJVuPla/MpLBn5/2mV7cMvhSiXAsdsGAd47ocKHRpiePHTOOW6Sal1aFJH+a68hFbSvi1u59xFkKz/E/ynyBVl/SAsdJvRvxnKRNb3CuMqsorYYxQGpKaKDhJkB1YufOA/yUpmLsaYnE5+YPTTAm6oMcMtlc+Jw1fpIoQS8Oqv9O4aiwPkI22Uf8mAYSZyH0ajT3kiy2v027oD+byZ5lFQrk48eU0eQVTmc7q44SudCemC414X/MwuETqei5JGHA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f583b2-e44f-438c-f64f-08d85fe874a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 17:45:26.6168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxA6DVZyA3taZF3FNJfES/FPBrTs2iOkgiEqjyV2FsAjMYyajT7dwEGB4Wal/5HQx8aiqm+Sr4ycWJo8y3hVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5895
Received-SPF: pass client-ip=40.107.237.80; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 13:46:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Wednesday, September 23, 2020 3:44 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Edgar Iglesias <edgari@xilinx.com>; Francisco Eduardo Iglesias
> <figlesia@xilinx.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; Eduardo Habkost <ehabkost@redhat.com>;
> Ying Fang <fangying1@huawei.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>; Sai Pavan Boddu
> <saipava@xilinx.com>
> Subject: Re: [PATCH v8 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
> model
>=20
>   Hi,
>=20
> > This patch sets the base to use xhci as sysbus model, for which pci
> > specific hooks are moved to hcd-xhci-pci.c. As a part of this
> > requirment msi/msix interrupts handling is moved under XHCIPCIState.
> > Made required changes for qemu-xhci-nec.
>=20
> Progress.  vmstate loads fine ;)
>=20
> Does not work though.  usb-tablet stops working after migration :(
>=20
> > @@ -3561,11 +3458,7 @@ static int usb_xhci_post_load(void *opaque, int
> version_id)
> >      }
> >
> >      for (intr =3D 0; intr < xhci->numintrs; intr++) {
> > -        if (xhci->intr[intr].msix_used) {
> > -            msix_vector_use(pci_dev, intr);
> > -        } else {
> > -            msix_vector_unuse(pci_dev, intr);
> > -        }
> > +        xhci_intr_update(xhci, intr);
> >      }
> >
> >      return 0;
>=20
> I suspect this is the problem.  I guess we should add usb_xhci_post_load_=
pci
> + usb_xhci_post_load_sysbus and move irq handling to these functions.
[Sai Pavan Boddu] I would create vmstate_post_load callbacks in xhci-core, =
which could implement post_load functionality in their respective files.
I will be sending V9 now.
Can you also provide any steps to test vmstate migration ?

Regards,
Sai Pavan
>=20
> take care,
>   Gerd


