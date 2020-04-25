Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A7DC55186
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 08:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C737D206B6
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 08:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C737D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSFtA-0007Tu-T1
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 04:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSFsE-0006rA-OY
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSFsE-0007yz-65
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:09:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jSFsD-0007yp-K6
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:09:17 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mbj7g-1ivgXk1y2g-00dIzc; Sat, 25 Apr 2020 10:09:06 +0200
Subject: Re: [PATCH] linux-user: return target error codes for socket() and
 prctl()
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
References: <20200424220033.GA28140@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d98935e8-66a6-98d2-e7a8-a1bba06f0013@vivier.eu>
Date: Sat, 25 Apr 2020 10:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424220033.GA28140@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xh8Dte0+uucv0dD1ZAbPdpt2EUm90qAXzkDtEm+UpSmaPKaqi9f
 nwQZXb+xljjXY0nJm+bGNkkaBYHO4uSZ53xFAT/fOOu93BbxyPiqK9ExMxo/hWxtTHac+1X
 R05LHEn66/F7dkItOauAD7oF3DXJ+11omUh+4m4RFlgvfaDqd7d6TnA2BJAIgCb0zzIeQHc
 N4BWpn9JZ6/354AAuOb1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7zIcjB+oZCM=:s3yBFIGaPvHSrA8ZefTRch
 Q5lKpzxT0gpfRQYcrBRiX0JnAosjPkvGVLGHh6hY+FX1j2YD+WYUJuYQs6oNqgk/tsMw5NtPb
 jOkqRh0A/q3eLV6TOwnsI+VkWePiV0C1gro+6L87+YAeKbuvVr6n4azSV5fiQmswuSBlezneN
 JNtLuDAALpA/Y1q2k99t7Pz6w9L58xyZpXBgC1SMyrTzfSCb7ZKlT+CZUpp1EjC7AvB4dtMaR
 OGSt022KeKtEyMCFGcoVEHu9PlGC95yBggwMVSs9d2E+xsD7/OjDPw81O6uBujb0Us8Bq2ed3
 kpCpkLY4OQVHMpvCi6k8qcE/HA0I7yADLcgz3/CeNGiPEcgt1ijfyn8zAFpiHz/dFbfTZyhBS
 NE1nrzy8pBXaGgFyUE9AcWE4lMtryYSYO5z1t+jbiib0ZVvko70k1E9460vO0XBiZwVwMvDL4
 +pmWj459x85aQ70zdIpEtbBLE8u0rSHl4jGzpAHanuIq9D889Wllx2N00ZzeoJjiJGWVM2uCi
 yTkwzOQJa1eoI8nOj3oa+0LeTPczElhTaJGx3MNTDD1Ym7YIWwJtb3v3GWiNdPxjkNA9dOjUZ
 2e9ywnk9gDlvuMK9O/6SZ/PNIMujgeb1AIHKCJeQTBk0GffKHJ/RNt/mGXxrnf01feeTMnWEI
 Nz/HGbLTeaTnX52Z0LEQd1m3DaWkZyQaw+b5IfK3r/WVU/rBcijvVcETn+iINrXwkbg+Pp45w
 Du3uiIWpOxtTpdOAzdTPaz2mByByl15tHh617Zo6NBkS0IyvB3PCYKXV9WXSyCZhL5UKurgSn
 gsznKTKcCsOVRiI7+HJ52Z81C8a4KGUnkAerbTpoqy5Rl+7yQ1tB6KXp9h9E0evULD1hn5b
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 04:09:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/04/2020 à 00:00, Helge Deller a écrit :
> Return target error codes instead of host error codes.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..655a86fa45 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2987,7 +2987,7 @@ static abi_long do_socket(int domain, int type, int protocol)
>  #endif
>           protocol == NETLINK_KOBJECT_UEVENT ||
>           protocol == NETLINK_AUDIT)) {
> -        return -EPFNOSUPPORT;
> +        return -TARGET_EPFNOSUPPORT;
>      }
> 
>      if (domain == AF_PACKET ||
> @@ -5856,7 +5856,7 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
> 
>  abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
>  {
> -    return -ENOSYS;
> +    return -TARGET_ENOSYS;
>  }
>  #else
>  abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

