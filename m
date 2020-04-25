Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2FEC55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 09:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C1A2074F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 09:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii2Q4Zvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C1A2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSH6U-0005xr-SP
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 05:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSH5E-0005E3-80
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSH4z-0006h2-4z
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:26:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jSH4y-0006fj-Kx
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587806790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcIayTYvRSnN3LHp4TWg4vfwCvPsVctRGypt1w6ru+g=;
 b=Ii2Q4ZvbwG1jR2LsrUckfTBdsSRwq4nFcjVvPUSeO7eH1yyKPIo0Ta3AUhkYzdcHEwt1pV
 CcM6fs6cnQUd6mE2mkdYitM6L/PznjyulOIgP6r5R6Emdtn0GwRpINf57lxiKD7wjeOjb1
 8UEwhBz4qu6fUrzDXnRA/UI+j+CnxlA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-uvjJvTidM3yhvzuHZOBBVg-1; Sat, 25 Apr 2020 05:26:28 -0400
X-MC-Unique: uvjJvTidM3yhvzuHZOBBVg-1
Received: by mail-wr1-f72.google.com with SMTP id v9so6406507wrt.7
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 02:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EcIayTYvRSnN3LHp4TWg4vfwCvPsVctRGypt1w6ru+g=;
 b=XlobDA9216Y8y/AfAbmRoYo6CEQh/o70q1bKbxHes0f/7sIbcoensyMIity8GcXIH5
 kDjB5DD0gysk1ekdHkmCmArQnLb81DT7VNPd2AglpY3ZvUFWlM7N4Gd43vke0otAOqtX
 G3aSiMk6j90dDD+9RjWFYlZ/tkEgIkoVmvv0kVD+mJd6QV3lvqpHXXV/o3KNrJxJdOYG
 y8MutDPohlDFuw2aFhqbNRpoiu0aLwG5VfFlBkLAzCDaCpTzwEqynv9WJhv0PEoVkcq5
 0NckPZgk2q4UDn/1GCPa6NXbaGPm9DAkS16QxkpPfoIVoJLfVUUM2M3/1VAaCStuu8T+
 9OiA==
X-Gm-Message-State: AGi0PuYhJ4sKXRmVY7I/Pis1N6WADVj2iJDgvdGQ6eFax1YICO31AfAm
 trAf+tR9OVj/ihXNNIeE5FYD0VjKGfnsOqrd8qSMGAxHPIeSU6+tJ9UblYS6fKPHUOz4RTfgFPG
 podhh/JW0qVQ3Cqo=
X-Received: by 2002:a5d:6148:: with SMTP id y8mr15777243wrt.236.1587806787031; 
 Sat, 25 Apr 2020 02:26:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypJrEPwo8PqkSy+AwbDGziqW7HxlTyJldn8EHJDzRKu+Q7IPdJOabx47EoCj6fSXW6f/LRnEmQ==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr15777218wrt.236.1587806786753; 
 Sat, 25 Apr 2020 02:26:26 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id j13sm11628472wro.51.2020.04.25.02.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 02:26:26 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Jones <drjones@redhat.com>
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
 <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
 <20200417131032.lcyunbjwofsn2nzz@kamzik.brq.redhat.com>
 <20200424121633.GF3106@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6f4b17c-1202-3aef-320a-247dc0295277@redhat.com>
Date: Sat, 25 Apr 2020 11:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424121633.GF3106@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 05:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, quintela@redhat.com,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/04/20 14:16, Dr. David Alan Gilbert wrote:
>>> I was trying to work out whether we need to migrate this state,
>>> and I'm not sure. Andrew, do you know? I think this comes down
>>> to "at what points in QEMU's kvm run loop can migration kick in",
>>> and specifically if we get a KVM_EXIT_ARM_NISV do we definitely
>>> go round the loop and KVM_RUN again without ever checking
>>> to see if we should do a migration ?
>>>
>> I'd prefer a migration expert confirm this, so I've CC'ed David and Juan,
>> but afaict there's no way to break out of the KVM_RUN loop after a
>> successful (ret=0) call to kvm_arch_handle_exit() until after the next
>> KVM_RUN ioctl. This is because even if migration kicks the vcpus between
>> kvm_arch_handle_exit() and the next run, the signal won't do anything
>> other than prepare the vcpu for an immediate exit.

As far as QEMU is concerned, this should be enough for Beata's patch to
be safe.  If the signal causes KVM to exit before KVM_EXIT_ARM_NISV,
it's of course okay.  If you get a KVM_EXIT_ARM_NISV, however, KVM_RUN
will exit with return code 0 and kvm_cpu_exec will:

- set env->ext_dabt_pending

- go round the loop again

- notice cpu->exit_request and schedule an immediate exit

- call kvm_arch_put_registers

- call KVM_RUN again, which will exit with -EINTR

- exit the loop and allow migration to proceed

However, I'm not sure that it's a good idea to

+        /* Clear instantly if the call was successful */
+        env->ext_dabt_pending = 0;

Rather, this should be done by the next kvm_arch_get_registers when it
calls KVM_GET_VCPU_EVENTS.  It's also possible to add an assertion in
kvm_get_vcpu_events that it you always get zero, to justify that the
field is not migrated.

Thanks,

Paolo


