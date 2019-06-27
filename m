Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CCC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C7F2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C7F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgUNM-00035Q-Ss
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 09:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgUKm-00082J-T4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgUKl-0000PB-O1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:21:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgUKl-0000Lf-GK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:21:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id f15so2569170wrp.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CDrR9Nsm0oTfwqp9uwCqko7bBznBmlA7BVlJ4TwTXPc=;
 b=MQawbwQcrCCe+EGoHQ1/ngg28ABCynp1dKQqVBO8g/TXlbvwXxJg7iH6e9ypcw/7Ou
 S+AsYjiFQ/fWhgy8U2sbQ0tS9G0ujQMoqvMavKjA9j1x0TQjfLSmVj1vqNxZob3upda0
 UGw9F/DeEo+n5tm/D5tsTtegWSa3XcCkX45hn/QdPRkz9E+/uCdKyu8NM/FKbfjJip6b
 GGdvdUecBkc7MDalFYaEOcgJllygzi7+c+tWDISiWlLlO/KlOyRe3UEMofZKdb+B8XKR
 ejk+4/gnNyEfLgJxqmwSNMUTtpjRCTicxVLm0yb6d4UegIkLtYEFKxeWbQcgnq9/Zg9c
 ELjA==
X-Gm-Message-State: APjAAAVLPmja9PqYOrwmndgxD70N/1caxOH1Yyl1ilYSYnN34N24VrxP
 93Jco3eGuGUU7F64tDrGRRFeZX4qiVg=
X-Google-Smtp-Source: APXvYqzdwvoEiwwL/XnwJJOw53JeC/EhsACFF3zqRz6dPVartCZXR1rEKyP4NyuVgf1hxZlDAunc4A==
X-Received: by 2002:adf:e705:: with SMTP id c5mr3414446wrm.270.1561641659488; 
 Thu, 27 Jun 2019 06:20:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9fc:4658:37f8:2b9c?
 ([2001:b07:6468:f312:9fc:4658:37f8:2b9c])
 by smtp.gmail.com with ESMTPSA id v27sm1450171wrv.45.2019.06.27.06.20.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 06:20:58 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <20190627090353.GA24929@redhat.com>
 <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com>
 <20190627125505.GH12358@redhat.com>
 <20190627131601.3zln6ywzewm35qvn@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e05632d6-751e-393e-ee12-97501a881ed1@redhat.com>
Date: Thu, 27 Jun 2019 15:20:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627131601.3zln6ywzewm35qvn@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 3/7] configure: integrate Meson in the
 build system
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

On 27/06/19 15:16, Gerd Hoffmann wrote:
>  Hi,
> 
>> Ok, I can understand that. I've been thinking about how we can switch
>> libvirt to use meson too, and trying to decide between meson being the
>> owner, calling out to make  vs keeping make as the owner and calling
>> out to meson. Ultimately to entirely banish make, autoconf, automake,
>> libtool, m4 & shell from our build system :-)
>>
>> Despite thinking about an incremental conversion though, I was still
>> hoping libvirt would just have a single (largish) patch series to
>> do a complete conversion at a specific point in time.
> 
> Another possible approach would be to have two build systems.
> The traditional configure & make and the new meson & ninja.
> 
> Advantage is we don't have to worry about the transition and mixing &
> make + meson at all.
> 
> Disadvantage is the duplication.  That wouldn't be forever though.
> I'd expect we'll have one or maybe two releases with both build systems,
> then delete the make & configure.

Yeah, I have seen other projects do this.  On the other hand I'm not
sure how you avoid bitrot in one of the two, and having to convert the
huge configure script from the beginning seems like a daunting task.

Paolo


