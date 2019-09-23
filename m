Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D5C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E768207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E768207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMtD-0000OD-Kl
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCMp2-0005Lc-Th
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCMp2-00064J-2W
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:48:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCMp1-00063j-TU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:48:04 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B7DF4E938
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:48:03 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so4732318wrq.19
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 04:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wcMCtshWnSV/TbYLLNXk21ZVUDcM5NTRhYx7eBXHOo8=;
 b=B/W7Mch/dTarRGL0mwumk6PkXHWz/5VeDhGSBq1ah061hZcwHv7L+a+nQO+qBcnXfj
 ah9ks83OgDh/cPrFZ9cmToaM81Nx1Y3mvhupikfA2z9NBPYiNCB5+yYM0VmWmMm1vVsh
 PAdWlEyxCpjpiERVGFa/mq9+T0jnODP/TX5Qo6iebNKeRJJSbkXWBpD9Oh9VJs0SGSyB
 wUZ6PiPXFaCtdlqt8HDvwFJhChuW0oLILF6lyUhJhEuj+ldOi1Ua8f0qmLZ6RABUXwrX
 64OjthS03K6DD98aeE7AtYTtolkvx42BsweDnMIrO0+6tpi+TMfPOB2u1KWt68LGWs/y
 7oCA==
X-Gm-Message-State: APjAAAUziCFHVgepP0GYZ4pBYJmXrroTZKBjl2JmfnvK/QHy3prOo0sA
 lLLmVPWpy1kGD4Shb7ABZ1iXAz6XwpCa7lBzIt83THgNTSoT+W5RSlfiyAGSxXTuLWVcgYivQjR
 1i6VlToiSj+O+ybo=
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr9229745wru.12.1569239281539;
 Mon, 23 Sep 2019 04:48:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkTAZfDYhqT+1sefLRpdnF369n4VcfRg2xo375gJSGvjt/9z96AMYCDABg8jimfXDqj+mW0w==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr9229727wru.12.1569239281239;
 Mon, 23 Sep 2019 04:48:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id t6sm16858164wmf.8.2019.09.23.04.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 04:48:00 -0700 (PDT)
Subject: Re: Migration failure when running nested VMs
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jintack Lim <incredible.tack@gmail.com>
References: <CAHyh4xhYrUbK0aEJmKp3_kOJG2E+AQLMUjyf7_pXVJgbqgv5JA@mail.gmail.com>
 <20190923104245.GA2866@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6fa1b7a6-52c8-fc98-c532-f2c0484d04b0@redhat.com>
Date: Mon, 23 Sep 2019 13:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923104245.GA2866@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/19 12:42, Dr. David Alan Gilbert wrote:
> 
> With those two clues, I guess maybe some dirty pages made by L2 are
> not transferred to the destination correctly, but I'm not really sure.
> 
> 3) It happens on Intel(R) Xeon(R) Silver 4114 CPU, but it does not on
> Intel(R) Xeon(R) CPU E5-2630 v3 CPU.

Hmm, try disabling pml (kvm_intel.pml=0).  This would be the main
difference, memory-management wise, between those two machines.

Paolo

