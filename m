Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A3DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CD520663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HPm571pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CD520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1zv-0004EN-CI
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1iO1Ra-0004Q3-6s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1iO1RX-0007mw-UE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:24:01 -0400
Received: from mail-bgr052101134016.outbound.protection.outlook.com
 ([52.101.134.16]:24903 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1iO1RX-0007kM-1i
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVMTTCwZJLp53pWy9QjzoKDDYaxXW4AxRJ/Wu37XP+ARCwtSL1TmSpV3jmdCaIBmQDdn3X6/SFVnfls30goGYVlfWrzXT94OxzWK4dqLMGoWwXYAnoRLelNLvRPihLWjx20UoJ1Uus8oxiPjlF/pZH0x104jXE5l+YCIwmq8OUE6ofwFDFHfMOhxhL6jnvC32QLdKCH0b66kGGwSVfP7s7lQ20dF0Ofqs6zu+EG/qUBfkRUyHbVPHoWCoHxUrFRK5Uu+5q2T+eIsMB/0YYSlw9DQtjz+ey/2CdcoyJeOQECvtDgazINykGiTYBZu56WJRdPAapismgeQO0cDY1UeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/qOYo+cYLRbtlElhr0A7LxRViNvpQVX1DxkHPsAJoI=;
 b=cfsU+9WHZkJWY/CZ8Nnaw6j1OMBMXrG8cl3ZrZQNAEML+KQ2zzzYyr7nPCcnpgf6l8L1WkBsvyhT/MpbB0qB6Vfb74e/zet6Wb6YY+y3XyI5uu2p3cVoIEaXIAwZpFbhMMIqXnrOnCCTTd/bvMqaTVgCmVyeUJ48rsk6OrG5rr76I7ne0mbd2yXxz1lceoqgmyk4PJgcvQFI7SkqSICsSglY5rWMFoAFfRy32Cdudjxt6bi/RuCy8zCQGdAMtW5npgMwqVBu6RorL755/LOrkITZPINusvLYi0M11sSxnT/GpDxfp/aRLXdu6kO4fSPou8CwyAXWzEnUoBQJ055cHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/qOYo+cYLRbtlElhr0A7LxRViNvpQVX1DxkHPsAJoI=;
 b=HPm571pcPzf9K6FGZP0AnO6g1JuYTnjrQfNK40sm6ajE5pFCdK0N6mwnWkxmSYlPBgx1olzm9rkzxhFhG5xmsr1oVGjfc9oThix6JeHoVni3YVbp271F0HO1CX14umfwMssUWK3p3cI1I87MpHQQ8WayLHSJQvKQhI1aesHBQWE=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2178.eurprd08.prod.outlook.com (10.172.215.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 15:23:55 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 15:23:55 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v6 0/11] add failover feature for assigned network devices
Thread-Topic: [PATCH v6 0/11] add failover feature for assigned network devices
Thread-Index: AQHViy7iJaKROCbVg0GiICMwdTBNrKdregwA
Date: Fri, 25 Oct 2019 15:23:55 +0000
Message-ID: <20191025152352.GA24293@rkaganb.sw.ru>
References: <20191025121930.6855-1-jfreimann@redhat.com>
In-Reply-To: <20191025121930.6855-1-jfreimann@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Jens Freimann
 <jfreimann@redhat.com>, qemu-devel@nongnu.org,	pkrempa@redhat.com,
 berrange@redhat.com, ehabkost@redhat.com,	mst@redhat.com, aadam@redhat.com,
 jasowang@redhat.com,	dgilbert@redhat.com, armbru@redhat.com,
 alex.williamson@redhat.com,	laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0301CA0020.eurprd03.prod.outlook.com
 (2603:10a6:3:76::30) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b823606-642b-46eb-c314-08d7595f597b
x-ms-traffictypediagnostic: AM4PR0802MB2178:
x-ms-exchange-purlcount: 8
x-microsoft-antispam-prvs: <AM4PR0802MB2178EB8CDAA76A4867E06D31C9650@AM4PR0802MB2178.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(199004)(189003)(6916009)(71190400001)(7416002)(8936002)(386003)(4326008)(256004)(14444005)(33656002)(2906002)(7736002)(8676002)(36756003)(81156014)(81166006)(3846002)(71200400001)(478600001)(486006)(446003)(6486002)(9686003)(6306002)(476003)(6512007)(11346002)(58126008)(66066001)(1076003)(6246003)(5660300002)(229853002)(305945005)(6116002)(76176011)(14454004)(316002)(66476007)(66446008)(25786009)(66946007)(66556008)(64756008)(26005)(52116002)(186003)(99286004)(54906003)(102836004)(86362001)(6506007)(6436002)(966005)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:AM4PR0802MB2178;
 H:AM4PR0802MB2242.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-transport-forked: True
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tL90uWAOUK7ju3ePdkBObhM9LmF9VjaFEdUcEQjkZqnwf111YPntGKPg4X/lCkzCLD9yaEzVzLW0b9DBcp8FDjEPV015PYQB4M/uIRqg47O0/LXhRWWLbXdLLryvcqcTP0/PfVsuTE4wg7W0lt229jgQQcPd0K/aAKU5+FXH9qHOnzBu1bpnFVkXtc5ANRMlzegSIaBhRdd6QJrEt2K9C4kfgyRrXwxmrxesPzsFhkbpACjas/KhnbnBiL6J08tJp2GW/P8j/46/c80A6oAUlAXiFyHppE6Gv5r98AdTa3XYFE0ZqI8wfNj6E9hDobjh9lM0DltZ6/PUwcXhWJ81BhlNSOnwVC7nDfZ/afQ/M0JcbqYb7GDGKO8j8Il/8LHs2ESHW672jtUiehufxEkPsiW7mY2IdZDBYFSfckH5cFM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2B449E2A462454583FDB4E4EA1FEE80@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b823606-642b-46eb-c314-08d7595f597b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 15:23:55.6381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ6mwpb3Bj0qTlON9Unib/70NaZMGzpMUgxPqTwy3ns3GyltXlbUTBnqKBal41Dfpk7xi4up9f+aQ0nNH6TFQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2178
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.134.16
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
Cc: "pkrempa@redhat.com" <pkrempa@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "aadam@redhat.com" <aadam@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>, "ailan@redhat.com" <ailan@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "parav@mellanox.com" <parav@mellanox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 02:19:19PM +0200, Jens Freimann wrote:
> This is implementing the host side of the net_failover concept
> (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> 
> Changes since v5:
> * rename net_failover_pair_id parameter/property to failover_pair_id
> * in PCI code use pci_bus_is_express(). This won't fail on functions > 0
> * make sure primary and standby can't be added to same PCI slot
> * add documentation file in docs/ to virtio-net patch, add file to
>    MAINTAINERS (added to networking devices section)
> * add comment to QAPI event for failover negotiation, try to improve
>    commit message 
> 
> The general idea is that we have a pair of devices, a vfio-pci and a
> virtio-net device. Before migration the vfio device is unplugged and data
> flows to the virtio-net device, on the target side another vfio-pci device
> is plugged in to take over the data-path. In the guest the net_failover
> module will pair net devices with the same MAC address.
> 
> * Patch 1 adds the infrastructure to hide the device for the qbus and qdev APIs
> 
> * Patch 2 adds checks to PCIDevice for only allowing ethernet devices as
>   failover primary and only PCIExpress capable devices
> 
> * Patch 3 sets a new flag for PCIDevice 'partially_hotplugged' which we
>   use to skip the unrealize code path when doing a unplug of the primary
>   device
> 
> * Patch 4 sets the pending_deleted_event before triggering the guest
>   unplug request
> 
> * Patch 5 and 6 add new qmp events, one sends the device id of a device
>   that was just requested to be unplugged from the guest and another one
>   to let libvirt know if VIRTIO_NET_F_STANDBY was negotiated
> 
> * Patch 7 make sure that we can unplug the vfio-device before
>   migration starts
> 
> * Patch 8 adds a new migration state that is entered while we wait for
>   devices to be unplugged by guest OS
> 
> * Patch 9 just adds the new migration state to a check in libqos code
> 
> * Patch 10 In the second patch the virtio-net uses the API to defer adding the vfio
>   device until the VIRTIO_NET_F_STANDBY feature is acked. It also
>   implements the migration handler to unplug the device from the guest and
>   re-plug in case of migration failure
> 
> * Patch 11 allows migration for failover vfio-pci devices
> 
> Previous discussion:
>   RFC v1 https://patchwork.ozlabs.org/cover/989098/
>   RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.html
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03968.html
>   v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg635214.html
>   v3: https://patchew.org/QEMU/20191011112015.11785-1-jfreimann@redhat.com/
>   v4: https://patchew.org/QEMU/20191018202040.30349-1-jfreimann@redhat.com/
>   v5: https://patchew.org/QEMU/20191023082711.16694-1-jfreimann@redhat.com/
> 
> To summarize concerns/feedback from previous discussion:
> 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
>   Migration might get stuck for unpredictable time with unclear reason.
>   This approach combines two tricky things, hot/unplug and migration.
>   -> We need to let libvirt know what's happening. Add new qmp events
>      and a new migration state. When a primary device is (partially)
>      unplugged (only from guest) we send a qmp event with the device id. When
>      it is unplugged from the guest the DEVICE_DELETED event is sent.
>      Migration will enter the wait-unplug state while waiting for the guest
>      os to unplug all primary devices and then move on with migration.
> 2. PCI devices are a precious ressource. The primary device should never
>   be added to QEMU if it won't be used by guest instead of hiding it in
>   QEMU.
>   -> We only hotplug the device when the standby feature bit was
>      negotiated. We save the device cmdline options until we need it for
>      qdev_device_add()

The status of the feature support in the guest can change.  E.g. a guest
reboot will clear it for certain, and the guest may boot into another OS
that doesn't support pv-pt failover, and will become confused by two
network devices with the same MAC.  AFAICS from a brief skimming, the
patchset doesn't appear to address this scenario (which is probably not
so uncommon).

>      Hiding a device can be a useful concept to model. For example a
>      pci device in a powered-off slot could be marked as hidden until the slot is
>      powered on (mst).
> 3. Management layer software should handle this. Open Stack already has
>   components/code to handle unplug/replug VFIO devices and metadata to
>   provide to the guest for detecting which devices should be paired.
>   -> An approach that includes all software from firmware to
>      higher-level management software wasn't tried in the last years. This is
>      an attempt to keep it simple and contained in QEMU as much as possible.
>      One of the problems that stopped management software and libvirt from
>      implementing this idea is that it can't be sure that it's possible to
>      re-plug the primary device. By not freeing the devices resources in QEMU
>      and only asking the guest OS to unplug it is possible to re-plug the
>      device in case of a migration failure.

Frankly I'm failing to see the point in requiring 100%-reliable re-plug
on migration rollback.  The whole idea of this failover is to allow
temporary QOS degradation; if this isn't allowed you don't even consider
migrating.  So if the migration fails, you can leave the guest in the
degraded state on the source host until a better migraion target is
found or the conditions on the source host allow the re-plug to succeed.

Thanks,
Roman.

