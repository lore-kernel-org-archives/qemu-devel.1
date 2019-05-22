Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E298CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94BE20851
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94BE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRVU-0003HL-V3
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:42:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTRU2-0002OV-Px
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTRU1-0006sd-TP
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:40:42 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTRU0-0006r1-ED
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:40:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MowSu-1grfIc3JhW-00qVHk; Wed, 22 May 2019 15:40:16 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190506141923.12183-1-philmd@redhat.com>
	<20190506141923.12183-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c5163291-d4ae-08db-0e7c-c24021647771@vivier.eu>
Date: Wed, 22 May 2019 15:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506141923.12183-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OzFRHyjmyZJAuaxqErQyjoGMcRRAg5WmlMwmVyseSL2iELDVB4F
	bvkKOeSytSOmMqU7ZnRTI+VPYMWsTzZzug7IMe4BOvhH7Bh04crMxslP8fULtJ85w4LjmGo
	ybs446J+hnmGmcMHBHPPNIDCOqIjrSvHemctNfoY0J3YLD3Kn2nTdJn7Crn72uFdTTxFd86
	rQxZDPBzPg5HQraaGYPzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SfVyTddEOWQ=:BsP4fqCB0gFW3pLmO03eYz
	23HxhQKJrcmo+CI124DNjJJN0UqkwAjyq9QHGyUCj3YuBepPYhbHD5BtUVNt0VrfDAhdGAfIA
	itPe6nGtniCAaYiHJWnUma3jL4F/JyZqeVYnGYkqV7oLL3DQteEZvnx5ZOU8nez3kjw53s2ho
	pIBuhbrlSD4yG7h61l8cotFrJZiP9qhT7H3/EGft8BGGLCQX3L9TNRumjs4gYdCXC/UKdcpoq
	ZvYb5IXf+9XFdtAHy3MJlEoPu0oJvDNq4dr+hPHjx3DGjMTHQKnBCIDUMaee6CiyPsOer2EHp
	1jxGLnmNxypHXWNcMzbQvET5ID6p1UiYda82f8pI6X3BlagZiGCFpivxPJBKCqztsuM2G5NGG
	8fufQaPrVyASiH5yOGeUnHB9cQeIPBt9Osfb5cqMAlu69l3YdTNij4EdvrD5cEWxMemSF9SKY
	BL3LmZcvIexNe3jKeJZRnuamjoIux7Juozy3qqSIfdTpWb7qnoc82iBpeGRYhcvYYvxhU0qi6
	3e4UjhcAjcLOx4Y5Wk7AuJkHJ8sIoU08Sy6Gr9n7FsVq853pBTDflAy3Un1g3dmhwHXb/dK85
	dYXnB7OXxWe55GjiQjW9ZUJdHeaXR6dqLzmI2VwnPD9oT8bgN+mQh0cfztgSWiPFi+mIv/BV0
	hj/51c8ywTvZSbjXJmOnOElgVWD1Dn2tosuf5TUhSegLQtLcwePG1InqT7CuSOVzK6TRguvOT
	Q9Jmppbgt8O//vlvPucLafw4a3CpibHa8WwIm4mRA8GkTG61hIOZ2keJSpI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v3 2/2] roms: List and describe the
 Makefile 'clean' rule
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
Cc: Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2019 16:19, Philippe Mathieu-Daudé wrote:
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   roms/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index ea6aec56abd..078d3fb7056 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -62,6 +62,8 @@ default:
>   	@echo "  u-boot.e500    -- update u-boot.e500"
>   	@echo "  u-boot.sam460  -- update u-boot.sam460"
>   	@echo "  efi            -- update UEFI (edk2) platform firmware"
> +	@echo "  clean          -- delete the files generated by the previous" \
> +	                          "build targets"
>   
>   bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
>   	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

