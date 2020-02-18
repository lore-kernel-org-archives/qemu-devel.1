Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA866C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF8520801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF8520801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48Ox-0000Z8-Qy
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j48MR-0006iL-7r
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j48MQ-0005Gk-3N
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:16:47 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50913)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j48ML-000508-03; Tue, 18 Feb 2020 14:16:41 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MMp08-1ilVZv0Ejc-00IoQG; Tue, 18 Feb 2020 20:16:35 +0100
Subject: Re: [PATCH 3/3] hw/block/pflash_cfi02: Remove unneeded variable
 assignment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200215161557.4077-1-philmd@redhat.com>
 <20200215161557.4077-4-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8ff580e0-df11-05e6-101f-3afef1a72778@vivier.eu>
Date: Tue, 18 Feb 2020 20:16:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215161557.4077-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/7ig+46uIGVBp1xNJoBHY6N+oEHIBNpWTmqrYpZD3aZeb2Uogy4
 uaTlvbIMGMJrQ9HwklzOaf785hxHmeF3PsWEKvkJsrZqYngxXUTCL+xUPY/tjn0r0VjbLyO
 qxtDzOXjLfaY8YppEFbV+47THIGPHLkq3JmTWEc/BK+s5Fvw/I7uFyhma4od3jFKd6Dn4P3
 zKmnb66vgYaS04baKqjvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NbehhBjCvsg=:XxKUe5j03+s11qftZTxq8E
 J/dL+D2m/krJdM+FrDWlRb+zP6Ak2nBgELkLZ+n641zk/pAYTsZW3D/C8sKTP3WpOgUmTX0cr
 zCYP/dssl0BWq5EqtjpO5sHW8VDJuXzV6e+KJHNJaXVLFHM6jWcJzzOfxD5nRM4qfacS9d2zZ
 BCI9bGygmQIl9F+Y6Ifd0l0+HBFh5znBSBVQs/f+cVuw1JqD1n87dhD1I3Z2+IO5+i60h7H6F
 wyjIF4+PX65HX5vZJf698z5E7EFgixlGIJ80qV8WE7T860bjc16Ii20uKFs0lQRyMNd4X1cz1
 m5l4zZ81oJsXx11XyXtFfUlCM9iRb6j3uyhB4OMlhrrA6jhzvr6XWzAQWaU1NBBDJQz3cXzL3
 nA13zp1kLqH/cYFjIhsfhetblJl4uwuR7AoakbKK02sQU/auxTmvIqr5EbfRtfWGENfIRYf6r
 WvTqj8oQC+Crr1aabTK1VOBnYrMtc3161XJdbyLj+Zop2PlvRShYVEZtWIArUKyrEIIthX/GM
 wc0GcaseitvrAz88RM5yMgdQy7avsrmUl0xDSm8b/Ir3yso2Tv10dzHzC/PHVzXIwJZJKAq/5
 oIcxFdvozRjwzRxMUVBC9Wpy9rJ+wpK+DDC6dBYAbtfOCMLQYiE0HVFt7Ud+qkXevopqks523
 TEZAPzZXaFcJrJy346uCt75TX3Q/2akNqILFZgQ/Xa+Xc1IRw0zvvbhvDPmfhpFsIf/KlxM4Q
 NS7PRkKECSRIQWYOWeeFa64YM0KO2b00UTzcJouCPubDo//HO+vIUgZvbNJ8xidZ8025e7l4V
 wdy894xD6b/Va+hl1BgXfiz4/6R9tTEmBEI15uFEKN3RcDrxgB31JMGusiiOO+nzRyiSz4Z
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/02/2020 à 17:15, Philippe Mathieu-Daudé a écrit :
> Fix warning reported by Clang static code analyzer:
> 
>     CC      hw/block/pflash_cfi02.o
>   hw/block/pflash_cfi02.c:311:5: warning: Value stored to 'ret' is never read
>       ret = -1;
>       ^     ~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi02.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 7c4744c020..12f18d401a 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -308,7 +308,6 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
>      hwaddr boff;
>      uint64_t ret;
>  
> -    ret = -1;
>      /* Lazy reset to ROMD mode after a certain amount of read accesses */
>      if (!pfl->rom_mode && pfl->wcycle == 0 &&
>          ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


