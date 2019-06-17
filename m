Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C877C31E49
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 01:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99DF2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 01:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gn+JF4rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99DF2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcguB-0005pF-MD
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 21:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcgtd-0005Js-Lr
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 21:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcgtb-0000zD-PX
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 21:57:21 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcgta-0000wD-KD
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 21:57:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id ay6so1175652plb.9
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 18:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2OsvSW4GSBnbgQa0sO0qsPNSXyQEpySHL7qaHEPIibQ=;
 b=Gn+JF4rA5YHVpOD7P5k7NRtOjE3IDTTeuw9YZNXRnjKu2oHh2Ao/55dqcTZ3Pyjv0N
 95bC5io9LwToY/LaSeWUC6qziWl5CrZn9OVwwT3XA8foC2OFffzu4Fxp3dS2cclrmp6Z
 CGYRhtsQXjY/UMZBNHE4KbcRIjZfhNsAaZYw03JxcYoWzHsOjOzQxQLmHv4shOs2HPHE
 R43ky7QHzj4eGta8kFUMRngLHIS+SxrNmyPXe8aAMtpE8IGsLEhgRew3JbFAsKD5HcM1
 jmgE3zKG6s5KlQoWMF+0QhkHiIRXnXi7HbLnoLLomoPDvHuN7BBVMDaAQhjjCPzi8aKc
 yJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2OsvSW4GSBnbgQa0sO0qsPNSXyQEpySHL7qaHEPIibQ=;
 b=YQvwI6jk0BWgxfhjeDB1QWazSSXkZX5POSa4CUNVYvfjAP+iizFDEwfBBejlR0KlHB
 2VRX+pqZJMP7OmyFuEezJzUA+TDVVa5HM/Ub9E/GDjmtuY08kdgOUCKjuTpU3w9VxebO
 N47IQKGrJuoULDF/CiubXdfJ8emhI7nJ9wUWk0LPcQUO55LeK46499TF1slnD20PwOMV
 HDzoVVOEMjJiIVHjuguHRlElvX4wh61mamAvSkhMEgpGWFDM834IUdwjlYtgG6O5Wdun
 RrUT2hHTTFg1jqP7jjt3JfgEhJ6Q4NUZxzc2R+lkct+Lt1PjoVRm/I9h46m3q99ncI3B
 liYg==
X-Gm-Message-State: APjAAAUmL7vj7lTrBJmbZur0dV1FlvshTWuJJdie3Dtx46bz4Mj5xXrG
 DYr+yqA2HROFflQ9BbEk4qWF5CteFjA=
X-Google-Smtp-Source: APXvYqx14GsrOpH79vh5sYeaAPz5Tz9FWzFlCCDZ9yza6WVJneEpMOtnrHCAu2qqGS7zXEd385kH2w==
X-Received: by 2002:a17:902:363:: with SMTP id
 90mr19619850pld.340.1560736634408; 
 Sun, 16 Jun 2019 18:57:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 r6sm8599799pji.0.2019.06.16.18.57.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 18:57:13 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
 <20190616123751.781-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6529a889-972e-7b74-a876-228a35a58a89@linaro.org>
Date: Sun, 16 Jun 2019 18:57:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616123751.781-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v3 02/15] target/ppc: remove
 getVSR()/putVSR() from mem_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/19 5:37 AM, Mark Cave-Ayland wrote:
> Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
> registers are in host endian order" functions getVSR() and putVSR() which used
> to convert the VSR registers into host endian order are no longer required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/mem_helper.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

