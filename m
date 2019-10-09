Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985EEC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71575205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71575205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJy1-0000RW-Ic
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIJMb-0004cK-Bb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIJMZ-0003zs-LP
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:19:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIJMZ-0003zf-Cs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:19:15 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81AE464043
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 21:19:14 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w8so1689148wrm.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 14:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zz5bhF6zfv+jR4MxHD4U4Soo4rdcQIP8qAHAJ/r2e0g=;
 b=KrEPiKG8tufkQK8qSwDa4I5vYZk+CcPU64PyhHh4yJ5kgV57CDvOuQOeY98t4e0hHR
 kHe4JKjvhKUt3tZ/MED9W7QuN9wHSa7ZRpHWE1Sdu4qWBqBefmamTMcZ26cFVpOK3tgn
 bAyGC32gUA7D/aPRvOQLYm6vevUPc7LcfkqHBH+FdeMz8nlBQFyzg2cvf0aql78fFC1G
 JlKXGmp7adLKm8pJfNBj3wbPrXm2l9ot6bnr76At5WnCecnvKF1jQ/oQv8Yn3ZViNSXJ
 +JZdlxbO3OLalt4D0bxVEzqKi4SNBMzaAMHTwJJ3NieHyBNHch3+msNahyKwQqV0pPm+
 Tp4g==
X-Gm-Message-State: APjAAAV9glRuJu3eUSUJadAkFgVHZeadmSdIriihAZSMwKXkpd9IMwI3
 mE/ECyB+d/2hDOc2hbzIIxAjEVoBC9qUXrYlKXiDBCdmdAc89ZD4rYU/vNIID5GcVmzciKm9wfB
 G2qRvBu18Y2/ibJ4=
X-Received: by 2002:a5d:6592:: with SMTP id q18mr5040491wru.382.1570655953127; 
 Wed, 09 Oct 2019 14:19:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwNCZNQfZZgNTPhUBtSUSZTx06BSOQ3+OhjHfq/mE2O2uyDEy86uvCIFtB++XKELdIzcCgSew==
X-Received: by 2002:a5d:6592:: with SMTP id q18mr5040470wru.382.1570655952808; 
 Wed, 09 Oct 2019 14:19:12 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q15sm5644526wrg.65.2019.10.09.14.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 14:19:12 -0700 (PDT)
Subject: Re: [PATCHv2 0/2] log guest name and memory error type AO, AR for MCEs
To: Mario Smarduch <msmarduch@digitalocean.com>, philmd@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com
References: <20191009164459.8209-1-msmarduch@digitalocean.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <71149051-f7b9-b3ef-8493-4e2db1644a8d@redhat.com>
Date: Wed, 9 Oct 2019 23:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009164459.8209-1-msmarduch@digitalocean.com>
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/19 18:44, Mario Smarduch wrote:
> In a large VPC environment we want to log memory error occurrences
> and log them with guest name and type - there are few use cases
> 
> 
> - if VM crashes on AR mce inform the user about the reason and resolve the case
> - if VM hangs notify the user to reboot and resume processing
> - if VM continues to run let the user know, he/she maybe able to correlate
>   to vm internal outage
> - Rawhammer attacks - isolate/determine the attacker possible migrating it off
>   the hypervisor
> - In general track memory errors on a hyperviosr over time to determine trends
> 
> Monitoring our fleet we come across quite a few of these and been
> able to take action where before there were no clues to the causes.
> 
> When memory error occurs we get a log entry in qemu log:
> 
> Guest [Droplet-12345678] 2019-08-02T05:00:11.940270Z qemu-system-x86_64:
> Guest MCE Memory Error at QEMU addr 0x7f3c7622f000 and GUEST 0x78e42f000
> addr of type BUS_MCEERR_AR injected
> 
> with enterprise logging environment we can to take further actions.
> 
> v1 -> v2:
> - split into two patches one to get the gustname second to log MCEs 
> - addressed comments for MCE logging
> 
> Mario Smarduch (2):
>   util/qemu-error: add guest name helper with -msg options
>   target/i386: log MCE guest and host addresses
> 
>  include/qemu/error-report.h |  1 +
>  qemu-options.hx             | 10 ++++++----
>  target/i386/kvm.c           | 29 ++++++++++++++++++++++++-----
>  util/qemu-error.c           | 31 +++++++++++++++++++++++++++++++
>  vl.c                        |  5 +++++
>  5 files changed, 67 insertions(+), 9 deletions(-)
> 

Queued, thanks.

Paolo

