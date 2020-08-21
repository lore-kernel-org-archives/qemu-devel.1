Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35314C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EB620724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILIJSeaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EB620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96F9-0000lj-Ac
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96EW-0000Ll-SL
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:33:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96ER-0001FR-Gj
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598013198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dR2zY5MFW4XOd+TU//cTYYraDfe4/34ctYa/xT0I44=;
 b=ILIJSeaR2yOWsbQraUJ19IomIdZNq5mQWr0ehXBUJJm2VzYiLHKIALZOAxDfyVwhC6Y8us
 6s/InejECpWzO8vYqoczEBhWvl9Vw8UcffcAuo24Wddj9p+7Tb7k30drIT9etfqlwbi3p1
 /g6FaWRti23IiBthFfE/rrKwzxksR0A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-m0DKE1MAOryVIuipFcv7cQ-1; Fri, 21 Aug 2020 08:33:15 -0400
X-MC-Unique: m0DKE1MAOryVIuipFcv7cQ-1
Received: by mail-wm1-f71.google.com with SMTP id r14so770172wmh.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 05:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7dR2zY5MFW4XOd+TU//cTYYraDfe4/34ctYa/xT0I44=;
 b=f4x2RDdFUPY+wTYWMDq3MQfLWR55S9adxBHuUEQAvgCLIUdjmXYvaaq5ZMZ1i3nsTX
 xGcOL/t3BfGsMUJuHpkVR6ycH8PBeqIEg3Ji665NanA986iOZTmpdzwIc9ZnOCNlh+1F
 t12gqIFnp+Df3yijiiC05Afg3oM2U6zUKlt/uvVeg8h9C1Y/C+DRwFGHPjuWNQordW0y
 v9E7IR0VLXQ1QzXx7jNMyrOeQsM86nyJ1DdclwFYuly2X/VUJqwgKVg7SJgB7eCKhbMK
 8zDt0Jvsx9XjW1BgeFcmgpDAz5caZ9IC1sShRLc8xJdr8ltY4a8NGSdss0F39RhvAkoI
 MzQg==
X-Gm-Message-State: AOAM533V1muyqn9DqpwkoYjhfMKyAo5jtl7ocRPhCiAVh17xwXSCUDCC
 3tZb5Ksir1eJvoFYZ1A9YBw9j4PWEOOu1hhMVLtzHPytFP6DG8Klb8LhYXTzn4Ox6NdsXAlNAXF
 k07pRbHL4Uvzutig=
X-Received: by 2002:a1c:e919:: with SMTP id q25mr3538956wmc.123.1598013194191; 
 Fri, 21 Aug 2020 05:33:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4/oNlHCyaeKAL8tuU8+UI0m0SV+ApbsvsldpigRnHjh+wqmyOj6Na72p+2U7amKbDuKUXBQ==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr3538931wmc.123.1598013193937; 
 Fri, 21 Aug 2020 05:33:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id g18sm4365850wru.27.2020.08.21.05.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 05:33:13 -0700 (PDT)
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Howard Spoelstra <hsp.cat7@gmail.com>
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CABLmASFno04tFBRTq=V8AO7dj1d67-SNpugUJMVVa4yzrPq03Q@mail.gmail.com>
 <CABLmASECM5tVVw3TMJn+0bCT7O4H_guy5TJd9YQKYYx+QUKBKQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd66cee7-c6d2-a81e-2e53-eca34ed78be8@redhat.com>
Date: Fri, 21 Aug 2020 14:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABLmASECM5tVVw3TMJn+0bCT7O4H_guy5TJd9YQKYYx+QUKBKQ@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 12:58, Howard Spoelstra wrote:
> I investigated a bit further and saw:
> ldd in Fedora tells me the executable is "not a dynamic executable".

How are you executing ldd?  I cross built a mingw executable from Fedora
and it was definitely using system DLLs.

PIE builds and doesn't start (doesn't even reach main) but --disable-pie
works just fine.  I don't know if the same issue is present under
Windows or it's Wine-specific.

Stuff that is not in CI pipelines is going to break.  Since there is an
easy workaround for bisection (--disable-pie), and Meson makes it easier
to run tests under Wine, we really should fix this on top of the
conversion and also add Wine support to the CI pipelines.  This way it
will be tested.

As to grepy.sh, perhaps the problem is due to CRLF line endings?  My
suggestion is that you just rewrite it in Python, like

s = set()
for fname in sys.argv[1:]:
    with open(fname, 'r') as f:
        s.update((x.rstrip() for x in f
                  if x.rstrip().endswith('=y')))
print(*sorted(s), sep='\n')

and send a patch after you've tested it.

Paolo

> Meson seems to default to try a static build and enable pie, whereas a
> normal build would require --static to enable that and have pie=no


