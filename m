Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64716C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7D9208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7D9208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8itP-00072U-Cq
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8ipa-0004Ik-3O
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8ipY-0007aR-8Y
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8ipX-0007ZI-SV
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:29:32 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA3A42D1EF1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 10:29:29 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id n6so13449558wrm.20
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 03:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vauwPtbjeZgfq127qNqjRJ2mtn1WKG9QoqNuBbVNdFo=;
 b=cLb7nD/lMKK5DV+46LRzXX2xDzhX27SKtRZPQneZNFZ2x5i5iZhhVFzUUUAKCRyao8
 5RNRNyLLFS1m/cfxfzH76g6rHc/tjuhZMvABGCKeRsecb51Piv37mToiHy9y9XMqunPb
 fNxilZhiCcvifSVDNo5odCGmyurn/viRe0gWe4tP/QVSc2oyDLPS4dUsXEzYrglztjGE
 VbLAjkVXDC0/jFRLq7eG8M8n3uC4bO3WzxisNEYZFHDmQhqiIIvQn6gaaLr+wUgqT2rG
 SQTK9H5Cvu8Cj9MgEUcal6lOjSkL4eoAFilhn/xxxD3zx0yzYMaTvE6hRDQZ4tmWpF3p
 gC4A==
X-Gm-Message-State: APjAAAW5T46E3RtXzII8Xij2vGAhOcrqnDiwOv+FFtlgBLc08aOi1xrY
 afE7a6fVLSj2Sg75KU0Mac04lvlfa8ccmJP1J+F/kCrYAOqi+qpflw4tUJX4SVHY4fc1SBp6s48
 S3an4SMvVJoilbh4=
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr35876140wru.48.1568370568584; 
 Fri, 13 Sep 2019 03:29:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyvJA5inYeA8r4/ErBgnjYk+azmoIIf5C8uEDXNhQLX8PENtbfCS8miEOeo2Ba5T5TvfsBw0A==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr35876122wru.48.1568370568346; 
 Fri, 13 Sep 2019 03:29:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c5d2:4bb2:a923:3a9a?
 ([2001:b07:6468:f312:c5d2:4bb2:a923:3a9a])
 by smtp.gmail.com with ESMTPSA id c10sm37913996wrf.58.2019.09.13.03.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 03:29:27 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190911190622.7629-1-dgilbert@redhat.com>
 <20190911190622.7629-2-dgilbert@redhat.com>
 <e8802180-3c9a-97b9-dae1-5e07d7843de3@redhat.com>
 <20190912174524.GD2722@work-vm>
 <cfead2da-0ccd-b629-4e5d-05cdffa34698@redhat.com>
 <20190913102445.GA2682@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e87197ef-ca47-8859-a4ed-5c2cd5e6324c@redhat.com>
Date: Fri, 13 Sep 2019 12:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913102445.GA2682@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/5] rcu: Add automatically released
 rcu_read_lock variant
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
Cc: quintela@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/19 12:24, Dr. David Alan Gilbert wrote:
>> We could also add LOCK_GUARD(lock) and WITH_LOCK_GUARD(lock), using
>> QemuLockable for polymorphism.  I even had patches a while ago (though
>> they used something like LOCK_GUARD(guard_var, lock).  I think we
>> dropped them because of fear that the API was a bit over-engineered.
> Probably a separate set.

Definitely so.  Thanks!

Paolo

