Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81CFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FBB2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FBB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYPt-0000YU-Gf
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMYOf-0007me-Pk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMYOe-000443-Re
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26375)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMYOe-00043r-MI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:10:56 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC884C057F2E
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 14:10:55 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z5so3176163wma.5
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r5W+Phq44CvsPWJF5OY3TM759aNqeo+HxTqMoa9gWek=;
 b=HiWHYxdkLK1fCNzU89p8v3QuNpWsuDOW3zGWiYIP71Xlp+t/NRp06S3YhRLc5f8fUY
 4IuaQ4vZmrbDZ4/NPHX2kaS10pKWTp9WooodhD3PzR6XzOpiiUdPAKWA8g10Solw8cip
 u/W7brwWs+IE5gBitXXCkCMvONKYsqL38kel/9jjKN2Y6YXVOgWGFbGwn/bRgfmJQJH7
 /fdhYYcllBE7hTeX4HWZlDFIXBD/nyq306hJGBz/MkgU3xM41xy5ywcclTJCjeyrYNcv
 QF42xNHbEyPcmcHP10CWNN2kyHdMkaJpZAhyQWdiFbF8n3KOPVFiHRTHYdQFHcTCHmUM
 cKpw==
X-Gm-Message-State: APjAAAUIgolS1d0vsbuYaVvHyO1BebMrfKHv7m58hYe1PbpdpM7nNxbr
 NkXTHA9ZUwyYD6wCRuZJ9hRQZHDjOi+9KLDvk/xMUeD7fBIMHtUvWZAE2DJ9VcV7cqQFDiep7uT
 duaWmDwD4ad2yVLU=
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr13904865wrs.227.1571667054181; 
 Mon, 21 Oct 2019 07:10:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWhwCA0lH80Yem9hD66+wNQutQnBpbPXDRTb4hMxAnJiOB4QYO7VMXkNmOGBnoYSQ/S6lJUw==
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr13904824wrs.227.1571667053852; 
 Mon, 21 Oct 2019 07:10:53 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u1sm13613516wmc.38.2019.10.21.07.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 07:10:53 -0700 (PDT)
Subject: Re: [PATCH 0/5] travis.yml improvements: Update libraries, build with
 arm64
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20191009170701.14756-1-thuth@redhat.com>
 <874l0860by.fsf@linaro.org> <8ac591e5-f70a-52a3-7af7-dde44b6fc6bf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1bf9bd05-778f-72a3-6e01-9057723777f4@redhat.com>
Date: Mon, 21 Oct 2019 16:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8ac591e5-f70a-52a3-7af7-dde44b6fc6bf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 3:53 PM, Thomas Huth wrote:
> On 16/10/2019 19.56, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> Update / add some libraries that we use in the Travis builds, and
>>> enable compiling on the aarch64 host, too.
>>
>> Queued 1-3 to testing/next and I'll have a play with 4/5 but probably
>> won't include them in the final PR unless they seem solid.
>=20
> Thanks! I think you could also pick patch 4 since the current line with
> "command -v ccache && ccache ..." is definitely nonsense (it currently
> just works since we always compile with ccache). We should either apply
> my patch 4, or if we say that we can not run without ccache, we should
> remove the "command -v ccache &&" part instead.

Yes, pick also #4 please :)

