Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C44C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 04:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF93207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 04:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="kW+mHd16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF93207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiVa9-0008QR-Ab
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 00:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jiVZT-0007zP-D8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 00:09:07 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jiVZS-0008HE-0O
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 00:09:07 -0400
Received: by mail-qt1-x843.google.com with SMTP id d27so16610099qtg.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 21:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Cz8XzlfdoeU3mZ3h5v3bbY9q8jVsNCLCDcH4SKdnpyI=;
 b=kW+mHd16zb5f4jg8RsawfUlp2VmqWxU0mmUFTnES+X94RXkFCPZNelOeZ0djhIfZZ7
 7PIRNjvY0sFLFfxp+JAEDhUarc1QjD8i/X+u56dBFGLv1KyHZmC3ZN3MDug49graP5dv
 +8lEXuSiO4tSdhqy64MiBf2DJcnvCI3RYi9/FJH7jpKJtPT6gr0Kw2o0HwlDWegH3p8K
 9esQPiFOsLCH5JJrvTiv4/GbJMdtbLRz3Pn8NTzXmjwX52f1zKGlMfKEGt/1STFhJx2I
 MQQ1zolLL8JNEe6VdICBgYp69fOQhDGeDz50XobFXW0fgzVqMDXmFXdLdLeDa+WQXDId
 wXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Cz8XzlfdoeU3mZ3h5v3bbY9q8jVsNCLCDcH4SKdnpyI=;
 b=RDECEgM/cbnP8tc5lxmEk/bN47PYvHh0Lt/ulmUuXqJfDUHShrFSAZbImSpH4KDn1c
 7hu0jS/vEMF0UrGqGO2HJzNS/UG6d/DAi+VtcQUOml7k0kN45Y1zPEslRbK8VUDhlJci
 qgpFi5Wm3q1ROXQ0Ikn08CChhkpBhbzheYRv2vIhAURegHEGmBasxkrumGhJIKDMaUMt
 tR/HQG56V4ERtqY7TaLNh+iKH24kvqLoFn+DkQF02cYosFxwvzAEvAyTSbD2h3HbjhQq
 qnWXnOlo4bSou2JevsmML30iVk9valy0ijdg3eAp8eGiq8baj+0kU6SXHLMFhqHDghWy
 5Ybw==
X-Gm-Message-State: AOAM531FvCpElYPwNxj+akLyb4JmKazI4SRAvlE8Ez8Uo2JdpSf8Eopf
 HR1ixvzPS/cJUvJflhNvjO3F+Q==
X-Google-Smtp-Source: ABdhPJwS63nd9zOxFwWPWcMsKW6aIAmvptt385zJZIp/Bg7SuLHbTNDOR+tTDBm2O5ZRtoNX6QOWkw==
X-Received: by 2002:ac8:768b:: with SMTP id g11mr27999969qtr.249.1591675744203; 
 Mon, 08 Jun 2020 21:09:04 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id p25sm9622848qtj.18.2020.06.08.21.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 21:09:03 -0700 (PDT)
Date: Tue, 9 Jun 2020 00:09:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 7/9] plugins: add API to return a name for a IO device
Message-ID: <20200609040902.GA3724030@sff>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-8-alex.bennee@linaro.org>
 <20200608034504.GA3619843@sff> <87zh9e6kxy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zh9e6kxy.fsf@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::843;
 envelope-from=cota@braap.org; helo=mail-qt1-x843.google.com
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 09:06:17 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > I'd rather use asprintf(3) and strdup(3) here, so that plugins don't
> > have to worry about glib, and on the QEMU side we don't have to worry
> > about plugins calling free() instead of g_free().
> 
> AFAIK you can actually mix free/g_free because g_free is just a NULL
> checking wrapper around free.

I was just going with the documentation, but you're right:

https://github.com/GNOME/glib/blob/mainline/glib/gmem.c#L196
> void
> g_free (gpointer mem)
> {
>   free (mem);
>   TRACE(GLIB_MEM_FREE((void*) mem));
> }

The NULL-pointer check is done by free(3), though.

> However ideally I'd be passing a
> non-freeable const char to the plugin but I didn't want to expose
> pointers deep inside of QEMU's guts although maybe I'm just being
> paranoid there given you can easily gdb the combined operation anyway.
>
> Perhaps there is a need for a separate memory region where we can store
> copies of strings we have made for the plugins?

I agree with the idea of not exposing internal pointers to plugins
(e.g. we don't pass a CPUState *, only an opaque handle) so I'm OK
with returning a dup'ed string here.

(snip)
> That said in another
> thread Peter was uncomfortable about exposing this piece of information
> to plugins. Maybe we should only expose something based on the optional
> -device foo,id=bar parameter?

I have no opinion on whether exposing this is a good idea. If it turns
out that it is, please have my

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio

