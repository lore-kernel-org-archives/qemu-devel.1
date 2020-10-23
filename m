Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A0C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405AE2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405AE2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVnqS-0005bP-8u
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 23:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d0u9.su@outlook.com>)
 id 1kVnp6-0004Rs-7I
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:33:00 -0400
Received: from mail-oln040092003109.outbound.protection.outlook.com
 ([40.92.3.109]:64843 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d0u9.su@outlook.com>)
 id 1kVnp4-0003TJ-0u
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNkrkDmXQMEsyTyx2s9Pt7y69pID2t9Xgqef/IUlL8w7IE3PRrTbj5XKmMsbHKCDdCCux8zj/c7IyK/wfuDoYJmNwqWV555LjjREvjlj9BhTIu215k2BxYUU2PYVBIgErsXOd55iG8zmDmVTbn77DceoxCSnmc2InkRtt5L+hxvGTBG0UBELipj6LWPFoLj2WgS+pmofM+XhTu3KllVrUlZbVcx9lIrHMNsqBb7yBariSp1l0BuhefmbZIHekO1iIq/fbNBzMqtH8Q7+E5Dbs8j9oo8OWNwqReY6I7XNr1qi4+I3i9Se9QtlAAauLAd6YbLfqPZNrX/hvzyv5Kor+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeFVmVqOgarH9k3K0GuRqqRayBBl+USkStEGP0lDb/Q=;
 b=MbQgzFuDKfpKvDOBto1kvnhdUMKWBSVmJEgO4qErpD8/h5LUe4Dy//6d3sKfCAzj8Z0ThZAqGRmnyvetFEWfeNeKZe7v2Bhx8a0drrF3tdzXXDbHSQK8zLcUffO1pylTKFyhBOWmsIXy1CFErG3+CkvOsJESoPOv0OwbJEZl1H0EG2xH/OeALkj4dtJTdy4bj0iXh/vPzO6xDQ2+C5kn5sTdVg5+kWnbahURVYXAdS9aL5qLhJ28ySCSis2pf19IQOzeZgmJqsvRo+i/bI8fB3zBmrXoj0LTOTp1PgITbPpLm4+yzC1sgVjGlNa/wtDObOw4QzmPPTDpGaiVzkhPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeFVmVqOgarH9k3K0GuRqqRayBBl+USkStEGP0lDb/Q=;
 b=hBWwqMP65jwAStDymEVFBYoaVGJJ88HDZ4HAG3mesReoI97YlVgPS52lG22AyRVTnUPpilP/Ftfo0rsSk2N9MimC9Qd2MEQF3ycTW3Y5g3NZqAK5Lk7xV34/2/vUleIHijRJox5ga24YIPy5UbIYKIUhWqgv5C7vSFEpe7YSmqpUI9jmlRk8OHii3DT/jWjWvBDVurgM16mHpr8q1yWgSkgRI6IeEhzLVlOAzLnZceM6sYMrXGRoVz0DF2NCNF4WJK/WaLmMRSZKx0FbRYvyltTCgpu5v4ngf4UCr2qwpyEnGmexLsmGMBbGC0cFjphhr5wEIGZlUrxtY0Coam5E8Q==
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (10.152.76.57) by BL2NAM02HT011.eop-nam02.prod.protection.outlook.com
 (10.152.76.150) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.20; Fri, 23 Oct
 2020 03:32:56 +0000
Received: from BYAPR11MB2664.namprd11.prod.outlook.com
 (2a01:111:e400:7e46::40) by BL2NAM02FT008.mail.protection.outlook.com
 (2a01:111:e400:7e46::162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.20 via Frontend
 Transport; Fri, 23 Oct 2020 03:32:56 +0000
Received: from BYAPR11MB2664.namprd11.prod.outlook.com
 ([fe80::2164:d6ba:9ca3:3090]) by BYAPR11MB2664.namprd11.prod.outlook.com
 ([fe80::2164:d6ba:9ca3:3090%4]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 03:32:56 +0000
From: Douglas Su <d0u9.su@outlook.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: Enable MSI-X support in PCIe device.
Thread-Topic: Enable MSI-X support in PCIe device.
Thread-Index: AQHWqOtsbiQu9ZKUjUCwfcsDfQs23w==
Date: Fri, 23 Oct 2020 03:32:56 +0000
Message-ID: <BYAPR11MB26641AF7375C0C2A2652D8C8EC1A0@BYAPR11MB2664.namprd11.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:57E16DD4C35B7B81D3BB9D0386FF3846D490811F223B847FA206FE828CD220C5;
 UpperCasedChecksum:F88637CF33E8F5739FD01D2853158A2AEAB9DDE53060B7564844CFBF01AADF32;
 SizeAsReceived:6585; Count:41
x-tmn: [j9MLQN3/+UJraKfXsHZsaL24HFISIdiy]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a561cf2a-9497-4ead-dfea-08d877045504
x-ms-traffictypediagnostic: BL2NAM02HT011:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wCa1rw0jORDlIAGcsf66u6Tt+j+nIiQ83hfN93Xn7qg+HGefTvKXMwIXYBf194cDUPGE7MyLTc4ffOYS21ZhPVPGbFZVoJzKm3EAGJ41fu0/E01c6u1H8kbtN4AxozV483hWlUnuUaTXiIFbWwGjvLsXR5Mpn65gp6wuuIg79rRlZfRLPQKg3f9q/aHFN7rslyqcQR0VTLLXZB7XjmLvA==
x-ms-exchange-antispam-messagedata: 35AMauq2yYfIFdfrccrKpfQo9I8/93dxXTO8u9/nr3VbgSCO8w5ncXGfz8Dvk8ID1PPaEZ2HX5TWB3HmRd/UPloUElx9UISEDePG49UKmZNoBygQatJDuRyVoAFLgYgW558zrDD1ycQvs0imruK9Gw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a561cf2a-9497-4ead-dfea-08d877045504
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 03:32:56.2602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT011
Received-SPF: pass client-ip=40.92.3.109; envelope-from=d0u9.su@outlook.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 23:32:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To use MSI-X interrupt in my PCIe device, In realize() function I make a MS=
IX initialization like this:=0A=
=0A=
#define MYDEV_MSIX_VEC_NUM 5=0A=
=0A=
void realize() {=0A=
    memory_region_init(&mydev->msix, OBJECT(edu), "mydev-msix",=0A=
                       MYDEV_MSIX_SIZE);=0A=
    pci_register_bar(pdev, MYDEV_MSIX_IDX,=0A=
                     PCI_BASE_ADDRESS_SPACE_MEMORY, &mydev->msix);=0A=
=0A=
    rv =3D msix_init(pdev, MYDEV_MSIX_VEC_NUM,=0A=
                   &edu->msix, MYDEV_MSIX_IDX, MYDEV_MSIX_TABLE,=0A=
                   &edu->msix, MYDEV_MSIX_IDX, MYDEV_MSIX_PBA,=0A=
                   0, errp);=0A=
}=0A=
=0A=
After this, a simple logic is added  to trigger interrupt by writing comman=
d to a specific BAR0 address.=0A=
=0A=
void trigger() {=0A=
    msix_notify(pdev, 1);         // send vector 1 to msix=0A=
}=0A=
=0A=
In the OS driver, MSIX is enabled via `pci_alloc_irq_vectors()`, which is d=
etailed in Linux Kernel's documentation `Documentation/PCI/msi-howto.rst` (=
I use kernel 5.7).=0A=
=0A=
It is correct to obtain the number of vector from that function but failed =
to receive interrupt from device. The IRQ, which is returned from `pci_irq_=
vector`, is registered via `request_irq()` in the deriver.=0A=
=0A=
Can anyone give a clue?=0A=

