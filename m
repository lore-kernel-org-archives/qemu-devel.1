Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344C9C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF00522511
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF00522511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptje-0001ww-8d
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yang.zhong@intel.com>) id 1hptjJ-000167-01
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1hptjF-00012M-LS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:17:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:54748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1hptjF-0000x6-CG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:17:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jul 2019 05:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; d="scan'208";a="368843842"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2019 05:17:04 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 05:17:04 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 05:17:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.60]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 20:17:02 +0800
From: "Zhong, Yang" <yang.zhong@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: The WCE issue in guest when i enable WCE in Qemu side.
Thread-Index: AdVBTuOdEgVuX2g+RsaI8qz+FhVG9w==
Date: Tue, 23 Jul 2019 12:17:02 +0000
Message-ID: <7A85DF989CAE8F42902CF7B31A7D94A1487D6D13@shsmsx102.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjc4NWU3MTktZjZjNy00OTQzLWI0ZWMtMTJhYzlmYTYyNTMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSXluV1J2ZURYVE4xS1FkUzF1d21oNlB0UVVjWnVwdEJIQXBoSTlSTG8yMkpmK0hiSGFsQW5JeGZDRmczbDJESyJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] The WCE issue in guest when i enable WCE in Qemu side.
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello all,

I am using the Qemu/SPDK to do vhost-user-blk verification, and the qemu co=
mmand as below:

./qemu-system-x86_64 \
    -machine q35,accel=3Dkvm \
    -cpu host -m 1024,maxmem=3D20G,slots=3D2 -smp 6 \
    -kernel  ./../linux-stable/arch/x86/boot/bzImage \
    -append 'root=3D/dev/vdb3 rw rootfstype=3Dext4 data=3Dordered rcupdate.=
rcu_expedited=3D1 pci=3Dlastbus=3D0 tsc=3Dreliable no_timer_check reboot=3D=
t noapictimer console=3Dhvc0' \
    -no-user-config -nodefaults \
    -drive file=3D/home/chen/project/clear-18080-kvm.img,if=3Dvirtio,format=
=3Draw -nographic -monitor pty \
    -device virtio-serial-pci,id=3Dvirtio-serial0,disable-modern \
    -chardev stdio,id=3Dcharconsole0 \
    -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole \
    -chardev socket,id=3Dchar0,path=3D/var/tmp/vhost.1 \
    -device vhost-user-blk-pci,chardev=3Dchar0,num-queues=3D1,bootindex=3D2=
,config-wce=3Dtrue \
    -object memory-backend-file,id=3Dmem1,size=3D1G,mem-path=3D/dev/hugepag=
es,share=3Don \
    -numa node,memdev=3Dmem1

When I set config-wce=3Dtrue or false, the below value never change
 root@unicorn ~ # cat /sys/block/vda/cache_type
write back
root@unicorn ~ # cat /sys/block/vda/device/features
0010 0010 0110 0110 0000 0000 0000 1000 1000 0000 0000 0000 0000 0000 0000 =
0000=20
From left to right, bit 11=3D0, which show there is no WCE feature in vhost=
-user-blk device.

I also did one simple patch to add config_wce value into s->blkcfg.wce, but=
 the result is same.

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9cb61336a6..0e3f490c82 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -447,6 +447,9 @@ reconnect:
         s->blkcfg.num_queues =3D s->num_queues;
     }

+    if (s->blkcfg.wce !=3D s->config_wce) {
+        s->blkcfg.wce =3D s->config_wce;
+    }
     return;

It seems the config-wce property setting in Qemu is not working, and I am n=
ot sure if this is a bug or vhost-user-blk only support write back mode ?
Thanks a lot!

Regards,

Yang





