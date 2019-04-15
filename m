Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBEC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A649220652
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A649220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFymm-0003Rw-SS
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:24:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFylo-00035H-Vs
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFylo-0000Au-4g
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hFyln-00005e-Th
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:23:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so19794067wmi.5
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 03:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5+TmwN8zoF1KI5lQ8pDNX8kg6DV3fp8rpxzNaqHlBKk=;
	b=KbIbfJaZGk96DfCy6gz4/mIqTpxpRolqhPLnI1W/DtJbMJKX3QSHPVJibmBm5KBVZj
	kUVQMRc8xOhYzB2+0jGSeZrQlfBhjUJTDKRNUTlbUyTbBS3H/NRrkZLPtjH7ZMlZ17qR
	+fA5GvcihzQgctqvVIWM+WW7ly8wQywEadeq4K8VBx1P1qklYdKZ23Lex8IUAKkkLiXn
	TbU7C2Rz6qa2EoG+Gs6bjslK9rUdnf18vGmZHC9Kl5t+5VsNYZO0zHWIcj5H5m4pC9C/
	DZ+IGEroA3G1qKRfh+rhaRDKzxY3wLgWLD3bYqU3XVU1FqOAf+d48GecE0qDG84NATPV
	a1uA==
X-Gm-Message-State: APjAAAWqIl/eOvfxkYV4blrrzNFyfhIu/CxZOTZ2BeCn/eweZnQB6t3C
	PrHlHxvwayo8wso3bfvfNeUHBw==
X-Google-Smtp-Source: APXvYqy4WcC0lTzJQn6gFoqUB5XL6I0th+Iss7Db7M9PCwH6psNJiA6BYOHHD1MhxHqAdVPKA6dzRg==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr20692586wmj.62.1555323801616; 
	Mon, 15 Apr 2019 03:23:21 -0700 (PDT)
Received: from [10.115.78.87] ([46.31.59.59]) by smtp.gmail.com with ESMTPSA id
	i18sm44125476wrm.7.2019.04.15.03.23.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 03:23:20 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
	<6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
	<66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bed878ef-0ce1-1081-a4cb-88b7775d1433@redhat.com>
Date: Mon, 15 Apr 2019 12:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 12/23] linux-user: Call qcrypto_init if
 not using -seed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415102318.qWmGzbPoheoyKk87JQblh_d6qD4An66XR9FhMgw4fmI@z>

On 4/13/19 8:44 AM, Richard Henderson wrote:
> On 4/10/19 11:49 PM, Philippe Mathieu-Daudé wrote:
>>> -    if (seed_optarg != NULL) {
>>> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
>>> +    {
>> Since 7be41675f7c we use gnu99 C, so this extra block indentation can be
>> removed.
>>
>>> +        Error *err = NULL;
>>> +        if (seed_optarg != NULL) {
>>> +            qemu_guest_random_seed_main(seed_optarg, &err);
>>> +        } else {
>>> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
>>> +            qcrypto_init(&err);
>>> +        }
>>> +        if (err) {
>>> +            error_reportf_err(err, "cannot initialize crypto: ");
>>> +            exit(1);
>>> +        }
>>>      }
> 
> I could, but it also limits the scope, which is of more importance to variables
> who have their address taken.  It means that their storage could (in theory) be
> shared with objects not overlapping in scope.

Fine then.

I think your '???' comment is appropriate but I'd rather let Daniel
opinate. Except that comment, for the rest:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

