Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4552FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 03:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACA120835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 03:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACA120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjZxc-0007gE-Ba
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 23:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianjay.zhou@huawei.com>)
 id 1jjZwl-00072A-2d
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 23:01:35 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2091 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianjay.zhou@huawei.com>)
 id 1jjZwi-0001vM-MD
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 23:01:34 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 69D336AFA63EBD4CDCDE;
 Fri, 12 Jun 2020 11:01:20 +0800 (CST)
Received: from DGGEMM508-MBX.china.huawei.com ([169.254.2.47]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0487.000;
 Fri, 12 Jun 2020 11:01:11 +0800
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
Thread-Topic: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
Thread-Index: AQHV8dBzPdW/4AkL+0GBczXBKqWav6hNu5OAgIcppiA=
Date: Fri, 12 Jun 2020 03:01:10 +0000
Message-ID: <B2D15215269B544CADD246097EACE7474BD26B9F@dggemm508-mbx.china.huawei.com>
References: <20200304025554.2159-1-jianjay.zhou@huawei.com>
 <18e7b781-8a52-d78a-a653-898445a5ee53@redhat.com>
In-Reply-To: <18e7b781-8a52-d78a-a653-898445a5ee53@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=jianjay.zhou@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 23:01:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>, "Wangxin \(Alexander,
 Cloud Infrastructure Service Product Dept.\)" <wangxinxin.wang@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Wednesday, March 18, 2020 6:48 PM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org;
> kvm@vger.kernel.org
> Cc: mst@redhat.com; cohuck@redhat.com; peterx@redhat.com; wangxin (U)
> <wangxinxin.wang@huawei.com>; Huangweidong (C)
> <weidong.huang@huawei.com>; Liujinsong (Paul) <liu.jinsong@huawei.com>
> Subject: Re: [PATCH] kvm: support to get/set dirty log initial-all-set ca=
pability
>=20
> On 04/03/20 03:55, Jay Zhou wrote:
> > Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
> > KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced in the kernel,
> > tweak the userspace side to detect and enable this capability.
> >
> > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > ---
> >  accel/kvm/kvm-all.c       | 21 ++++++++++++++-------
> >  linux-headers/linux/kvm.h |  3 +++
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
> > 439a4efe52..45ab25be63 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -100,7 +100,7 @@ struct KVMState
> >      bool kernel_irqchip_required;
> >      OnOffAuto kernel_irqchip_split;
> >      bool sync_mmu;
> > -    bool manual_dirty_log_protect;
> > +    uint64_t manual_dirty_log_protect;
> >      /* The man page (and posix) say ioctl numbers are signed int, but
> >       * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
> >       * unsigned, and treating them as signed here can break things */
> > @@ -1882,6 +1882,7 @@ static int kvm_init(MachineState *ms)
> >      int ret;
> >      int type =3D 0;
> >      const char *kvm_type;
> > +    uint64_t dirty_log_manual_caps;
> >
> >      s =3D KVM_STATE(ms->accelerator);
> >
> > @@ -2007,14 +2008,20 @@ static int kvm_init(MachineState *ms)
> >      s->coalesced_pio =3D s->coalesced_mmio &&
> >                         kvm_check_extension(s,
> KVM_CAP_COALESCED_PIO);
> >
> > -    s->manual_dirty_log_protect =3D
> > +    dirty_log_manual_caps =3D
> >          kvm_check_extension(s,
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> > -    if (s->manual_dirty_log_protect) {
> > -        ret =3D kvm_vm_enable_cap(s,
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0, 1);
> > +    dirty_log_manual_caps &=3D
> (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
> > +                              KVM_DIRTY_LOG_INITIALLY_SET);
> > +    s->manual_dirty_log_protect =3D dirty_log_manual_caps;
> > +    if (dirty_log_manual_caps) {
> > +        ret =3D kvm_vm_enable_cap(s,
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0,
> > +                                   dirty_log_manual_caps);
> >          if (ret) {
> > -            warn_report("Trying to enable
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 "
> > -                        "but failed.  Falling back to the legacy mode.=
 ");
> > -            s->manual_dirty_log_protect =3D false;
> > +            warn_report("Trying to enable capability %"PRIu64" of "
> > +                        "KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2
> but failed. "
> > +                        "Falling back to the legacy mode. ",
> > +                        dirty_log_manual_caps);
> > +            s->manual_dirty_log_protect =3D 0;
> >          }
> >      }
> >
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index 265099100e..3cb71c2b19 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -1628,4 +1628,7 @@ struct kvm_hyperv_eventfd {
> >  #define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
> >  #define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
> >
> > +#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
> > +#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
> > +
> >  #endif /* __LINUX_KVM_H */
> >
>=20
> Queued, thanks.
>=20

Hi Paolo,

It seems that this patch isn't included in your last pull request...
If there's something else to be done, please let me know.

Regards,
Jay Zhou

