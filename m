Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02106C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 11:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E292184E
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 11:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E292184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSK5f-0006J5-O2
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 07:34:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jakub.jermar@kernkonzept.com>) id 1hSK4o-0005yX-E9
	for qemu-devel@nongnu.org; Sun, 19 May 2019 07:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jakub.jermar@kernkonzept.com>) id 1hSK4n-0005lU-AL
	for qemu-devel@nongnu.org; Sun, 19 May 2019 07:34:02 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]:34293
	helo=mx.kernkonzept.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jakub.jermar@kernkonzept.com>)
	id 1hSK4n-0005io-4K
	for qemu-devel@nongnu.org; Sun, 19 May 2019 07:34:01 -0400
Received: from 93-153-64-87.customers.tmcz.cz ([93.153.64.87]
	helo=[192.168.0.108]) by mx.kernkonzept.com with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	id 1hSK4e-0000fa-QD; Sun, 19 May 2019 13:33:52 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Jakub Jermar <jakub.jermar@kernkonzept.com>
Organization: Kernkonzept
Message-ID: <bb25cbee-9265-260a-681d-d7d390c007ee@kernkonzept.com>
Date: Sun, 19 May 2019 13:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c1c:b490::2
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 5/19/19 12:52 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> The following changes since commit 1b46b4daa6fbf45eddcf77877379a0afac341df9:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190517-pull-request' into staging (2019-05-17 17:25:19 +0100)
> 
> are available in the git repository at:
> 
>   https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019
> 
> for you to fetch changes up to 71074d1d2fae9a0c8dab87c5bb5271a71d6cb7ab:
> 
>   mips: Decide to map PAGE_EXEC in map_address (2019-05-19 12:11:46 +0200)
> 
> ----------------------------------------------------------------
> 
> MIPS queue for May 19th, 2019
> 
>   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)

This was rather a problem with failing non-executable page tests in
L4Re, not HelenOS. Even though I tested HelenOS for regressions.

Cheers,
Jakub

>   * A set of fixes for emulation of MSA ASE on big endian hosts
>   * Improved usage of object_initialize() and object_initialize_child()
>   * Better handling of 'div by zero' cases in MSA ASE
> 
> ----------------------------------------------------------------
> 
> Jakub Jermář (1):
>   mips: Decide to map PAGE_EXEC in map_address
> 
> Mateja Marjanovic (7):
>   target/mips: Make the results of DIV_<U|S>.<B|H|W|D> the same as on
>     hardware
>   target/mips: Make the results of MOD_<U|S>.<B|H|W|D> the same as on
>     hardware
>   target/mips: Fix MSA instructions LD.<B|H|W|D> on big endian host
>   target/mips: Fix MSA instructions ST.<B|H|W|D> on big endian host
>   target/mips: Refactor and fix COPY_S.<B|H|W|D> instructions
>   target/mips: Refactor and fix COPY_U.<B|H|W> instructions
>   target/mips: Refactor and fix INSERT.<B|H|W|D> instructions
> 
> Philippe Mathieu-Daudé (2):
>   hw/mips: Use object_initialize() on MIPSCPSState
>   hw/mips: Use object_initialize_child for correct reference counting
> 
>  hw/mips/boston.c         |  25 ++--
>  hw/mips/cps.c            |  20 +--
>  hw/mips/mips_malta.c     |  17 +--
>  target/mips/helper.c     |  13 +-
>  target/mips/helper.h     |  16 +-
>  target/mips/msa_helper.c | 191 ++++++++++++++++--------
>  target/mips/op_helper.c  | 376 ++++++++++++++++++++++++++++++++++++++++++-----
>  target/mips/translate.c  |  59 +++++++-
>  8 files changed, 574 insertions(+), 143 deletions(-)
> 

-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

