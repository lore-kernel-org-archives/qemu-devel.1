Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6FC4727D
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 00:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A71921D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 00:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLXwJLf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A71921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLxgJ-0000xB-FY
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 20:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLxfZ-0000XF-Ih
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 20:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLxfX-0003JH-0Y
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 20:02:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601078545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQNfYduq9Qt3GYuCjVIaYqi/k4BVyWoOAqL/z+NmITQ=;
 b=GLXwJLf3n7dgsQN56U12Bd7iPmhckjlwg5uAy2depJXTHqWhvgtYpJHXvQ3fcr7h9Ttt7X
 Nkmdqp4SltCHTFzuuGIrxizLVCs0lOjQ83s4IX76aft+uyl5c7yNG7kzLTL3TdMiMJsyJW
 D7nOQM22VBo3D2QjfsN4qGCBX1O/KYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-ZwNhK0PlMmCg61PBWUE5bg-1; Fri, 25 Sep 2020 20:02:23 -0400
X-MC-Unique: ZwNhK0PlMmCg61PBWUE5bg-1
Received: by mail-wm1-f72.google.com with SMTP id a25so282958wmb.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 17:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WQNfYduq9Qt3GYuCjVIaYqi/k4BVyWoOAqL/z+NmITQ=;
 b=RCE5j/8fXC6RqVhCaMi0Idea32FNjaqWJZLnhRHIENPGuCnUU2owlKV/xVFTqVR85t
 /RILitsfTxKxC32+YmiSufvVa6ba50Xrzx/TyUhkXXrAbebFody/jpTtqEK95zITTDe3
 hf7QqQ81iDnJjB1geoDor4F5wlElZ+xg64+id96dch0NqhYrt6p1T1TAZBSVpNmoXAkl
 LxJIBEqmACjeSvfVmNt/AK+vdE0cPoTTShy2bPmfSvsWkvpwFGfKnm/vHm+TxTet3Rtf
 GtnUKEw71zaQKHj7JeU9zsyB+8riSk2guKmiux6X+EVz73NFp+tEFUWuQB5t4E/0bAf9
 07ow==
X-Gm-Message-State: AOAM532mAfjO2a2hOLXwdIkkOgFyGPf2BTN7gHkb7E/PcClQNxwFfgmc
 jQADzS+a+65WTX3QTbx7kFlY9rrp9XatWK9iaYU70rxV3VlXw+4x1/UcFzgywK2qcgd26P4VtcL
 kH3gB48eykQGo7dg=
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr57416wmh.3.1601078542118;
 Fri, 25 Sep 2020 17:02:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzRF8+sTRpdzzqIriB/IaOmtmdMFVDYbVUWsOMb4ZGV8dXkFMuuOsLaso0xvrYVGr4rpKG7A==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr57398wmh.3.1601078541816;
 Fri, 25 Sep 2020 17:02:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id f14sm631427wme.22.2020.09.25.17.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 17:02:21 -0700 (PDT)
Subject: Re: SEV guest debugging support for Qemu
To: Ashish Kalra <ashish.kalra@amd.com>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
 <20200925204607.GA10964@ashkalra_ubuntu_server>
 <e9b09c9b-4d4c-c6de-4cce-807effc38836@redhat.com>
 <20200925234841.GA11103@ashkalra_ubuntu_server>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a0188c5-8dbc-e86c-6726-ba7bfb821697@redhat.com>
Date: Sat, 26 Sep 2020 02:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925234841.GA11103@ashkalra_ubuntu_server>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thomas.lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/20 01:48, Ashish Kalra wrote:
> Thanks for your input, i have one additional query with reference to this support :
> 
> For all explicitly unecrypted guest memory regions such as S/W IOTLB bounce buffers,
> dma_decrypted() allocated regions and for guest regions marked as "__bss_decrypted",
> we need to ensure that DBG_DECRYPT API calls are bypassed for such
> regions and those regions are dumped as un-encrypted.

Yes those would be a bit different as they would be physical memory
accesses.  Those currently go through address_space_read in memory_dump
(monitor/misc.c), and would have to use the MemoryDebugOps instead.
That is the place to hook into in order to read the KVM page encryption
bitmap (which is not per-CPU, so another MemoryDebugOps entry
get_phys_addr_attrs?); the MemTxAttrs can then be passed to the read
function in the MemoryDebugOps.

> This guest memory regions encryption status is found using KVM's page encryption bitmap
> support which is part of the page encryption bitmap hypercall interface of the
> KVM/QEMU SEV live migration patches.
> 
> As this additional debug support is dependent on the KVM's page encryption bitmap
> support, are there any updates on KVM SEV live migration patches ?

Sorry about that, I've been busy with QEMU.  I'll review them as soon as
possible.

Paolo


