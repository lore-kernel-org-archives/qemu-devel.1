Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B04C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA0420869
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZrqOT9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA0420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFCAj-000279-Sg
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 02:29:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFC9y-0001p4-0N
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFC9x-0008Oi-2y
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:29:05 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFC9w-0008OA-Mn
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:29:05 -0400
Received: by mail-pl1-x642.google.com with SMTP id g12so6116778pll.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=SsNi8Uo8iVJ48DUrhnqYMYyH96Djvb4zFiYHlb1DVik=;
	b=pZrqOT9LEx4zOzR+vvN0+GxXMRqg3dXdqNpukfT+fmBlfGoxbEBSInNsao/c3kLdaQ
	Xzn1iBajnA9EMyeYoiYglT6SkOxe0jI+9KwrQxsIyHRXCtKx4uYqKDTd/KoEB6aj60SA
	RlNx0oswb3CBSpTQQhxyL+0il8XxfC++KZzUJPkz1rBns66YbE+6f9DqVb5B7KgKrPrO
	3pG/qq+g1G49ec1qOP5KcKYOztckirH3AO5bjaoojKXvjDubOaQ6YYglAVf9E9n/IA3A
	NURAs2qBkcNCAeEWJYdfwucOSCgWRLoC4TwnnbDWzx1J622EpgSM9u+XgoloTUa6rmvw
	0EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=SsNi8Uo8iVJ48DUrhnqYMYyH96Djvb4zFiYHlb1DVik=;
	b=D/ShKMbg2qZ9ttwhi8b9lU5VE/F1VJuIi47yistSfjYtlrU6iL+QHI/7LwWEoNkliD
	OiMg60z/mtIVhf8Pnc8CSVlGIdCc8RsNn8xbp6XUQbbCEEUGVZG2WyzgA8wRnt6l9YTQ
	ODKzHV3EVydzLc2fP6kTn+Gkf6Ly/cqsGqAVyRsheLwkhgrX9y4mbhN+v2T/v0wk1OAQ
	Ovv5EwqkJGZYiJRJp9vdy443WvycfV0EpZW8lod+DrgAdYOaktTw3lPBl2h64gczDw6B
	N0sKrcRJKWp8PBHEfPW62neoT/WaEzmOSbK6Q5VvyGUbTxqrashvXaO9+6Vtto+5DKGf
	bneg==
X-Gm-Message-State: APjAAAXuEjjPGT3msXMKJF2nkrMJIp0BJMKLHu1ZrfIjcknlARAf9l0a
	5Obw93nOMseWq599/xtvZeCGJA==
X-Google-Smtp-Source: APXvYqwtRQCgGhIugzYr93BrrcHf466gaHqBss0LLnDEE87nqVmLYrYUNTRvDf9hJlBRmFGivmmAGQ==
X-Received: by 2002:a17:902:184:: with SMTP id
	b4mr41210205plb.26.1555136943485; 
	Fri, 12 Apr 2019 23:29:03 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	25sm18969248pfo.145.2019.04.12.23.29.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 23:29:02 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-42-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0871b6f8-6073-4311-78a5-4772817a009e@linaro.org>
Date: Fri, 12 Apr 2019 20:28:53 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-42-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v1 41/41] s390x/tcg: Implement VECTOR TEST
 UNDER MASK
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413062853._bOPbmqdPyVKz9aazK_jNUuQzf9em8VWlWZwUENkC9k@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +void HELPER(gvec_vtm)(void *v1, const void *v2, CPUS390XState *env,
> +                      uint32_t desc)
> +{
> +    S390Vector tmp;
> +
> +    s390_vec_and(&tmp, v1, v2);
> +    if (s390_vec_is_zero(&tmp)) {
> +        /* Selected bits all zeros; or all mask bits zero */
> +        env->cc_op = 0;
> +    } else if (s390_vec_equal(&tmp, v2)) {
> +        /* Selected bits all ones */
> +        env->cc_op = 3;
> +    } else {
> +        /* Selected bits a mix of zeros and ones */
> +        env->cc_op = 1;
> +    }
> +}

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However, if you return this value, then you can do

DEF_HELPER_FLAGS_4(gvec_vtm, TCG_CALL_NO_RWG_SE, i32, cptr, cptr)

static DisasJumpType op_vtm(DisasContext *s, DisasOps *o)
{
    TCGv_ptr p1 = tcg_temp_new_ptr();
    TCGv_ptr p2 = tcg_temp_new_ptr();

    tcg_gen_addi_ptr(p1, cpu_env,
        vec_full_reg_offset(get_field(s->fields, v1)));
    tcg_gen_addi_ptr(p2, cpu_env,
        vec_full_reg_offset(get_field(s->fields, v2)));
    gen_helper_gvec_vtm(cc_op, p1, p2);
    tcg_temp_free_ptr(p1);
    tcg_temp_free_ptr(p2);
    set_cc_static(s);
    return DISAS_NEXT;
}

Perhaps it doesn't matter though, since use of vtm probably implies a jump,
which implies end of TB, which means that registers are going to get saved to
backing store anyway.


r~

