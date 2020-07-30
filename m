Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F03C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0567C2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gznR2ctk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0567C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18Kc-0006k6-09
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k18Jq-0006Gz-93
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:09:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k18Jo-0003gV-Hn
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:09:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id j7so7274714oij.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qoj9ub5lu7I9r6SyG8ha2PcJGoGjDBZdUu1nw4D0MKM=;
 b=gznR2ctkVldiVZIsWp5D27ojBXSNl9qFepSrYRzsdcLc9U3f6jIq2jPD5tH9Tk+nQd
 zm5nrbNrSxckOk5/VaPRaRaqe8ioJ8rqrSgi/h5vmJGPw83wiIQc6sakQlpRUZl4IdbK
 Wx86/OTUlaFYOPhIIrSwZLumXy3RNWwYME6ITKDcJvOvL/0dAbtV+ss6cgN3daR7HHNr
 6HUl27t5p9HzXzU16zpDd8WSGjksE+PSQE7E4DEzzJl+G6/TESiNeMh6fog1Qq7ooZSR
 rIY95DYaLcB4mUZhj7uk8MRnzhEq+EG4fFqgO3DqvBAgbY9w7glcwxZC+DrumvlO2yvh
 Nguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qoj9ub5lu7I9r6SyG8ha2PcJGoGjDBZdUu1nw4D0MKM=;
 b=pD9R0gwNrEIvOCYhldvL1peaYO62w4HJIIsZcRTCM6G3jyRrkYHrnrWL1jc/wuOv03
 IdFFOFd49mfiTEAe/07o3pC8Ek1ylFDr5VbApSgCMU1G1mOz4iSriK8OxF6Sj/n1A59w
 LvGFkwDXAmeoLav4K/zqCId80u7Z9/b4wjJLfhne35rMLztlm3xCxq8gGlBlerdPO69P
 oEAQeZhgAG9HeKztYehDwpEbSjZKAp//qpwhD2AO0+TuZ0e8r8QXtvZZtXRmb6wadeND
 D0aqZYPajQ6AS659uQD5S4RMU9Ew0mxQpo3Es9blVLm2qje4qYu+t0pWrN2EjLGrmIf0
 KbBw==
X-Gm-Message-State: AOAM532fEpyr3985H1btm9dWaiZKsaQ6DTzyoXQQmTiofRjSG10Fumvq
 HNRYiNDmLF1ySzGhVXj+s8deECt8zA4K69yT3kHqUw==
X-Google-Smtp-Source: ABdhPJxscN1AlheuZ3CtnUGLRJl4TRtDmv/qgLtx7c58cY6Z2qWP8RqtR2w2HSjo+TisKvMoCm+BwXyt/vdlDuNdMZE=
X-Received: by 2002:aca:4a96:: with SMTP id
 x144mr11426934oia.163.1596114595311; 
 Thu, 30 Jul 2020 06:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200730130156.35063-1-pasic@linux.ibm.com>
In-Reply-To: <20200730130156.35063-1-pasic@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 14:09:44 +0100
Message-ID: <CAFEAcA9y8e6oaqaZvPm=GYHdov_TBnUeSBZt6-cAJmK3f_rQAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] s390x/s390-virtio-ccw: fix off-by-one in loadparm
 getter
To: Halil Pasic <pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 14:02, Halil Pasic <pasic@linux.ibm.com> wrote:
>
> As pointed out by Peter, g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1)
> reads one past of the end of ms->loadparm, so g_memdup() can not be used
> here.
>
> Let's use g_strndup instead!
>
> Fixes: d664548328 ("s390x/s390-virtio-ccw: fix loadparm property getter")
> Fixes: Coverity CID 1431058
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 403d30e13b..e72c61d2ea 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -701,12 +701,9 @@ bool hpage_1m_allowed(void)
>  static char *machine_get_loadparm(Object *obj, Error **errp)
>  {
>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> -    char *loadparm_str;
>
>      /* make a NUL-terminated string */
> -    loadparm_str = g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1);
> -    loadparm_str[sizeof(ms->loadparm)] = 0;
> -    return loadparm_str;
> +    return g_strndup((char *) ms->loadparm, sizeof(ms->loadparm));
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

