Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00226C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6E82064A
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdzsaTmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6E82064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspfo-0007XK-UV
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hspfT-00077M-0G
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hspfS-0003af-09
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:33:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hspfR-0003aA-Pk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:33:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so60026303wmg.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oAQ5pqrgiYDeU0LcqcJpINH6c9BvcprJJXZf7rdEvkY=;
 b=TdzsaTmhdy7YANTNt9dfWOitsgI6tuV305UySzsyo6SBwOr9dWobgLU6mZ+NY16aGF
 SXeYgTB6jUI4tEOrKUQfHua9GhN6T9ss3kfp7O9tDjPK3qSuOlGpJFWwYRG0LXRmPj/L
 mGcB15BkxPjZ7fpCoPzItmOraMMJzRSYg9qCIQcqIGPEsw+nyDsyxaE5l6c1sfk/9jr5
 36jeTc//uX0c4Qe0TpO6jYpMK4t5a+2UIpOpmKomfWCYDB66kSBCgAG/QDjGbOEP4EOc
 WWA8XXd4wRoFfCAXPOwqDWJ+U0B93ryKUXMkPqRlKQSmx1tp6Iulc8vlK0+tARW5yXVD
 06Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oAQ5pqrgiYDeU0LcqcJpINH6c9BvcprJJXZf7rdEvkY=;
 b=HM0xap3lcaRZI1AhzwXlJdqtn7f1chDm4rJQPnY97buR1/nbO0m7VMHzdKgvD35ytS
 fbAOrdNTtgj9tlwX4M2rZRnv/oTLws9I0sfwku27n/6w8XuZKka5htVFMdrh4gTqhnVm
 KWco6g6ikYrSXcAc84+PDW126MRUum1WUsuUDpitaYVfNVAoFU8NxhQuSCK8FOTC/gdh
 IhK8M2dD+wBAs3XI7SBN72l315aW0XzpJ9RzWfeaSxW+djLASqlRczfpzURr8fcf6PMe
 ddqRyrQlzSrQaXcbi1LLUrZK6uoohWjymhf2/EECOyT1Sn1hUkB5U3V7TMLmaRwSW9Gy
 Tjkw==
X-Gm-Message-State: APjAAAX7qXhHXK6S3m5n8L3i9Uik59N7O7QPTUu21DJ2jXVf6qm6DA3T
 jDxx9uJ4pkxwm20knjUdeo4VFstG8iY=
X-Google-Smtp-Source: APXvYqwnhwGR9gBuDof0dqJ+tJvPJvNfniJp2FXQIVLfK7JZmKAJ9oHl398uXyKQgEadeaA+z+AdBQ==
X-Received: by 2002:a1c:f914:: with SMTP id x20mr33887362wmh.142.1564583603992; 
 Wed, 31 Jul 2019 07:33:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t185sm58813566wma.11.2019.07.31.07.33.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 07:33:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C49D1FF87;
 Wed, 31 Jul 2019 15:33:23 +0100 (BST)
References: <20190725084341.8287-1-berrange@redhat.com>
 <87a7cui9le.fsf@linaro.org> <20190731141055.GI12463@redhat.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190731141055.GI12463@redhat.com>
Date: Wed, 31 Jul 2019 15:33:22 +0100
Message-ID: <877e7yi899.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 0/3] require newer glib2 to enable
 autofree'ing of stack variables exiting scope
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


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 31, 2019 at 03:04:29PM +0100, Alex Benn=C3=A9e wrote:
>>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>> > Both GCC and CLang support a C extension attribute((cleanup)) which
>> > allows you to define a function that is invoked when a stack variable
>> > exits scope. This typically used to free the memory allocated to it,
>> > though you're not restricted to this. For example it could be used to
>> > unlock a mutex.
>> <snip>
>> >
>> >     GOOD:
>> >         g_autofree char *wibble =3D g_strdup("wibble")
>> > 	...
>> > 	return g_steal_pointer(wibble);
>> >
>> >     g_steal_pointer is an inline function which simply copies
>> >     the pointer to a new variable, and sets the original variable
>> >     to NULL, thus avoiding cleanup.
>>
>> Surely this is a particular use case where you wouldn't use g_autofree
>> to declare the variable as you intending to return it to the outer scope?
>
> I think it depends on the situation. Obviously real code will have
> something in the "..." part I snipped.
>
> You have 20 code paths that can result in returning with an error, where
> you want to have all variables freed, and only 1 code path for success
> Then it makes sense to use g_autofree + g_steal_pointer to eliminate
> many goto jumps.
>
> If you have only 1 error path and 1 success path, then a traditional
> g_free() call is may well be sufficient.

I suspect this would be worth a write up in HACKING or CODING_STYLE with
the next iteration? (which reminds me we should really merge and .rst up
those documents)

>
> IOW, as with many coding "rules", there's scope to use personal
> judgement as to when it is right to ignore it vs folow it.
>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

