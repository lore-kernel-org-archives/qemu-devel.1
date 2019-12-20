Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2596C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E7824682
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E7824682
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFLi-0004sF-Vu
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iiFKd-00046s-H7
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iiFKc-0004R6-28
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:16:27 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:38423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iiFKb-0004Jm-Ip; Fri, 20 Dec 2019 05:16:25 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M4bA0-1ihgpP3PmQ-001kxB; Fri, 20 Dec 2019 11:16:05 +0100
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1576815466.git.fthain@telegraphics.com.au>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 00/13] Fixes for DP8393X SONIC device emulation
Message-ID: <e090162f-9810-caad-ffa9-35ac1bc1e923@vivier.eu>
Date: Fri, 20 Dec 2019 11:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <cover.1576815466.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t7AWTT4BcHZtk+DKV+PICD+l1i+1QNXk990Z213l1m7ATkMa6cO
 LrH+eZlyx1BK9WtE6GVxPNEFvlA80uoLkP4HHf/iu+erQsnQ6Xj+QyPjMqmxSHuFwa/PKmO
 UfNw+IlYN8ls5X6JBZlfyYpLSZ7iLWKoVkKNLPQAmfr/LESObRZ4w9vkn/63z8yNFRJEAji
 dMzMGsTcYCLDBTK8y/CFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:42IS8wKmDv4=:sQiPpXJFAAndVPqYPPmoUs
 k30sJ7PQ2O1Yyl/0GqqRw1L50dAnqxsaZgWla7Dgqj5jitTsaEtsLdhARMcmTTa5A4wrFKKC7
 vKmYb3n0Qe3gJeANTo5fpnhtH4u8cbFIiSuTUORVga6iy+ASmnmzKimaoSDqDqLCXs1sPOrpg
 BF85d5s2NCux6vdPW5yLjqfoqjSCIuacKPEv4quC9MZb03w38BdsP5J9KSkSV4njl3Zqehy4D
 Sbi/uk/w4LxS5eAetLBa3yMV5WzSjvh6oJYZwFK7LPnEzSaRfV/z6IIpPF83wZ2xxQcf4nLjP
 gBoomUuni9+1FrsSTY7noZevqDX+LyfXpqf2V+ZSXKJtk7ACnnvt4dp8LAEG0Tw18Tcswfv2d
 FTpF4XgcCXU/Rg/m9SM+0hv+CBfK1z6GjTNhWMoVpmXPQH8URO5NRzOdmJrUD6v4/hWcphdJq
 D3SdQjFxrLGJqEDtdJWWTDnZMs0VYh1mkrp9MEvDhdQ2q8XSY7ciIkO2ixO1nDzkwtGhmQoIY
 gpsXBs6JqPbFi7rHWIO8836byUmXyvU+8Zb0/tledSY0DkD55xGC4Di5tJPoG7Qmbiu4xv1nb
 2iyik2Y7XA8SZYM2e+vF2Vzo2YNCAuLjH8CYVX4OChHPRyGV/JJiV+q52dPoRu5Pfx6nk3XjO
 5IwGxCjk2urhY6GvDas8j0BHAu+IVCH64BATXzTfg44OeXRNU6U4zXvS6PHRWiOVWygNysgxy
 j+g40c+XQZBESD6DJhKGxmm16Cg1EHGLtm+t3oDAW9MyjLKKeNr9ycQZ1jyTsbVIBfH3jLg8J
 iQ9INvqxGpsbVytkJalcRh2CCupNBue8wk9/WmTTf87ybCnYJ3WZyvqOb68gQPu9d9dfiSuVo
 /T4/xiCqfo1s9n3D4+jJE9SuswoINIBjuzfgQuNeM=
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 217.72.192.73
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/12/2019 à 05:17, Finn Thain a écrit :
> Hi All,
> 
> There are bugs in the DP8393X emulation that can stop packet reception.
> 
> Whilst debugging the device I found that the receiver algorithm differs
> from the one described in the National Semiconductor datasheet.
> 
> These issues and others are addressed by this patch series.
> 
> This series has only been tested with Linux/m68k guests. It needs further
> testing with MIPS Magnum guests such as NetBSD or Windows NT.
> 
> Note that the mainline Linux sonic driver also has bugs.
> Those bugs have been fixed in a series of patches at,
> https://github.com/fthain/linux/commits/mac68k
> 
> ---
> Changed since v1:
>  - Minor revisions described in patch descriptions.
>  - Dropped patches 4/10 and 7/10.
>  - Added 5 new patches.
> 
> 
> Finn Thain (13):
>   dp8393x: Mask EOL bit from descriptor addresses
>   dp8393x: Clean up endianness hacks
>   dp8393x: Have dp8393x_receive() return the packet size
>   dp8393x: Update LLFA and CRDA registers from rx descriptor
>   dp8393x: Clear RRRA command register bit only when appropriate
>   dp8393x: Implement packet size limit and RBAE interrupt
>   dp8393x: Don't stop reception upon RBE interrupt assertion
>   dp8393x: Don't clobber packet checksum
>   dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
>   dp8393x: Pad frames to word or long word boundary
>   dp8393x: Clear descriptor in_use field when necessary
>   dp8393x: Always update RRA pointers and sequence numbers
>   dp8393x: Correctly advance RRP
> 
>  hw/net/dp8393x.c | 147 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 100 insertions(+), 47 deletions(-)
> 

For q800:

Tested-by: Laurent Vivier <laurent@vivier.eu>

