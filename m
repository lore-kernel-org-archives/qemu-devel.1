Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F18C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35BB206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35BB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kMS-0007qn-Tx
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0kHw-0003Do-Cu
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0kHu-0001uc-EX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0kHt-0001sM-Na
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:25:50 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FCAA51EE4
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:25:48 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a2so2979736wrs.8
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 03:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hiYHgtWvxIYKpABRjXZ6oTiyD4CaxUQ9+lIx5+x1CiE=;
 b=Alge6Agpr0ezMSkhDTjMWBLICTDqhxynvOKwFQoRT3XmCp+f/d2/ccWoA6g5IYTAlc
 fhLEz4xZmZJlcmQkNOZSO7AR0B1wePQxsmbvxUl6UiF7DEgJTJ8kC9LdoX0WYiGaISt3
 nk0P7xm4mgoF27TymDYTp3JKO4wfLB4vkcv2oAt+C+067PBgxyy93tN64GMBRzAsJEip
 P30LFMH4CXXMigzUyL6FCKe7BaGlO39C7mqPend5WYobMt+JjNxA8Lmks01oKdsfX9TF
 LIejVEgICGElN9EuQ6bLPFiepYvh1uUCp4nRTbqVCwsaoiv/P6wyRtsRki33nij5iyrf
 ThKg==
X-Gm-Message-State: APjAAAU/+hI9zpSoJ0XWxc2/KBOUv9E3wBZZI3tT3HvCbeGFH2tM1R3v
 5QugnfRcovFrWoR17VwokjhYZ1NYEsiBw2fkxD0xREGHFNc/SdOJkT/v2THx5GGasTeEaZUF9Ap
 VskOdaAwtyeYeOB4=
X-Received: by 2002:a1c:7619:: with SMTP id r25mr5562166wmc.153.1566469547279; 
 Thu, 22 Aug 2019 03:25:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyeVWUf/ei/L0DsAUm2ffjzoOBcLP7tXIOjrzPQVfMHklwdMlT63rg83eKLy8blciOW1IMwkQ==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr5562134wmc.153.1566469547029; 
 Thu, 22 Aug 2019 03:25:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id q124sm3125697wma.33.2019.08.22.03.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 03:25:46 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
 <20190819030654.GA18468@richard>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ca763291-dd0d-48ba-cede-4b19493c01fb@redhat.com>
Date: Thu, 22 Aug 2019 12:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819030654.GA18468@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] Refine exec
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/19 05:06, Wei Yang wrote:
> On Thu, Mar 21, 2019 at 04:25:49PM +0800, Wei Yang wrote:
>> This serial refine exec a little.
>>
> 
> Ping again.

Queued all except 2, thanks!

Paolo

>> Wei Yang (6):
>>  exec.c: replace hwaddr with uint64_t for better understanding
>>  exec.c: remove an unnecessary assert on PHYS_MAP_NODE_NIL in
>>    phys_map_node_alloc()
>>  exec.c: get nodes_nb_alloc with one MAX calculation
>>  exec.c: subpage->sub_section is already initialized to 0
>>  exec.c: correct the maximum skip value during compact
>>  exec.c: add a check between constants to see whether we could skip
>>
>> exec.c | 21 ++++++++++-----------
>> 1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> -- 
>> 2.19.1
> 


