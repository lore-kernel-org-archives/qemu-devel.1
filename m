Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83814CA9EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1982084D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="K31UHUC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1982084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRjo2-0001rm-F1
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 16:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <parav@mellanox.com>) id 1iRjn8-0001O8-1L
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 16:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <parav@mellanox.com>) id 1iRjn5-0000vN-Mi
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 16:21:37 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com
 ([40.107.13.81]:54926 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <parav@mellanox.com>) id 1iRjn5-0000oB-4q
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 16:21:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhG/dj2OrmYiHzNXtmBG4KvyajAGXezuyEpMgHGiKVMIse9ODi4X5PTW2zfoAJ5UANqHLiAz9/sKgIpKI0HQThhD+/jSg/v6o3PLxCYly1SKbivdgwr0sWNzKBFh7ABMx05j7LmlU4tulKime4e88w6U+KtwSA9e01GYjbCGh0WIFHqjlg1ToMQi0bxsuN395W5RBnWyr/wO5n1hIWUWnDwtC75rocb15pdchAWlr/pAbIy0wrm4avXhzbg1N7st3tjVkDcGRLrHpZMnuEacP+9lVat94hqPH/OUc7km1zedqpZw+sOQMtfleZj4c+Ei/rdfT7jUFjuws1qBC3JJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQsSjQjwwiWXSudPMb89E7RlHGj1pszq6YjnBahUQ6Y=;
 b=hkWY9uweBTdZNmQVDHfld99IgFl07NPvlDaGtN3IxMsSsLMsZ+sgum4Hed0oBnqO30v1moQ61shHjGDKo3iFmjVthmWN4yzqqUIhIWImo1tq0v2hF7qnbTQZthY9cU+FU/wZb+LHYQXpYW3b+xpNVuHyLn82ubTfukdSh6NCNCeADWTohvHjZYurZi/FZ8Oaoy3oIeRe7nhwV9er8+vMLlTEsUDKp5sULWswfSu87+IGx5ppNwb5n95KwZGAm0ucXeLxoOS1KqA1Un1EPOmo3qhj1u2KjcE78ZG9Ak/dxDu7SBgkEvy87JUo/wGjNlCnV0WXP4cFcgJ2duWGqio8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQsSjQjwwiWXSudPMb89E7RlHGj1pszq6YjnBahUQ6Y=;
 b=K31UHUC8MG7HnHTcXJtqsBexXsebNYWoha5brM/ghdoULjcav+1PaFreDzbfQchLfLz+ElfrlvCf71d1Ew0+AivfmynY0321DxQGJFJmkEOjB3diZMnDncLEfED6DwEurKjWMFxNjCWo8YCrhAjtOU3QP6VvHkw4jvtVxCZL5LY=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4660.eurprd05.prod.outlook.com (52.133.55.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 21:21:29 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 21:21:29 +0000
From: Parav Pandit <parav@mellanox.com>
To: Jens Freimann <jfreimann@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v7 0/11] add failover feature for assigned network devices
Thread-Topic: [PATCH v7 0/11] add failover feature for assigned network devices
Thread-Index: AQHVjk7r70Gny9baC0GBsV+u3ndmZKd7jhhg
Date: Mon, 4 Nov 2019 21:21:29 +0000
Message-ID: <AM0PR05MB4866CE01B7FA661DD2463F1DD17F0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191029114905.6856-1-jfreimann@redhat.com>
In-Reply-To: <20191029114905.6856-1-jfreimann@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc481f62-5b3b-4a38-8df4-08d7616cf565
x-ms-traffictypediagnostic: AM0PR05MB4660:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR05MB46608373CA61021F399F082AD17F0@AM0PR05MB4660.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(13464003)(189003)(66446008)(7736002)(4326008)(66066001)(64756008)(66946007)(305945005)(2501003)(99286004)(66556008)(66476007)(9686003)(186003)(74316002)(3846002)(33656002)(6116002)(11346002)(476003)(2906002)(14444005)(256004)(5660300002)(486006)(86362001)(7416002)(14454004)(6246003)(229853002)(6436002)(25786009)(81166006)(8676002)(71190400001)(81156014)(71200400001)(446003)(52536014)(110136005)(76176011)(55016002)(7696005)(316002)(6506007)(102836004)(6306002)(76116006)(8936002)(54906003)(26005)(53546011)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB4660;
 H:AM0PR05MB4866.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ElFDNIdvA3RpOPFe/CiNO/tMN3zKNOxovM+wexN9r3NhYzOpAaQ5lcOFLPcjKtRLCKvs9Awmz2wW43UeZudXWybfboo1QumGf2csAaVKJrGZmtXdLjGT77uRduNNjx0TVsO1rY91/9UfeyQPV+tmUPzPwNoBkb+habuJBJrCPPYZvXZPxvcO2TlmdossuvfE/+MD8RS0gMW4ifm5ixbRMZ7mGpGTbYbJGG8WQQYFFxxTuIcwJZOh1+kEA2gNPe6JZEgV94Q5QZ0wxJS3uu0+qjWrU7SJeav+sXSAzPmBerzWPdqYuqVgslqf2/AJRR0+3Is5Vu+I2a8+H9GkAmKgEGK/tRFTpcJ37bnMht6w6z3Y6uiskFZo8bqtFQWsYOEQyTH3vYxQPA3V/7SoHKgdcvdMW2u53l3xstsV2Ot+tSrPsa0Yo4897Vj8CsNipM5sOV6PTjfSq2MYRv5JW5Fyvdi5edMjqfuDMgchKjs9gvk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc481f62-5b3b-4a38-8df4-08d7616cf565
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 21:21:29.7110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHiKpX/7slvZL3OFgbP38U8r0aQdv/k8+xF7l/VKsmEHPqkt2XmFP/ppHaD2Xr3a75wXl8Wj5iD9wBKqSgrrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4660
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.81
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
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "aadam@redhat.com" <aadam@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ailan@redhat.com" <ailan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jens,


> -----Original Message-----
> From: Jens Freimann <jfreimann@redhat.com>
> Sent: Tuesday, October 29, 2019 6:49 AM
> To: qemu-devel@nongnu.org
> Cc: ehabkost@redhat.com; mst@redhat.com; berrange@redhat.com;
> laine@redhat.com; aadam@redhat.com; ailan@redhat.com; Parav Pandit
> <parav@mellanox.com>; dgilbert@redhat.com; alex.williamson@redhat.com;
> armbru@redhat.com; eblake@redhat.com; jasowang@redhat.com;
> quintela@redhat.com; pbonzini@redhat.com
> Subject: [PATCH v7 0/11] add failover feature for assigned network device=
s
>=20
> This is implementing the host side of the net_failover concept
> (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
>=20
> Changes since v6:
> * reword patch description of 06/11 (Markus)
> * have qemu_savevm_state_guest_unplug_pending() return true when at
>   least one device is still not unplugged (Dave)
>=20
> The general idea is that we have a pair of devices, a vfio-pci and a virt=
io-net
> device. Before migration the vfio device is unplugged and data flows to t=
he
> virtio-net device, on the target side another vfio-pci device is plugged =
in to take
> over the data-path. In the guest the net_failover module will pair net de=
vices
> with the same MAC address.
>=20
> * Patch 1 adds the infrastructure to hide the device for the qbus and qde=
v APIs
>=20
> * Patch 2 adds checks to PCIDevice for only allowing ethernet devices as
>   failover primary and only PCIExpress capable devices
>=20
> * Patch 3 sets a new flag for PCIDevice 'partially_hotplugged' which we
>   use to skip the unrealize code path when doing a unplug of the primary
>   device
>=20
> * Patch 4 sets the pending_deleted_event before triggering the guest
>   unplug request
>=20
> * Patch 5 and 6 add new qmp events, one sends the device id of a device
>   that was just requested to be unplugged from the guest and another one
>   to let libvirt know if VIRTIO_NET_F_STANDBY was negotiated
>=20
> * Patch 7 make sure that we can unplug the vfio-device before
>   migration starts
>=20
> * Patch 8 adds a new migration state that is entered while we wait for
>   devices to be unplugged by guest OS
>=20
> * Patch 9 just adds the new migration state to a check in libqos code
>=20
> * Patch 10 In the second patch the virtio-net uses the API to defer addin=
g the
> vfio
>   device until the VIRTIO_NET_F_STANDBY feature is acked. It also
>   implements the migration handler to unplug the device from the guest an=
d
>   re-plug in case of migration failure
>=20
> * Patch 11 allows migration for failover vfio-pci devices
>=20

Patches are great to see failover capability enabled on the netdevice.
However it's very difficult to test it without having libvirt support.
Can we please have the necessary libvirt enhancements?
I will be able to test it with Mellanox ConnectX5 device + qemu + libvirt.

[..]


