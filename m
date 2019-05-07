Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53DC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A603E20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A603E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO5Tk-0006J0-0R
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 15:10:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hO5Sr-0005wF-PH
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hO5Sp-00055Y-T4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:09:21 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hO5Sl-0004yH-GI; Tue, 07 May 2019 15:09:15 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MJm8H-1h8Lsy3Dg1-00K8WB; Tue, 07 May 2019 21:08:45 +0200
To: qemu-devel@nongnu.org
References: <20190503112654.4393-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <80fb3313-239a-5828-94fa-d27137bfcb05@vivier.eu>
Date: Tue, 7 May 2019 21:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:19uv/PyUpnAaUSFgO1xFRIbpN12+eA6tZWRyX8ajFFOxkTFw0MK
	958DOmGDEsQ0mgV1tcWjKhjPXtKPs3ooNmkk23Bu/hfMGvxXwG/7B2LaVEjDNECkfv3y3Og
	o+nPyvER53Zru8fetdGmgs6+9pxHAfR4GRXROWx/quShnPE3bLs6dibPa/reNBIYvSSa5Xq
	vbyHQFN93wouTZ1Uz6YrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XfTBrHepZDE=:mPBrwhmI53e69bYdfCploG
	CwnUaztfib7o2qhkwHPkc4gjjkiRDGHn1O9xP0NqcCczlH98Zs1H94MgBM/VTnrQAZb8+5Yw2
	Rwv7YJ1SHeJrloB4T59ddTqeszMkmPxsRcrAzfB9qTqdREaWZ/A7zY86NXvWML06HoLgGzguc
	3ZK+IcXauXv9octUtFm1GGe0LAM8DX6VMkGGGlS1VRLRkGq3ZyeY3ww7MmEMne3SUdPLV8HDT
	cWUW6eG0t2vYlkGMCsGSpEaq07TcBwceNFLhP/Lbm6xtxkY+iejstmWMQI5wF85EKysdcsLAA
	5PrZV0Mm+gSi3UmdMj5uY2sCK6t+ZTpHB7UU0berg8OXq/Ms8UlY39fpXnk5L3KYSjnkLfJHK
	Cdpu0NtctbbO05aY/gxtxXuQLOT6mKh7QgFrifc/LPqbv0uaMoTnZ8bo+Ohk/JUxNbBLPRDIO
	v8+4QsthF2v3WOzB7j3q9h63DK74o0VOZcmIDPC8h9uILyRJGNG/qJ73i1nWDsf0uBwbsqhPT
	Ox2dV2NjZbBDxhaaHMPO1cRHqUhfuUQvMIoJSzxqHQybhPVBUkMB2n6V/apkiYL1Gm3G7x4cw
	XYWuVf1E05MzHbcTfqhJKUUua7CrjU1yyFRTZt0mSEHnINeGiYnxXczVLnRAjEi4NTRoxABkK
	YlMlZppaYIWBGXW2UNe/wml0yaTb/IkXtZpPJq/6f/8BwrztDrvlvKjMtzBjjNEro64Scaxx5
	oMIYNAUbpO4NvnNtdSSR7DWwAKYh60nTv+le01hpoeW4lGwa/dF0Es/9i2o=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PULL v2 00/12] Trivial branch patches
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Fabien Chouteau <chouteau@adacore.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping ?


On 03/05/2019 13:26, Laurent Vivier wrote:
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
> 
>    Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
> 
> are available in the Git repository at:
> 
>    git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
> 
> for you to fetch changes up to 2d2023c3b99edb33ad4bb9791f70456ea1a1c049:
> 
>    sockets: avoid string truncation warnings when copying UNIX path (2019-05-03 13:03:04 +0200)
> 
> ----------------------------------------------------------------
> Pull request trivial branch 2019-05-03
> 
> ----------------------------------------------------------------
> 
> Aruna Jayasena (1):
>    Header cleanups
> 
> Daniel P. Berrangé (1):
>    sockets: avoid string truncation warnings when copying UNIX path
> 
> Dr. David Alan Gilbert (1):
>    configure: fix pam test warning
> 
> Marc-André Lureau (1):
>    doc: fix the configuration path
> 
> Philippe Mathieu-Daudé (3):
>    hw/net/pcnet: Use qemu_log_mask(GUEST_ERROR) instead of printf
>    Makefile: Let the 'clean' rule remove qemu-ga.exe on Windows hosts
>    hw/sparc/leon3: Allow load of uImage firmwares
> 
> Stefan Weil (1):
>    Update configure
> 
> Thomas Huth (1):
>    net: Print output of "-net nic, model=help" to stdout instead of
>      stderr
> 
> Wei Yang (3):
>    CODING_STYLE: specify the indent rule for multiline code
>    CODING_STYLE: indent example code as all others
>    qom: use object_new_with_type in object_new_with_propv
> 
>   qemu-ga.texi              |  4 ++--
>   configure                 |  5 ++---
>   Makefile                  | 11 +++++----
>   include/exec/cpu-common.h |  3 ---
>   hw/net/pcnet.c            |  4 +++-
>   hw/sparc/leon3.c          |  4 ++++
>   net/net.c                 |  7 +++---
>   qom/object.c              |  2 +-
>   util/qemu-sockets.c       | 12 ++++++----
>   CODING_STYLE              | 47 +++++++++++++++++++++++++++++++++++----
>   10 files changed, 74 insertions(+), 25 deletions(-)
> 


