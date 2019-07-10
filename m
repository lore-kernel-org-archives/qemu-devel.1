Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1583C73C6D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899572064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899572064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl5sR-000810-Pl
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 02:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hl5rt-0007Ui-MB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hl5rq-0001HV-1f
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:14:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hl5rp-00019G-Hh
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:14:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so899950edo.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 23:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/o3x5qOy3xHjcrMltm0J8mgZ8oU3Ci8q369/gw2f3TQ=;
 b=TDNgoNHfAxLywDEbDe65QFFDjHcJFssdgBAHW/HK95zNvvjAjmHpPLsNDeJlX75NXP
 2KW7SqeULA3JasvZmCX4ZMDvcStdDfhyOeRwe7KRMYOh1YMQMfnp/iq+Ks4iNLopUA24
 GWZuo/nMiXLih/wKVtu8yEWOvlt/Eybh80s4VtlGlaJEJVov8tmGWgLBdgID4wI1PZoe
 cEY7Y8MCWq7G/Ppqe/YPjOIaoDSr3sLs/TwzGiA3zpNUf0D/lodig13ztefp8QPmtQXK
 sJMWSO3EYPy5IWit7MapoISKf9aCAx/cSWFrvkrHF9N+nDX2bpYKzU1Dhz8GW+m+i9RL
 MNzw==
X-Gm-Message-State: APjAAAV36y9Kpmjzrp7+fdH7QnAN5Pqw45NRhKnWJua7cjJ+v/CXce7n
 byECobY3Ulpcc56jDG6YIyQqrQ==
X-Google-Smtp-Source: APXvYqwsQzBhmt6AcViAF4XM4ASlOWMomaRXFrQpfbCVH3evWQEOhYDNuY+mKWgro5KgGtR3Zj7d8A==
X-Received: by 2002:a50:e718:: with SMTP id a24mr29394494edn.91.1562739241377; 
 Tue, 09 Jul 2019 23:14:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id c7sm833660wro.70.2019.07.09.23.14.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 23:14:00 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708072437.3339-4-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6d9d0fe-d2ca-3130-dba0-b602c533c536@redhat.com>
Date: Wed, 10 Jul 2019 08:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708072437.3339-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.68
Subject: Re: [Qemu-devel] [PATCH 3/3] Add dbus-vmstate object
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/19 09:24, Marc-André Lureau wrote:
> +
> +    dstaddr = g_strsplit(g_test_dbus_get_bus_address(dstbus), ",", 2);
> +    dst_qemu_args =
> +        g_strdup_printf("-object dbus-vmstate,id=dv,addr=%s -incoming %s",
> +                        dstaddr[0], uri);
> +

Stupid question: what does the address look like, and what prevents user
A from using this to "steal" data from user B's virtual machine?

Paolo

