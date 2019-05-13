Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957AC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC9B20879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC9B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55127 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ8kl-00058l-QI
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:04:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ8j6-0004Et-D5
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ8j0-0005aL-O6
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:02:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hQ8iy-0005QW-Nr
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:02:29 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N6bsM-1gdIVi3J3G-0186oV; Mon, 13 May 2019 13:02:24 +0200
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvmpnomohfm.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0fd56bfd-73fc-4859-1d42-f7e6557eff27@vivier.eu>
Date: Mon, 13 May 2019 13:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <mvmpnomohfm.fsf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YqNVkTAmxEeSnBbmvQ46R3Hq/QuuFWr0KgOQQjyVrD+/e3lQmqL
	PvKmgL4w5TomQ6pQnKVUPYEv0A+GPWvG6mZvCTXuWFwtcvIEFPK1Nim64CIR5NaJkvnFgME
	wWHPxaaPDnYBpjdhAUazzWAEIxSXF2Th2U97DkYAwb6KB/IuoefsOMo5hMi+wXhmx+fGc4W
	aAAHAd06fewjlQ04EbzfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bTXe/Ps98xY=:bJo43tT+GboQi/4Q/URjJR
	YT/m1C38XdWzSrqNLA8dZBE35Tr1GQ7wmSHLqF4yL7/VVcQpe2SYT4OSYBM/Vb9y9JEzWn6bW
	EhjIY2jFCBJd0u7j6+MlGvE1xv/ej00Ax2jWn4Zue9+/q1eYVjnLW+5uec9UG1JcOkULNF67+
	FO941fXdvCbMFHMrnaNvIlbiQR8HYOPgTO6DhyEFcE70Dbd5/ZF7ekYI0fc+0+nsK14CB78pS
	nnOn3gi+28olgdOIlnAoGijCbgWco4siy/wankTGuM9rNlEYMzDUss3Z2HvFErGfv8QGAIZC8
	JpryxGh65jAy5AIKzkdAbo+gXbQ93zifNayD+kg1L5vYVHl0w303b4KhRah4mrLEo95CRZbCS
	Ek6IrLmYOtieFZfhCrcPcdgDMp7uWxeJ+DSlW5nGGwoYa2zm3/OxxQ/tPWnRTtLGKQDKP0Vhr
	hfUlqIJaSbxtvOsbSafShYUbSIRXrgv379C4aWTeSFTUOiPGQw359CZxVyns4l/mecdivprsr
	EyFI5RUcwojZdGTT1Pt7zBgtOKuMoEDQjGcNUTiaSnx6tdgVE7efheOBQqezaQObHRmCFUFMs
	x73IteQP9wTSyyP2CIN28+EYucmrc9wLXlNX/mFp6ar8kzXXL0Xl9gKyPS9+rpiPl6kc5un+M
	R2h8UtTHhfQvvI7dOovpc2vGke0M3ckQByX5wYTr191bTkdRIkEr3wSxxnrSTw3FFHyu28qhT
	MY+zTrigbhCZfb4MvksrMHi0uBTfH6RdB/d0hQsLaxXH9NG2tvHLZ+1P+kw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH] linux-user: Implement membarrier syscall
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/2019 11:02, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



