Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F32CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC13206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iWehB+qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC13206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZbC-000624-Im
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iMZUh-00028k-QT
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iMZUf-0004q3-Bj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:21:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:47981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iMZUd-0004oz-66
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1571671248;
 bh=/EU04Mhh/5Y1QsB+4SJ1Sv6E6htHv1FAz6NmCP+zf/k=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=iWehB+qF/5WJN2AGv9RjetHA33MC4fM4ZkF5hV/P9Yo6dcx5d+UsbWjKNK8fPkmzC
 We7mn/XEe4hLYjcwOjD8OyeuksqOrtjM+mrQJY9bKAbi0BAPRHwFm8CkMT+45yMONN
 yP+0dlV/8W6ArtMJFEaZQueC7egQXeoUsbP2hwzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDc7-1i1B9h1NAD-00uXdm; Mon, 21
 Oct 2019 17:20:48 +0200
Subject: Re: [PATCH v5 0/3] tests/vm: netbsd autoinstall, with IPv6 disabled
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191018181705.17957-1-ehabkost@redhat.com>
 <87r236w6qo.fsf@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <a327a8fc-336c-47e6-30fe-760e0aa9f5d3@gmx.com>
Date: Mon, 21 Oct 2019 17:21:05 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87r236w6qo.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BagIxZCbjTwhYBndaAUWlXXDkrhybqzwlU40MHdKXbhjMqi11ML
 QKFiGTOuUq1GkmwyMnYuyX3N1MWQkAu9UUeIXSEV9gld/hy/5CKzMHXzSHZMTwlJsTG6lyx
 XydaWl28mUmEzq+ZtapKKTfihfQsH0pJTP3iWtBUnDX4mWqMMlT9kjjdS0zZUoHYYHKfc2Y
 D2t0aRmORpjnv1EEdIijg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IAdRyGSn6Mk=:Dt2Vxx5SWi9Oa5Nx616fzO
 0qOJrye58g0K816UaGrVTlcmdAYrGoVhrTk47SUWrA0ONdshWfZ/oSFAUhxg81mNSriMJqhfA
 SbyWm/WPs15AbKRJ023rr1vW7vIP6h0HK7kBbMoO8r1ouyJSmoX91bRVfzBZ5+7GkJH+pg1lu
 njj86nxcIts3jDknbhRiNFU/zM4u+826W+DJTT2QYAo/rCIP+Qlb/N8xV3NjxuKv5ee9U7L20
 2oscUeqzrvFFEfgs37JpTJU2p6AW0m4UyevNQOhHDxWJk+TevaNZdOn7nvjqbb1T5ulsfVSds
 8cmX8RFkxlk+FZ3rHIW39upNwSw9C+a4dqqC+kHdqG9QhB7vKMwJYP0P4XOWqAGzl8Bj+Evig
 BXT0MqGZkfK+zza5vprdcpOwG68rAtXtdG6H9nq+Gdm/djNO49MR4fgAB4q22x4OmcsDVFmjr
 NGgc9TLp7Vhm20mw5vU1YvRrhKBHphwo7RKnwOsh17v4KxwoARSPxcwtyxNd9GyNcOYBHLNDC
 GQZ5dkGHQfvm2HMQJI7awNIyLMCNpnfDIy8DPU2zc5BuS1gPdVA0tVRbOwDR77SD9wZrJg/ZY
 WHpWz+nR+kd7/OD8hsHukHZRB8BRYaiLFZSRBRv/nbZyUZ0jqcmYJkLVq2PFtpp4IneJTk1dn
 7WSE28nwCK9RG3H1dgtsjdCrS3QgQ7LocgYlOxpxAeQjn52pEAij8P6m/OfWZwj3G39hdMrnm
 h/sRiIKURGpT3t64bnxZ6ZYf294HbjFTvrD4u/uw2VYhrUkFexjGCcY2UCB5hFzMYtLHD2evD
 g7LiyhY7FVzEh9rSaT7lJEHRGS6oxRnGsJQfzBXguqYLMIxtYjx9nCXbmVAgjy6vxZH/TqjQt
 uyI8U+50WNpWut/xUVVhOk4o5yKDVx0DtJtrd5JBUx9gUBiDjd9KldwXkfDOLjv5ym/Lmfmak
 Oig5OmAvuWw9MQ9AUFYFEK7CTwjXD91yL9n4qK4Oli19LHIXcKsUx0fOG35pmqSYOQNDNCmMc
 KgPtFjSAQHRt8aekVADpGwJqWXB6Hij0ew/uqr9Rzod/KZ/L/SW/ZXIZOb7jmuU499Jwn1cxa
 5JRU/MLCfHoYzAi+F6f+rcaBzt0+bzsK6gLi9TW+PHrYDfz6qwTkBh56OlPvsFPNQUzHxaZLP
 19ttSPtAKIdo4b2PYiv8vGKH0kzknwAhinX8/Yjf9q9aRd3nzBf3jN8XNXgMnSsVgXeamwn+2
 Pv5w39Q8CVJG7ZlhS1D99UsiQx3BrwE0eDykShQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.19
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.10.2019 15:47, Alex Benn=C3=A9e wrote:
>
> Eduardo Habkost <ehabkost@redhat.com> writes:
>
>> I'm numbering this series v5 because it's a new version of the
>> patch sent by Gerd, at:
>>
>>   Date: Mon, 17 Jun 2019 06:38:56 +0200
>>   Message-Id: <20190617043858.8290-10-kraxel@redhat.com>
>>   Subject: [PATCH v4 09/11] tests/vm: netbsd autoinstall, using serial
>>   console
>
> Queued to testing/next, thanks. I've made the changes Thomas suggested
> in his review.
>
>>
>> Changes v4 -> v5:
>> * Rebase to latest qemu.git master
>> * Disable IPv6 by default (see
>>   https://lore.kernel.org/qemu-devel/20191017225548.GL4084@habkost.net/=
 for context)
>>
>> Eduardo Habkost (2):
>>   tests/vm: Let subclasses disable IPv6
>>   tests/vm/netbsd: Disable IPv6
>>

I'm going to report this one to other NetBSD developers and hopefully
the problem will go away in future.

I have faced such problems in the past myself but didn't know what and
who is culprit.

>> Gerd Hoffmann (1):
>>   tests/vm: netbsd autoinstall, using serial console
>>
>>  tests/vm/basevm.py |   5 +-
>>  tests/vm/netbsd    | 196 ++++++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 190 insertions(+), 11 deletions(-)
>
>
> --
> Alex Benn=C3=A9e
>


