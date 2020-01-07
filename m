Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B9C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFF9207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUsQk6k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFF9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iom9B-0004Ld-Rd
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iom5A-0004EO-Qn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iom59-0000KR-2t
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:27:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iom58-0000HM-M6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578392845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vozNSWGOqGw+rzRrkIUpBcg6Szu1Q4RiSvWuOU9wJ0Y=;
 b=PUsQk6k1D/LmtisRcJd45APZOFb6cS3vD9zNezHyb7OuZLWx827UbXMFTxQmAUkTmBcvLi
 YoSBS3+p1qhnnN2fqBkmIKJINeTCa+qos6b/4D13Lvrw09QBNTP0p9JrbFj5AfazvpCl3D
 nHKsTSdn9TLd0xr4gTXN3hSvRSj1kOo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-WlvtEw_CO9W8VNMbUQ3xqg-1; Tue, 07 Jan 2020 05:27:24 -0500
Received: by mail-wm1-f69.google.com with SMTP id c4so3914164wmb.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lr94RCTGcK381iTJJE6awOqmZcJ9B02thTJPNJha0gw=;
 b=oVh+Mx4/Qv+zA0qWo453Xbi1XDZD1X5k0pyZ3wE+zUOI8utq4e7T7DyBLkiC4M4Wtt
 ocwoGeptjgmk5Qf7wcsDjOy9uKaOOeMMczVvQI3NfjdhFvS8Ndz1CdbO+RUvpZyGCytU
 4VusMximDrPVf7RGF53jZt6Vmv5UGFArSUhabmzZTXntkHWnQDwslifipTGGxm+Wpb7B
 mCFlgDNiTisUE/UUzZBY7FEZ1aKegVGg7dWZLnLzorMNI6r2q4SoE/IOwTZJG9RcLdqT
 pqldp1bKayeGxlcddc8k3yhhOQZ0SK+++KixPIGfL5NjCZ7Szc7y8HWLVT2YaR5SIo4F
 QZzQ==
X-Gm-Message-State: APjAAAUfvTtINnW6oIvrlKlo+t6meQZvApqpzDq2pz87fVeBr9DcwJ66
 D4bsqMR9vCHniHVHfUw1YaBE1LOI4LbkL00Xc5pLywcpLa19ChFIQHC4SJaRq3mJEVaHn5IYI0K
 QfV+LBXzk9lh4e/s=
X-Received: by 2002:a05:600c:298:: with SMTP id
 24mr37952736wmk.141.1578392843550; 
 Tue, 07 Jan 2020 02:27:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqzx0hozzj8jdQr19Z4l/0dJMbqq6I+3IDckPSEn244CKdsaujf0eeRgJ37xiFhMJ8Pgon3TDQ==
X-Received: by 2002:a05:600c:298:: with SMTP id
 24mr37952707wmk.141.1578392843259; 
 Tue, 07 Jan 2020 02:27:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id i11sm76317581wrs.10.2020.01.07.02.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:27:22 -0800 (PST)
Subject: Re: [PATCH] x86: Check for machine state object class before
 typecasting it
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
 <bda93e70-f737-4384-0422-3901767b6330@redhat.com>
 <e70937bd-15e9-aa75-d894-b32b43052b6a@redhat.com>
 <b718e77c-9b49-9c18-7b9b-55333ab0afe5@redhat.com>
 <337056f8-4c8f-9a18-5f58-13dc459f6346@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7b0685b-2444-d7f6-c4ba-2632bd2e4a23@redhat.com>
Date: Tue, 7 Jan 2020 11:27:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <337056f8-4c8f-9a18-5f58-13dc459f6346@redhat.com>
Content-Language: en-US
X-MC-Unique: WlvtEw_CO9W8VNMbUQ3xqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: mtosatti@redhat.com, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/12/19 14:17, Michal Pr=C3=ADvozn=C3=ADk wrote:
> On 12/30/19 10:45 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/30/19 10:35 AM, Michal Pr=C3=ADvozn=C3=ADk wrote:
>>> On 12/30/19 9:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 12/30/19 9:00 AM, Michal Privoznik wrote:
>>>>> In v4.2.0-246-ged9e923c3c the SMM property was moved from PC
>>>>
>>>> Typo v4.2.0-246-ged9e923c3c -> ed9e923c3c.
>>>
>>> This depends on how you format the hash :-)
>>> I've used 'git describe ed9e923c3c' because I find it more readable for
>>> us humans (at least we see what version the commit was introduced in).
>>> But I don't know what the praxis is in qemu.
>>
>> Hmm I never used it. Your explanation makes sense, but the tag confused
>> me because I don't have it locally. However git (and gitk) seems clever
>> enough to only use the useful part:
>=20
> The v4.2.0 tag is in origin. I wonder how come you do not have it.
>=20
>>
>> $ git show randomcrap-ged9e923c3c

Cool, I didn't know this.  I usually format it like

ed9e923c3c ("x86: move SMM property to X86MachineState", 2019-12-17)

I can see why most developers don't use "git describe", because at least
those that also are maintainers will often have intermediate tags after
a release.

Anyway I've queued this patch, thanks.

Paolo


