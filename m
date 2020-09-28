Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5787C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B262100A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Hm5s4Cup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B262100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMnvq-0005gO-10
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kMnur-0005FM-P7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:49:45 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:36532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kMnup-0000TY-4f
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:49:45 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id BCFA0C60F16;
 Mon, 28 Sep 2020 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601279378;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nFuGdeKpoqd6qfIdTNAisbjqTCYPVzUWG6ttJDpwME=;
 b=Hm5s4CupodsBkoxpjbyKQPKzajOav4a5PyNbxzSusVHGvKGSNfrtOL9TYhISheSREJXkIt
 wIeP4PDujXYZufxbzwI5HfsdiWx0fU07UUYueAc2SE2UjQ1joOPKW6Ta0Y52aTRoEL3M9I
 ijNytlA5va1O2joJlNhKkZTGohemFEEO7s4tbnNIhvMMVSyYBUR/NJgqxpS5Sg+xnnjGYy
 1UnfA8MMxnVA8EYOHEGe16oAFngwaSqvoeBYb0u06dACuBfkF/1uhHrt+bmsG5tYw8h77H
 JFCsZb7cC8cTHWexqWsnCwYQSrtIeD/up5Wj5XCy0XO5b+uFStd1OVBll+zu+Q==
Date: Mon, 28 Sep 2020 09:50:35 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/3] util/cutils: Introduce freq_to_str() to display
 Hertz units
Message-ID: <20200928075035.7faf4ccxvtfpira6@sekoia-pc.home.lmichel.fr>
References: <20200927090820.61859-1-f4bug@amsat.org>
 <20200927090820.61859-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200927090820.61859-2-f4bug@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601279379;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nFuGdeKpoqd6qfIdTNAisbjqTCYPVzUWG6ttJDpwME=;
 b=EGjIH6bSiFYGod8Dy2+OqZ4Kf8Fu9rNBxpRxN8fjAWH2X+OJJRZ9tz4bGElpm5bQAGa+Uh
 gJHdacUf6othJxpmd8nUc6FgDpeYj8t2g24+MBNej3mu0cTBqzJQdUg9jNWyed18b2iZO0
 POxidCj9MFTsD7JTl6qK7Wt1hJXW4Kz6ERjUGZ9EjNZr3/Af2q25Rdk5ZrS1yvRdw0qdgM
 MsMBil5SXulQfAVjjEToFRG+1S4gihQVhRhRwjA3aJ+oT7XHLUzU0DHW51It66/IR092dd
 O2ZG+Bkfzd/g3k8JunZGI9++kLWzngUQjbgUtQO2djqpuiy69tR+IwgKdwuF7g==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601279379; a=rsa-sha256; cv=none;
 b=jlsWJMY7rtZeapj9aH8xABOa/HBko6rwzEdo6mqPak5Rz/+fWGDKj03cTQuWJGuw/v11FgkgM+kVXT7A8WdU2rC5eEmLVy1WmWqcUp0mBS9ACoFt3jtZ3UPfv/0wwcWlL2rdBx6x0xc6MawVw57ohio9+KkyL2DpoacqJIm4+gBIG1jlDhNeXfhBVKGDxXqFsgFN5ka/sFXtvqSUEZG1vmK5GVlJ2bSajjzJuEzQHUtWwUbtVeuS/JYmoS80dlYzCV84/DhjGV6bNk06+JlpLGUKzfXntYpYUe+5fu8Bkw9+/SedQMcYuIrK34B2VE1ChvihcEPr1NeJCr8hsCQCxw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:49:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 11:08 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
> Introduce freq_to_str() to convert frequency values in human
> friendly units using the SI units for Hertz.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu/cutils.h | 12 ++++++++++++
>  util/cutils.c         | 10 ++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index eb59852dfdf..0186c846e9c 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -158,6 +158,18 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>  
>  char *size_to_str(uint64_t val);
>  
> +/**
> + * freq_to_str:
> + * @freq_hz: frequency to stringify
> + *
> + * Return human readable string for frequency @freq_hz.
> + * Use SI units like KHz, MHz, and so forth.
> + *
> + * The caller is responsible for releasing the value returned with g_free()
> + * after use.
> + */
> +char *freq_to_str(uint64_t freq_hz);
> +
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>  
> diff --git a/util/cutils.c b/util/cutils.c
> index 36ce712271f..dab837fd8b8 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -885,6 +885,16 @@ char *size_to_str(uint64_t val)
>      return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
>  }
>  
> +char *freq_to_str(uint64_t freq_hz)
> +{
> +    static const char *suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
> +    unsigned unit_index = log10(freq_hz) / 3;
> +
> +    return g_strdup_printf("%0.3g %sHz",
> +                           freq_hz / pow(10.0, unit_index * 3.0),
> +                           suffixes[unit_index]);

You could end up going out of your 'suffixes' array if freq_hz is very
high. Also, to avoid the complexity of log10/pow, maybe something like:

    double freq = freq_hz;
    size_t idx = 0;

    while (freq >= 1000.0 && idx < ARRAY_LENGTH(suffixes)) {
        freq /= 1000.0;
        idx++;
    }

    return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);

is enough?

-- 
Luc

> +}
> +
>  int qemu_pstrcmp0(const char **str1, const char **str2)
>  {
>      return g_strcmp0(*str1, *str2);
> -- 
> 2.26.2
> 

