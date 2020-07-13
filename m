Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80216C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5609920674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5609920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3XH-0005F0-J1
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv3WE-00047Y-0s
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:49:38 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv3WC-0000QW-2U
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:49:37 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MMFZQ-1kCAgz0Grm-00JNMj; Mon, 13 Jul 2020 20:49:27 +0200
Subject: Re: [PATCH] linux-user: Use EPROTONOSUPPORT for unimplemented netlink
 protocols
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200707001036.1671982-1-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc54c9f9-d74a-3d67-261d-0e34d65ee1fd@vivier.eu>
Date: Mon, 13 Jul 2020 20:49:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707001036.1671982-1-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QI77yguBOdGaRBpe40fRT3uSrSO7PpJagJn6+P2GINb2mZS3ENE
 29dXewReBvCvsFw8yU/Rm+fqD5118QVq+zXbJu98oKiFnj+qrrNLuC5zd8/VvRU8LKIj30J
 7phkoIbCdVynATrCevx3A63m2Ao2KG3QB0u5w5bhc9MleRpzQPkODx1ZVTxuwZdm+tbY0Fd
 yjqT8jGAiNwd1SaY4GfcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cbon7tAvHJw=:Q0EwZDfU4S7W2CCuTvEqUZ
 ghQDKSCGc26Cama/tPbZSaPDXc1aIU8Qdsh+VlmOy2VWD/YP4VijsY76DAFhqAaqfHU5GxQ52
 p8kJIreedcYRoJCd2ti8IS1Ho28rcwfmX5Rso/Ivd8D9Mt/qNAc7jBgz8sIyfV2QTcI2zbfwH
 IsQ1Ba/R/qMV0KoO3nH9kUVaOsVRdNgkaOeXLRFRKf7jTPfPTjjSba54vc09c/P1ZcoipZt1M
 Z2flxLLdZKHY9qpgAD7cfqg3fh7GZ1OYvDEaKP7Bx28it/gz+nrGLe7p+VLUvh4zTSvnzcBWU
 5XYPrYwBZJn/mp9GZAJacYUCxWmbWtGla+YmXdsCUwvsGfHn0L6Xs4iNUP6c9c5ToHD/nGlKC
 fXKtTzSENIY/rYNP4k7GRPpz9bmj5WXQXhUu4eyHYgq5kOG1mqZpBsqFDxEQ6unSAXbbpxLmt
 mSjS9+y2IoqTC3YgOKO1+dJ3kdGkjgw03GyIXKNFLwEoYItLP0rBej6XidxBLKC8kh050lYKg
 rBbDsw1vOmuiZlsYxpAumBmf8iGc6vpxhcNpsK7ph917AkM7toXDPoqWuYIZWM6oJN7dmmp28
 rG3Qwpmnik5nA18+hbLtqxXhK+urJRE9x3771vvPl3KTpA/4u7LG3M/zpN+rCeifXLBH4C1RQ
 R30tFIzYMBOc5+d2VUuxUUkXxkJyhcPGLoWfaB7cSSIsyryls/toc9p/M/P7PbBqQOCtPYxNL
 huZAy3fuwLUdIj77hqoRV0DoYFnOlY8agRgcBreX9OtYqXmxos+iE4ogn79CphdRrN7632Re9
 AGC1+XFV36QS1mD1HokFkWeU1CUy7ZDd2mdy7pggwXcWqKO02MOniiPWdDDqA0acakTrTnL
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 14:49:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/07/2020 à 02:10, Josh Kunz a écrit :
> Linux uses the EPROTONOSUPPORT error code[1] if the users requests a
> netlink socket with an unsupported netlink protocol. This change
> switches linux-user to use the same code as Linux, instead of
> EPFNOSUPPORT (which AFAIK is just an anachronistic version of
> EAFNOSUPPORT).
> 
> Tested by compiling all linux-user targets on x86.
> 
> [1]:
> https://github.com/torvalds/linux/blob/bfe91da29bfad9941d5d703d45e29f0812a20724/net/netlink/af_netlink.c#L683
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 97de9fb5c9..4ab9852600 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2987,7 +2987,7 @@ static abi_long do_socket(int domain, int type, int protocol)
>  #endif
>           protocol == NETLINK_KOBJECT_UEVENT ||
>           protocol == NETLINK_AUDIT)) {
> -        return -TARGET_EPFNOSUPPORT;
> +        return -TARGET_EPROTONOSUPPORT;
>      }
>  
>      if (domain == AF_PACKET ||
> 

Applied to my linux-user-for-5.1 branch.

Thanks,
Laurent


