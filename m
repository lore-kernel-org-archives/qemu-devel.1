Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44992C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04982073A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdnGDCUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04982073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfk9-0000M0-Sh
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKfgX-0003qP-HS
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:38:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKfgV-00079R-UG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:38:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id m6so16515472wrn.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JaYbX7zM19CAeY9PfVh1oaA8/hBGphLlkSvvP0983Gw=;
 b=NdnGDCUacZ6VCkGmUsdfFJljTKBuFuJx4oiFK6pWSd1DfzdxuudEbwEiGzuxoeoubP
 TKUXurxDEel2CA4UqdJbDYK4L/KVoVVqQX0BWlJyBM8XDvX1DVF7jZZjN0e1NG3M5U6a
 unOro8AtrBUrQoIehPW9ticGPaTRDTjoEicnjRVNj5Mru4sAPsk3yWk4rm65ppDcrUud
 a0+VX7kGZevjTpCw4T6gnBNDBE3RjiOsFpeHb2QW749f1kfYkq6orqW1DD2fWJ8WWqIU
 C65hattHJ0q+mylz61KT2bUZndPi+rA3KswbIZrffYk7Fzb8KhjP3301RiYNRdBSW+NO
 sZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JaYbX7zM19CAeY9PfVh1oaA8/hBGphLlkSvvP0983Gw=;
 b=kyiAX8mCAjQkyd8lYQRHP4roZKcuNaeJYnS7hPTxhRfwPpP+RgApL0r7S7s73Z7Amx
 kg1EFVAzEI/LQ3jyIlCfytzKL26gisyBwGvUKbKti3dkr6RQSTlT+ZZLtOy9cQH3Gv6N
 qJATpRvvvS1+/aaknA750M8jcmKT5hL+mI2kCy9aScs/FHe2tLZzV8Eb5WNFAQXeGGQf
 KQddcnTsTT4FJzUxvmqhh3iVxXyBUH4z5/AkITYoqU5xV65k7IcM/M6KRTMu8aJh+wpM
 PJOdRDZca8LWb7vPLvCwU9zs3bkXV89d1Z3zn4FX1jeejZij2Pa9An1UUBUtFdR5Sx5b
 b1Ng==
X-Gm-Message-State: AOAM532QropWASKtnn7xeng5/RJLe4Wsud1XIA8mTke4rvtN6+bqmcMr
 6pVtJ84Pj+gjmCFGJOwQ1g4=
X-Google-Smtp-Source: ABdhPJzY6/qksvbvIcQ7lt0npPKjIcUyWf0SEgM01/42xd1PgDUOkARlMBrxwLGP9THc878lZgEffg==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr4530752wrn.63.1600771086436;
 Tue, 22 Sep 2020 03:38:06 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y1sm3901681wma.36.2020.09.22.03.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 03:38:05 -0700 (PDT)
Subject: Re: [PATCH 4/7] shippable.yml: Remove the Debian9-based MinGW
 cross-compiler tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-5-thuth@redhat.com>
 <20200921180735.GW1942072@redhat.com>
 <1a939758-99df-9f59-9fa9-4232f9b76425@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0663ccfd-0757-6b16-6f26-a9f2128d99bb@amsat.org>
Date: Tue, 22 Sep 2020 12:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1a939758-99df-9f59-9fa9-4232f9b76425@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 8:10 PM, Thomas Huth wrote:
> On 21/09/2020 20.07, Daniel P. Berrangé wrote:
>> On Mon, Sep 21, 2020 at 07:43:17PM +0200, Thomas Huth wrote:
>>> We're not supporting Debian 9 anymore, and we are now testing
>>> MinGW cross-compiler builds in the gitlab-CI, too, so we do not
>>> really need these jobs in the shippable.yml anymore.
>>
>> For that matter aren't all the other shippable entries obsolete
>> now too since we added .gitlab-ci.d/crossbuilds.yml ?
> 
> Yes, they are covered by the gitlab-ci now, too.
> 
>> IOW, can we remove shippable entirely at this point ?
> 
> We likely could ... but I recently had a very quick chat with Alex in
> IRC, and we agreed to keep them for a while until it's  clearer whether
> we can continue with unlimited CI minutes in gitlab or not.

As an intermediate step we can pull the docker images from GitLab.

> 
>  Thomas
> 


