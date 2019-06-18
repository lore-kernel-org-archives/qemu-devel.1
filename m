Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A65C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D37020B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D37020B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHYn-0008UV-7P
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdHDE-000644-Mf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdHDD-0005jE-Rg
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:44:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdHDD-0005hx-KT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:43:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so4054155wme.4
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U9zxtkoZwhnJFFCX0A2D5Wx51sna0MNIsF7wCnvQr8Y=;
 b=UO+8T42RkS3prAOwvkbVaXV+J0+/h5wZfHgLXqTgTKgahXKWR7btKQUbIbNtKpsffJ
 uFt5n1sL3aGHMRVPZJIi9dtSfaUZD5bSb6rfz49dMkAHRNpwsSOuOKmr6M8z89LfSWl0
 6TzMRFce7y3sleP/4JvQHj5rJ3Te0+6F8OsyhwdtUkvOONB0gOcAFVtqD3uwP5tshyt3
 KEOdH4qqBKgiZ55qeHNUH8KAhax+WUou7H0FSycLvbYYu94wamEAQlcaE0BNK89X+a3p
 FDmGlL6mKUVGAhGA70H1Hcw+RI7HsM3pt1B/42BQfAp8x7if9HT1IHrA5QG+FWIo8kX6
 sAKA==
X-Gm-Message-State: APjAAAUusAeZIxoi35CQaH14ZxRbYtQJgf9DCecDTiQWNXdHp5Mc/uqM
 3nVLoNYkAkGJzqZ5NknFVxx5Uw==
X-Google-Smtp-Source: APXvYqxqaxwx9AsD8KRHoKJayou8ibFDWOOap67b06dvF+r+xR0glc/5phevjwrXe35EFPEpcGPm3g==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr4769563wmh.115.1560876238594; 
 Tue, 18 Jun 2019 09:43:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d?
 ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
 by smtp.gmail.com with ESMTPSA id e7sm1944266wmd.0.2019.06.18.09.43.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 09:43:58 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Liran Alon <liran.alon@oracle.com>
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-7-liran.alon@oracle.com>
 <20190618085539.GB2850@work-vm>
 <AB34E76F-231C-4E66-B5CB-113AFCE7A20F@oracle.com>
 <20190618154218.GH2850@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5816685f-32f7-68dd-596c-7dcfaf7e3d4f@redhat.com>
Date: Tue, 18 Jun 2019 18:44:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618154218.GH2850@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [QEMU PATCH v3 6/9] vmstate: Add support for
 kernel integer types
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, rth@twiddle.net,
 jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/19 17:42, Dr. David Alan Gilbert wrote:
>>> Have you checked that builds OK on a non-Linux system?
>> Hmm that’s a good point. No. :P
> Worth a check if you can find one lying around :-)

It does not, but it's a macro so it's enough to enclose the uses in
#ifdef CONFIG_LINUX or CONFIG_KVM.

Paolo

