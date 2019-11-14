Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC4C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B59206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSYnqVpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B59206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBSX-0001cm-6t
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVBR3-0000J0-Np
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVBR2-0003xN-Qj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:29:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVBR2-0003wN-NE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573723743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=jWdU9vc/iHY6Raayhmeat9Yt1MpSMW+9VudkLrYV0Pk=;
 b=hSYnqVpIqYCShF5xHFddj41jbCtDyopHDNpTMp1SSek6eGYloY08hBFTcKN+5dWxFNFbQ6
 Dd9nesE0k44n3sZDYMtkEcBqrsLXikkyM1hbQByRVtMhtbf0K0g3Td3zMVoCyoyKjU4wmv
 LfIhYQ9NtXrW738YgJFw+9D/EI5Np30=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-D5ELwrLtNMWmjhyVJaVsvg-1; Thu, 14 Nov 2019 04:29:02 -0500
Received: by mail-wr1-f69.google.com with SMTP id b4so4054135wrn.8
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9k6NC2Vw/orKloeanVhEZ2WkgsZOikzAdVr2whoYBwQ=;
 b=HTMrlPBnFFC2pwLCCW69JAVVnm4ZaE1ZUW5MIleaMq9oDoU9fZeG9Wr4DZuhU7xUkB
 V1bh8UpIUv1c05lSN8GYbsOytLYW79fihjU/ymHWlG6VizOtl891tCARyoLffQmKYcxO
 7MX7OhllG5HmG69OLBLcDGK8pRN5AzFnxEANLbTk9gVnWqT2A7FYU9b/82vBaMqe+cN8
 l7r3l8Oi1a/c480pTrgCo0t3aVqSknOge/Bh6kaGqy3Wr3DxXCmkOdh6QpwHHrGLZl5a
 NORuwiZpGLd0WdpA0WPvWTXmATwlF6KVtazfxYZw3fkoE5a5OVif9w1gY56QNIjtT8GT
 pGoA==
X-Gm-Message-State: APjAAAUDd6IDzKBhMMx7rIzHQbccOt6onTqs7eKAVHAAxhV9kTtuY6qm
 3S2g5lJ3EptoWITlQGbFVSfIC66/dKHKgvBR7CmkIH5C3P+sEA7La+P+S1C580rEQYH1vEdT8MZ
 eLmZY0D26S65DKwk=
X-Received: by 2002:a5d:4982:: with SMTP id r2mr7210370wrq.254.1573723741493; 
 Thu, 14 Nov 2019 01:29:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwr1PbawBW9qnLKKGIqjzlqiOVmM45IGIMu+XgEcA32lgx8YTZrAthds0g7kMuBw/y/aMdgXA==
X-Received: by 2002:a5d:4982:: with SMTP id r2mr7210357wrq.254.1573723741225; 
 Thu, 14 Nov 2019 01:29:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id 62sm7923240wre.38.2019.11.14.01.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 01:29:00 -0800 (PST)
Subject: Re: [PATCH 02/16] vl: extract accelerator option processing to a
 separate function
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-3-git-send-email-pbonzini@redhat.com>
 <CAJ+F1CLt2buDE8=GaPO7wTBC5Z7-TgM+GVgR+kZwRcYxMdN14g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e8339001-b331-f46c-1731-378279793cbf@redhat.com>
Date: Thu, 14 Nov 2019 10:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLt2buDE8=GaPO7wTBC5Z7-TgM+GVgR+kZwRcYxMdN14g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: D5ELwrLtNMWmjhyVJaVsvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/19 08:55, Marc-Andr=C3=A9 Lureau wrote:
>> +
>> +    qemu_opts_foreach(qemu_find_opts("accel"),
>> +                      do_configure_accelerator, NULL, &error_fatal);
> It used to call qemu_tcg_configure() when no -accel option given. In
> this case, it still sets mttcg_enabled =3D default_mttcg_enabled(), but
> now it misses that. Perhaps it could be set earlier.
>=20

Oh, right.  This is fixed later in the series, but I think in v2 I will
move this to the TCG init function.

Paolo


