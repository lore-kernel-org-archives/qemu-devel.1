Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2DACA9ED4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28A92087F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSQjYeYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28A92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQKC3-0002nn-Rj
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 19:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iQKBL-0002OV-7r
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iQKBI-0007cm-LD
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:48:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iQKBI-0007bt-9t
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572565722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=lEG3f/8chXumNyO/JN8Fm/ikhnF0lFTzbeQAUb+YOYQ=;
 b=YSQjYeYUtlPffDQOZCPyOYW0YHH93moAXVdQBNVPaJM5dR7OQZZc+jqjrpXiyYVTbGNGLZ
 UbvcmoEExdWQ4hcnqnomobmjwy/I1+CA09dKbL1wQejxf9mOiKTFygQWSuV3TrK6qk+aaR
 8TfIYo0bv3+w6ruTHPoVT4GU0px4GLA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-EIv-oF5kPi-04xL722fxLw-1; Thu, 31 Oct 2019 19:48:38 -0400
Received: by mail-wr1-f71.google.com with SMTP id i10so4466853wrp.7
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 16:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5wsDN8B4BCGG9DtljzjtWJTgItzvJ5s3zDhg4UimEXc=;
 b=Z88cus/hi6R5mi5mp4mWXQfOWb8vpZyaWNwd9INZN1wDkQaeEaZhk9j1sZhCRun+hx
 7+ZopRttItTMfMpyUb5wN0Ti0CUqmG9N0gPnfDHCeob+NTeQfDNtn3yQXhK8DCKrzX8j
 WouFcQkKsHNXyNuYJ2ju7NRBhFFvCvAUx68KqYx52s1d/Ep4Nho2nFLd53cgm1XujYVR
 Vvj5BYOL8mUplkWN5bi0crv6IqYmGTYtcwBIkwzKMvvYmOPyiBGZmOYhSYMMgrB5P9UC
 JXbbldScGpaeMBe7A2D4+x3BGWEORC4wigvbVEc4P9YUex4CuoIKKu9UmWVPPxqeT0TE
 fRPQ==
X-Gm-Message-State: APjAAAUqGIUoD99/GLz5k9ekRZzcjgFnb7FssnImOr34u0lafeaBM3/t
 7/uLPebKuuXsnIIq954jhRZ+DSS+GNCWABd74+Dn+10l6aqWO7XsOI7aSox9fXWGT5LrM7i1Bgp
 5OOlJzNbkb14gsgo=
X-Received: by 2002:a1c:48c4:: with SMTP id v187mr7768375wma.27.1572565716578; 
 Thu, 31 Oct 2019 16:48:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYw64ORqmQ7x7/xsjJ2f2OcTdmb73eA5ULAKjnD7MqknrqMunYnSCo5YZILzAfqQGrN0YtOw==
X-Received: by 2002:a1c:48c4:: with SMTP id v187mr7768367wma.27.1572565716304; 
 Thu, 31 Oct 2019 16:48:36 -0700 (PDT)
Received: from [192.168.20.72] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id v6sm6444427wru.72.2019.10.31.16.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 16:48:35 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] docs: integrate doc comments with Sphinx build
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191029162248.13383-1-pbonzini@redhat.com>
 <CAFEAcA9nT0AfDPmQ2_SDec7_z3+wGS=XQJnSiQwrWCydLgv83Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3369940d-5c3c-c72f-7c64-2bff7daf55f2@redhat.com>
Date: Fri, 1 Nov 2019 00:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nT0AfDPmQ2_SDec7_z3+wGS=XQJnSiQwrWCydLgv83Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: EIv-oF5kPi-04xL722fxLw-1
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/19 19:21, Peter Maydell wrote:
> On Tue, 29 Oct 2019 at 16:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Hello,
>>
>> this is an attempt at including kernel-doc, with small tweaks (see patch
>> 2) to support QEMU's doc comment format, in the Sphinx documentation pip=
eline.
>>
>> The ugly part is patch 3, which disables Sphinx's "nitpicking" (warn on
>> invalid cross-reference) mode.  It would probably be possible to use
>> the nitpick_ignore configuration entry instead.
>>
>> Paolo
>>
>> Paolo Bonzini (6):
>>   docs: import Linux kernel-doc script and extension
>>   docs: tweak kernel-doc for QEMU coding standards
>>   docs: disable sphinx warning about missing cross references
>>   memory: adjust API documentation to (modified) kerneldoc format
>>   docs: add memory API reference
>>   memory: include MemoryListener documentation and some missing function
>>     parameters
>=20
> Could you briefly describe the differences between this patchset
> and the RFC I sent a while back:
> https://patchew.org/QEMU/20190521122519.12573-1-peter.maydell@linaro.org/
> please?

Thanks for the pointer, I didn't remember it; my series is not based on
your work.  The main difference is in patch 2 ("docs: tweak kernel-doc
for QEMU coding standards"), which tweaks kernel-doc to recognize camel
case types and QEMU's usage of "#" to indicate types (inspired by GTKDoc
and different from the "&" sigil used in the kernel sources).

As a result of this, the adjustments to be made to header files are much
smaller.  In particular there are no hunks such as


 /**
- * MemoryListener: callbacks structure for updates to the physical
memory map
+ * struct MemoryListener: callbacks structure for updates to the
physical memory map
  *

The other difference is that this is based on newer kernel sources,
therefore I had to import the additional file docs/sphinx/kernellog.py.
 On the other hand, I forgot to commit docs/sphinx/kerneldoc.py...

If we agree that nitpicking mode is unmaintainable, I can merge your
work with mine and repost.

Thanks,

Paolo


