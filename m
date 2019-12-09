Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B5C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6004F207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzLbE7Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6004F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMgn-0007UL-Iu
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieMfo-0006tL-1d
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieMfn-0004PM-4A
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:18:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieMfn-0004MY-07
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575911894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkbboqHxsVcFpztbMlV+++1ATZTTUc5Tz3jRFPj0eUU=;
 b=OzLbE7VtdJQAuOEYwmMskMDK+1TZ5Q5IEur+jy0HEqbL6nFhWjD45AnaSMYvgSOsaj89YL
 GlIKh1+LnoJkiyTbTFKD0i4LVgmV+vYDutN+lp1+D5aziMf7YlqkAPrOZySwwy6JIhQpp5
 pJQDENdcazbE0HqUNtb6022E6lRdOgw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-ynxe13hEOmql9MXMTHyTcg-1; Mon, 09 Dec 2019 12:18:11 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so7845970wrw.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 09:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fwT2Sz8JqB1Bwaa5HEvc5la6J8LZFzeVXaWZ2qGMvC4=;
 b=GI1tENp6Hz9F4RDumrShDjLqFNkdvTBkLk+bv6BQOyN+aEO9lAt7B/fE2nLRmK/w3C
 dqDID3z1NxZRBFhR2G/traYhqB+PpgEi1BU3ANO6cPoe158tdioDo1xJ6M3fKOaz54t6
 hCQBVW62unMvhhdFyb12O2oT3hryGlcjNYOH8Y50iGy8wJsB3bU0p4if9qBXCLGjAG3j
 kxj5VFC+j6HqRFfnWkbTQjVS+M8+ccR0BYtBd0wFducfcyGYU2apMb+kKy37c3WWOwbd
 pSIfe4xbFI6y8/uDQ9uNTJAbuW5kzIyh4T2hCEJY70NWD06ZSszOAHZVHn6JtAllGM1w
 BDyA==
X-Gm-Message-State: APjAAAWZ0d3HNqlp+vwnUWFEZejnoB0gaqdQr0W140pNoobHUdzc6mdH
 Nr2exJUctBUeyNWYnrnIc8Gy+sGA6iAd6l+YpdxQOPLAnFhlTtthybQx3V2Z6aOqiQgM+/oaMef
 B8hWuMHouYMnaxsg=
X-Received: by 2002:adf:ce87:: with SMTP id r7mr3227791wrn.245.1575911889801; 
 Mon, 09 Dec 2019 09:18:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRIqtb/C2zPKn3wOsFZPjRg9Q5/7u5N4YxLjy26Zod8wgH6t/zrytBj4g31cRUOxXVB3o+iw==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr3227778wrn.245.1575911889523; 
 Mon, 09 Dec 2019 09:18:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id z64sm4751wmg.30.2019.12.09.09.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 09:18:08 -0800 (PST)
Subject: Re: [PATCH v2 14/18] tcg: add "-accel tcg, tb-size" and deprecate
 "-tb-size"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-15-git-send-email-pbonzini@redhat.com>
 <1383ee6f-7bc6-8e3c-571a-0a85a787b4be@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e51b040d-2442-112e-484c-94f8353775cc@redhat.com>
Date: Mon, 9 Dec 2019 18:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1383ee6f-7bc6-8e3c-571a-0a85a787b4be@redhat.com>
Content-Language: en-US
X-MC-Unique: ynxe13hEOmql9MXMTHyTcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 16:52, Philippe Mathieu-Daud=E9 wrote:
>>
>> =A0 =A0 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>> -=A0=A0=A0 "-accel [accel=3D]accelerator[,thread=3Dsingle|multi]\n"
>> +=A0=A0=A0 "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
>=20
> ^ This seems from the previous patch, 'convert "-accel threads"'.

I left it here because until now it was accurate (thread became a QOM
property, but it was still the only -accel suboption).

Paolo


