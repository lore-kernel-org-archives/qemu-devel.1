Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF8C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A36121734
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A36121734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVB6E-0006LM-FP
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:35:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVB4F-0005G6-DZ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVB4D-0006o5-NZ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:33:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hVB4D-0006n6-Fz
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:33:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MIxmm-1hAuNm42Yc-00KPfh; Mon, 27 May 2019 10:32:41 +0200
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
References: <20190526072826.32956-1-lucienmp_antispam@yahoo.com>
	<b7c64daf-5036-b492-92a5-b25524d8cbde@vivier.eu>
	<652107096.7996190.1558928620614@mail.yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ce0a8f20-b569-391c-6e72-25e41001876e@vivier.eu>
Date: Mon, 27 May 2019 10:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <652107096.7996190.1558928620614@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3UsKXx0gw72KteUZhW20ffd4I1As0sAjV/+WIMdkcdsszbyTL5Q
	nlUd+7g9oKSAeDcxhVuz5IeMuURK5l7pqEX4Yv1D4gYSOtfUKWB4m5WhADSa38klgFC4VzT
	x48tYqGf9ZuDNM6R6rFzCbZWDp613ZL3vjBgU+OFGuyhJNP7kfgVxDznPjKKerLhTvBf21N
	y5Ku7IYOGGJubvUW8QFzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Prq6WVBpOEI=:VR1UP/zs2syJUAzgksMBZX
	rEIGOUDC5xT1G/F82BFEG/if/FJ6ssvZoYKtu5Q/V+yJjCfoXxpei5xOzbn5fouNYoB/jSA8z
	3QDdETp94//AXrlCne+KsNh5N7UESLXs5fNukfFKpS9PbQ7wFbY0fnGJVHhQShI7DltTJ0PIn
	wM0/d8+5dTA/4KQsIFQK9/VJ0/aAT1lE0dcilnj08jfY31ur5NPgqBslNZXPFw1qpsZAOY0Yd
	YqaOorLSCT5ZljMVpx/pDMVHuzqe/M1n3VMDSk5l+qu6RSjbUiAkTS7iAWPwH7Yi62Y/lmsXJ
	6GmbRlylG4m9eiootvOR1u5By7MB9yYNkuth30Ne8puvMZE77lvlpfajNAt8t33fnS0vcoTzy
	G48qyZBbB//ookYreirUWcDnrFfrUaJjVi/BU+mtheLwWDfL63FJL9iOc51yuHhMEyqtQnG3h
	ZkcgK0oqxTkFiE2IXroRVPQcT43LPyCSnvLSwU0+NBty/SVhUNgteqUMMk+oB4fdMDy2KELMg
	Fyx4y153qYjPBODg0DX29a4l2Bwz/w6YN3Mk4K6dZE2WpVGlsr/DGNgUltnkRsFDo1PGyElSn
	NjXS+CNVP7ExgkpFGI1vXtM80OJNWBfgHilD7bu8qly9vtRAs9bt5Xr9WyHqSGS68mnloindx
	tRRi7/at1Ih8jZAiTgJuHcA/cU+d1onDP5k8X8RcduaHSLVu49TEH4rZ/Hmbg9H4b9ihFbO9u
	fyGp95Ec79CBWdJSbtsYUsoob7gvCDsQw7/riEqluF0aGJH0IErvScbeEpY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH] Incorrect Stack Pointer shadow register
 support on some m68k CPUs
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
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Emilio G . Cota" <cota@braap.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/2019 05:43, Lucien Anti-Spam wrote:
> 
>  > On Sunday, May 26, 2019, 10:10:39 PM GMT+9, Laurent Vivier 
> <laurent@vivier.eu> wrote:
>  > On 26/05/2019 09:28, Lucien Murray-Pitts wrote:
>  >> On CPU32 and the early 68000 and 68010 the ISP doesnt exist.
>  >> These CPUs only have SSP/USP.
>  >>
> [SNIP]
>  >> The movec instruction when accessing these shadow registers
>  >> in some configurations should issue a TRAP.  This patch does not
>  >> add this funcitonality to the helpers.
>  >>
> 
>  >I think it's better to also update movec in the same patch.
> [LMP] Movec should be undefined (coldfire manual) for registers it 
> doesnt know.  The MC680X0 manual is less clear.
> Technically this could be just leaving the operation of the instruction 
> alone and allowing it to pass back MSP/ISP/USP as it currently does.  My 
> thinking is this is less likely to break anything

In fact, code in m68k_movec_from()/m68k_movec_to() need rework because 
they trigger a cpu_abort() with unknown code, they need rework too. So I 
think we can just do as you propose for the moment.

Thanks,
Laurent

