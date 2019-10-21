Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F9DCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDAC2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDAC2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTLy-0001TO-HM
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMTL2-000101-3E
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMTL0-00035r-Q5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:46:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMTL0-00034T-KT
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:46:50 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98A52C057EC6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:46:48 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id u17so241061wmd.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yguR9XSrQSy4qyjSZ4WvBI3X1UqOF2kgF3I5zwSLgAU=;
 b=Tu/nbaT0S6tyk0LdE0HtZq9YeBTcfNSgIzoM2mBpGtq63Y5Ay0DmxGrMjhlrPEMT0k
 TZ3yhveSukNGhK4+JUrtSXOScONBG/ul0VT3z/62EfMOZqu8afQheBA/qlRlhWFUZtFk
 s+5+OjinGlEbpgOguk/SiQQ03EtWgK4XndTJC7ZAZtpcn/LhHfNI+22SyveL8T7sg3U/
 q8YN2zxXdlpZh+QIHcfi8eOKx+8h+zRlph5RqTqmR25Gt+B3qOl9uF9Q/H7nwPCHY5eT
 TCijxrhLBXAUvrlw/K2uPjgBtDBfg/GShbnqQLPMegiwAl9oci/0xJu7d+qxqo9ZMNdX
 dU+w==
X-Gm-Message-State: APjAAAUyp3J+BUP/om5YfFJ8NENFyx/D7rXoc1nRpWTrgaCPJbheqVHl
 1fnQHFo/B0PsliTbfpXkA69pe2uGUoX1bzpVS8vI5LahLyGQRStt81TUk71/MhAWy6sapbyerpG
 mQL6bA3E/WrkDhWY=
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr18343056wmk.126.1571647607297; 
 Mon, 21 Oct 2019 01:46:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwb+1Qs44J4OWK0u6z9sN5zmMqBnRi/XpRw9/nJ0/quK/n5hB9kGzNzc93cx+EaQvwebTi6Eg==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr18343039wmk.126.1571647607043; 
 Mon, 21 Oct 2019 01:46:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:566:fc24:94f2:2f13?
 ([2001:b07:6468:f312:566:fc24:94f2:2f13])
 by smtp.gmail.com with ESMTPSA id y5sm3819787wmi.10.2019.10.21.01.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 01:46:46 -0700 (PDT)
Subject: Re: [PATCH] error: Fix -msg timestamp default
To: Markus Armbruster <armbru@redhat.com>
References: <20191010081508.8978-1-armbru@redhat.com>
 <167c9b31-7592-de9f-a1a3-e79d8e66fc5c@redhat.com>
 <878spe8ts7.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <29710dbf-c362-2e62-e9ad-e33ee90a0a3a@redhat.com>
Date: Mon, 21 Oct 2019 10:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <878spe8ts7.fsf@dusky.pond.sub.org>
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
Cc: msmarduch@digitalocean.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/19 09:03, Markus Armbruster wrote:
> In my review, I proposed replacing it by error_guest_name, to avoid
> having to get -name parameter "guest" all the time.  I included a
> revised patch to illustrate.  Goes on top of this one.  My revised patch
> doesn't fully address my review.  In particular, there's a TODO in the
> commit message.  Mario, would you be willing to complete it and post it?

Yes, it's better if I leave the whole series to you and Mario.  I'll
just get the KVM MCE changes.

Paolo

