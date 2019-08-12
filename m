Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25278C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6132085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6132085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx6IS-0003VK-4Z
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 05:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx6I1-0002zc-8n
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx6I0-00080I-8q
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:06:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx6Hy-0007yw-7s
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:06:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so13628008wrj.12
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 02:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wKqdeSy5cdJsAd0+kNh6JU5posSCQfpFR60EsLy/x8Q=;
 b=mu/nBVIixnBx+3qEi1qBUnA4LoVkS6UQ7JWRkTu4TVRZHEipektDcTZKg9hKCHBEyH
 ekNv/cHd6LG9b5stV9+4a+Odryu2VdnqblkWp7uBY4En5zGxVgNloKL5ZMmKjrjbKivO
 LRnqG6rfYAgiVTtjJ0k3I4ul2IlbdyJRkwJgiNgD+KqeccuV34ox8CX2AAFoqmS3abRK
 T8E9aOgfBk4hpcMtt14uQcrwtTvtgeTLIeq8QpQIDYGTqGfpjcbtcbOOWSKgSoZAzx3+
 aFiiNble3ZaYLH73pVivrQzTfRkVguqOrka+0HxysEDifOx2M7BAXSFAIgq0B6jOgnXh
 Iq8Q==
X-Gm-Message-State: APjAAAW9Fc6ywMa2M0A8iMLlEWNg5Byvs0T1kU5/CigLIhbgwfh5jjhX
 NxsEQ+q/v5M5Bi89QZdHQn5k0A==
X-Google-Smtp-Source: APXvYqwAZ+N+qMbIdr3nvwt3VQkXcX5P+GGUcqUBOg7s/jBWCpBwPlYvraK2v9gE7Ba5T17EOCFFSA==
X-Received: by 2002:a5d:4589:: with SMTP id p9mr30281115wrq.276.1565600808708; 
 Mon, 12 Aug 2019 02:06:48 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id e10sm27592952wrn.33.2019.08.12.02.06.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 02:06:48 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190701194942.10092-1-philmd@redhat.com>
 <CAFEAcA_bWHAe_aoaN1+1RFm3zEvAxmzQtVm1zbatJHG_+CgqmA@mail.gmail.com>
 <07662a67-b4cf-e681-fffa-98a03a26e0fb@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f410698e-7f8f-f81b-50f7-40b401d76ac1@redhat.com>
Date: Mon, 12 Aug 2019 11:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <07662a67-b4cf-e681-fffa-98a03a26e0fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v4 0/8] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 10:22 PM, Philippe Mathieu-Daudé wrote:
> Hi Peter, Paolo, Alex, Thomas :)
> 
> On 7/2/19 4:08 PM, Peter Maydell wrote:
>> On Mon, 1 Jul 2019 at 20:49, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> [...]
>>> $ git backport-diff -u v3 -r target-arm.next..v4
>>> Key:
>>> [----] : patches are identical
>>> [####] : number of functional differences between upstream/downstream patch
>>> [down] : patch is downstream-only
>>> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>>>
> [skipping patches already applied...]
> 
>>> 004/8:[----] [--] 'RFC target/arm: Restrict pre-ARMv7 cpus to TCG'
>>> 005/8:[----] [--] 'RFC target/arm: Do not build pre-ARMv7 cpus when using KVM'
>>> 006/8:[----] [--] 'RFC target/arm: Restrict R and M profiles to TCG'
>>> 007/8:[----] [--] 'RFC target/arm: Do not build A/M-profile cpus when using KVM'
>>> 008/8:[----] [--] 'target/arm: Do not build TCG objects when TCG is off'
>>
>> I'm going to apply patches 1 and 2 to target-arm.next for rc0 (since
>> 2 is helpful to redhat downstream and taking 1 now reduces the
>> amount of code-movement patches you'll need to rebase). Patch 3
>> doesn't compile and 4-8 are rfc.
> 
> The remaining patches can be applied without conflict, so no need to
> respin (yet) IMO.
> 
> Paolo/Thomas, do you mind reviewing patches 5 and 7? They are kconfig
> related.
> 
> Peter/Alex, do you mind reviewing patches 4 and 6 first, then 5 and 7 (5
> and 7 can wait for Paolo/Thomas' review first).

Patches 4/6 were tagged 'RFC' for late 4.1 inclusion, so can be
considered normal patches once 4.2 dev cycle opens.

