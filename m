Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662FEC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CAF206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5HHFJYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CAF206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBXk-0004FQ-Cb
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVBX1-0003i5-1g
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVBWz-0007ev-MF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:35:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVBWz-0007ej-Hm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573724112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=E896oExkGxJDYqZFrYPQcQ4KqYQe0zOTxKrxWcNKok0=;
 b=A5HHFJYIvbGS/lNEmG2HVnK9WxgitUYE/LQLwdlDLDUQCvc6H/RJ/9Vaj75oQww3oFe5vg
 m0iSDrjg8xWKPJorKgg9sRKcEktd+njiyVNoNTWEvPSTKjNIkwEBxEfL2AnGR40DIPu66g
 AUfWzLkmCqE/VWxdGOmg2RptmRWgKiI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-L-mm-iV3NNeESPkBspkMHw-1; Thu, 14 Nov 2019 04:35:11 -0500
Received: by mail-wm1-f70.google.com with SMTP id d140so3843342wmd.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QYKPu3fVw4Ep5LiBbn800fKqeBk0FGEB/k/8u06E5o8=;
 b=bhgU0xdoCWN4YfhY3jbSZ8YkvQ6dpYlilur5uhgi7brvl52e+oLYhbe/UUslgO3CO4
 jlNIMpWIjsO7U2FEGeWzxbkeIMwgBiNS06lG6E6JM9Zx2EOapURl8Y/RNbnAfBfrNEaD
 bO4olqXBSFgGDw/SzFvatsJEopLiZk/NeB8U32gee1QPJTkIhOLU0FwELYykmeWshm4t
 tIn1tbyys+/aSNADT2056vtYDnbHkPi0wHw4Qwxt5IoAH0rc0Xs80F4SFeNjAB6z3CUS
 0d7aCre4RevqOr+sHFGuhTHYanW84OW+bRdndd6xXn8Lhzreoc6GJFPMIEyH6LaLA+9+
 296g==
X-Gm-Message-State: APjAAAWA2FZbFhv4g1uh8q/V1g1dHNbLYmYhbjkeNz6Fh4SXYD4Wh0W+
 3WNAW21pBeaOKQHF4t75Hlsbi7tDa5BdazMV1nURM+MKV62NadV+vARM3aaOCEo1s5gfo5Anthf
 SEHpLshJhZSGDJJI=
X-Received: by 2002:a5d:518c:: with SMTP id k12mr7214542wrv.104.1573724110704; 
 Thu, 14 Nov 2019 01:35:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTkXrWmhbJ/VjyEFicbQB/n+nQFKupKMIGGa8NF1D+UAnfDomY58qs7qR7ISy8P/EFBOuE3w==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr7214515wrv.104.1573724110425; 
 Thu, 14 Nov 2019 01:35:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id s17sm5000772wmh.41.2019.11.14.01.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 01:35:09 -0800 (PST)
Subject: Re: [PATCH 01/16] memory: do not look at current_machine->accel
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-2-git-send-email-pbonzini@redhat.com>
 <2db4f901-65ad-4b80-d309-b8b63330492f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4783e606-19b8-c3c0-08ab-ac84b02af6f4@redhat.com>
Date: Thu, 14 Nov 2019 10:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2db4f901-65ad-4b80-d309-b8b63330492f@redhat.com>
Content-Language: en-US
X-MC-Unique: L-mm-iV3NNeESPkBspkMHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/19 10:10, Thomas Huth wrote:
>> "info mtree" prints the wrong accelerator name if used with for example
>> "-machine accel=3Dkvm:tcg".
> I had a quick look at the output of "info mtree" with and without
> "accel=3Dkvm:tcg", but I could not spot any obvious places where it's
> wrong. Could you give an example?

Indeed the commit message should say "info mtree -f".

$ x86_64-softmmu/qemu-system-x86_64 -M microvm -enable-kvm -machine accel=
=3Dkvm:tcg -monitor stdio
QEMU 4.1.50 monitor - type 'help' for more information
(qemu) info mtree -f
...
FlatView #1
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 Root memory region: system
  0000000000000000-00000000000effff (prio 0, ram): microvm.ram kvm:tcg
  00000000000f0000-00000000000fffff (prio 0, ram): pc.bios kvm:tcg
  0000000000100000-0000000007ffffff (prio 0, ram): microvm.ram @00000000001=
00000 kvm:tcg

Paolo


