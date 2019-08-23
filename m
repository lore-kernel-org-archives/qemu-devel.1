Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9DDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1918233FE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1918233FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BtH-00045n-RX
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i1Bs8-0002yJ-S3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i1Bs5-0001H2-1E
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46755)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i1Bs3-0001CD-MB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:53:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MwgOK-1iQ9PJ2PdK-00y78F; Fri, 23 Aug 2019 17:52:47 +0200
To: Shu-Chun Weng <scw@google.com>, Riku Voipio <riku.voipio@iki.fi>
References: <CAL1e-=hMssOVfvGWsyWmUgPyG-1ovMva9W5-T+GJgoyn_29-VQ@mail.gmail.com>
 <20190817000714.142802-1-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dd9face3-4cd8-c76a-c9c1-8e4a9cd37859@vivier.eu>
Date: Fri, 23 Aug 2019 17:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817000714.142802-1-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FeDEj5eiZifDufbjOVT3Rb1aENrXq2WFmXuck/oVGtQJk1N6E5W
 4ykOgvtQhYYmQWmeFsckQLIv/QYOblEzt6wXXPIAFNPcIgDLfE7/W+3QZJ8z0+ZFUcvngz6
 hyW4xi6GOqYBFd6fWIPoEn3ezCOLhxOJutlPy7irATqyHcfHRjgwTgbSv35H1hmeHxNY2ND
 JyD1DHTBEeN83TJJQbpVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0r0BrhU05NE=:nCpe2xOPGAvvdKDjzc56Rn
 VbkTNlLQ8cOogcDq3CVipacsRqhDV0w1yCROTwkVc+LzsI1KRD6VezGuWk4CmLA47A2iAnYcQ
 UM/LL/QezY3DH2UzeY3X7a3lhR699IbtFAC4zTJviqiN4U/2J8L5IQ82tfQzTB5ge8bJ/AxHE
 oQd1XRXW1OU63cIP4c2F3ds6n6dCOr/7kGKsTVUC2PVJhAw4H2GSF+TNI/HxOEl6zEdep6hkY
 a4lbKVt30J75az1EuMLDICGI0UiaeVwXfcAlPX6CL+GiDwNfd/hsdvYrOKBV/x0qF1+ZtVlnX
 18xnPhaUM3UsB/aqaeosI6YzQ5PvBvzyKHgrIzG2qEnlMXZDHrTtqLFyA2e84M3Zgo9T5XV1Y
 bEZ0HRgVNY8TlVdMQ4bW8C6rMDYwsoUNTl1jEz85z5OIsoilTPekFkO6xQ4BfP6mjgL4Vmbqm
 +yL0WDKKiJpGuwEmHcrUi+1/IrcqIZLUkF9BNNKN7W4sk1wLrmeiJectr9c4aSfiOEfKMcUC2
 r0Kc7ohz9hxtL2bkc4x5v6zN9ZkXiMpSO6wniGxoikGF6DH/cpNokfC1AfwJiPmD8FaqCoOca
 aroGMFO2XfhTPOPavrpK4egayl7Kw8FLPiK1qMIqmJp0PNNTtdMLtqY8ef+AMe1qXhS31+PIc
 8g6JY6F+QC4c2XwTfeOcuzgDYXw/nhcURt67STOPsU7nO9y5x0aglZG7KuQR3m7Zh9t8OWR0t
 vL91ul3IkyTezfQCbnc3SHUx/DW6Y+hRTyNc0/O6ErlR6qyqJwMggLbv0k9vB77OoFgkdMJmW
 ia0Y7VPObSObD7/6YrBEMSPq28RZA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Add support for SIOCETHTOOL
 ioctl
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
Cc: arunkaly@google.com, qemu-devel@nongnu.org, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/08/2019 à 02:07, Shu-Chun Weng via Qemu-devel a écrit :
> The ioctl numeric values are platform-independent and determined by
> the file include/uapi/linux/sockios.h in Linux kernel source code:
> 
>   #define SIOCETHTOOL   0x8946
> 
> These ioctls get (or set) the field ifr_data of type char* in the
> structure ifreq. Such functionality is achieved in QEMU by using
> MK_STRUCT() and MK_PTR() macros with an appropriate argument, as
> it was done for existing similar cases.

I think it's a little bit more complicated...

According to kernel code in dev_ethtool(), ifr_data points to 32bit
value which is a sub-command (ETHTOOL_*), so this value must be
converted to the good endianness.

Then this sub-command can have parameters and thus these parameters must
be converted too.

Thanks,
Laurent

