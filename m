Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A08C54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8668B20722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyAf5ZI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8668B20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFy4q-0000qk-NK
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 06:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFy3s-0007jP-T9
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFy3r-0003mP-M2
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:42:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFy3r-0003m8-IH
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584873751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xLIKwsq25JUatASyWxUu1coWVJU/mgHzlqyH4gT854=;
 b=OyAf5ZI3TtCYCmzEGFYfafDkxxZbBHdLsHKRH4+Zar1MT86ndx/BU3Boq2XhQy2U3KqR2W
 PaQh0JsAgk/ezwPSQl0xeyB50KkFBYtFQ70DEmmO7ESq2kVmajLhacmB3vGsKM9GH9M2r/
 SIovJylD2GbuZ+C1qJq9onFmppApeo8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-rm7_fyhGOsCfFTu-OSU5Uw-1; Sun, 22 Mar 2020 06:42:29 -0400
X-MC-Unique: rm7_fyhGOsCfFTu-OSU5Uw-1
Received: by mail-ed1-f72.google.com with SMTP id x1so9000659edv.14
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 03:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MZGjYugZOOcVevU7b7Fy/xIXaBdOlOTCeazBQRuo7NM=;
 b=YqSYAsXA0o3mJlVUkneCjqnr3p+UB2KXIxaQq/PpXr0Xe0pd4bsIu3Yv0CCW6EfNkS
 pedHlzw+8PpXieQwF146wEmGznJA0Go/OM+vlaTXC7Zjk2/yzyazjsVwT8/Qy6xaO8gb
 iks0HrdAawjjpATs7BV2SsV2/le1z+b3UNgU4248Kvv2+Pox3/nSyiQF8NBD3GI+ipYr
 /Dm+21Y2qNh4n/9nRP74yECL2gCPS7qvw+KsgB1YrqUOMVIrfh+zTUHb5Ps6T8rWTCvs
 Q5rm7r9ewRE7605bFcKmFjWqVcB2JFWMS1mnHEhEvmc9r+S6nwP0bZWvx8QJWmjcIjPB
 z+Og==
X-Gm-Message-State: ANhLgQ3v6Q6NQ4jmm+BO05ozfW75u2zbL8i0G0XxovLAPulAMa5HAYTK
 yVhPeXgZBkzRuCppwL0nwxPkgn4YXDvv5pTRhx0CuV8AB/J9ELHzX34d7ZxIWOG0OSqUoVF0Xrp
 5wV4gAlWugUl44Bg=
X-Received: by 2002:a17:906:c7cd:: with SMTP id
 dc13mr15300134ejb.199.1584873748090; 
 Sun, 22 Mar 2020 03:42:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu7QsoDHxAOLi9AGN0YTVkzTEVF/pJPUQaSqDrKDOBC5BuZNeRMHjnIkLPZ+NVm+JR1AP8uJw==
X-Received: by 2002:a17:906:c7cd:: with SMTP id
 dc13mr15300124ejb.199.1584873747795; 
 Sun, 22 Mar 2020 03:42:27 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id s6sm823913edu.42.2020.03.22.03.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2020 03:42:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] thread.h: Fix Coverity version of
 qemu_cond_timedwait()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7e94ad47-f917-5f14-c903-386f869d0d9c@redhat.com>
Date: Sun, 22 Mar 2020 11:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-3-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 8:33 PM, Peter Maydell wrote:
> For Coverity's benefit, we provide simpler versions of functions like
> qemu_mutex_lock(), qemu_cond_wait() and qemu_cond_timedwait().  When
> we added qemu_cond_timedwait() in commit 3dcc9c6ec4ea, a cut and
> paste error meant that the Coverity version of qemu_cond_timedwait()
> was using the wrong _impl function, which makes the Coverity parser
> complain:
>=20
> "/qemu/include/qemu/thread.h", line 159: warning #140: too many arguments=
 in
>            function call
>        return qemu_cond_timedwait(cond, mutex, ms);
>               ^
>=20
> "/qemu/include/qemu/thread.h", line 159: warning #120: return value type =
does
>            not match the function type
>        return qemu_cond_timedwait(cond, mutex, ms);
>               ^
>=20
> "/qemu/include/qemu/thread.h", line 156: warning #1563: function
>            "qemu_cond_timedwait" not emitted, consider modeling it or rev=
iew
>            parse diagnostics to improve fidelity
>    static inline bool (qemu_cond_timedwait)(QemuCond *cond, QemuMutex *mu=
tex,
>                        ^
>=20
> These aren't fatal, but reduce the scope of the analysis. Fix the error.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/thread.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 047db0307e7..10262c63f58 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -67,7 +67,7 @@ extern QemuCondTimedWaitFunc qemu_cond_timedwait_func;
>   #define qemu_cond_wait(c, m)                                           =
 \
>               qemu_cond_wait_impl(c, m, __FILE__, __LINE__);
>   #define qemu_cond_timedwait(c, m, ms)                                  =
 \
> -            qemu_cond_wait_impl(c, m, ms, __FILE__, __LINE__);
> +            qemu_cond_timedwait_impl(c, m, ms, __FILE__, __LINE__);
>   #else
>   #define qemu_mutex_lock(m) ({                                          =
 \
>               QemuMutexLockFunc _f =3D atomic_read(&qemu_mutex_lock_func)=
;  \
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


