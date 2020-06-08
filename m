Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 03:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1FB2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 03:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="nNEI/Zit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1FB2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji8pq-0006QH-So
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 23:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1ji8pD-0005hc-V7
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 23:51:51 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:35729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1ji8pC-000687-P2
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 23:51:51 -0400
Received: by mail-qt1-x833.google.com with SMTP id z1so13685715qtn.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 20:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xtfNxlvfBtpjjWpRP8pTeNLg5ruQ//RZo4/++ndRZZc=;
 b=nNEI/ZituJJbSpWkJzr34Wtln3MUErXZ1ZrT4+xXtBaS187BuXep0s3H0PMZAybYyn
 02ILAcVe9xAPVdcBqRHl9ua5McSc4+BZ99QZWQIhP3lBYixUGfaEeoYMjMqHuXofl+8t
 5Dh1wdUVsUhbCtAVmVJ0KpjFqd+qKFKJVESDfd3+DjFyw4LKL9y6PbwzNw5bYZVDJAjf
 p6NQq38Gw7V8DCZHfgMlmTHHCMlSXWeqXZqKDBjLsTq7juPidWFYmnfrqRJrf0QLozpu
 sII1h1QPIMRR6tHXTqg0SYoir8Nz0KHKJIYggH9NwxqIjfrSKuDQeYPHMqUcbSD12127
 ChCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xtfNxlvfBtpjjWpRP8pTeNLg5ruQ//RZo4/++ndRZZc=;
 b=lMHsQhEy4KnJG7z5CpJczS02FIHPESiW7gdAOFohLl4AkrbNjVy9xSeZ+wnVEuljcj
 lR5QXJFrZbZsLtqJimFaZc9CEnsxryyfHW0gpIU2MVneKel2vg/KZ0ywrfuLSaDEHFgn
 rZXkmLD92mwuqZmMkLOZLlKyCq5/G7omE1duW5O96BaLo7NvhgbusYU8H0nWh6xs/GgN
 GJh1ft+AepoBx209+0/9mpC5ccdom24QqvfNaBHkuhR5sdx0LmGqLFhhZl+iUqVigpCD
 3IsjTkzMdW2w47YJxgkMliy1XUE7WvOWFfp4jqhInKRaXddK8/jEV09z+V7samovPfIx
 pAxQ==
X-Gm-Message-State: AOAM530i8lUfh3dV9ZQVVyNlMYr0ku4k/+93Q+aGFvpEYfCjsdMcz5qj
 AT5PfvXPesmypTyfaXLkQdtMNQ==
X-Google-Smtp-Source: ABdhPJzF0H/vzj8M6guM6JAe2qsoC1aOgvQpbLXf+nnT66pXr+nqEe8Tm/xLXq9yU2d2T+WHgyvdfg==
X-Received: by 2002:ac8:776a:: with SMTP id h10mr20705121qtu.389.1591588309734; 
 Sun, 07 Jun 2020 20:51:49 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id m13sm6696534qta.90.2020.06.07.20.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2020 20:51:49 -0700 (PDT)
Date: Sun, 7 Jun 2020 23:51:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 13/13] tests:  Disable select tests under TSan, which
 hit TSan issue.
Message-ID: <20200608035148.GB3619843@sff>
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-14-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605173422.1490-14-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::833;
 envelope-from=cota@braap.org; helo=mail-qt1-x833.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 05, 2020 at 13:34:22 -0400, Robert Foley wrote:
> Disable a few tests under CONFIG_TSAN, which
> run into a known TSan issue that results in a hang.
> https://github.com/google/sanitizers/issues/1116
> 
> The disabled tests under TSan include all the qtests as well as
> the test-char, test-qga, and test-qdev-global-props.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio

