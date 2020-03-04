Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E0CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 12:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8822072A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 12:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqEA+qtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8822072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9T1T-0004Pc-CF
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 07:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9T0k-0003ox-QV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 07:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9T0j-0008UU-6F
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 07:20:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9T0j-0008To-1a
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 07:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583324424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+Sc/Ytj5/l/uu/Ia3HqP8++YO1gK1k+ox+yPLhoME4=;
 b=LqEA+qtlH6GfAKoF0XG/19HLhxddfEFFlX6YBclplW8/xXVfnnpU8dHMFV3uYFeiCuR3HE
 RMYvNhJ7zZGjREcvd0c0nnYaS5/Y0qbGTU32RBFZHXwlzJleqTOEd1cJ8CU45tis6N0Pjm
 U9EW67SkC0DBnDAqucL94QnRRjlSeLk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-tqpCeHg5Pe-BncJp18tXww-1; Wed, 04 Mar 2020 07:20:20 -0500
X-MC-Unique: tqpCeHg5Pe-BncJp18tXww-1
Received: by mail-wr1-f71.google.com with SMTP id x14so186280wrv.23
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 04:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e+Sc/Ytj5/l/uu/Ia3HqP8++YO1gK1k+ox+yPLhoME4=;
 b=R1CHAoLbxTTE1+uhK0kC7HwnZ/vvOgBg9iuS1Vp5hcj3DSb7CGEE7SPpZZ1xG8nhgy
 zuKzRJsLn3kSqb24TT61ySEbhOcxr0GefFMU90KW5aHnOQXRt3eYC/gmnMcZo9Kcuoat
 D10kUof2Y8xcKJFeozgp2bvHOhPXhgXZbAalAezkrobYb43txy/kVxw6aW/rWrf8tlOR
 213sEkZkW69tZV82HL1Z9mmWhE40yMFQo3PGDA/kdfW511HBOQDVXQOpwq/5fHgDLxF5
 1I1CE9o+IwGAQfssWxUw2xSIsMqtGcTKjIMIHHZuQVEOZ/JAsRGqmKZGdzGKsNUwdkOB
 B8ug==
X-Gm-Message-State: ANhLgQ1uN14Gfi81rB84ZgSpTxa9WtjFBAYqltQxjRJGsUJmcjZT6jao
 N06FS9jcW9bOVY7AkGzTnnnCnYWULXAJ5oZPyFZeEytOrvAriTUL3eOgT3h9oazyn9WkJwwZtGS
 H2NTZ+Bsw0ZoNdbw=
X-Received: by 2002:adf:ded2:: with SMTP id i18mr3868238wrn.173.1583324419657; 
 Wed, 04 Mar 2020 04:20:19 -0800 (PST)
X-Google-Smtp-Source: ADFU+vshvrrpeXFRXbmb2xrQXVEOm80husPmZGBGfnEdZ7YzWg9lSperp8LFHjt7S8qLxpjoboQ8vA==
X-Received: by 2002:adf:ded2:: with SMTP id i18mr3868216wrn.173.1583324419352; 
 Wed, 04 Mar 2020 04:20:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id i6sm5550115wra.42.2020.03.04.04.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 04:20:18 -0800 (PST)
Subject: Re: [PATCH] optionrom/pvh: scan entire RSDP Area
To: Stefano Garzarella <sgarzare@redhat.com>,
 Joe Richey <joerichey94@gmail.com>
References: <20200303105246.66390-1-joerichey94@gmail.com>
 <20200304085541.cyirmrx5dozhf63a@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbbee5d6-ede2-a0b8-16f3-9496a783a62f@redhat.com>
Date: Wed, 4 Mar 2020 13:20:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304085541.cyirmrx5dozhf63a@steredhat>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Joe Richey <joerichey@google.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/03/20 09:55, Stefano Garzarella wrote:
> CCing Paolo
> 
> On Tue, Mar 03, 2020 at 02:52:47AM -0800, Joe Richey wrote:
>> From: Joe Richey <joerichey@google.com>
>>
>> Right now the PVH option rom scans for the RSDP from 0xE0000 to
>> 0xE1FFF. This is probobly a typo, it should scan from 0xE0000 to
>> 0xFFFFF.
>>
>> This is actually an issue on some QEMU versions/machines. For example,
>> when I run QEMU the RSDP is placed at 0xf5ad0 which will not be picked
>> up by the current implementation.
>>
>> This bug still allows a Linux guest to boot (in most configurations) as
>> the kernel will just scan for the RSDP if one isn't provided.
>>
>> Signed-off-by: Joe Richey <joerichey@google.com>
>> ---
>>  pc-bios/optionrom/pvh_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
>> index a015e1bf22..28e79d7fc4 100644
>> --- a/pc-bios/optionrom/pvh_main.c
>> +++ b/pc-bios/optionrom/pvh_main.c
>> @@ -29,7 +29,7 @@ asm (".code32"); /* this code will be executed in protected mode */
>>  
>>  #define RSDP_SIGNATURE          0x2052545020445352LL /* "RSD PTR " */
>>  #define RSDP_AREA_ADDR          0x000E0000
>> -#define RSDP_AREA_SIZE          2048
>> +#define RSDP_AREA_SIZE          0x00020000
>>  #define EBDA_BASE_ADDR          0x0000040E
>>  #define EBDA_SIZE               1024
>>  
> 
> The patch LGTM!
> 
> When I wrote this code I followed [1], where it is written that it can
> be found in the "memory region from 0x000E0000 to 0x000FFFFF", so it
> should be a typo.
> 
> Thanks for fixing it!
> 
> 
> Fixes: 2785dc7b17 ("optionrom: add new PVH option rom")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> 
> [1] https://wiki.osdev.org/RSDP#Detecting_the_RSDP
> 

Queued, thanks for both the fix and the Cc.

Paolo


