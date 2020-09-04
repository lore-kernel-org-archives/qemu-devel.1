Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C7C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2041206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2041206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE6bo-0007v4-Pg
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kE6bI-0007VB-L7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:57:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37788
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kE6bH-0000aE-2e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:57:36 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-1HeFL2qGNsuOdGqxtE-b8A-1; Fri, 04 Sep 2020 03:57:32 -0400
X-MC-Unique: 1HeFL2qGNsuOdGqxtE-b8A-1
Received: by mail-ed1-f69.google.com with SMTP id r8so2346218edy.17
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 00:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NUTkMwJAiuZJTT7YMeGgxS8bI07fib2WUQtooNkoWHM=;
 b=iw6CoWHB2N9yoHTKaivk9wNZku7Cs+NcYxmoTlZtvvE4Gw8i6A4dYHQ/GRy/Csd/iH
 ZYPdrIWhVfBl2uKcyJcwVeL02vV09vSjaZCnrUE9dA3+tc35HbepGVSVT1FSeSQGEoys
 f2ZOYV0Q1zPSgWdxx5hKm/aHi03FXt2Mr1J5T968G4BjdXIt8UXEbMVKxgtz0+PojlBG
 UBfyA65NKXrI3NZM+uLwYTAzNWFWqvZ0G3z9t72sr0tNh6iVomIazkUPl5Xsnjyb/k2x
 WnpUke1uhNC6aTQm6BSuBGSx+ZNE82c1oZBHFAxRkAp0YGMq/d1hUQhkIi2ttmXP0ykW
 QOXQ==
X-Gm-Message-State: AOAM531W7LPkt5hbb6+Ap+3VeAnieorJ8TVLf7iFiSsWO1RYAjgS9JLa
 16Dxe/G0aPNQB6cFKsIMUMEvWOs7l0wEiHgBpx42mzIS03+ALEejHLrpUh+nF9AimdNFGleJ7Yy
 5nmXGYCLEDRGkxT0=
X-Received: by 2002:a17:906:403:: with SMTP id
 d3mr6000606eja.522.1599206251311; 
 Fri, 04 Sep 2020 00:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAylU373gIfa1wsyknF3CfLzOiM8wBfEcZAaM6fvrYguyU7g6rcVLbtAyKKWrrah7q43IQIg==
X-Received: by 2002:a17:906:403:: with SMTP id
 d3mr6000598eja.522.1599206251128; 
 Fri, 04 Sep 2020 00:57:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6276:52ed:96d5:c094?
 ([2001:b07:6468:f312:6276:52ed:96d5:c094])
 by smtp.gmail.com with ESMTPSA id w20sm5372808ejc.77.2020.09.04.00.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 00:57:30 -0700 (PDT)
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
To: Markus Armbruster <armbru@redhat.com>
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
 <20200903154906.GA441291@redhat.com>
 <69f279ce-30e8-e83c-718b-021d3e6b264d@redhat.com>
 <87a6y6dmy4.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <509826bc-9683-dd1d-fa6a-55fc3fddc57c@redhat.com>
Date: Fri, 4 Sep 2020 09:57:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87a6y6dmy4.fsf@dusky.pond.sub.org>
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: marcandre.lureau@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/09/20 09:24, Markus Armbruster wrote:
>> Ah, via the tools variable in configure.  Nice maze.  I've queued the patch.
> Please don't.
> 
> These programs are examples to help people understand how the ivhsmem
> device works.  They might even be useful for debugging.  They are *not*
> to be used in production.

Oooookay. :)  It needs to be documented in the changelog.

Paolo

> docs/specs/ivshmem-spec.txt:
> 
>     Example server code is in contrib/ivshmem-server/.  Not to be used in
>     production.  It assumes all clients use the same number of interrupt
>     vectors.
> 
>     A standalone client is in contrib/ivshmem-client/.  It can be useful
>     for debugging.
> 
> Installing example *source* might make sense (but I doubt it).
> Installing the binaries does not.
> 


