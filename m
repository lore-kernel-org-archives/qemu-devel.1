Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA377C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25B820673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25B820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heLeL-0008P8-QQ
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1heLdM-0007iP-G6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1heLdL-0003sJ-7Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:39:24 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1heLdL-0003rZ-0R
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:39:23 -0400
Received: by mail-wr1-f48.google.com with SMTP id v14so7047562wrr.4
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 08:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/5Fl7jKdJw5qCmU35z+n5kM2fVIO3vsnKgfnMWCl5dE=;
 b=MwSKMGDnfeAY33fJzZb2hr2DmyzzOwn7+9Sq3K1Lw2YNKTacKOkFD2xLKNrrxKnlfj
 XHUkKwlJPr8pKM1x6WW7sd/8ML8InyMuXkztpp9JcedcHnKdAGPyjuKS9qDfRi0jucPV
 BP2Bbf7HgJXZo5/Eq5LfTCEW4tHha9Nk2OKrjFLyOO/8UkyRBEHbtwiN2s2wvMXG2jHf
 MiarlvEJUIeYPpUTqR8+5StdPQM6gLRq6cYM8c3QVTO/5Ar3er3Os8quYTZP9ZQlk7kF
 nTcWPRyq0WD6PnnWOIg3ZYgRL1IJAnu9YBjdlvsUwkG/AB0+mPIaUn6hmhi2b9xuzI1q
 H9iw==
X-Gm-Message-State: APjAAAXOdw/M1Q250ndlSVMCUr7Ul23+bSdye9X9krlvyB/rW7Pv9qCQ
 PHoqJbQd2MZcMe9/AG7ycnx8A5ReEc8=
X-Google-Smtp-Source: APXvYqymKZBtSneuMK1tgWTN25mA0BULPrt71Y3plHA3mFmcQklbfXEN2Ur/O/PFr+iaDN4w5NzAgw==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr20040441wrn.216.1561131561642; 
 Fri, 21 Jun 2019 08:39:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id g8sm2237917wme.20.2019.06.21.08.39.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 08:39:20 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
 <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
 <3b4d778c-8c41-b8f2-7e1c-b7328072c3d5@redhat.com>
 <96B0BE25-AA15-4FAA-9228-A68C0845E110@oracle.com>
 <beac3448-d66f-438f-c0bf-b35bc7c90137@redhat.com>
 <10C55D5F-B505-4172-8500-D8EBCEA43941@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c67d746-6095-25a8-d569-0d590024c3dc@redhat.com>
Date: Fri, 21 Jun 2019 17:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <10C55D5F-B505-4172-8500-D8EBCEA43941@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.48
Subject: Re: [Qemu-devel] [PULL 20/25] target/i386: kvm: Add support for
 save and restore nested state
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/06/19 17:00, Liran Alon wrote:
> Cool.
> Are you planning to make those changes when applying/merging or
> do you need me to submit a new patch-series version?
> Also note my comment on the other patch regarding block migration on AMD vCPU which expose SVM.

It's already merged, but it's not a big deal since it's only AMD.  We
can follow up before release.

Paolo

