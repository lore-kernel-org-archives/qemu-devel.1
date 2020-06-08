Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FBEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F1420656
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrFFqdQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F1420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiCoG-0006An-AF
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 04:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiCnY-0005l3-AC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 04:06:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiCnW-0004KB-U4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 04:06:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id u13so14394740wml.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fbCDlMUVnJaCYqBO6gQQ+AmoWd39Zy7BSpN6sSIV+D0=;
 b=QrFFqdQuR4RFqHFymETd7ep5jjwnwdLMi0U5ivTd93fNbZW7d0HoABJ+WYIMLtVeKL
 fWoyy5TL59yGgkUn1+kWc0jpDrjC01rJZzHuGHm4L54o/GXnZ6bFQbVfRxbUcOh3Zzjf
 1o8TpbB6zNHQT5o2SUM7+TLJfgEdutXBCliekj6WUVQWRn483QbXJ/bnfCo/lN0YPUqR
 Atsp4RchJpQWNLptsGZtIAR1jJfcK9OYa5t77iNwsa0lD3Yn89G76VPEvt4thri/x40/
 FzKYZSV5QHIshl/5YpAWDDF6aSdQKI37WAFjKF2ccQgomxJBZkb5tdsTD0ivP//fyFSU
 ++Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fbCDlMUVnJaCYqBO6gQQ+AmoWd39Zy7BSpN6sSIV+D0=;
 b=hwS3uI5THE/CDj+QCd7Mhuotr2a9bT25PraGNuIZLnQ9dA3iWO4MKqhYKcFrxq9iVI
 l80qfUnKo0efPIx4/Dt4obg+PnL4k7kDj1PX1V62LHgoQp6LazdRZptixeTQfj/GR3U1
 naA4kO9jnBrGtej71CGj26s4HPloIm+gFH7IwYE82gasm5JL1XmRYxbIy0A+s2eVWadK
 Udyrph0Lby3EJd8leAQmo484JiZYLhUbAXkXMX7NnoIg4s6lhbmm8Ux8tHMbRqHDFAiE
 IwfxUxJqH0bPsUF6ErYU7JKt04Tw2Svi/wkcmPZ2ZWaxV/cw8rl1cASd0b4dsKX9zvsE
 9f+A==
X-Gm-Message-State: AOAM531pUFGjxb9LZ/3EA6bn64CsCFSV1u9LvwyANcHsmvgUO+dy95RB
 +mtbPFFEc1vq4dgSTn2DCEOrKQ==
X-Google-Smtp-Source: ABdhPJwSC+26sBqTvxPif5NoZ/9SUk7fbZaTXLuLZ0O+KKKdLYIYXV+idJExOdQ6omzbY8AbU0RJ3w==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr14774399wmk.94.1591603580415; 
 Mon, 08 Jun 2020 01:06:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm23598798wra.86.2020.06.08.01.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 01:06:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C7FA51FF7E;
 Mon,  8 Jun 2020 09:06:17 +0100 (BST)
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-8-alex.bennee@linaro.org>
 <20200608034504.GA3619843@sff>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH v1 7/9] plugins: add API to return a name for a IO device
In-reply-to: <20200608034504.GA3619843@sff>
Date: Mon, 08 Jun 2020 09:06:17 +0100
Message-ID: <87zh9e6kxy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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


Emilio G. Cota <cota@braap.org> writes:

> On Tue, Jun 02, 2020 at 16:46:22 +0100, Alex Benn=C3=A9e wrote:
>> This may well end up being anonymous but it should always be unique.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  include/qemu/qemu-plugin.h |  5 +++++
>>  plugins/api.c              | 18 ++++++++++++++++++
>>  2 files changed, 23 insertions(+)
>>=20
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index bab8b0d4b3a..43c6a9e857f 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -335,6 +335,11 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(q=
emu_plugin_meminfo_t info,
>>  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
>>  uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwad=
dr *haddr);
>>=20=20
>> +/*
>> + * Returns a string representing the device. Plugin must free() it
>> + */
>> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *=
haddr);
>> +
>>  typedef void
>>  (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
>>                               qemu_plugin_meminfo_t info, uint64_t vaddr,
>> diff --git a/plugins/api.c b/plugins/api.c
>> index bbdc5a4eb46..3c73de8c1c2 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -303,6 +303,24 @@ uint64_t qemu_plugin_hwaddr_device_offset(const str=
uct qemu_plugin_hwaddr *haddr
>>      return 0;
>>  }
>>=20=20
>> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *=
haddr)
>> +{
>> +#ifdef CONFIG_SOFTMMU
>> +    if (haddr && haddr->is_io) {
>> +        MemoryRegionSection *mrs =3D haddr->v.io.section;
>> +        if (!mrs->mr->name) {
>> +            return g_strdup_printf("anon%08lx", 0xffffffff & (uintptr_t=
) mrs->mr);
>> +        } else {
>> +            return g_strdup(mrs->mr->name);
>> +        }
>> +    } else {
>> +        return g_strdup("RAM");
>> +    }
>> +#else
>> +    return g_strdup("Invalid");
>> +#endif
>> +}
>
> I'd rather use asprintf(3) and strdup(3) here, so that plugins don't
> have to worry about glib, and on the QEMU side we don't have to worry
> about plugins calling free() instead of g_free().

AFAIK you can actually mix free/g_free because g_free is just a NULL
checking wrapper around free. However ideally I'd be passing a
non-freeable const char to the plugin but I didn't want to expose
pointers deep inside of QEMU's guts although maybe I'm just being
paranoid there given you can easily gdb the combined operation anyway.

Perhaps there is a need for a separate memory region where we can store
copies of strings we have made for the plugins?

> Or given that this doesn't look perf-critical, perhaps an easier way out
> is to wrap the above with:
>
> char *g_str =3D above();
> char *ret =3D strdup(g_str);
> g_free(g_str);
> return ret;
>
> Not sure we should NULL-check ret, since I don't know whether
> mrs->mr->name is guaranteed to be non-NULL.

Experimentation showed you can get null mrs->name has a result of a
region being subdivided due to an some operations. That said in another
thread Peter was uncomfortable about exposing this piece of information
to plugins. Maybe we should only expose something based on the optional
-device foo,id=3Dbar parameter?

>
> Thanks,
> 		Emilio


--=20
Alex Benn=C3=A9e

