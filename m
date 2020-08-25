Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5B3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F092071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9I8lxhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F092071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAXRC-0003Uk-3F
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAXQZ-00035Q-Jv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:47:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30472
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAXQX-00017n-FQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598356064;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ri8/khocIFoj+i6bLmwSjtnHR5B4a9pv3RKK5fGnK/c=;
 b=G9I8lxhs2zRMuPz5cyPr1fLwWF8TtWsdoW1fU1v1gdPsQBK96WsiXkXBOlOvV6kos1Bjri
 oAXZ+f+qO8eHgeNdieZvKJQ1yOs1STtUyTwZresbvuSno8UFnDclBnLvXGXK6cnNh/phAL
 TScq791CRmpdcakedUxWccKAInXGL4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-pJCououDO6CpybQdPJPt1g-1; Tue, 25 Aug 2020 07:47:42 -0400
X-MC-Unique: pJCououDO6CpybQdPJPt1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E8F1084C99
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:47:41 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8A8D1014161;
 Tue, 25 Aug 2020 11:47:39 +0000 (UTC)
Date: Tue, 25 Aug 2020 12:47:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 55/58] [automated] Use OBJECT_DECLARE_TYPE where
 possible
Message-ID: <20200825114736.GM107278@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-56-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820001236.1284548-56-ehabkost@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 08:12:33PM -0400, Eduardo Habkost wrote:
> Replace DECLARE_OBJ_CHECKERS with OBJECT_DECLARE_TYPE where the
> typedefs can be safely removed.
> 
> Generated running:
> 
> $ ./scripts/codeconverter/converter.py -i \
>   --pattern=DeclareObjCheckers $(git grep -l '' -- '*.[ch]')
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Script re-run after typedefs and macros were moved, and now the
>   patch also touches:
>   - TYPE_ARM_SSE
>   - TYPE_SD_BUS
> ---
>  hw/audio/intel-hda.h                | 6 ++----
>  hw/display/virtio-vga.h             | 6 ++----
>  include/authz/base.h                | 6 ++----
>  include/authz/list.h                | 6 ++----
>  include/authz/listfile.h            | 6 ++----
>  include/authz/pamacct.h             | 6 ++----
>  include/authz/simple.h              | 6 ++----
>  include/crypto/secret_common.h      | 6 ++----
>  include/crypto/secret_keyring.h     | 6 ++----
>  include/hw/arm/armsse.h             | 6 ++----
>  include/hw/hyperv/vmbus.h           | 6 ++----
>  include/hw/i2c/i2c.h                | 6 ++----
>  include/hw/i2c/smbus_slave.h        | 6 ++----
>  include/hw/ipack/ipack.h            | 6 ++----
>  include/hw/ipmi/ipmi.h              | 6 ++----
>  include/hw/mem/pc-dimm.h            | 6 ++----
>  include/hw/ppc/pnv.h                | 6 ++----
>  include/hw/ppc/pnv_core.h           | 6 ++----
>  include/hw/ppc/pnv_homer.h          | 6 ++----
>  include/hw/ppc/pnv_occ.h            | 6 ++----
>  include/hw/ppc/pnv_psi.h            | 6 ++----
>  include/hw/ppc/pnv_xive.h           | 6 ++----
>  include/hw/ppc/spapr_cpu_core.h     | 6 ++----
>  include/hw/ppc/spapr_drc.h          | 6 ++----
>  include/hw/ppc/spapr_vio.h          | 6 ++----
>  include/hw/ppc/spapr_xive.h         | 6 ++----
>  include/hw/ppc/xics.h               | 6 ++----
>  include/hw/ppc/xive.h               | 6 ++----
>  include/hw/s390x/event-facility.h   | 6 ++----
>  include/hw/s390x/s390_flic.h        | 6 ++----
>  include/hw/s390x/sclp.h             | 6 ++----
>  include/hw/sd/sd.h                  | 6 ++----
>  include/hw/ssi/ssi.h                | 6 ++----
>  include/hw/sysbus.h                 | 6 ++----
>  include/hw/virtio/virtio-gpu.h      | 6 ++----
>  include/hw/virtio/virtio-input.h    | 6 ++----
>  include/hw/virtio/virtio-mem.h      | 6 ++----
>  include/hw/virtio/virtio-pmem.h     | 6 ++----
>  include/hw/virtio/virtio-serial.h   | 6 ++----
>  include/hw/xen/xen-bus.h            | 6 ++----
>  include/io/channel.h                | 6 ++----
>  include/io/dns-resolver.h           | 6 ++----
>  include/io/net-listener.h           | 6 ++----
>  include/scsi/pr-manager.h           | 6 ++----
>  include/sysemu/cryptodev.h          | 6 ++----
>  include/sysemu/hostmem.h            | 6 ++----
>  include/sysemu/rng.h                | 6 ++----
>  include/sysemu/tpm_backend.h        | 6 ++----
>  include/sysemu/vhost-user-backend.h | 6 ++----
>  target/alpha/cpu-qom.h              | 6 ++----
>  target/arm/cpu-qom.h                | 6 ++----
>  target/avr/cpu-qom.h                | 6 ++----
>  target/cris/cpu-qom.h               | 6 ++----
>  target/hppa/cpu-qom.h               | 6 ++----
>  target/i386/cpu-qom.h               | 6 ++----
>  target/lm32/cpu-qom.h               | 6 ++----
>  target/m68k/cpu-qom.h               | 6 ++----
>  target/microblaze/cpu-qom.h         | 6 ++----
>  target/mips/cpu-qom.h               | 6 ++----
>  target/moxie/cpu.h                  | 6 ++----
>  target/nios2/cpu.h                  | 6 ++----
>  target/openrisc/cpu.h               | 6 ++----
>  target/ppc/cpu-qom.h                | 6 ++----
>  target/riscv/cpu.h                  | 6 ++----
>  target/s390x/cpu-qom.h              | 6 ++----
>  target/sh4/cpu-qom.h                | 6 ++----
>  target/sparc/cpu-qom.h              | 6 ++----
>  target/tilegx/cpu.h                 | 6 ++----
>  target/tricore/cpu-qom.h            | 6 ++----
>  target/unicore32/cpu-qom.h          | 6 ++----
>  target/xtensa/cpu-qom.h             | 6 ++----
>  backends/dbus-vmstate.c             | 6 ++----
>  ui/input-barrier.c                  | 6 ++----
>  ui/input-linux.c                    | 6 ++----
>  74 files changed, 148 insertions(+), 296 deletions(-)


Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


