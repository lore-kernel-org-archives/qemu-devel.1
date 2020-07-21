Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7ACC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A6120720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv1lz9R3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A6120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxo8I-0000xD-Db
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jxo7T-00005z-Vl
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:59:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jxo7S-0004pG-BY
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595321965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gm31oYrr9yYNUUSwA3soCdHxf5TJyBMC9AzTE8/VYwE=;
 b=Jv1lz9R3MVTedRhYovCUjLrrBprAnEcJCHUJ8ncD5iyxAvdsZ4p2wYkqwB6pBhpkkfD7t/
 YHOt6OQn/ur6FoiMmWm2qzGgwxCsy0aUKL43mBj+obWmVKCaQFQ4uKHQDf/4NBnxscKV6k
 +7UkO0M8rK22A6OiVUAXZwBIEWGb6tE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-Lea6ZHrbMU2dSKY0hePdbQ-1; Tue, 21 Jul 2020 04:58:14 -0400
X-MC-Unique: Lea6ZHrbMU2dSKY0hePdbQ-1
Received: by mail-wr1-f70.google.com with SMTP id v4so5719722wrb.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 01:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Gm31oYrr9yYNUUSwA3soCdHxf5TJyBMC9AzTE8/VYwE=;
 b=tw/7otnDr/wsnekBqtZLg0XrkIJTPwNsHm8XRL6V9hazNJMBNr+YykeEjQIDnRrdgl
 kLUGUSlebHAnihOxQdnaGI5FgaugKiJ+vQ8jHP3laj0rMQH68DvHbVVHdFmksOWR8MZ+
 8yZg2RLsC82gvAXzFlUmb3VRJp66y5223fcI8dfUYqHyiW6/D7nP8ggxkMz8PmPRZ9al
 DSmcAT4dCQVJzgvlsA7y3yXKKiof8V2jPRyCpqMPW2Qt8Jqdm5RaPRDlHjtAUTMXgM4J
 K53k6pPFTDpOT+f0QvWkh2o6aSzv/AZA0vwhvNVK64VtCltPF/dBZW0A41w1SksBPYp8
 zrdA==
X-Gm-Message-State: AOAM532ESpKphAJ2FaFPC1fAkSEFrTWZ5MgqDBxQUaS81rY8efA4GpFC
 HsTVDWxSVZXG8o0gPFmogI7CvzxcOEwiGb6C+1/aLWORmAtnsQSemC00WcUKBSy6JPgPP8LEHXS
 tHm4bXUFCJ738J2A=
X-Received: by 2002:adf:eccd:: with SMTP id s13mr27508370wro.217.1595321893712; 
 Tue, 21 Jul 2020 01:58:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAtHrn5CO4SGpsWVWoKUPQv4QJMgeXk/OpQFtC+FZadaYYykylBB4UAeyxlKneVQszYeXHqA==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr27508355wro.217.1595321893528; 
 Tue, 21 Jul 2020 01:58:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id h10sm1461833wro.57.2020.07.21.01.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 01:58:12 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] i386/kvm: correct the meaning of '0xffffffff' value for
 hv-spinlocks
In-Reply-To: <20200720194039.GX1274972@habkost.net>
References: <20200515114847.74523-1-vkuznets@redhat.com>
 <20200720194039.GX1274972@habkost.net>
Date: Tue, 21 Jul 2020 10:58:11 +0200
Message-ID: <87r1t5p7mk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, May 15, 2020 at 01:48:47PM +0200, Vitaly Kuznetsov wrote:
>> Hyper-V TLFS prior to version 6.0 had a mistake in it: special value
>> '0xffffffff' for CPUID 0x40000004.EBX was called 'never to retry', this
>> looked weird (like why it's not '0' which supposedly have the same effect?)
>> but nobody raised the question. In TLFS version 6.0 the mistake was
>> corrected to 'never notify' which sounds logical. Fix QEMU accordingly.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> I've just found this buried in my inbox, sorry for missing it!

Better late than never! (And, to be honest, I completely forgot about it
as well :-)

>
> Queued for 5.2.
>

Thanks!

-- 
Vitaly


