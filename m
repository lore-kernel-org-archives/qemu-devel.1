Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ED6C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71FB207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NviUJGXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71FB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5GZ-00084Z-28
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX4ya-0002zZ-LI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:31:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX4yY-00049h-EE
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588951901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUkTJEbXEMCm3sKLxj2KywXilCnCVVLPbqHWI8aeR4E=;
 b=NviUJGXNrrBPFeUXtHj7BqNVmz3S3+VfKefcOXmoBbMUF/yGRbY0n0PDZ9k16hpH1VZdCO
 h52qSlDEp0PUBglcQjm+essjTxXXB8+Hfv24607pCds5vaZ/4E9I3/cPksz2rDWg8l7mEu
 WyaE/lAz5tyAwqysM3pfLdQv7oz0/vI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-0X7IpNZ0Mo2abQRkNGfuCQ-1; Fri, 08 May 2020 11:31:39 -0400
X-MC-Unique: 0X7IpNZ0Mo2abQRkNGfuCQ-1
Received: by mail-wr1-f71.google.com with SMTP id u4so1051773wrm.13
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AUkTJEbXEMCm3sKLxj2KywXilCnCVVLPbqHWI8aeR4E=;
 b=nrrx6uM5soxgWIVN+UXQoUZVoyw/OO7no1deK6F1laLjFfBAV1RdVC2hUDBIi3PzYK
 B0cajMP9FTn3uDdas05ZySE/sClasmvtg5GKZqNggc6bcpLi3izXCJ8keMlwi8X+Epjn
 Oa5eWzwg0yai0xWGUSirM5CK5ZshU0s5k23qTGgFemZJHi8xrX+pzSqB5Rs0a+bmkdlE
 MFotW2EhgjtKNlQdVSgdUZLTrpWNvb0QXSqE0OfwKr8L2P/jlSi5dn+vAw6exAvU5F0b
 UzRa/7pbF0fhSyGscF4F0vRnliDnGZgLv91sHiozbPrOEZuQE7nv+tL7RoGMCXQxnm4J
 4hdg==
X-Gm-Message-State: AGi0Pub77g1HZJrMQs3ZtOsFpKuZ+uaGYc+5ILTdfQE3f0RfEUSpZv1g
 UBppUtwUONQOxP+kEFcg5nm1JR55CwO1P3R/cZ2RTXbnuwuEr07IA6abU/YGyvJo7SrIkNnBM66
 Zbfy1jK2zEnUmm3Y=
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr12808063wma.118.1588951898606; 
 Fri, 08 May 2020 08:31:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypL2fGeUgjHCxll65VsvtZ1qg41AryU2QW5vprP7vHCZ9bLAkT2NlTJkhJ456BnwK5JblJnTWg==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr12808033wma.118.1588951898283; 
 Fri, 08 May 2020 08:31:38 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id i1sm3408067wrx.22.2020.05.08.08.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 08:31:37 -0700 (PDT)
Subject: Re: [PATCH] qom/object: Fix object_child_foreach_recursive() return
 value
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200404153340.164861-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8530616a-1a92-e80e-4b03-c217faabe3e7@redhat.com>
Date: Fri, 8 May 2020 17:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200404153340.164861-1-clg@kaod.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 11:31:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/4/20 5:33 PM, Cédric Le Goater wrote:
> When recursing, the return value of do_object_child_foreach() is not
> taken into account.
> 
> Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Fixes: d714b8de7747 ("qom: Add recursive version of object_child_for_each")

Indeed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   qom/object.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 1812f792247d..b68a707a5e65 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1057,7 +1057,10 @@ static int do_object_child_foreach(Object *obj,
>                   break;
>               }
>               if (recurse) {
> -                do_object_child_foreach(child, fn, opaque, true);
> +                ret = do_object_child_foreach(child, fn, opaque, true);
> +                if (ret != 0) {
> +                    break;
> +                }
>               }
>           }
>       }
> 


