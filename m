Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3941FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00234206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gpq2RnIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00234206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdYn-0000wU-0P
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQdXO-0000BE-Lz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQdXK-0003pT-8d
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:01:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQdXJ-0003lV-QJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587416459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9qaNLRbiOGHYjbtlSMmU8UwrWtpb1LdX0h3WxxrdS1U=;
 b=Gpq2RnIbc0dKzUcppyCm5Sz1iiNp3oOxngIt0MKdwVjvmsEiXFsFLXaFBf32vTGfIIW9SP
 NWXFuWozp63WZ29EJE+QmR1cCs15ZFwSXF6fkKBJ+nr+tyKPx/yid+4wLbOrH0t1T20mfd
 vn8Qwhbc+PVtfUFwkItdiYh6R93Z3Ic=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-G9JnJZ14NdSJt5WKlaCHWA-1; Mon, 20 Apr 2020 17:00:53 -0400
X-MC-Unique: G9JnJZ14NdSJt5WKlaCHWA-1
Received: by mail-qk1-f197.google.com with SMTP id i2so5397187qkl.5
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=oA0q205cNKraswioVyV9roVxBfawafZhIBWK2wbRyhw=;
 b=VqPgRniho0N73rZnzXVeJK6VOzAlg686fWi0zkOQz4MajEjcpNXv+uoW+VwCBcoOz4
 8vJYPUy+n1UKnxYIyLkOwbOzShhS65mr9hYEhE9Nh6MjWaZCl50vJJYNroCQKsIHlkme
 K8uy2W6u+jYr0z17/0xoICTQbRw28gaLdPVEx/bYsJkabjT8g00npOPLHahsc0HJz9rH
 yr6UDiNQ6D4sJR4ft3g/nvhTaEhvyGytO111VtVg0BaY83jasa0td0ekoEMW35okc6+2
 Vbsx1hPydEgXQlrO2xa2gDMD2qoxdA0ewCxdpBBaN42XdWkfg3iW+G9rZVXZxluEZ6Rw
 6Sog==
X-Gm-Message-State: AGi0PuZAlJPXPn3JbP5q6rYHjR96xggd/7esjsUbMMsH1CTmS+y6b5TE
 DINJN9cngrfL79K+Ujl0hIPXdRcK8w2drp+0retYq9mLkin9WqHpENQpqVSKFB55WZFeB9thACk
 xSpEojQ4qwVYrT0M=
X-Received: by 2002:a05:620a:541:: with SMTP id
 o1mr16912965qko.89.1587416452289; 
 Mon, 20 Apr 2020 14:00:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJY5yc8fTx7aqKGB7VVe/xiYLZdyrO2VUkQze+SOE7gRC2abSHLG404iexvDa3PEDspeVwJsA==
X-Received: by 2002:a05:620a:541:: with SMTP id
 o1mr16912846qko.89.1587416451118; 
 Mon, 20 Apr 2020 14:00:51 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id x18sm457254qkn.107.2020.04.20.14.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:00:50 -0700 (PDT)
Date: Mon, 20 Apr 2020 17:00:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Question on memory commit during MR finalize()
Message-ID: <20200420210049.GA420399@xz-x1>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 17:00:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo & all,

After my recent rebase and changes to my local QEMU kvm-dirty-ring tree, I =
can
easily trigger a QEMU crash at boot with that:

  kvm_set_phys_mem: error registering slot: File exists

With backtrace:

#0  __GI_raise (sig=3Dsig@entry=3D6)=20
#1  0x00007f29559088d9 in __GI_abort ()=20
#2  0x000055ce0b39cd84 in kvm_set_phys_mem (kml=3D0x55ce0e1efeb8, section=
=3D0x7f294ae035b0, add=3Dtrue)=20
#3  0x000055ce0b39d5aa in kvm_region_add (listener=3D0x55ce0e1efeb8, sectio=
n=3D0x7f294ae035b0)=20
#4  0x000055ce0b388ae6 in address_space_update_topology_pass (as=3D0x55ce0b=
f129e0 <address_space_memory>, old_view=3D0x55ce0ef8ae80, new_view=3D0x7f29=
44001c20, adding=3Dtrue)=20
#5  0x000055ce0b388dde in address_space_set_flatview (as=3D0x55ce0bf129e0 <=
address_space_memory>)=20
#6  0x000055ce0b388f85 in memory_region_transaction_commit ()=20
#7  0x000055ce0b38a8e4 in memory_region_finalize (obj=3D0x55ce0e52f700)=20
#8  0x000055ce0b821de2 in object_deinit (obj=3D0x55ce0e52f700, type=3D0x55c=
e0de89d80)=20
#9  0x000055ce0b821e54 in object_finalize (data=3D0x55ce0e52f700)=20
#10 0x000055ce0b822e0f in object_unref (obj=3D0x55ce0e52f700)=20
#11 0x000055ce0b32461c in phys_section_destroy (mr=3D0x55ce0e52f700)=20
#12 0x000055ce0b324676 in phys_sections_free (map=3D0x55ce0e1bf7a0)=20
#13 0x000055ce0b327d89 in address_space_dispatch_free (d=3D0x55ce0e1bf790)=
=20
#14 0x000055ce0b3863f8 in flatview_destroy (view=3D0x55ce0e193ab0)=20
#15 0x000055ce0b9a39cb in call_rcu_thread (opaque=3D0x0)=20
#16 0x000055ce0b9899d9 in qemu_thread_start (args=3D0x55ce0de39a40)=20
#17 0x00007f2955ab54e2 in start_thread (arg=3D<optimized out>)=20
#18 0x00007f29559e4693 in clone ()=20

It's KVM_SET_USER_MEMORY_REGION returning -EEXIST.

I'm still uncertain how the dirty ring branch can easily trigger this, howe=
ver
the backtrace looks really odd to me in that we're going to do memory commi=
t
and even sending KVM ioctls during finalize(), especially in the RCU thread=
...
I never expected that.

I wanted to understand better on 2e2b8eb70f ("memory: allow destroying a
non-empty MemoryRegion", 2015-10-09), but the context didn't help much [1].=
  Do
any of you still remember why we do that?  Is it really what we want to sen=
d
KVM ioctls even in the RCU thread during finalize()?

Any input would be greatly welcomed.

Thanks,

[1] https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00110.html

-- Peter Xu


