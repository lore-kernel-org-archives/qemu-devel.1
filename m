Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D4C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB582465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB582465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32987 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqec-0002m7-Op
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 16:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irqdp-00024i-Ms
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irqdm-0006Cp-E9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:55:57 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:36227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irqdm-0006Bs-3r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:55:54 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MiZkX-1jKbXV0mr1-00fk7H; Wed, 15 Jan 2020 22:55:34 +0100
Subject: Re: [PATCH v8 13/13] linux-user: Add support for TYPE_LONG and
 TYPE_ULONG in do_ioctl()
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1579117007-7565-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579117007-7565-14-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <265bfeef-d479-554c-a005-44d938d39fe4@vivier.eu>
Date: Wed, 15 Jan 2020 22:55:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579117007-7565-14-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fr4zVRQLIu30CfuvZh+I3qi9qUCPi8OBHki506/Jx8J9NRx+a5M
 hUMWzKpYIrRU2K3pK7To3M2J4FAMOBW3TGZjOZDCaCLWEZmFW9kLrwWcTSn6RQ02m9UqFsM
 BKd/fzw2W416x22DP9fJf48Y/3T4Y50XiLdT+zTWntOYlJojjHBIRQtMFBfyqgb8hGyDLhm
 R+OrXQW+pV4HL9St/zDcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:emaQkQ9eScg=:qi2WLh+2sviAsv09Y5nQpB
 oH5YifcHh1W3k7sx6ipWyoUK6mNTQ7ZWLnFx3ZHp2Q02B45OEM36+ttHfbKb0IrFO7syKG3XQ
 EN5eG5v/y8j1zqvkLsZlYsyuhOhjOpcr/UlunzwuJD5Aja6Fi2e2KS8mwvyAlvW3MY6OoSe/f
 f1Ji8gFejQzRqUAkXCUXWL1xBATpGgEJLp5/SWCfnBqtYZRimQJ2P15upmGgf64NtVJ4EJYAB
 xOuJqQ2PQ63yafPg+K5wD45pOC8g2xudllbuwIe0dFmDPebG9INmVqXDP7F2DZsuaxFYR01uC
 4f0Vd5O5TrvkPyJ/927qHMKWsLwoHbVS6zM+wMY7S5Dn9VKY/C53bgs0iqLOxLjAD7mwKRK4h
 NwVDmiCNIrx/dV9RArZdYIKiOY7OXoGYUXlWEalDKKv3QsxBwLIEqsw/IUq6AUS45GAvH+EhK
 j7v+FsgtB80E7/PfjAtPWCyxoCB/4EhKbEw1BxiyObITTYwUolEWlDU+58XRpYkD0QrG0vTBP
 6Ce/97k6EYnQEPf1OO0ce9kyk/IavN+im3dwCO+QZmpZCUS1ziWVF+urcRmo7Zpv6n3gitN/G
 mOQXtdxiik0W0LDbwGVBv8vJdrNCg1p4SyT5HzFAroUkcjktIxXRdDXbbF5IXp9kZkRiOBsa1
 IICQSZzajBDvpIJFfzS3rVmaZoPxnRV1pIS7c59FgGt1cfp/S2gfz+4hLMTgjGSbvgeUveqxT
 zGMWI2pA8ip9vnhZiQTDb7/jUagKVXrvlW2I0vvMQROm6IZlwUJVg67QMytOZXXBvhXxH+FLO
 eTdhJMFsCbLDMOKJOLB6RhJrMYcfb/7NFGQ6SioZ381spEunoHMEdWV+b2dX4PKQlQlWWW9CI
 Q2TifpwQQ0tsBIJKTxtMONbL4sRJZ086K6FRIQ2qY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, arnd@arndb.de,
 richard.henderson@linaro.org, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/01/2020 à 20:36, Filip Bozuta a écrit :
> Function "do_ioctl()" located in file "syscall.c" was missing
> an option for TYPE_LONG and TYPE_ULONG. This caused some ioctls
> to not be recognised because they had the third argument that was
> of type 'long' or 'unsigned long'.
> 
> For example:
> 
> Since implemented ioctls RTC_IRQP_SET and RTC_EPOCH_SET
> are of type IOW(writing type) that have unsigned long as
> their third argument, they were not recognised in QEMU
> before the changes of this patch.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/syscall.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a3993a2..2ba2c5c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5176,6 +5176,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
>          break;
>      case TYPE_PTRVOID:
>      case TYPE_INT:
> +    case TYPE_LONG:
> +    case TYPE_ULONG:
>          ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
>          break;
>      case TYPE_PTR:
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

I will move this patch at the beginning of the series when I'll merge it.

Thanks,
Laurent

