Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66858C4360C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 16:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D60120835
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 16:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D60120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iH99e-0003LK-DD
	for qemu-devel@archiver.kernel.org; Sun, 06 Oct 2019 12:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iH98V-0002Yw-9D
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iH98U-0006wc-2y
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iH98T-0006wG-To
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:11:54 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D47A883F45
 for <qemu-devel@nongnu.org>; Sun,  6 Oct 2019 16:11:52 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k67so2284088wmf.3
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2019 09:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T4rtIVyNbX3AmeHViU22cZEfjzHvDZfc22fjcoeRsak=;
 b=Hl5W0JsRJyKgsg2acL1szo24s4IHSFIaZZb8tMYM6U3QZv8F5AEHdRoH8YGT1kyQbw
 /AurPEmZKQV80j5DU2epECs03eW7rf+KLbU26qNgR1AOTspBDcU5l5bGioiXNJtBd+7p
 Op2aQOolhFyPsVUzbTTbgEvRs4/t/TgFvA2HX9BC+AEqP/oI032kE5llm6SvN38NpYpd
 xTWUqzPkhCPplgv7FBAD5XIp8PpBjNKAT7BiBw5uKx9QZhyIdajF+qFXsll7GahTPS2G
 QhgRkIqUmMgry0rodXWED89zFF2WPIsfeRjLoaQifGI4ALMNkP6Tz0YZFkD5kJ6u1gvb
 o5Jw==
X-Gm-Message-State: APjAAAVRdBm1BYGbf3qfvsEj7vYupRFzgd6tn0CjauVGarN+kHoj7zXe
 L2tp2XqurQSMKscRNncT14mb2xILNoIfpDqRXUJ/uR5E3YFrCYDQJ7hfkcVuB3sEJkMT/7LIf0u
 9V+ZdyXAHxsh8JvY=
X-Received: by 2002:adf:eb8d:: with SMTP id t13mr17867295wrn.53.1570378311416; 
 Sun, 06 Oct 2019 09:11:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+jgBd0V+FfwXx3881WMWzXWPrCQYrF9njBD8483tXNBXQwwPszcV8F+8drh9J1ZfR1ivyug==
X-Received: by 2002:adf:eb8d:: with SMTP id t13mr17867278wrn.53.1570378311168; 
 Sun, 06 Oct 2019 09:11:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e876:e214:dc8e:2846?
 ([2001:b07:6468:f312:e876:e214:dc8e:2846])
 by smtp.gmail.com with ESMTPSA id a71sm11000251wme.11.2019.10.06.09.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Oct 2019 09:11:50 -0700 (PDT)
Subject: Re: [PATCH] target/i386: log guest name and memory error type AO, AR
 for MCEs
To: Mario Smarduch <msmarduch@digitalocean.com>, mtosatti@redhat.com,
 armbru@redhat.com
References: <ceb4d639-842a-30bd-5d54-bfacb07b5cc4@digitalocean.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c78d014f-20f4-d25f-e50a-92c960200d7e@redhat.com>
Date: Sun, 6 Oct 2019 18:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ceb4d639-842a-30bd-5d54-bfacb07b5cc4@digitalocean.com>
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

On 05/10/19 01:53, Mario Smarduch wrote:
> Guest [Droplet-12345678] 2019-08-02T05:00:11.940270Z qemu-system-x86_64:
> Guest MCE Memory Error at qemu addr 0x7f3c7622f000 and guest 78e42f000
> addr of type BUS_MCEERR_AR injected
> 
> with enterprise logging environment we can to take further actions.
> 
> Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>

The guest name part should be a separate patch, controlled by "-msg
name=on" or something like that.  The MCE parts look good okay.  Can you
split the patch in two?

Paolo

