Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53055C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A05820881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A05820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTWN-0007LJ-DX
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:51:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTOc-0001XH-FF
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTOU-0003WI-2b
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:43:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46823)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTTOR-0003FP-QY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:43:05 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1Mq2Sa-1gqXoo1res-00nBGV; Wed, 22 May 2019 17:42:56 +0200
To: Chen-Yu Tsai <wens@kernel.org>, qemu-devel@nongnu.org
References: <20190522153631.17152-1-wens@kernel.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <70e4cbac-4d0e-8e81-0db0-2d3922c3fcac@vivier.eu>
Date: Wed, 22 May 2019 17:42:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190522153631.17152-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3mwBdTk6C6QSfNbqyw6lvevMTxnjh8k/EUukMeeaKjcpJ+YGdSX
	+v/W0kZuEZUZ/q9++2pV7aNDzF7LXNJAZpq/sUPgus5rahFiyYt3RpXN4PrJ14Id7fGjS5B
	lNgnRQ/JpDsm5C9y+z0EPiI0aFZCsN1VYJNxzBCZ5dl/ddEjWOk6SzWzitquvn19OpJKwh2
	g8WyeahySp+g/C5+mbDWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Db0/FcjQ7uc=:fNwtQ+ZZBCOgM+sbOsp+M9
	1zuT3L7FwTsadXBZ3J8pKqwUa+W+/lMtknkMn0qocydWTmq1lQEz6YiL+5wA4NkSGKkxH5vlv
	nNNSBo7TC7Vs2ERXAO1dRtlMda2JcNbCXKtQv2IEYjyOLmg8T0dLf90gCrPOMYGTQ7E3/zi3s
	k0Lf7EZAwp0TstYQfENwU9qjVQsc72ME7Ki/tKcvhSgBlvC+YH9l80UvcYl8eavymQObIv2O9
	Joy8yxVNg7eFrcFIe2KUCIhoKBvY/6Yc99xKHeF76a3c0OldGA+B5GLAEDH0EL2RDA6ooONVL
	d8J9VqfzPTL5jZ9+PAgGLZLzMWcJK4XAvy2lXKiwxnYehgDSgsZaoBU/6Mic/55MyZE8ZyctG
	JCQ3AZf0VfjRdA+JtXJ35Xm5yhcCcLHQ4PoTRuT0Bu83adfHHgvOha35DlH1jbcN8SIgubwGS
	0pk+5QhXDNQd7UbIP9DVLWhq7TmH9s8vWJ2i5WHV4Hem60k37sENYzGQhsM4gA82ko7ELeMfD
	8uoCLiQTOt7T+LAf9khmou9JzIA2q+8TvUB8mZKtXKBWnmbE1a4TcG/Qb/cQqRL726P5+hbFM
	K4Qtk16fnxf0n70mAIg2pvhPKUZDd5b3wJx3Wv3xcpbo3tjGyHEchjYq/q0sTseyIVBFh9Lwt
	Kpy0RVW7Krv8x2jh/OHkb0aAt0/MXihyv/hs/fFI9qegSfW2qbRNPov1qwW6pqwQ2bVvIEjbv
	Gv85Yu3NopJrAIVRZ/jSkVeBY9kjptNH9ntPHKyN30Kr5l7gf2FOMPZ2WZU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Pass through nanosecond
 timestamp components for stat syscalls
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

On 22/05/2019 17:36, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Since Linux 2.6 the stat syscalls have mostly supported nanosecond
> components for each of the file-related timestamps.
> 
> QEMU user mode emulation currently does not pass through the nanosecond
> portion of the timestamp, even when the host system fills in the value.
> This results in a mismatch when run on subsecond resolution filesystems
> such as ext4 or XFS.
> 
> An example of this leading to inconsistency is cross-debootstraping a
> full desktop root filesystem of Debian Buster. Recent versions of
> fontconfig store the full timestamp (instead of just the second portion)
> of the directory in its per-directory cache file, and checks this against
> the directory to see if the cache is up-to-date. With QEMU user mode
> emulation, the timestamp stored is incorrect, and upon booting the rootfs
> natively, fontconfig discovers the mismatch, and proceeds to rebuild the
> cache on the comparatively slow machine (low-power ARM vs x86). This
> stalls the first attempt to open whatever application that incorporates
> fontconfig.
> 
> This patch renames the "unused" padding trailing each timestamp element
> to its nanosecond counterpart name if such an element exists in the
> kernel sources for the given platform. Not all do. Then have the syscall
> wrapper fill in the nanosecond portion if the host supports it, as
> specified by the _POSIX_C_SOURCE and _XOPEN_SOURCE feature macros.
> 
> Recent versions of glibc only use stat64 and newfstatat syscalls on
> 32-bit and 64-bit platforms respectively. The changes in this patch
> were tested by directly calling the stat, stat64 and newfstatat syscalls
> directly, in addition to the glibc wrapper, on arm and aarch64 little
> endian targets.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> ---
> 
> Changes since v1:
> 
>    - Define TARGET_STAT_HAS_NSEC for targets that have the *_nsec fields
>      in their struct stat
> 
>    - Only copy the *_nsec fields in the stat (not stat64) code path if
>      TARGET_STAT_HAS_NSEC is defined


Please use the same syntax as the kernel does, it helps for code review:

   TARGET_STAT_HAVE_NSEC

Thanks,
Laurent

