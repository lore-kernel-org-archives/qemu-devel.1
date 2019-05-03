Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA56C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0A62075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0A62075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWRS-000476-6L
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:33:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWGa-00022v-VV
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWGZ-0004wZ-VP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:22:12 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWGZ-0004uk-LO; Fri, 03 May 2019 07:22:11 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1Mt71D-1gU0vy43WT-00tTDe; Fri, 03 May 2019 13:21:56 +0200
To: qemu-devel@nongnu.org
References: <20190503111832.30316-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c2a39c3c-c9df-12d1-7dac-5ffe14a64ad7@vivier.eu>
Date: Fri, 3 May 2019 13:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190503111832.30316-1-laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AFfU9T91hKdlrA3ZReUoWPrNPRd01sMOK9UNtrHjeM4nkg4tDtR
	kE/AwdBKodOwr4+/BFJ9OAhcBj5XPi8uI9nCFulmFBIR1yj0j6MuZJXMbmyAs/VepUAqLwl
	XR46je7pmTvmRuJbRJGUK3F+oTzvJjhXYPdYwg2N1l4eV58qjSe2jTC33vA/kUx1xbEts4i
	+OJQc/QCsXIHLqfMB2Hkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DdzfAstBuoc=:BpAm9TND6rYC0RqcacCmw8
	iVqKHjbK4i+npwyE3yOdFDZ79qBR7A2akhOvV25y2bdoPz5MGpwzg7pn+y2mtBNHZ4mP22hv/
	AHpejVR/11TUcVT1lATXORLdROzzy1yXnb2SGdUFVCrB5OUj3VCwQnDS9BvboFt7f4ak3JBQB
	DOF56ZWAJ3xsN9vBy+4kiQfa1LP/2YvbUPpqDAIZRJ4IkGu5J4Pd9mX0N/zIpsOQOrb4QQMxK
	0J/2lL6h2A84csBDhjnJtyBh0ntGG1SLC1y5zVTwd84/0YCjG6WTi4TuMR7ldzd2VqH9IqKXU
	XGbxJfxBXQJf4MTI4wqG3Lc43bVRKjw/97seMT6sJ8rzoR1aGaZTwjXRZTrpvJsginFM82LS8
	Ld8le1eiTlswwVHAphMzfljHD0IoCiX1DfUjVwPsmqVUpIdDCdqF63FktUU6dW975caM6nRMK
	Q3z3HG2tkBr8Gv7ABSWoIAIoL01eEurDTWS9fTbCehZn84OWPR6evrpplFnEF5eLMzbhcYDSq
	ey8TmLElnRSKGGrAj6KND2HGAt2JUQUKfekQZscuNVwLprUw5CGOOXuQGUeEh5bLfrKK/rEEB
	ORZ7QgrNkTVnjzbn5BhNwKTmJbrJ2yn0BQ51XNm4OmIdDf3bhnneuwB5BX0mh6pdQmKeNtw2r
	W1lZ8DGIDvgZwis+ja5NtR2nE1W2v2DB8ZKbAzYWWS3G8u8T2IeXQI0JXdGj3icntbFbVv44F
	l/WyvAsj5ORWMj6w0Q1DmiPKLtUCGhFHQUaLh9u/hPR9IKH7I6C3hIhYU+0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Message-ID: <20190503112154.Agf6T1TKLu56jzVQtneo8pQKrGxVXh223yFMrva9pP0@z>

On 03/05/2019 13:18, Laurent Vivier wrote:
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
> 
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
> 
> for you to fetch changes up to 2d2023c3b99edb33ad4bb9791f70456ea1a1c049:
> 
>   sockets: avoid string truncation warnings when copying UNIX path (2019-05-03 13:03:04 +0200)
> 
> ----------------------------------------------------------------
> Pull request trivial branch 2019-05-03
> 
> ----------------------------------------------------------------
> 
> Aruna Jayasena (1):
>   Header cleanups
> 
> Daniel P. Berrangé (1):
>   sockets: avoid string truncation warnings when copying UNIX path
> 
> Dr. David Alan Gilbert (1):
>   configure: fix pam test warning
> 
> Marc-André Lureau (1):
>   doc: fix the configuration path
> 
> Philippe Mathieu-Daudé (3):
>   hw/net/pcnet: Use qemu_log_mask(GUEST_ERROR) instead of printf
>   Makefile: Let the 'clean' rule remove qemu-ga.exe on Windows hosts
>   hw/sparc/leon3: Allow load of uImage firmwares
> 
> Stefan Weil (1):
>   Update configure
> 
> Thomas Huth (1):
>   net: Print output of "-net nic, model=help" to stdout instead of
>     stderr
> 
> Wei Yang (3):
>   CODING_STYLE: specify the indent rule for multiline code
>   CODING_STYLE: indent example code as all others
>   qom: use object_new_with_type in object_new_with_propv
> 
>  qemu-ga.texi              |  4 ++--
>  configure                 |  5 ++---
>  Makefile                  | 11 +++++----
>  include/exec/cpu-common.h |  3 ---
>  hw/net/pcnet.c            |  4 +++-
>  hw/sparc/leon3.c          |  4 ++++
>  net/net.c                 |  7 +++---
>  qom/object.c              |  2 +-
>  util/qemu-sockets.c       | 12 ++++++----
>  CODING_STYLE              | 47 +++++++++++++++++++++++++++++++++++----
>  10 files changed, 74 insertions(+), 25 deletions(-)
> 

Forget this series, the send has been aborted for an unknown reason.

Thanks,
Laurent

