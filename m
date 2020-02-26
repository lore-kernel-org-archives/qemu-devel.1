Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44966C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E7E20714
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9qcj/7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E7E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j731J-0005Ua-3Q
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 15:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j730O-0004nw-3m
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j730M-0005aV-Pm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:10:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31984
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j730M-0005Yp-M5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582747802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1Ywjbgh9xw00FxTIBnYTT8TJCDJbPWVkbEVaQgDgkQ=;
 b=f9qcj/7/9MRYb/U4a/NNPn1g+18IEPoHXgTOEP094EP2ofDAGiT5iPsJfAdiM6BBZ9KUCJ
 GUBVI1TuEkQENiYT31g0cyoIhIRIxs3AAURkMbVfz4fJB5iYRGLUFOKU/aUoLqIOlrWEYu
 lR1N4YMdPWVsLU8pysCIQJXFEglrKIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-mwrg5VB6NJeW_CLfu5SwLg-1; Wed, 26 Feb 2020 15:09:58 -0500
X-MC-Unique: mwrg5VB6NJeW_CLfu5SwLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1E8D800D50;
 Wed, 26 Feb 2020 20:09:56 +0000 (UTC)
Received: from gondolin (ovpn-117-69.ams2.redhat.com [10.36.117.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0200019C58;
 Wed, 26 Feb 2020 20:09:52 +0000 (UTC)
Date: Wed, 26 Feb 2020 21:09:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 00/18] s390x: Protected Virtualization support
Message-ID: <20200226210944.12feb012.cohuck@redhat.com>
In-Reply-To: <20200226122038.61481-1-frankja@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 07:20:20 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Most of the QEMU changes for PV are related to the new IPL type with
> subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
> IPL secure guests. Note that we can only boot into secure mode from
> normal mode, i.e. stfle 161 is not active in secure mode.
> 
> The other changes related to data gathering for emulation and
> disabling addressing checks in secure mode, as well as CPU resets.
> 
> v5:
> 	* Added balloon inhibition
> 	* Moved docs into docs/system
> 	* Some more enable/disable changes
> 	* Moved enablement/disablement of pv in separate functions
> 	* Some review fixes
> 
> v4:
> 	* Sync with KVM changes
> 	* Review changes
> 
> V3:
> 	* Use dedicated functions to access SIDA
> 	* Smaller cleanups and segfault fixes
> 	* Error reporting for Ultravisor calls
> 	* Inject of RC of diag308 subcode 10 fails
> 
> V2:
> 	* Split out cleanups
> 	* Internal PV state tracking
> 	* Review feedback
> 
> 
> Christian Borntraeger (1):
>   s390x: Add unpack facility feature to GA1
> 
> Janosch Frank (17):
>   s390x: Use constant for ESA PSW address
>   Sync pv
>   s390x: protvirt: Add diag308 subcodes 8 - 10
>   s390x: protvirt: Support unpack facility
>   s390x: protvirt: Add migration blocker
>   s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
>   s390x: protvirt: Inhibit balloon when switching to protected mode
>   s390x: protvirt: KVM intercept changes
>   s390x: Add SIDA memory ops
>   s390x: protvirt: Move STSI data over SIDAD
>   s390x: protvirt: SCLP interpretation
>   s390x: protvirt: Set guest IPL PSW
>   s390x: protvirt: Move diag 308 data over SIDAD
>   s390x: protvirt: Disable address checks for PV guest IO emulation
>   s390x: protvirt: Move IO control structures over SIDA
>   s390x: protvirt: Handle SIGP store status correctly
>   docs: Add protvirt docs
> 
>  docs/system/index.rst               |   1 +
>  docs/system/protvirt.rst            |  57 +++++++++++
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  82 +++++++++++++++-
>  hw/s390x/ipl.h                      |  33 +++++++
>  hw/s390x/pv.c                       | 106 +++++++++++++++++++++
>  hw/s390x/pv.h                       |  34 +++++++
>  hw/s390x/s390-virtio-ccw.c          | 143 +++++++++++++++++++++++++++-
>  hw/s390x/sclp.c                     |  17 ++++
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  include/hw/s390x/sclp.h             |   2 +
>  linux-headers/linux/kvm.h           |  45 ++++++++-
>  target/s390x/cpu.c                  |  27 ++++--
>  target/s390x/cpu.h                  |   9 +-
>  target/s390x/cpu_features_def.inc.h |   1 +
>  target/s390x/diag.c                 |  61 ++++++++++--
>  target/s390x/gen-features.c         |   1 +
>  target/s390x/helper.c               |   4 +
>  target/s390x/ioinst.c               | 113 +++++++++++++++-------
>  target/s390x/kvm.c                  |  54 ++++++++++-
>  target/s390x/kvm_s390x.h            |   2 +
>  target/s390x/mmu_helper.c           |  14 +++
>  target/s390x/sigp.c                 |   1 +
>  23 files changed, 744 insertions(+), 65 deletions(-)
>  create mode 100644 docs/system/protvirt.rst
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 hw/s390x/pv.h
> 

I guess this is on top of my published s390-next branch? (At least I
can apply it there...)

When I try to build the result on x86 with clang, I get

In file included from /home/cohuck/git/qemu/hw/s390x/ipl.c:36:
/home/cohuck/git/qemu/hw/s390x/pv.h:25:5: error: no previous prototype for
      function 's390_pv_vm_enable' [-Werror,-Wmissing-prototypes]
int s390_pv_vm_enable(void) { return 0; }
    ^
/home/cohuck/git/qemu/hw/s390x/pv.h:26:6: error: no previous prototype for
      function 's390_pv_vm_disable' [-Werror,-Wmissing-prototypes]
void s390_pv_vm_disable(void) {}
     ^
/home/cohuck/git/qemu/hw/s390x/pv.h:27:5: error: no previous prototype for
      function 's390_pv_set_sec_parms' [-Werror,-Wmissing-prototypes]
int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) { return 0; }
    ^
/home/cohuck/git/qemu/hw/s390x/pv.h:28:5: error: no previous prototype for
      function 's390_pv_unpack' [-Werror,-Wmissing-prototypes]
int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0; }
    ^
/home/cohuck/git/qemu/hw/s390x/pv.h:29:6: error: no previous prototype for
      function 's390_pv_perf_clear_reset' [-Werror,-Wmissing-prototypes]
void s390_pv_perf_clear_reset(void) {}
     ^
/home/cohuck/git/qemu/hw/s390x/pv.h:30:5: error: no previous prototype for
      function 's390_pv_verify' [-Werror,-Wmissing-prototypes]
int s390_pv_verify(void) { return 0; }
    ^
/home/cohuck/git/qemu/hw/s390x/pv.h:31:6: error: no previous prototype for
      function 's390_pv_unshare' [-Werror,-Wmissing-prototypes]
void s390_pv_unshare(void) {}
     ^

and

/home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c:355:9: error: variable 'rc' is
      used uninitialized whenever 'if' condition is true
      [-Werror,-Wsometimes-uninitialized]
    if (local_err) {
        ^~~~~~~~~
/home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c:391:12: note: uninitialized use
      occurs here
    return rc;
           ^~
/home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c:355:5: note: remove the 'if' if
      its condition is always false
    if (local_err) {
    ^~~~~~~~~~~~~~~~
/home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c:347:11: note: initialize the
      variable 'rc' to silence this warning
    int rc;
          ^
           = 0
/home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c:396:26: error: incomplete
      definition of type 'struct kvm_run'
    int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
              ~~~~~~~~~~~^
/home/cohuck/git/qemu/include/hw/core/cpu.h:265:8: note: forward declaration of
      'struct kvm_run'
struct kvm_run;
       ^


