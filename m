Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC0DC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8786206DB
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwnfCZN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8786206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOd8M-0005u3-KZ
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 04:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOd7Y-0005TX-SX
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOd7W-00032J-CX
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601714539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0xpqNSz4nR6zaOIrWqbrOYhSZ4Jof6dJwL27Mhk994=;
 b=fwnfCZN2uOfJhYDqENY61mrjnrmYmoUfjDLDr6HLP7sxqkRHMBSxRbWI1vj/3NHBX1HBC+
 /22qE2T2xhstbVLZeKO321bi6m9o2j3jLpgoZwbbOwMQ11uYSggeMM8ABltDitYnnKiZE7
 dzGL5Qy1ULsKJBjZCnPmuhZxbEXC/ec=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-GOziJyg8MGCxiYm0g0JY7Q-1; Sat, 03 Oct 2020 04:42:14 -0400
X-MC-Unique: GOziJyg8MGCxiYm0g0JY7Q-1
Received: by mail-wr1-f70.google.com with SMTP id s8so1577323wrb.15
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 01:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S0xpqNSz4nR6zaOIrWqbrOYhSZ4Jof6dJwL27Mhk994=;
 b=FKBJQvfqLu/iqk3wEv9HWw95qroc72MTuFOW2fXfkGeWJ3jO3AbS6DKT+gZEiN+urT
 XCcLh5nkYyX2uMOQGMjbaF/VMfwPVJWKQz7F5/lUd57jXDTcBa93xZ78EDhI3VPwLCa0
 KE3ZyPehZzdi3wHvOmmhzHOsXxau1ymD/T/F1SwUGcGvwS6mzVcftbWmrnumy/0P4c1i
 gtxREjO160YmKz9lxyuuq6vTHY1FUhiT4Bs5uv+02iahLhkW98R27HSZPZksmqHGISrs
 OR0Zdu3fdFy7Trspd2hvfTGI9zI83028DTOia2dWpaxdOFNan0TV1U+2xGoj1UEuDbxU
 gUcA==
X-Gm-Message-State: AOAM533XPIKT0KevqDvncSQhV2ZyhDW31xmrWt74iqK7dcuiHWvh0OL2
 dkdIlxzHDUObEeZSZAqLOCQAwKDH5M9q6ZPAFxxTcpE7ZnfbrCHxmSqmSlnLSyD+2C8Hvag2iSx
 fDtAI52MdLkQlYPg=
X-Received: by 2002:adf:93e5:: with SMTP id 92mr7013537wrp.31.1601714533490;
 Sat, 03 Oct 2020 01:42:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrRPU3hOX01ntmaQSZ5IbgEzb06+x487DnrYKVXRHnEmoNE4UilX7kIqwMqHiDZPlDphSp3Q==
X-Received: by 2002:adf:93e5:: with SMTP id 92mr7013528wrp.31.1601714533291;
 Sat, 03 Oct 2020 01:42:13 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id h17sm4861827wro.27.2020.10.03.01.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 01:42:12 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: luoyonggang@gmail.com
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
 <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
 <CAE2XoE-Z0E1TSn1pHfBK=7vcGL9qkxVwwxMOg3KhqaMMdJidiA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3cf8a363-bdfa-2e31-995d-52a0fd1dfd42@redhat.com>
Date: Sat, 3 Oct 2020 10:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-Z0E1TSn1pHfBK=7vcGL9qkxVwwxMOg3KhqaMMdJidiA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 10:28, 罗勇刚(Yonggang Luo) wrote:
>> Yes, I think adding a "links" argument to dependency (similar to
>> find_library's has_headers argument) makes sense.  That would be written
>>
>>     dependency('libudev',
>>                required: get_option('mpath').enabled(),
>>                static: enable_static,
>>                links: skeleton)
> make sense, may also need extra cflags and link flags.

They would be provided by the dependency, in general.

Paolo


