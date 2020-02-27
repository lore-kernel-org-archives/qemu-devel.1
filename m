Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0FEC3F344
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986F120801
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD3hYN0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986F120801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Jtt-0003Un-RO
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7Jt3-0002a6-FM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7Jt2-0006mW-Cr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:11:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7Jt2-0006m6-88
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DePheex2ORRDapYP7hpYINkW6NL4eqyTd7UQ9bbxx0A=;
 b=LD3hYN0fCdqlWGdaYkSU+kfP6g5Do+bpnMS9evFR+EIIPpxSSEKFm/Fh0Gr5e2NFGKqZEq
 eLX7CglYqRNNIhynQsMu2uAO3a5kd1ggwgPDsz88m2jxJvuY5iYds1GTsSnV2ji5kRVcJD
 JD9kOU3dzXS63QeyOaJ413lMpsPJH6M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313---Y4UyfcOCGQyRgfpJ08vw-1; Thu, 27 Feb 2020 09:11:30 -0500
X-MC-Unique: --Y4UyfcOCGQyRgfpJ08vw-1
Received: by mail-wr1-f69.google.com with SMTP id f10so1367690wrv.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DePheex2ORRDapYP7hpYINkW6NL4eqyTd7UQ9bbxx0A=;
 b=aDeswdYFH/a60bo/wsubcYcHBcFGXM75Od9IZqbb+NbRmldqVhbYLQwM0PPdVBkSTJ
 aUEE1CZ4zwED6e8a+vCm9pNjSjtTuHCM9hu+/8Vn8ZGoLOEivwrU5Ccrb3vS+zAdIHKH
 WmhKlYWZ1Qr1BlR8i2KzlXW3JVlJoKsu9PBulyBL1vZCp2YWmkKUs7yGKjzEeE3rEaxo
 gO6aHxt32wiz1Bue15OQcu2pYqllBZ+0ALiyDkvGhKfRf2a/XL0S+vS/83Thm+e1Jus/
 HmnF7kyew7kXVMdZmDnLNl7lYvTEix7qu/aodPrllG2NkmiaPyBSVHMT7wk9NG6d9AKs
 Uidw==
X-Gm-Message-State: APjAAAVZAYT8uF8X9vOUIDMWx+TDgkEoesV6rruBYhcqTbKBoPPz5D2d
 oyOb0y3OUP9f+serPpgYRSMQJgVWIbhdRK7f24gpYvB/eSqUAGXWYoru9CgTSek6e96wVr8bjlp
 5eB+/ARusoY2R8so=
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr5202550wmb.64.1582812689473; 
 Thu, 27 Feb 2020 06:11:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpVIGr6CQ+jpg4FSuGM4Hi5APc3P55KMPM9cUOLKvwTf1HLhz5fgLcPAWDNoyIFXR3bWR1dQ==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr5202520wmb.64.1582812689126; 
 Thu, 27 Feb 2020 06:11:29 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t131sm8263285wmb.13.2020.02.27.06.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:11:28 -0800 (PST)
Subject: Re: [PATCH v6 9/9] iotests: add pylintrc file
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-10-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0ea6f1e1-9f8c-a536-0553-ebc7639b0955@redhat.com>
Date: Thu, 27 Feb 2020 15:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-10-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:06 AM, John Snow wrote:
> Repeatable results. run `pylint iotests.py` and you should get a pass.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/pylintrc | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 tests/qemu-iotests/pylintrc
> 
> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> new file mode 100644
> index 0000000000..feed506f75
> --- /dev/null
> +++ b/tests/qemu-iotests/pylintrc
> @@ -0,0 +1,20 @@
> +[MESSAGES CONTROL]
> +
> +# Disable the message, report, category or checker with the given id(s). You
> +# can either give multiple identifiers separated by comma (,) or put this
> +# option multiple times (only on the command line, not in the configuration
> +# file where it should appear only once). You can also use "--disable=all" to
> +# disable everything first and then reenable specific checks. For example, if
> +# you want to run only the similarities checker, you can use "--disable=all
> +# --enable=similarities". If you want to run only the classes checker, but have
> +# no Warning level messages displayed, use "--disable=all --enable=classes
> +# --disable=W".
> +disable=invalid-name,
> +        missing-docstring,
> +        line-too-long,
> +        too-many-lines,
> +        too-few-public-methods,
> +        too-many-arguments,
> +        too-many-locals,
> +        too-many-branches,
> +        too-many-public-methods,
> \ No newline at end of file
> 

Can you run it in one of the CI jobs?


