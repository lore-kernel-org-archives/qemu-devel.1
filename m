Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7B9C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE5A20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/pKsL15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE5A20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkmo-0005XT-4Q
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkmC-00050g-Ee
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:12:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkmA-000743-5C
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593879145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I6EbQC+4n7BnvuTnV5GlBDgAKh3ptuniVuwiQ4k+Rhw=;
 b=Y/pKsL153gmAqD9R3k3UQK9C0LO7RjkZhVk6d+FCfaOnYwGAaWEvG6jWNIR8CkOFBinjtf
 +AmY6dgtRs9t3VGQdCenjobHRqfeoLVPBEXrrXNVluqI/meTnDjk0ADos/BZ1AVyEoCUTa
 9Q8DloECVuiEh0bLPMOscAXF7o577R0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-AQcIzzbhMceIMOwf9JKzWg-1; Sat, 04 Jul 2020 12:12:23 -0400
X-MC-Unique: AQcIzzbhMceIMOwf9JKzWg-1
Received: by mail-wr1-f71.google.com with SMTP id i10so36011786wrn.21
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 09:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=I6EbQC+4n7BnvuTnV5GlBDgAKh3ptuniVuwiQ4k+Rhw=;
 b=YZzOxW+rv6NPUIKSEL2oDFRcOS+OeaI/w4/5j3JNKtCN5/IVB5jEpgwbhXzPC5vbqm
 HTlewpmz6LI0jggOG/QaPl1j6MO80quC/7qkZHdNr20E1QdS8d/dKQjDWqe6DeaZcvET
 d+GIgUuJDegbeprMhtg/iHvBr2JJ37o6PSsAPrHIjG8Iz7LJ52y6nw0CxYJEB+1KK5QF
 JmfKcaPAnJa9DloRNS4O7ZrL7hAndxxtGynJS19xiZa0zOjIhjZoTMlOeW/UNqACWlq2
 WE6JGbsYFdfQkxB8lYuaRbBQMsY3veTSX2zcjBlmOjqvDfpPK4fwR2R+SQDfPHPNPZHD
 ZAAQ==
X-Gm-Message-State: AOAM533YRgVdhc6sGrNTTMbX8Z72VzydixthuRfwPVq9bHKRul0CPUmx
 opBC5lXlUo+HWmNUWFJGU1pS1u8albuOsRzuH60IPQiSWdKjdKJBakYJSvlxK4iHuBpFcx8pU7n
 JteEswBapdJ0PSUs=
X-Received: by 2002:a1c:7916:: with SMTP id l22mr33184248wme.115.1593879142358; 
 Sat, 04 Jul 2020 09:12:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGjfcpK1SRBF+cFHobNnuRej3sQFqvXBR49U7wkqAbY2PSfUFTAgP02yO/wQnvKIlLRepIxA==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr33184231wme.115.1593879142087; 
 Sat, 04 Jul 2020 09:12:22 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z25sm16089866wmk.28.2020.07.04.09.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 09:12:21 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update Radoslaw Biernacki email address
To: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Leif Lindholm <leif@nuviainc.com>,
 qemu-arm <qemu-arm@nongnu.org>
References: <20200512170704.9290-1-rad@semihalf.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <80ccdde4-77db-4e83-f711-6a7c389c31bf@redhat.com>
Date: Sat, 4 Jul 2020 18:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512170704.9290-1-rad@semihalf.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial...

On 5/12/20 7:07 PM, Radoslaw Biernacki wrote:
> My Linaro account is no longer active and stop forwarding emails to me.
> Changing it to my current employer domain.
> 
> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6412067bde..668da447e3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -46,6 +46,7 @@ Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
> +Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>  Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..a9d6893036 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -799,7 +799,7 @@ F: include/hw/misc/imx6_*.h
>  F: include/hw/ssi/imx_spi.h
>  
>  SBSA-REF
> -M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> +M: Radoslaw Biernacki <rad@semihalf.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
>  R: Leif Lindholm <leif@nuviainc.com>
>  L: qemu-arm@nongnu.org
> 


