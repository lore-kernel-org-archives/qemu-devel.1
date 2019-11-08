Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B41C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 03:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7790721882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 03:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7790721882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSuZi-000549-KF
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 22:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iSuYW-0004YR-4m
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 22:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iSuYU-0005Qf-3A
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 22:03:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:10922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iSuYT-0005OT-Rm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 22:03:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 19:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; d="scan'208";a="377643354"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga005.jf.intel.com with ESMTP; 07 Nov 2019 19:03:15 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 19:03:15 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 19:03:14 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 19:03:14 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.108]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.213]) with mapi id 14.03.0439.000;
 Fri, 8 Nov 2019 11:03:12 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH V2 0/4] Introduce Advanced Watch Dog module
Thread-Topic: [PATCH V2 0/4] Introduce Advanced Watch Dog module
Thread-Index: AQHVkF/dCZkY63OlaUKaGfjMi+8NlqeAoLkg
Date: Fri, 8 Nov 2019 03:03:11 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78062F1384@shsmsx102.ccr.corp.intel.com>
References: <20191101024850.20808-1-chen.zhang@intel.com>
In-Reply-To: <20191101024850.20808-1-chen.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmYyMGNmZTUtNTE5Zi00Mjc2LTg3OGItNzgyMjZkMWJjOWU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2ZsTDhIV0JKZTd6UkFDTjBXckdid1ZLb1hMc2pldzhJNTgwNDdoNjl2NkNSdUlyVCs1YnNHTHN6WGNBa1VaWSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi~ All~=20

Ping.... Anyone have time to review this series? I need more comments~

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen <chen.zhang@intel.com>
> Sent: Friday, November 1, 2019 10:49 AM
> To: Jason Wang <jasowang@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Philippe Mathieu-Daud=E9 <philmd@redhat.com>;
> qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhang, Chen
> <chen.zhang@intel.com>
> Subject: [PATCH V2 0/4] Introduce Advanced Watch Dog module
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Advanced Watch Dog is an universal monitoring module on VMM side, it can
> be used to detect network down(VMM to guest, VMM to VMM, VMM to
> another remote server) and do previously set operation. Current AWD patch
> just accept any input as the signal to refresh the watchdog timer, and we=
 can
> also make a certain interactive protocol here. For the output user can pr=
e-
> write some command or some messages in the AWD opt-script. We noticed
> that there is no way for VMM communicate directly, maybe some people
> think we don't need such things(up layer software like openstack can hand=
le
> it). But we engaged with real customer found that in some cases,they need=
 a
> lightweight and efficient mechanism to solve some practical
> problems(openstack is too heavy).
> for example: When it detects lost connection with the paired node,it will
> send message to admin, notify another VMM, send qmp command to qemu
> do some operation like restart the VM, build VMM heartbeat system, etc.
> It make user have basic VM/Host network monitoring tools and basic false
> tolerance and recovery solution.
>=20
> Demo usage(for COLO heartbeat service):
>=20
> In primary node:
>=20
> -chardev socket,id=3Dh1,host=3D3.3.3.3,port=3D9009,server,nowait
> -chardev socket,id=3Dheartbeat0,host=3D3.3.3.3,port=3D4445
> -object iothread,id=3Diothread2
> -object advanced-
> watchdog,id=3Dheart1,server=3Don,awd_node=3Dh1,notification_node=3Dheartb=
eat
> 0,opt_script=3Dcolo_opt_script_path,iothread=3Diothread1,pulse_interval=
=3D1000,
> timeout=3D5000
>=20
> In secondary node:
>=20
> -monitor tcp::4445,server,nowait
> -chardev socket,id=3Dh1,host=3D3.3.3.3,port=3D9009,reconnect=3D1
> -chardev socket,id=3Dheart1,host=3D3.3.3.8,port=3D4445
> -object iothread,id=3Diothread1
> -object advanced-
> watchdog,id=3Dheart1,server=3Doff,awd_node=3Dh1,notification_node=3Dheart=
1,op
> t_script=3Dcolo_secondary_opt_script,iothread=3Diothread1,timeout=3D10000
>=20
>=20
> V2:
>  - Addressed Philippe comments add configure selector for AWD.
>=20
> Initial:
>  - Initial version.
>=20
> Zhang Chen (4):
>   net/awd.c: Introduce Advanced Watch Dog module framework
>   net/awd.c: Initailize input/output chardev
>   net/awd.c: Load advanced watch dog worker thread job
>   vl.c: Make Advanced Watch Dog delayed initialization
>=20
>  configure         |   9 +
>  net/Makefile.objs |   1 +
>  net/awd.c         | 491
> ++++++++++++++++++++++++++++++++++++++++++++++
>  qemu-options.hx   |   6 +
>  vl.c              |   7 +
>  5 files changed, 514 insertions(+)
>  create mode 100644 net/awd.c
>=20
> --
> 2.17.1


