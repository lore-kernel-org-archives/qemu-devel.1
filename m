Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ACAC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63A720838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63A720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGgO-000884-44
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43435)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1htGfP-0007i2-CT
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1htGfO-0007st-3l
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:23:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1htGfN-0007sS-U9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:23:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so74740461wrf.11
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 12:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tKAihF9ty/d1LsfQLMNyWdhrrO/GJkEPkrfyO6OG5I4=;
 b=mmKUvHwvw1lRQd0Mvi7mTTL1+ZkCpHaI8wcOjQyHqr06cVagBiazueia4QelAgOawx
 Bo2jCAyvMdov+fQowdy7QCTqYbss/j9uNordzc7N70fA5qGSC9DkhI4gLTo/tX23wDvw
 Qp21ahYrGorXt5E6axEDy9tAtKi9niw8V/VVrl3ir1MFQNe+olzfP+12tWruB44XBVQU
 W9XYCRjB0pooeQtwmwAaKg7rMgtqBf6Fc7+CqbClOJYcYfY3A0nrGvqZV7dXS7k8fOEs
 oWRo4bdY//BR3o1ms6j4e7NhT8Vj9gq/3PWBvYmQZyc47egkIqG1nt0JR7L+PqB0Xfff
 7LVw==
X-Gm-Message-State: APjAAAUOVMfvTbMfrz+3iC8j+RZAjzU+9E1jc18B5Tvj6rjkHYOtTXzu
 3Uds98buM8X+fe6V8gmo6kDY0w==
X-Google-Smtp-Source: APXvYqxxMNpyifXzRBXIO+keH9IewwBtCrwVIcVpLMM/NC5DjqSv819D/z+HICHO7VZ4jFRyphuUGQ==
X-Received: by 2002:adf:aac8:: with SMTP id i8mr20623717wrc.56.1564687387523; 
 Thu, 01 Aug 2019 12:23:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3?
 ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
 by smtp.gmail.com with ESMTPSA id n9sm117824892wrp.54.2019.08.01.12.23.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 12:23:06 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net> <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
 <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
 <20190730210718.GU4313@habkost.net>
 <e995c6d9-f63a-be72-7d15-ac59a343b487@redhat.com>
 <20190801185043.GC20035@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a8736545-74f6-4b2b-3f10-1ccc780a11fa@redhat.com>
Date: Thu, 1 Aug 2019 21:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801185043.GC20035@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [RFC] HACKING: Document 'struct' keyword usage
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/08/19 20:50, Eduardo Habkost wrote:
> On Wed, Jul 31, 2019 at 10:35:31AM +0200, Thomas Huth wrote:
>> On 30/07/2019 23.07, Eduardo Habkost wrote:
>>> Sometimes we use the 'struct' keyword to help us reduce
>>> dependencies between header files.  Document that practice.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>> I wonder if this is too terse?  Should we give examples?
>>> ---
>>>  HACKING | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/HACKING b/HACKING
>>> index 0fc3e0fc04..112685bdaf 100644
>>> --- a/HACKING
>>> +++ b/HACKING
>>> @@ -101,6 +101,8 @@ it points to, or it is aliased to another pointer that is.
>>>  
>>>  2.3. Typedefs
>>>  Typedefs are used to eliminate the redundant 'struct' keyword.
>>> +However, the 'struct' keyword may be sometimes used in header
>>> +files to avoid unnecessary dependencies between headers.
>>
>> See also the discussion earlier this year:
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg586180.html
> 
> Nice, it adds even more information than this patch.
> 
> For reference, this is the patch at the URL above:
> 
> -Typedefs are used to eliminate the redundant 'struct' keyword.
> +Typedefs can be used to eliminate the redundant 'struct' keyword. This is
> +especially helpful for common types that are used all over the place. Since
> +certain C compilers choke on duplicated typedefs, you should avoid them and
> +declare a typedef only in one header file. For common types, you can use
> +"include/qemu/typedefs.h" for example. Note that it is also perfectly fine to
> +use forward struct definitions without typedefs for references in headers
> +to avoid the problem with duplicated typedefs.
> 
> I don't agree with the first two sentences, and I agree with what Paolo said
> here:
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg586214.html
> 
> ("I agree 100% with the wording after 'Since'.  However, I think the first
> part should be made stronger, not weaker.")
> 
> Paolo sent the following proposal:
> 
> | Typedefs are use to eliminate the redundant 'struct' keyword, since type
> | names have a different style than other identifiers ("CamelCase" versus
> | "snake_case").  Each struct should have a CamelCase name and a
> | corresponding typedef.
> | 
> | Since certain C compilers choke on duplicated typedefs, you should avoid
> | them and declare a typedef only in one header file.  For common types,
> | you can use "include/qemu/typedefs.h" for example.  However, as a metter
> | of convenience it is also perfectly fine to use forward struct
> | definitions instead of typedefs in headers and function prototypes; this
> | avoids problems with duplicated typedefs and reduces the need to include
> | headers from other headers.
> 
> It seems perfect to me.
> 
> Paolo, do I have your signed-off-by to send that in a patch?

Sure.

Paolo


