Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2466CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A0121D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXKqCyae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A0121D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy9a-0000KF-U3
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNy59-0002Pi-OX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNy58-0002uo-Bk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:48:39 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNy58-0002uY-7E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:48:38 -0400
Received: by mail-qt1-x842.google.com with SMTP id m15so2792014qtq.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/AMs0Dimb29TZlqTvMOTBeJcsLLD71JGQkASIBl9xME=;
 b=HXKqCyae1o8GGdtx1cU7ywBhEPj/VJab7fLs9EO8J5kamTR2V6cy6hToaEdgbPIBtT
 X551pF72UdIg5NCpy6ISz73eRj2DgCLJGhOh1OUnVEks0OxxEQkIxH0oco/i/DnF+mVP
 rL9d/YYvb2dXtoGcFP9dike0gSTSjYFVNxPgh1owCpllnyxlCI5ZatIiXZpAAiGFEmo7
 494dDp3gDSi3kWW6KlDlJUeVd/t9sXdo7HJQe+C70tMNeaFgoCHIahfTkJ0oXNQ1Drzo
 V00JyrB/Bwc3nB3BpMexF/wExBCQt8xPCuQxd9uWy9NFy50s2TzYANVIo2FvEkF3Ytzn
 R1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/AMs0Dimb29TZlqTvMOTBeJcsLLD71JGQkASIBl9xME=;
 b=XwgExrgl2A4JNp1He5rBpLpxO8S7+0Fpg5i09y2UcmNXyIqquYm/O8J12l6TAEbKtc
 C+TS5NIrW0C1gD5BQK9ZT2Z1yMhyyvSGxskvV60H99G2nKM4RrQw5e6O8Jubx+cK91wQ
 mFdjD+xYlPS5AgfrjcFOChNopjxKcmnOyUry90SNmjW71dP7yzTTDruyJZm5bUtQkE1x
 FN1QtrXCDs8Ym/jw45Knt/aAoQEiwD5cAndrqOPf5rX6Qsu6V8u9lRCRmVUX1VJ34Tru
 MdParmK9/93SpwQzGy7RziwipNQyOTqkWeDqQRbmq7eg1HvhdtBc7zlOcD5r66MVTYt+
 wrwA==
X-Gm-Message-State: APjAAAX/cDHDwMHHKiR4DnajI3O5KGGiQauap/XXXyLwYzaig6zubvG4
 Rp6LW59gkJa5jogQERljm/63RA==
X-Google-Smtp-Source: APXvYqzXCAPtdh31nWZd7wHsiUXqobCvZQpZxdfcDwLNt/y2TYjJSbEeHRcJoc42jgzVUyUp8R0+DQ==
X-Received: by 2002:a0c:c482:: with SMTP id u2mr2760962qvi.121.1572004117097; 
 Fri, 25 Oct 2019 04:48:37 -0700 (PDT)
Received: from [172.20.87.163] (198-4-20-64.static.cosmoweb.net. [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id t199sm990799qke.36.2019.10.25.04.48.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 04:48:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-2-richard.henderson@linaro.org>
 <55b477b7-877e-954f-2175-ed36fa787600@redhat.com>
 <e41a98e4-189a-1e0f-7b29-51a6e00e4d7e@redhat.com>
 <26cb0551-fbac-e059-c1bf-9c17420528b7@linaro.org>
 <af5b2cb5-49b5-68c2-e55b-a1077ad4df28@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <370895eb-f229-ff61-16aa-80587d6ff79a@linaro.org>
Date: Fri, 25 Oct 2019 07:48:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <af5b2cb5-49b5-68c2-e55b-a1077ad4df28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: alex.bennee@linaro.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 10:14 AM, Paolo Bonzini wrote:
> On 24/10/19 16:06, Richard Henderson wrote:
>> Richard confused ROUND_UP with QEMU_ALIGN_UP.
> 
> Uh, those are both really badly named.  Especially considering that
> DIV_ROUND_UP divides the result of QEMU_ALIGN_UP.  Should we consider
> swapping them?!?

Perhaps not swapping, but perhaps renaming ROUND_UP to POW2_ROUND_UP or
something.  I dunno, naming is hard.  :-P


r~

