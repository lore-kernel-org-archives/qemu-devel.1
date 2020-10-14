Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1275C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404FA20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFVgoD7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404FA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kScC5-0003xR-3q
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSc8r-00014T-T4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSc8p-0008LT-O9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602664090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZZ9hnLpBSfUPYJnzrr8XxQqJEL/cKh9kdDj1jdY0mI=;
 b=IFVgoD7x1dyUKYaW6cxQSwHrhvoGn/NaVnSntmyO++GvCxCF+3BmqnOoeDTogb/Ddubw5v
 INOLSf00cWZVEKFO+c2FoIxZd5y+psr6XlK/2glOTBmTiKwOeKdnCNp6DgEWACrF4w6kbI
 CA88CpiSWdnkbSVMP/6qEM5ipnQ70rc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-NxNf8OLSP-6OxkJ5ytRoKA-1; Wed, 14 Oct 2020 04:28:09 -0400
X-MC-Unique: NxNf8OLSP-6OxkJ5ytRoKA-1
Received: by mail-ej1-f71.google.com with SMTP id c20so871274ejs.12
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 01:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MZZ9hnLpBSfUPYJnzrr8XxQqJEL/cKh9kdDj1jdY0mI=;
 b=N2nnaHKY+EIGI/JdXmhkfcnaszeT0OEpR72t/kfEfvX7BeETUtLWWt+Ofs9i0fFxva
 V9cdtJ+mbFfOxvRf/ZprI4J+Hn9tKXNdGRPcWkOb2ffZAxmhEw+Q8sxiGlpSBZcXYFYU
 Wlx1JCWf5AIQfLrU/FXG9WOT0stKAHWpQ9qSaS7802KAZ8mDKCj+vrSEvsF9GXOKmxhA
 4Ros2d55THKbKS4w2MGEgA0Zdf8rXJ4JUdJsoaIs/SvByWkD7Y1T16065wiZosLa0/8v
 T6bAjuui6sFZ/an9Mp1fD3F7qXiR0SRBzJFoQjpFY21qP95tNF1lXvjiHg9KFn510cB7
 2UMw==
X-Gm-Message-State: AOAM530+TZS6Xjw2JzdBT44nBDElfIfR+xzthdcwojgSPXoSm7ylq6m3
 9NdHm03R8g9FpT10OLqrT1/5Xf7V39MOFmrJM8QqabTRcmT48knKtTz9LFN3aFJfA9KpXeshEn3
 J3vqpudgwZRAydPc=
X-Received: by 2002:a17:906:4e19:: with SMTP id
 z25mr4280719eju.44.1602664087759; 
 Wed, 14 Oct 2020 01:28:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzum0nzPjm+ya3l+65XT3fFEQPrAM01mV7i4zpCRmhZN3Ic86tRPf+B9dOifSlQiZiw5WPMGw==
X-Received: by 2002:a17:906:4e19:: with SMTP id
 z25mr4280709eju.44.1602664087568; 
 Wed, 14 Oct 2020 01:28:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e5f7:db3b:55ea:7337?
 ([2001:b07:6468:f312:e5f7:db3b:55ea:7337])
 by smtp.gmail.com with ESMTPSA id bu23sm1110816edb.69.2020.10.14.01.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 01:28:06 -0700 (PDT)
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: harry harry <hiharryharryharry@gmail.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
 <20201013070329.GC11344@linux.intel.com>
 <CA+-xGqO37RzQDg5dnE_3NWMp6+u2L02GQDqoSr3RdedoMBugrg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <626a8667-be00-96b7-f21d-1ec7648ee1e6@redhat.com>
Date: Wed, 14 Oct 2020 10:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+-xGqO37RzQDg5dnE_3NWMp6+u2L02GQDqoSr3RdedoMBugrg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, mathieu.tarral@protonmail.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/10/20 00:40, harry harry wrote:
> Q1: Is there any file like ``/proc/pid/pagemap'' to record the
> mappings between GPAs and HVAs in the host OS?

No, there isn't.

> Q2: Seems that there might be extra overhead (e.g., synchronization
> between EPT tables and host regular page tables; maintaining extra
> regular page tables and data structures), which is caused by the extra
> translation between GPAs to HVAs via memslots. Why doesn't KVM
> directly use GPAs as HVAs and leverage extended/nested page tables to
> translate HVAs (i.e., GPAs) to HPAs?

See my other answer.  What you are saying is simply not possible.

Paolo


