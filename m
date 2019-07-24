Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5CC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D92321911
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D92321911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKrq-0007Sh-31
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 13:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jusual@redhat.com>) id 1hqKSk-0000JY-Sz
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1hqKSk-0004hq-1e
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:49:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1hqKSj-0004fY-SV
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:49:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so31882984wmc.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 09:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ny1WHTXCCbrtJ+RgVT3tUnqKrmvL0lS+jpEErA65aSY=;
 b=QeUUvuZ+5j+s3kGXI1zs1DpSwAOUSi+2UEeAl0yYtG6EwiqGOsRw+TKdROgcjh8a49
 s0Oc9Abe2EywBsvPkgf8Pmrd9LIDbxdJKjXbqDBxE4HF9YNiOginmbt09O92f6FsYLCU
 SNe3R1a2gol2+RdcJzgw39rxopYnnItq+JulPSCtxzv0Z6TXN/dbg/5K+dnCXa7NEZmc
 DLH5PYErzGxLsqjil8jDRRQyrUJ1E8/SA6kv55lgwl8a16c4oqxS7MaPByyiGvv78rKf
 gXgLCWHY5OhHnX3Df+D84kS2b5uRdD6oYxp88/B/OObBP4I63gNWpy+J/9KbzS/THUQ9
 wYiA==
X-Gm-Message-State: APjAAAU3eyb63JX6jotxtFMfluNjtraj/db6Dkq+YLCDoocYfoxx0ZFJ
 h1dqj2k6xPb7bsVLOaex8vobyw==
X-Google-Smtp-Source: APXvYqz9VRXAK+zPPJ5Tle/gKBs8PElMCBj0N3nqi+JsGpRvEbnzTxqimpBBDmroItj4NzU3MyiHBQ==
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr71886715wmc.161.1563986996885; 
 Wed, 24 Jul 2019 09:49:56 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id f192sm51809378wmg.30.2019.07.24.09.49.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 09:49:56 -0700 (PDT)
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-15-mehta.aaru20@gmail.com>
From: Julia Suvorova <jusual@redhat.com>
Message-ID: <579aa7c6-f51a-7ef9-9a03-17d22f032a7b@redhat.com>
Date: Wed, 24 Jul 2019 18:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719133530.28688-15-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
X-Mailman-Approved-At: Wed, 24 Jul 2019 13:13:36 -0400
Subject: Re: [Qemu-devel] [PATCH v6 14/14] qemu-iotest: enable testing with
 qemu-io aio options
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 3:35 PM, Aarushi Mehta wrote:
  @@ -225,6 +227,10 @@ s/ .*//p
>           CACHEMODE_IS_DEFAULT=false
>           cachemode=false
>           continue
> +    elif $aiomode
> +    then
> +        AIOMODE="$r"
> +        aiomode=false

'continue' is missed here.

Best regards, Julia Suvorova.

