Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E583C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376D4206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMUxzp7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376D4206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT28R-0006SA-CI
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT27Y-0005jv-HZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT27V-00068W-OY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:40:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT27V-0005dX-Ah
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587987615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuaceiQyoLPkHdkQV/i9/sM7PJIOH54Ha7t8w6WIQds=;
 b=MMUxzp7DPs60xhdIkD44AuavSJEKGbIZy1E3KwcHev6EeEJdBQEbJN8NYTQt371y+EhSGC
 YB3qf6Ll7fhnFcWR4LfahgaCrYEhgM03R6DzsH6mc9A4OeVhm3oeMUUOQL4a3QjNneSav1
 WzxuDv5k/J/mTrJ9XQX5hPejO0TEWM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-nTPA9XPvNnKqjmthq0MNrg-1; Mon, 27 Apr 2020 07:40:12 -0400
X-MC-Unique: nTPA9XPvNnKqjmthq0MNrg-1
Received: by mail-wm1-f72.google.com with SMTP id d134so7831392wmd.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 04:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uiDKxO8euLQYav4pg6evb8rRPepPosbpaD/esvSllg4=;
 b=bR1h7j78j9lVQGxhqv/XuyP5CPAN0Vrc0DPsoqmIoUIyjrBvL57Wowa8zn5D0blVg9
 n4/D//2QLiCR9yx8rmzGXuKvaY1mBemync+ce6QMtQiGWCF1JBKACkHu3hTAASuY/8bB
 ZfYQxlVioG/4gmecrCGMMDkhNkImXZscUG/a8hzaBfMrkaKUukorv8Edl/75wXRcIkBn
 xaq1QUuFThqL+QtkR04PeHAi/aDNtMbO7Nj9HZWs1G+PoyYbj3qz8Q+ZcFSmur791Qy0
 dUft5zek97es/Uu33LsFGFjxOsPrOL277Ca1tiyAxXnqQu1tDMtL/aA6qB0F8uZ/mSZT
 6ZdQ==
X-Gm-Message-State: AGi0PuZz/AKRzPGx4dTOx7HlK9oRGUYdiQKKox92T4Sx5TYwwZXNwUEv
 +cdYr63mbETuQSZ0Guz32mxD0QRuaMpY1HJSBrLwJB6qEECdOnbDSyQ78rHZ9xKyedhvTGGEMEU
 KoeEgNsk3TYm3Tis=
X-Received: by 2002:adf:80ee:: with SMTP id 101mr27710526wrl.156.1587987610993; 
 Mon, 27 Apr 2020 04:40:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypKXFaZzhnEQqToaDlveTEi7RsltqgqkPuKVhoiu/6aXJh2366pDENFkex7Ds/BWn5+2NaYedw==
X-Received: by 2002:adf:80ee:: with SMTP id 101mr27710486wrl.156.1587987610774; 
 Mon, 27 Apr 2020 04:40:10 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id u3sm20452624wrt.93.2020.04.27.04.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 04:40:09 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] block: use int64_t as bytes type in tracked
 requests
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-3-vsementsov@virtuozzo.com>
 <ab987de2-812b-7d31-ed3a-aafc7d44399b@redhat.com>
 <d8d3666d-427d-ec76-f58e-2e82525459d8@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3c053fdf-c17f-9145-22a8-e9b7236c903e@redhat.com>
Date: Mon, 27 Apr 2020 13:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d8d3666d-427d-ec76-f58e-2e82525459d8@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:33:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 ronniesahlberg@gmail.com, sw@weilnetz.de, stefanha@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 sheepdog@lists.wpkg.org, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 namei.unix@gmail.com, den@openvz.org, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 1:26 PM, Vladimir Sementsov-Ogievskiy wrote:
> 27.04.2020 13:11, Philippe Mathieu-Daud=E9 wrote:
>> On 4/27/20 10:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> We are generally moving to int64_t for both offset and bytes parameters
>>> on all io paths. Convert tracked requests now.
>>
>> This doesn't seem a strong justification... If I understand correctly=20
>> this patch, it is safer to use positive signed type rather than=20
>> unsigned type. OK it might make sense to better catch overflow, but it=
=20
>> should be explained in the function prototypes, else commit message,=20
>> else the series cover IMHO.
>=20
> First time I decided to follow the tendency not to copy the whole=20
> cover-letter from previous series, but just give a link to it :) It's=20
> chosen not for safety..
>=20
> My reason is the fact that some functions may return int64_t=20
> offset/bytes, and negative values are used to indicate an error. It=20
> seems good to use same type always, making it simple to reuse local=20
> variables for storing return value and as arguments (if it is=20
> appropriate in the context).

I agree we want errors returned, so negative values for that.

I'm not sure it is a good practice to pass unsigned values via signed=20
type simply to 'reuse' local variables. I'm worried we might hide new=20
bugs and it might become harder to find others bugs.

Anyway I'll follow Eric and Stefan choice here, as they are more=20
experienced.

>=20
> Eric also added (in v1 thread), that off_t is signed too.
>=20
> So the aim of the series is not signed type, the aim is 64bit. And for=20
> consistency, we should use same type for all io functions. And my=20
> proposal is int64_t, for these two reasons above. May be good to add=20
> them to the first commit message.
>=20


