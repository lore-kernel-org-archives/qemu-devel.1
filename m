Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8BCC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E97206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E97206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3pz-0000kz-QI
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:24:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3pC-0000S6-B3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3pB-0007ee-4V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:23:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3pA-0007bA-TH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:23:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so22193932wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/Z7CLKoOWzQ7iA0YuEwyp+9ceqNH9L2l+ydjdLGJ08A=;
	b=ceFxoFs2ndPK0lvxkc9K67u/Rr6B66s7U7Xq7LffDJZyzhkFYLR+7OC9Ht/S+CT3gI
	UsA4edvfou2BbinZj+MvnbBf0fSu0u6siCrnOd4JL9Vb5jQnfI0mFeEAtraSI2GUhUSu
	dY3G2gQgnlWNeusz3mSm2OxVL1tIrILjdpYw2+6lnXWERGhW2j4/+PDslJVvsUDwHjov
	O2xortdyuaw+Jtl8sk1ajqiYF174VrGTq9sugOe63wBxmiuad4ZNylF870NdITvD4SJy
	9/yW/MuNccQRwn7GpjiCIiHiS0kw2C+++Hx5y5GWCo2Wztowaf73kVtddw33c7Dk+V30
	EfRg==
X-Gm-Message-State: APjAAAWpmFlzg/F+kp6rb8u5HrTmpJwCtTHVF2G+hmO2SqjkZh5dqm6B
	pzIQwBdf22jvkUwZGHEGPyIu6A==
X-Google-Smtp-Source: APXvYqxljc2kKtxF3jWoOCXS87ADr62GsnEx4JmSQfN52VRhtIfKdpUajlGPLkZNDUpTOdX+cl14rg==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr4257904wrq.248.1556058214957; 
	Tue, 23 Apr 2019 15:23:34 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	v22sm4286106wml.32.2019.04.23.15.23.33
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:23:34 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <76b8bb16-2e71-c41f-0d4a-79f6df059092@redhat.com>
Date: Wed, 24 Apr 2019 00:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-2-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
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
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423222333.AUlNY4s6xkL-ORqvThCgn7uwxyFqSWyUJI1XN-44ZaE@z>

Hi Eduardo,

On 4/23/19 11:22 PM, Eduardo Habkost wrote:
> This struct will be used to represent support and deprecation
> status of QEMU features.

Excellent idea!

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi/common.json | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..b59d0dc66b 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -193,3 +193,27 @@
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> +
> +##
> +# @SupportStatusInfo:
> +#
> +# Information on support status of a given feature
> +# (e.g. machine type)

Hopefully it is generic, we can use it for devices too.

> +#
> +# @deprecated: if true, the given feature is deprecated and may be removed
> +#              in future versions of QEMU according to the QEMU deprecation
> +#              policy.
> +#
> +# @status-message: Human readable message describing support status
> +#                  of the feature.
> +#
> +# @suggested-alternative: Optional.  Suggested alternative for a deprecated
> +#                         feature.  For machine types, this should be the name
> +#                         of an available machine-type.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'SupportStatusInfo',
> +  'data': { 'deprecated': 'bool',
> +            '*status-message': 'str',

This one shouldn't be optional IMHO, we should enforce developpers to
give a reason for their deprecation.

With this argument not optional:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +            '*suggested-alternative': 'str' } }
> 

