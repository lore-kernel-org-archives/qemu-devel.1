Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485FC49EAD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FA420869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FA420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvZf-0001Lb-Id
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRvXO-0007hV-RP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRvXM-0003xd-Pc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:54:10 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:40589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRvXJ-0003rf-EO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:54:06 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M9nlN-1iXAKK338n-005u2g; Tue, 05 Nov 2019 10:54:01 +0100
Subject: Re: [PATCH v2 12/12] linux-user/alpha: Set r20 secondary return value
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-13-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b9eee751-a891-7bf4-f086-ccf6fa1ba56f@vivier.eu>
Date: Tue, 5 Nov 2019 10:53:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6yfeu8GfDWbDlnu8a6usplXNQlHvbZZWA3MRCsqh/h6/HiIQIcn
 djsYUWEx4t9rtrSoS4McDHy1wEewjReRgOUopJ0M7OWvq7TlMclGjQvOIJxhd1vtS7qjNtb
 b995KlmTp7AjlzytcrR97dBTiH6K35Kd8r+yE1GQLB9rXEDQOUCV0v8Tv78Lg+YZWR3PFx0
 941XPKUwMKe1WBtjQDVBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IKKTY9rW84c=:oDIIefYrINhJ2EbTDFkXdo
 JTt/5UQ7C6oQN+ahLTP776rBgw8KvlmvVh9DZVTPysQSqaz4raSYAgqNJXaPbp9d0VFSKU6JE
 F1/SEQwslX1t+vBdFRmESHf+LyPxSHDZBjkpzgFb5nzRganUtjJMl21FKGPd+XWUF5Jg1xe2X
 W3kL0hzhZz5MgpuGTkMZwKgHmSiV663rHbU5TnG8Gv+AFoT4k02fZy9vsTXqX2uDAZr1LECr1
 irU2SCWaZlShKq1LHazqvtNP9jOLi+L8KgVQGG0LLBTXCE/X7Yp0ZiMrOLVvdqhOOoSN2eVb8
 92eBs35gI4w4cqCOqO3LgopD+F+Mu9Fzn1OP36jSiVEYmsT0q/cR0ATD+B+HDIfNnU546U5wI
 Js6F0Vpn7EzV5XH4C+jybPLEa0U/TZUtsAEtfqeNYDOUfSh/oldGDjDAE/lTztjyf/pBDBMpq
 GKky4aSzrJ34OR0Uw8L4XOfMpVxkSEJSAcV2Nwf0W7rqwVZ64DyFkWJLlxi7wQsBiokLYM9NH
 Qk0hnXlJKgUMTBBC3YgdSeSwD7KxHA0682KH5tuaByRFyQBRJ2jdAG1HEoBtElK5qWYJJj8Fx
 I9M0SrGkI3uksu22KevUVruyM4JQmn/XSiHV/UhTH0C4P3bb6N8eHD8+UFFKSEGisRQKfsXrN
 xwjxz8AoKFrr1xXnQm+PeHiybb0ZonSHEm7x+qpY0p7GNAcflbROpfLmadAPYBYPYJMpgiA4l
 mITK4KlXbmoMI4Pb/owvjeXuwzWVJ4DUnYWAFPW9YLGxlu7lUPmxnla3zJC4U5UIWyKBzVQyk
 NXOAURu/hM4GDZIlV8A2Fw5oWBEN+q0dVu3fNd0cCQI5CKuLuT0rkMtMwAlvVwtRhpmSs7/6C
 Q6A1yhwFKAN9vyNm3cUDPnA/Tbxq0TTQi4dUTZxr4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/10/2019 à 13:39, Richard Henderson a écrit :
> This value is not, as far as I know, used by any linux software,
> but it is set by the kernel and is part of the ABI.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Do not set the parent secondary return if SETTLS.
> ---
>  linux-user/alpha/target_cpu.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
> index dd25e18f47..ad408ab5cc 100644
> --- a/linux-user/alpha/target_cpu.h
> +++ b/linux-user/alpha/target_cpu.h
> @@ -27,10 +27,19 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
>      }
>      env->ir[IR_V0] = 0;
>      env->ir[IR_A3] = 0;
> +    env->ir[IR_A4] = 1;  /* OSF/1 secondary return: child */
>  }
>  
>  static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
>  {
> +    /*
> +     * OSF/1 secondary return: parent
> +     * Note that the kernel does not do this if SETTLS, because the
> +     * settls argument register is still live after copy_thread.
> +     */
> +    if (!(flags & CLONE_SETTLS)) {
> +        env->ir[IR_A4] = 0;
> +    }
>  }
>  
>  static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
> 

Applied to my linux-user branch.

Thanks,
Laurent

