Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8395D221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InwW8W9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8395D221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3chx-0007qi-A6
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3cgY-0006xY-Vw
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:59:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30501
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3cgT-0001XU-NK
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596707975;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BzBBRkTJmDxX/OyyT2yMKFtBeBJLV2HKxiETMMsqdFE=;
 b=InwW8W9+18ES4kGq6/9TFJ4p6NuLCpnE5GUu/P6sWfeiitUR+RPECeB9Q8wL+GEqRwNE2u
 Im0SN80Tj3y+7OLy410k5vPYFPHRJm0FxclX82JDKeIYpbGX08NPJASQO/z2useGwcaj3b
 V0vOzjWf72pz5OWJPAaKa6g+9S0xwwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-XCRDzJQPME-eV2ixkj9Szg-1; Thu, 06 Aug 2020 05:59:26 -0400
X-MC-Unique: XCRDzJQPME-eV2ixkj9Szg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF60758;
 Thu,  6 Aug 2020 09:59:24 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C69491A4D9;
 Thu,  6 Aug 2020 09:59:22 +0000 (UTC)
Date: Thu, 6 Aug 2020 10:59:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [PATCH 0/5] log: Add logs for some modules
Message-ID: <20200806095919.GE4159383@redhat.com>
References: <20200806093720.2355692-1-liangpeng10@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200806093720.2355692-1-liangpeng10@huawei.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 05:37:15PM +0800, Peng Liang wrote:
> This path serial add some logs for some modeuls to make it easier to debug.

I appreciate the sentiment, but the use of 'info_report' means this
debug info is unconditionally printed to stderr. I'm not convinced
users in general will be happy with this approach of having stderr
filled with debug info every time QEMU is launched.

For example launching a random QEMU guest I have currently with your
patches applied results in many 100's lines of debug output spewed
to stderr.

Much of this I think should be done as trace points so it is possible
opt-in to acquiring debug information instead of it being unconditionally
emitted.

qemu-system-x86_64: info: qemu pid is 4174203, options parsing start
qemu-system-x86_64: -m 2048: info: memory options parse start
char device redirected to /dev/pts/14 (label charserial0)
2020-08-06T09:54:56.002249Z qemu-system-x86_64: info: Finish drive init.
2020-08-06T09:54:56.002335Z qemu-system-x86_64: info: configure accelerator pc-i440fx-3.1 start
2020-08-06T09:54:56.002997Z qemu-system-x86_64: info: machine init start
2020-08-06T09:54:56.003063Z qemu-system-x86_64: info: qemu enter main_loop
2020-08-06T09:54:56.028256Z qemu-system-x86_64: info: device init start
2020-08-06T09:54:56.032942Z qemu-system-x86_64: -device qemu-xhci,p2=15,p3=15,id=usb,bus=pci.0,addr=0x3: info: add qdev qemu-xhci:usb success
2020-08-06T09:54:56.033952Z qemu-system-x86_64: -device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x4: info: add qdev virtio-serial-pci:virtio-serial0 success
2020-08-06T09:54:56.034915Z qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x5,drive=libvirt-1-format,id=virtio-disk0,bootindex=1: info: add qdev virtio-blk-pci:virtio-disk0 success
2020-08-06T09:54:56.035829Z qemu-system-x86_64: -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:ba:40:93,bus=pci.0,addr=0x2: info: add rom file: virtio-net-pci.rom
2020-08-06T09:54:56.035981Z qemu-system-x86_64: -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:ba:40:93,bus=pci.0,addr=0x2: info: add qdev virtio-net-pci:net0 success
2020-08-06T09:54:56.036161Z qemu-system-x86_64: -device isa-serial,chardev=charserial0,id=serial0: info: add qdev isa-serial:serial0 success
2020-08-06T09:54:56.036214Z qemu-system-x86_64: -device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=org.qemu.guest_agent.0: info: add qdev virtserialport:channel0 success
2020-08-06T09:54:56.036806Z qemu-system-x86_64: -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x6: info: add qdev virtio-balloon-pci:balloon0 success
2020-08-06T09:54:56.037728Z qemu-system-x86_64: -device virtio-rng-pci,rng=objrng0,id=rng0,bus=pci.0,addr=0x7: info: add qdev virtio-rng-pci:rng0 success
2020-08-06T09:54:56.046939Z qemu-system-x86_64: info: reset all devices
2020-08-06T09:54:56.048999Z qemu-system-x86_64: info: qemu enter main_loop
info: qmp_cmd_name: qmp_capabilities, arguments: {}
info: qmp_cmd_name: query-migrate-capabilities, arguments: {}
info: qmp_cmd_name: migrate-set-capabilities, arguments: {"capabilities": [{"state": true, "capability": "events"}]}
info: qmp_cmd_name: query-chardev, arguments: {}
info: qmp_cmd_name: qom-list, arguments: {"path": "/machine/unattached/device[0]"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "realized"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hotplugged"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hotpluggable"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fill-mtrr-mask"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "x-force-features"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-vpindex"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "enforce"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-runtime"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-tlbflush"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-crash"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-reset"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pmu"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-relaxed"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tcg-cpuid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmware-cpuid-freq"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-stimer"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "legacy-cache"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "x-migrate-smi-count"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-reenlightenment"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "x-hv-synic-kvm-only"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "l3-cache"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "lmce"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-passthrough"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-no-smi-migration"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-stimer-direct"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "host-phys-bits"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "check"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-time"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "full-cpuid-auto-level"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-synic"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-evmcs"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-ipi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-vapic"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cpuid-0xb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hv-frequencies"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "x-intel-pt-auto-level"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invept-single-context"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "core-capability"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "popcnt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm_mmu"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "dtes64"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse4_1"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invvpid-single-addr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xstore"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-vmfunc"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pse36"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512-4vnniw"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fma4"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512-vp2intersect"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-poll-control"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm_nopiodelay"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "amd-stibp"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pclmuldq"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-store-lma"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "erms"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vaes"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-activity-wait-sipi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-flexpriority"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "rdrand"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-ept-advanced-exitinfo"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-pause-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-shadow-vmcs"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512-vpopcntdq"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tbm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xcrypt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "lm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-pv-eoi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-monitor-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-eptad"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pae"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ssse3"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-unrestricted-guest"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "phe"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "movdiri"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "taa-no"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "full-width-write"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "perfctr_nb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "arat"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512vbmi2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "perfctr_core"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm_asyncpf"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "x2apic"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "npt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512ifma"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm_poll_control"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-vnmi-pending"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invpcid-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-io-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pmm-en"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsc"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-ins-outs"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "dca"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-apicv-x2apic"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ia64"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "perfctr-core"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-cr3-load-noexit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvmclock"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-entry-noload-debugctl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "invtsc"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pn"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512cd"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "md-clear"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cmp-legacy"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cx16"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512dq"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "abm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-activity-shutdown"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-pv-ipi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-apicv-register"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fxsr-opt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "skip-l1dfl-vmentry"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pcid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "rdpid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "wbnoinvd"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "syscall"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pse"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsc_scale"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "mce"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xsaves"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-entry-load-pat"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ibpb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-apicv-xapic"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cldemote"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "rtm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "lwp"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-steal-time"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-hlt-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-entry-load-efer"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "nrip_save"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invlpg-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-save-efer"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-eptp-switching"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vme"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-pv-unhalt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-desc-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm_pv_unhalt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "svm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "lahf-lm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invvpid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-hint-dedicated"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "mca"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "mtrr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmcb_clean"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pfthreshold"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pmm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pbe"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-entry-ia32e-mode"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-rdpmc-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "split-lock-detect"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fpu"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "skinit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sep"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512-bf16"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-rdtscp-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "nx"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invvpid-all-context"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ds-cpl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pause-filter"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fsrm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pause_filter"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-vmwrite-vmexit-fields"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-ept"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "nodeid-msr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "smap"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-io-bitmap"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-intr-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fxsr_opt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cr8legacy"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cmp_legacy"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-zero-len-inject"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "virt-ssbd"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pschange-mc-no"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "umip"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512er"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-vpid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xstore-en"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512vl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invept-single-context-noglobals"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cmov"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "rsba"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-posted-intr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xcrypt-en"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tm2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-clear-bndcfgs"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-ept-execonly"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-load-efer"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xsaveerptr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fsgsbase"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512bw"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-vintr-pending"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "smx"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-secondary-ctls"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "lbrv"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hle"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "monitor"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tce"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse4a"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vpclmulqdq"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsc-scale"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-pv-tlb-flush"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "mds-no"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-cr8-load-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-activity-hlt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "i64"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "adx"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invept-all-context"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ffxsr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "amd-no-ssb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-entry-load-bndcfgs"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "svm_lock"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "msr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pclmulqdq"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-preemption-timer"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "clflush"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ssb-no"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "mpx"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "extapic"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-vnmi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xop"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-rdseed-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "smep"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-mwait-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-rdtsc-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "cx8"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse4-2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xsavec"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pku"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsx-ldtrk"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-mtf"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmcb-clean"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-load-pat"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "stibp"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-cr3-store-noexit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsx-ctrl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "svm-lock"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse4-1"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "lahf_lm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm_pv_eoi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "clzero"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ds"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "osvw"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm_steal_time"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-true-ctls"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "movdir64b"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-invept"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "acpi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xd"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "nodeid_msr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ds_cpl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-ept-1gb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "nrip-save"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "gfni"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-mmu"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse3"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "serialize"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512bitalg"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "rdseed"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sha-ni"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ace2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "waitpkg"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-rdrand-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "f16c"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "3dnowprefetch"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-encls-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "topoext"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "rdctl-no"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "mmx"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512-4fmaps"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-cr8-store-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512vnni"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pni"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "movbe"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "mmxext"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-ple"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-apicv-vid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "flushbyasid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "rdtscp"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "clwb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-asyncpf"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-pv-sched-yield"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "decodeassists"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pat"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "invpcid"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pdpe1gb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-save-pat"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsc-adjust"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-entry-load-rtit-ctl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ht"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xtpr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsc_adjust"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-tsc-offset"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ssbd"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-clear-rtit-ctl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "3dnowext"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "clflushopt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pdcm"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xsave"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "est"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pge"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "pcommit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ibs"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "tsc-deadline"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvmclock-stable-bit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "misalignsse"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-msr-bitmap"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "perfctr-nb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "apic"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512vbmi"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-nosave-debugctl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512f"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-save-preemption-timer"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "arch-capabilities"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "bmi2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-pml"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-nmi-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "intel-pt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "wdt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ace2-en"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "avx512pf"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "bmi1"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-page-walk-5"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "kvm-nopiodelay"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse4.2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-ept-2mb"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-load-perf-global-ctrl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "3dnow"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-wbinvd-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "la57"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-page-walk-4"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse4.1"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ibrs-all"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xgetbv1"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "xsaveopt"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "spec-ctrl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-entry-load-perf-global-ctrl"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-exit-ack-intr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-xsaves"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "phe-en"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fxsr"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "hypervisor"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "aes"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "amd-ssbd"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "sse4_2"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "de"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "ss"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "vmx-movdr-exit"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "fma"}
info: qmp_cmd_name: qom-get, arguments: {"path": "/machine/unattached/device[0]", "property": "unavailable-features"}
info: qmp_cmd_name: query-hotpluggable-cpus, arguments: {}
info: qmp_cmd_name: query-cpus-fast, arguments: {}
info: qmp_cmd_name: query-iothreads, arguments: {}
info: qmp_cmd_name: balloon, arguments: {"value": 2147483648}
info: qmp_cmd_name: qom-list, arguments: {"path": "/machine/peripheral"}
info: qmp_cmd_name: query-block, arguments: {}
info: qmp_cmd_name: cont, arguments: {}
info: qmp cont is received and vm is started
info: {"timestamp": {"seconds": 1596707696, "microseconds": 348455}, "event": "RESUME"}
2020-08-06T09:54:57.800270Z qemu-system-x86_64: info: virtio-rng device status is 1 that means ACKNOWLEDGE
2020-08-06T09:54:57.800301Z qemu-system-x86_64: info: virtio-rng device status is 3 that means DRIVER
2020-08-06T09:54:57.800361Z qemu-system-x86_64: info: virtio-rng device status is 7 that means DRIVER OK
2020-08-06T09:54:57.986059Z qemu-system-x86_64: info: virtio-blk device status is 1 that means ACKNOWLEDGE
2020-08-06T09:54:57.986089Z qemu-system-x86_64: info: virtio-blk device status is 3 that means DRIVER
2020-08-06T09:54:57.986177Z qemu-system-x86_64: info: virtio-blk device status is 7 that means DRIVER OK
2020-08-06T09:55:06.599507Z qemu-system-x86_64: terminating on signal 15 from pid 4173713 (/usr/sbin/libvirtd)
2020-08-06T09:55:06.599580Z qemu-system-x86_64: info: {"timestamp": {"seconds": 1596707706, "microseconds": 599541}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-signal"}}
2020-08-06T09:55:06.599977Z qemu-system-x86_64: info: virtio-rng device status is 7 that means DRIVER OK
2020-08-06T09:55:06.600085Z qemu-system-x86_64: info: virtio-blk device status is 7 that means DRIVER OK
2020-08-06 09:55:06.800+0000: shutting down, reason=destroyed


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


