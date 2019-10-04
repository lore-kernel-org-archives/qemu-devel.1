Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0957C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F19215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F19215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMWN-0007T2-65
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iGMSX-0005tU-0s
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iGMSV-00064q-IW
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:13:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iGMSU-00063R-FR
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:13:19 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66F45C010925
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 12:13:16 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id s19so1538004wmj.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 05:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I/+3oWvTBkjp4fCjo+Yb0vZD4x6p3dKk8JBZFOgKexY=;
 b=oX655PJ5IYrUMgTUuRYcSYfMA0aQZlu/GzA3PH4SkRkK0pReX8sKtOmY7i4r63AyEy
 qZ70RzlcYW+tcfLdqnVEX2XvyFC14sadQ51Zyop3n+UU8Ytf4JvX9iWNqw49hS+KcsP6
 0KJdUJJWNpEiIQx4NscZ9igQpFP3VwQjsOwEN4hSXxf+GBWyrRPQlg6fi6Ut4cTD3IS0
 DPpFzTWNQq0pImS8Ydoi87f6Lywtq0v+wdxPUSeN4fjSd5wA+gssetUpWHuOvsD0ehSr
 WauVJgSdaYAHud/THTP3tS8xAcdkETjFpMB4Z07UvMYc40rS1QAfl5OC0VI0lW1S6O+0
 FlGA==
X-Gm-Message-State: APjAAAWKortL4OIE85lWd5CIpRmZr3is8VGVQTlBHbNpkNBzK2AjtBqt
 9ILmLJsqBET0eHT/RV/Z+ZbqL2cZ/AKecKQ+ZcJ6grMJzXZjyOO82BtzaDXaH+TpjSm387BJCei
 Rqbk/3hofhhlwufk=
X-Received: by 2002:a5d:4751:: with SMTP id o17mr11301802wrs.113.1570191195034; 
 Fri, 04 Oct 2019 05:13:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPXdFKYk3BVQydJV3NFDhKxg+UUfTKLrEW2Nvagl08HtFLoRLTiV2RAWcP2YbyOGd7bYN8Kg==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr11301774wrs.113.1570191194730; 
 Fri, 04 Oct 2019 05:13:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e56d:fbdf:8b79:c79c?
 ([2001:b07:6468:f312:e56d:fbdf:8b79:c79c])
 by smtp.gmail.com with ESMTPSA id a2sm7184100wrp.11.2019.10.04.05.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 05:13:14 -0700 (PDT)
Subject: Re: libvirt? qemu change that mmaps ELF files breaks libvirt svirt
 handling for os.kernel
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <d450afbe-06ae-f6f7-3bc0-f1a54c31907c@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1dc0a320-b771-072d-d1f4-4eda2ab51a1f@redhat.com>
Date: Fri, 4 Oct 2019 14:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d450afbe-06ae-f6f7-3bc0-f1a54c31907c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/10/19 14:03, Christian Borntraeger wrote:
> Stefano, Paolo,
> 
> I have an interesting fail in QEMU 
> 
> 2019-10-04T12:00:32.675188Z qemu-system-s390x: GLib: g_mapped_file_unref: assertion 'file != NULL' failed
> that bisected to 
> commit 816b9fe450220e19acb91a0ce4a8ade7000648d1 (refs/bisect/bad)
>     elf-ops.h: Map into memory the ELF to load
> 
> strace tells that I can read the ELF file, but not mmap
> strace:
> 214365 openat(AT_FDCWD, "/var/lib/libvirt/images/test_cpu_timer.elf", O_RDONLY) = 36
> 214365 read(46, "\177ELF\2\2\1\0\0\0\0\0\0\0\0\0", 16) = 16
> 214365 lseek(46, 0, SEEK_SET)           = 0
> [...]
> 214365 fstat(46, {st_mode=S_IFREG|0755, st_size=168176, ...}) = 0
> 214365 mmap(NULL, 168176, PROT_READ|PROT_WRITE, MAP_PRIVATE, 46, 0) = -1 EACCES (Permission denied)
> 
> So reading from /var/lib/libvirt/images/test_cpu_timer.elf does work, mmaping does not.
> setenforce 0 makes the problem go away. 
> 
> This might be more of an issue in libvirt, setting the svirt context too
> restrictive, but I am not too deep into the svirt part of libvirt.
> Reverting the qemu commit makes the problem go away.

Yes, the policy is too restrictive in my opinion.

Can you include the output of "audit2allow" and/or "audit2allow -R"?

Thanks,

Paolo

