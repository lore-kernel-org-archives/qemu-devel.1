Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D85CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 18:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE80720862
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 18:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE80720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQxt7-00030v-QP
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 14:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQxrA-0001zA-5b
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 14:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQxr9-0004j2-6Q
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 14:10:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQxr8-0004eH-SV
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 14:10:35 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MD9Ox-1iHvRl0OW1-0095vP; Sat, 02 Nov 2019 19:10:28 +0100
Subject: Re: [RFC] q800: fix I/O memory map
References: <20191031100341.3827-1-laurent@vivier.eu>
To: Paolo Bonzini <pbonzini@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f0e03032-0ef1-3c8a-0f8d-9608c5c7a5fb@vivier.eu>
Date: Sat, 2 Nov 2019 19:10:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031100341.3827-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QscQCYPLAKV+G1CCmh1BXiVXFQwTpV0I6M1suHWW2/Ci6kCU7vj
 k3/Hc76+yGJt0eKsVUwktc7pKNeprghZl4g8/6LizL0fz3/unjd4jCepR46yo4XkOPTKvoI
 yQL1PvL7USeyfUxVk/tybYljYXVqJKNcFLqv4HHBCoiho4n9KkDq6kjjk6JE9iQDTgEZ41D
 gQ9XIagP4IuCmFIjGTfaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmqSXPmU35w=:tETFZ5xvONKFczff50nWmp
 mNvDGhvIP7tbmntKtG3RStmAASB5QNRwDCT6T2w4saQ1zymVd+4hA3XCZRkwmPIB2MyN4BK6I
 AdAfKLQhC7cD+obkSAaUIaUcPltcfANq79rAdinGccDtuIkv4RI9TM/ShsKwaO8lkuGJ2q90U
 sLSVIUZtpLg2yXy0ISb5t2u2BfrN4Q5i0XaOwb6M71VWHUPjKspdkTVPQMOwS33LLiu4iviGH
 MITUNFNi6OzepUa5tfRpXJ0O/lh2YAjEN7lCmw+icMe/Q8hRu46hJJ5yX3mLPGUnZJO3Yl3oL
 J+pPDFBseBxECEJzweQp7Yfumcl9l7k3rGNBl8FREOjsKcjiUF1ooJrj8qpOaiiXw5nFsE3NM
 d9BOTv61eBvd9MCvnCwdeMMejwS30mX8fcixCWkc2HnskrfzvpwoTtcAQY0rjMFwfNTWRwNuV
 qmVNlcI91hiNPxtxy6CM3y7KGaoFwyX4nyaRlWA7/5SFj8z77/QzDn1AvN7rDJyL8KQxTT1BM
 rfWb+nPIkZP8QzlrS5MSuyyiRCxUEvZRRDKK0yNMRtDKwrtwTlAG3kbm62kG7GFjsu7dvOhB+
 4Fnt9+WVL2LOwF19AYgEZIP0sTs/lTLH40RRlZ0qlmHbiH9W6WSS1Kci/loqqD0Dx0FNzeuy8
 IvVW+uQXBHJUGfjZnX5DZ5K9XHAE8eqAH0FpYVrEntqDDMmcgmtW2hOhH251pC4N+cV/QJABj
 sZ4Tk1huHIyqFgeL9lMOLdPp5YAvgtWnjB+UB4vhGKgcvQwdYbEC8OaBWMzPdN9UdUVpVwlzw
 jmsX48q4AePovmkMHLBQVCfCPMxXayw6Zof3AuNTM8cr/atvkjpobLlFgcNPGXvqV0QqKGlor
 0FJb3HF8NL5bhY3S69307I5x0XzXma2xDfKWmfNFU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo,

the RFC was mainly for you:

Is this the good way to replicate 256 times a memory chunk containing a
bunch of different MMIO spaces?

...
> +    /*
> +     * Memory from VIA_BASE to VIA_BASE + 0x40000 is repeated
> +     * from VIA_BASE + 0x40000 to VIA_BASE + 0x4000000
> +     */
> +    for (i = 1; i < 256; i++) {
> +        MemoryRegion *io = g_malloc(sizeof(*io));
> +        char *name = g_strdup_printf("mac_m68k.io[%d]", i);
> +
> +        memory_region_init_alias(io, NULL, name, get_system_memory(),
> +                                 VIA_BASE, 0x40000);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    VIA_BASE + i * 0x40000, io);
> +        g_free(name);
> +    }
> +
...
Thanks,
Laurent

