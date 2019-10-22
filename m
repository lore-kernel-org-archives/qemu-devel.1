Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73117CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431D021783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Zrimu/Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431D021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMu3H-0000VT-6k
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iMtrD-0005XG-J3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iMtr8-0000qu-HS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:05:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:36023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>)
 id 1iMtr6-0000q3-RK; Tue, 22 Oct 2019 09:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1571749520;
 bh=qCr22OlxYn8GogmmhOhXfIudQFj6s7coIJR85deqlvY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Zrimu/AupbweoXRu9xjK6huNCo+YtPARmszDFaRb/R3EfJMlzNEMWMqIwAl6jhyeV
 6KRCF7R5IQpKCes+5DO1PELCeaF0c3iRvsBzAH0rqoIR7a69Qa0aKXmC6ZLEpnku0V
 Yny2ZWCucBB++tSB3tgL2hAjJgCgrrme5tK8D6pY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSbxD-1iTfEv2OPB-00SsJL; Tue, 22
 Oct 2019 15:05:20 +0200
Subject: Re: Python 2 and test/vm/netbsd
To: Samuel Thibault <samuel.thibault@gnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net> <20191017220541.GJ4084@habkost.net>
 <20191017225548.GL4084@habkost.net>
 <20191018104439.c2tojlvi2c5zzesi@sirius.home.kraxel.org>
 <20191018142940.GN4084@habkost.net>
 <a0c2df74-360b-79de-132e-f4d5be5bfc12@redhat.com>
 <20191018160019.he52tpvjqolzgswg@function>
 <20191018164143.GP4084@habkost.net>
 <20191022131615.ivlfwpct22zcjzde@function>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <b9e761a5-87fc-c5c7-8abc-fadeec2e1508@gmx.com>
Date: Tue, 22 Oct 2019 15:05:28 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022131615.ivlfwpct22zcjzde@function>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VA75p3q3fcMofiOwIf3+TTflBboDVAhVmDvNhRKdqhbg2Hj13Wx
 oZ+UEQrJY95kaxd1b6HCr6l5vXDokxu1jTnTdCUhDXhEXb3zN8JaPTHw4xVA/zGxxMVEZtq
 e+JhmSKAiwmpB8CG432LZPLf+9YxaHK8zwsXtq9Ws1Nbp/l4YOIVvjWT9/Hi5V6SzQt4Tj2
 B4hkbw4KX8O5z/Gbj6iPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNzJbh2a0Ws=:jyCgWWXef4S8Ut5AKvabXa
 Hc4qorK5YEIklSpR5riBubAisYFGHLGjdtRCkw+UFLh6Dydv5rAqwlmP35c5OkuQ84GAwEgNV
 YB7kUhqmgX9gIIZFEqP6qXUCsQGB3YTrNBAZaCsTlZNlIqeXwCK7z/DzF57lf4eg4me6kRO8G
 ah8EGHZd9zrCkFWIWaRsu1M7iOcNVn976HbyULhihHXG4/RUL5ls1hrB+DtabOZdjiWSC/zWO
 FJluZ84taFaCx3qH9xSkQWgytosd2kLkZthOjW5PsK5WtIUvSzaCNRJjVV9r5qWh7WgH8HaJ/
 UWsckXMB2lq0vZpaEOGmIyBBL/hVbqdtlGUoMbo30H2id7vevVKHofMWa8/oMY4ZqzkH5E8Ce
 mQK9KEnWMEsH0sCNWalfG+dDwYxU+HgodRXKxOHk3f09p0Q6zt8shlHEdFHqeH7idO1Zx1XF8
 JZ6feezGkDhKQOzWFz+ChoMJjC4JrCkh+cbZjAciQQjMJds8xpNqXt/1MxoF/DeErgCq1uTBA
 EH/arvrQ7BoIn+t1BfFE/o7Uq3iWi/yMm9Q8fu1sfFE4yYs+PEDGLYOj/4BnY50WwRbbEJ0zH
 x3Nv6v1zpGEUrAHxHqwXsHvm+nIg8udQxdr6HS2fD+Y+w6agqXR8tMMRcn59yK1xZQFlJzlNk
 Jk59dw0vLL5BHNT6pPMaqHZu/bCjvcjDt/M1HGaYquPkUDSme0vPdtEiW7j0DkrfIaympgiAB
 /TYZ/Orb8yUNv5iyujKbZdjHqI+4OZglY24g65YA8nMhYWCK6sREYHZgBLwak48lYP24alQMg
 kF4IiqCGjtdajkdpDWQKdUTccZm8hPR1JN1ohDP6vDjnvB6QVBrGQM/WIP2IKn7nEHckQ/GIp
 igYuDP0qkU360RQVyPKTlXKybGQwX5uJCSdbe2+nOKxlRYQ5uQ8cL5NX60J6HgqKgzIUwwPM0
 F+el3KTP9drbTTIB2iLwQtdlO99bp1lyu0QBDi6oQ38Ghiunh/BceIW3f5d+v/DteiR3o23k5
 5vjWGXBoG0LQyv+TQM4tHllmWnT/WveMeTjsqvBJgN+LEcZa/oFS5FumlOvqMHPPr0n0Tcm6p
 KcvpsqoJZ9+5NQZ//jHjPfG9WSJ9/a7NVVI2PQ+4SnVGm8VqgraCrOXKckrFdTwpuKHVQDqqZ
 JJ+FyTpv1SFSH5nIsnKS/scWkHrVmQLsfCQmVRi8hD9Kbx5ijCAMNI3gRYsUCxMFeggPFl3LI
 9S+t4hSV7IpvtkCU05bK1QhhArqlfmbGY+okHrg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.15
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.10.2019 15:16, Samuel Thibault wrote:
> Eduardo Habkost, le ven. 18 oct. 2019 13:41:43 -0300, a ecrit:
>> On Fri, Oct 18, 2019 at 06:00:19PM +0200, Samuel Thibault wrote:
>>> It was implemented at the time of introduction of IPv6 in SLIRP. Perha=
ps
>>> NetBSD has a slightly different behavior which makes the implementatio=
n
>>> fail to notice the error.
>>
>> If anybody is interested in investigating it, a network traffic
>> dump generated by `-object filter-dump` is attached.
>
> The dump does show the Destination Unreachable icmp message, so it seems
> it's the guest which does not notice it for some reason.
>
> Samuel
>

I will try to investigate it on the NetBSD kernel level.

