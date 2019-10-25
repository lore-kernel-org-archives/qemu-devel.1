Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CFECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09B421872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jA/Tqnf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09B421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6fg-0001ht-Eg
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6Vg-0003EY-7n
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6Ve-0007g3-Ur
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:48:35 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d]:46230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO6Ve-0007fV-Px
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:48:34 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id h202so1436603ybg.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5FfLgzkrijB5kaN0qmWruhWuxCjOqsZWoeMphZYvIqo=;
 b=jA/Tqnf8CheDmbtS5JiLoiuZgB9fQNXJ9cDkASuC4dKq1cVChE7+y1X77n+q/UHeWk
 uWi/7punIk4Itl/WjuiuPa8i32DzdkUQzHY3XWOgf8vnhiL5uiAejYY4Svje7IggLyNb
 uwvFlarKUHb3s8X4to7TJofUy9aRokIoSL074552LJ+ySVvLCYxAVPPKEy1w1Y6AtvMK
 n8mLwHFZ374DWmZKE3FN4PQz0DyTzterCdeBLaloyf+RVXwlKLMWHXkVsuAPWbaRLvsS
 BSXREw0RNTgF6wPNW80ajZMB9S8k8UQvMxWAlGnwrsd8odv3/Rp5wEr2gURCfaa28K0f
 ZrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5FfLgzkrijB5kaN0qmWruhWuxCjOqsZWoeMphZYvIqo=;
 b=By/AagUToaBt8aVci46glUExR0Z81IpY2z54+NhK4WQ7FjjuHO4C4CQLVIykxvydwF
 FxyAp0HhkCEHJJuvDjTlbJ0hNrdBaTzACvdsSklf8n5flUJ23/jFZpH/nQUJZLgEO9iy
 /S7cxm7W+HT8Qz73RQt8ZEPk5HWhAanitEdC7JOe48HpmUCbn6zHj6GNpEDSi66igrJH
 1RI+oizOWTcCVJx0Oa06OewqguGvIpkheUpjv/O8exQN7ndPHQLWSFs7ZZ5wYIs2JzWW
 QzbkHPt+9EBmd+qPAVZrD0u9sMwJsT4L5K34EwvKxqvDGuk45R+K9hRyavSyPgTbQd3x
 ixbQ==
X-Gm-Message-State: APjAAAXcZQYVQf1Tk7uJh6HyVfms+OzANc0ELwKPik9bNx6qRJ6n34/Q
 015RqE8u/xLyAFovD0NYPuyVxBqoTzo=
X-Google-Smtp-Source: APXvYqz4pd8COPemarAXB8+vv3Pxiyb6LpL85OtlFrBtGDnwYAD5/KbUUVYYY11taUpKum9sU4buLA==
X-Received: by 2002:a25:414f:: with SMTP id o76mr4507402yba.401.1572036512100; 
 Fri, 25 Oct 2019 13:48:32 -0700 (PDT)
Received: from [172.20.40.202] ([206.121.8.178])
 by smtp.gmail.com with ESMTPSA id y142sm2391401ywy.80.2019.10.25.13.48.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 13:48:31 -0700 (PDT)
Subject: Re: [PULL 00/12] tcg patch queue
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
 <CAFEAcA_Wpn7uOs_GB5=ym+poSq=vVStp4EVPzaYoGGyEX90x2w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <24d8d3fc-6ff5-1293-8b20-f116a385177b@linaro.org>
Date: Fri, 25 Oct 2019 16:48:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Wpn7uOs_GB5=ym+poSq=vVStp4EVPzaYoGGyEX90x2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b2d
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 12:12 PM, Peter Maydell wrote:
> Compile failure, win32:
...
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gmacros.h:337:23:
> error: expected expression befor
> e 'do'
>  #define G_STMT_START  do
>                        ^
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gtestutils.h:115:41:
> note: in expansion of macro 'G_STMT_START'
>  #define g_assert(expr)                  G_STMT_START { \
>                                          ^
> /home/petmay01/qemu-for-merges/include/qemu/osdep.h:152:20: note: in
> expansion of macro 'g_assert'
>  #define assert(x)  g_assert(x)

Ho hum.   This...

>                     ^
> /home/petmay01/qemu-for-merges/include/exec/cpu-all.h:225:29: note: in
> expansion of macro 'assert'
>  #  define TARGET_PAGE_MASK (assert(target_page.decided), target_page.mask)

... must be the reason why we used to use ({ ... }) here.

Why oh why does g_assert use a do/while(0) statement instead of use an
expression like the C assert is required to do?

> Also
> /home/petmay01/qemu-for-merges/exec.c: In function 'iotlb_to_section':
> /home/petmay01/qemu-for-merges/exec.c:2871:1: error: control reaches
> end of non-void function [-Werror=return-type]
>  }
...
> Not sure if that's just follow-on errors from the earlier
> ones, though.

These are all follow-on, as you say.


r~

