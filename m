Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F87C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED438208E4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PK9U+sX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED438208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbPVy-0001q1-4p
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 09:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbPUc-0001EU-FO
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbPUa-0001vs-76
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604760418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6BdhuWP+wStHFfv5PyvBDmVRy3k+XSmlu3C+hlMa/LM=;
 b=PK9U+sX+2lkCXXz+bvUb4eNf9fLTnUKb6kYcGHFre7R94Y427bwJ61oK9GvFNa7nhjICuJ
 m/xgeVZx4kbpj2kmlmXRfqbguaTSLXn7L4YldH36y4Pwx/z3c5hJfIQDx3a0qdEgBojvlK
 AOMUhfIble2yre52SxufHX/rPkAgSJ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-xMfO41wbONuuHTHH9bp--g-1; Sat, 07 Nov 2020 09:46:55 -0500
X-MC-Unique: xMfO41wbONuuHTHH9bp--g-1
Received: by mail-wm1-f69.google.com with SMTP id g3so1030071wmh.9
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 06:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=6BdhuWP+wStHFfv5PyvBDmVRy3k+XSmlu3C+hlMa/LM=;
 b=mD0VvDgyrAvtNURuFVg7scWfLUWIPH4U+7ekHC35GYCTYvxGdETcifqXIR598guPKD
 vVjhy8b9aZv6h7DLczsk3CKGxrvJihiudP6vkHGo0aUVx70cRC4eBApvH92rIb3ekdJd
 x4bg5OK+HKwznimu9w3B1xp2a5BmxcSYeaTbHEoFSC6UpSaeSdV8IuXcrYksv9koFh/C
 dG3ea53/kN3O0j3dCFvHMqfM2/RMloLvuW8xOqygqAa/X/qxsNGmd1j3oy/H63ffGXfT
 Ek8xJeD3TsljmaNZdCbdoWE52vATDRvVjhGlW6T+Dve2I/3G9ZxMbq+Fn3OIEuDhBfS1
 nu2w==
X-Gm-Message-State: AOAM530UbPC9tEtX1xhUqD+IpffGml7JLWfjftPkstIKfio0EFlS8qDF
 lVbA9SgNHIEuIkGKKcBOpW4wwnQQh+EuCnQ7/rBW+AEHLvNr9Wd2kxumI/dlAdUFn7A8gC+q98n
 1PBaviOwbibQvtJM=
X-Received: by 2002:a1c:f311:: with SMTP id q17mr5020674wmq.28.1604760414691; 
 Sat, 07 Nov 2020 06:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH8+Yzqn40/xRL5yUzAXCdueHd7TwhQgM1pgqVX8lj02Mc10hULSw2lbvzQlsR+OaivrEsFA==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr5020660wmq.28.1604760414491; 
 Sat, 07 Nov 2020 06:46:54 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t13sm6923728wru.67.2020.11.07.06.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 06:46:53 -0800 (PST)
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: hw/i386/q35: Where go LPC irqs?
Message-ID: <52d30372-44aa-153b-c69f-57150b6cf6b6@redhat.com>
Date: Sat, 7 Nov 2020 15:46:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I am confuse with the LPC/GSI code.

In pc_q35_init() we connect the LPC outputs to
GSI input:

116 static void pc_q35_init(MachineState *machine)
117 {
...
240     /* irq lines */
241     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
242
243     ich9_lpc = ICH9_LPC_DEVICE(lpc);
244     lpc_dev = DEVICE(lpc);
245     for (i = 0; i < GSI_NUM_PINS; i++) {
246         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i,
x86ms->gsi[i]);
247     }
...
268     /* init basic PC hardware */
269     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state,
!mc->no_floppy,
270                          0xff0104);

But then we call pc_basic_device_init() which overwrite
the GSI inputs with HPET outputs:

1118 void pc_basic_device_init(struct PCMachineState *pcms,
1119                           ISABus *isa_bus, qemu_irq *gsi,
1120                           ISADevice **rtc_state,
1121                           bool create_fdctrl,
1122                           uint32_t hpet_irqs)
1123 {
...
1139     /*
1140      * Check if an HPET shall be created.
1141      *
1142      * Without KVM_CAP_PIT_STATE2, we cannot switch off the
in-kernel PIT
1143      * when the HPET wants to take over. Thus we have to disable
the latter.
1144      */
1145     if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
1146                                kvm_has_pit_state2())) {
...
1165         for (i = 0; i < GSI_NUM_PINS; i++) {
1166             sysbus_connect_irq(SYS_BUS_DEVICE(hpet), i, gsi[i]);
1167         }

Are LPC IRQ still delivered?

Peter commented here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg758178.html

"Connecting two qemu_irqs outputs directly
to the same input is not valid as it produces subtly wrong behaviour
(for instance if both the IRQ lines are high, and then one goes
low, the PIC input will see this as a high-to-low transition
even though the second IRQ line should still be holding it high)."

Are this IRQ OR'ed to the GSI?

Thanks,

Phil.


