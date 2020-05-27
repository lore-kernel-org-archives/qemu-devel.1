Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9330CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63893207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63893207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxJ1-0005ht-Gh
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jdxIE-0004VN-6N
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:44:30 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jdxID-0000gv-1N
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:44:29 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MKd92-1jIyUs3UrM-00Kysl; Wed, 27 May 2020 16:44:23 +0200
Subject: Re: [PATCH 7/7] linux-user: limit check to HOST_LONG_BITS <
 TARGET_ABI_BITS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-8-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1b050c61-0cd3-bc91-7610-856a28a27175@vivier.eu>
Date: Wed, 27 May 2020 16:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525131823.715-8-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tZHl0TDJMEXS/+/oU+/sZXdJ04nT4njTLzyLqhoayJ6Nl7DwyVL
 8E8vnayGpi/fkr/14A7fOEE+T3lXAvV6J/sPglzemNRh6NSo034qIer1jcO8UM7cV5/GKSa
 MHjUdw1xxGhgyp9zlqdGXDR8Ybjvg5uC5taofOSwZRxqgzoJMy4jGjtzcUM7ym+W4ldD0tT
 suXv7H1+y007LaWQbMR6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:huaF3AL6uT4=:gAjjgOnXQIdwgG/lqNjOS7
 NPqx2x5AwIFdxt79X3xKBamt/u9+qfFw0a/6MdbtlmAi4XbPe9SvJYIOOfNlOyU4kZrDQoTWI
 CAnhnru/W7crBjxMm+n7c3X7eLk99hpPW3DSebOlSX5olgRHelZOOVYt4iTqMTut2pO7/1OnX
 uSOVgUAmboLYDXT5CQRl3ybam9NsCtid1feI1jcABkhORzUsbUmU95AqEnQ96PVjjio7RhJ66
 T7p2pXHGuIx8VvXB6HIe1w0TddS0dnjnhp5+8W6S+pzUw0AwgGtKAkjmUYTU/tHnsE1qpgtnR
 bR5bL5bkSUkDhaf/j6x5AGG0dMJY/o2j2iO1wAibXJiUhx4P3c4jr01mOJh0jtMA+4Yo0Oe77
 CFv2T81tUN8GJ1+pKClK8RmL+57I7NtTEl9HXeDMC/EZxVuRc0AdVr6jlKLJltGKPWG0MFgKi
 saBVO50XbEhka6GJCtzbE3CfPGvzejohL3EmphL7cARtqo54/FfLd2oVHTihXPKLV0G2hYr+4
 FhMt1CdezCeVNthOKBlD8aXvuSwnNxnj5+hZkOitIx/rvnNRygdUfKFhB20eJ/sM+o+Ce3pnb
 t5uhMaWV7sVesS2SDyM7x8Cs7uRvSg3/HtS1Ks+eeDjWJWavZCuqvz0LFGp235+kcQ4LUOI6Z
 6g6/leiEGQ5Q7AL0ytI12LQJmZuCxJ2nPxFje0DjH6ksTsJnjpLVrVO2BRgNSH4rBbms4sEWX
 QXuBPt/FXQWpNP4CQUMVklOqM65lECs/imHbxDvlYQ//moHJYQIICpvM25+Mfi2i/jeQ1Ml7K
 D6bqDlCjFgqDmicvkouXCSyKqa8xbcs3hVNBwTfZdnhqXnRk9hfTfY6jQ8MSvmVGN5PSFHd
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 10:32:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/05/2020 à 15:18, Thomas Huth a écrit :
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> Newer clangs rightly spot that you can never exceed the full address
> space of 64 bit hosts with:
> 
>   linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>   long' > 18446744073709551615 is always false
>   [-Werror,-Wtautological-type-limit-compare]
>   4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>   4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>   4687 1 error generated.
> 
> So lets limit the check to 32 bit hosts only.
> 
> Fixes: ee94743034bf
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [thuth: Use HOST_LONG_BITS < TARGET_ABI_BITS instead of HOST_LONG_BITS == 32]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  linux-user/elfload.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 01a9323a63..ebc663ea0b 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2073,12 +2073,14 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
>              exit(EXIT_FAILURE);
>          }
>      } else {
> +#if HOST_LONG_BITS < TARGET_ABI_BITS
>          if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>              error_report("%s: requires more virtual address space "
>                           "than the host can provide (0x%" PRIx64 ")",
>                           image_name, (uint64_t)guest_hiaddr - guest_base);
>              exit(EXIT_FAILURE);
>          }
> +#endif
>      }
>  
>      /*
> 

Philippe sent the same patch:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg699796.html

Thanks,
Laurent

