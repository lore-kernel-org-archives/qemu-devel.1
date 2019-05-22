Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57ADC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD1E217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD1E217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNpr-00029N-VU
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:47:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNoN-0001g3-HD
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNoJ-0003xf-E6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:45:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTNoF-0003ul-KS
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:45:21 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M2fHt-1hUkiY3e6J-004Fnk; Wed, 22 May 2019 11:45:18 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
	<20190519201953.20161-14-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d7a7d687-2496-2254-31a9-075a6af5b0e5@vivier.eu>
Date: Wed, 22 May 2019 11:45:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QR70cJJjOaEgTAfrKn5uXHupT5Iyq6LLXnjNnGztaqpzd2cQpj9
	ydOVoQg8/rE12+gydgOz7bNQTd1hfugUA+Z1BMb4ncRpoimEYQ8bgnwlQlxaZj2Mv6lMXuC
	VIPNmF2SSL8RBezg6WKKHtXN1lbC1c35G31IhaV9r9RcbiSITFcVqsHrJ+wrJuTpf5B0Kx8
	iGZ2u/r77IfSZh3xa7kfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pwxMYtBP+V0=:WsBMc+yF/jKMLLXS6E3Zuv
	OXue04ehCoErn88RfOr3cj8VII5gV6RpOzjapFVSBCHr8bO5g6m4A3b9WKsmqqfFJrdY/UL1S
	aZsPEQaR6Ei/hRI/6R/11PNjRK48OqXH+iERgEtLTj83vBuW5v9RVwaSi+B7kiYSytsu0gj6r
	KBKsqyrSB1oIKp1Dl+KU3dMK+Ahw8cf6McM4ugDylLV1aCV76t+xG/vcwxIfTStZ0S7apebDr
	mN3fQJ4BbRkzGg4VsiZu8dPOEs3jVLGjOTjxMNZSkOmfxnNy3ch2QubMEIfEQM+iQecQ9WWDX
	oQczaJsg+Ya306EKsIcEj3EE4CDeLEt22ilnhgl3OmrWsYhbrFT4yZ9DZovbCXh1ptJfqzFDK
	GiEhgG/C9brDyK+YwejT9YccqZSRGvSB/2zkL9f9PsTspHe/M2pFvz/cvZj8t7PbxaqRmZ2k0
	KJ6yXVE5TfM8AgZe3EudiKZZGTuurBoxbhj1pn+AZ6ZqXt0y/Vz8b/gtkyEsXNjBy7QT8hTjL
	BP1dyL3J2v7Qt/mJt2ReSTcbn19YZMvAa4Nc9EgoYnMfa9dcROgVBls94v+eOGzcW8Ioe3QNH
	HZj1aexDg7VonDJGcPkVB81PPLZGAXZl5PbQuYSBDPGh9guv1EfqJ2hA0GqRg7spkz1c7r/Rm
	3B5Vu2S6ZByK2zyGd0DK5RkZ90keuquwxKVgUYFNomy2+7Hd46nXR2qn7gXtapxUECHE457Fu
	GPY8vBfenlB8DimN2dcv3yLaS4s9vBf+XZ2D5VbSGlQAYPG6wrSNMCGeDq0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH 13/13] linux-user: Align mmap_find_vma to
 host page size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/2019 22:19, Richard Henderson wrote:
> This can avoid stack allocation failures for i386 guest
> on ppc64 (64k page) host.
> 
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 10796b37ac..af41339d57 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -262,6 +262,8 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>       abi_ulong addr;
>       int wrapped, repeat;
>   
> +    align = MAX(align, qemu_host_page_size);
> +
>       /* If 'start' == 0, then a default start address is used. */
>       if (start == 0) {
>           start = mmap_next_start;
> 

Applied to my linux-user branch.

Thanks,
Laurent

