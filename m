Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E2CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D46F20768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D46F20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joiaS-0005WW-I6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1joiZd-00050h-0h; Fri, 26 Jun 2020 03:14:57 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1joiZa-0007pG-VK; Fri, 26 Jun 2020 03:14:56 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MfHIZ-1jDUHU3T11-00gszw; Fri, 26 Jun 2020 09:14:48 +0200
Subject: Re: [PATCH v2 00/22] ADB: fix autopoll issues and rework mac_via
 state machine
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, fthain@telegraphics.com.au
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bca1d4a8-de1c-89f6-3958-61a6f6aec77c@vivier.eu>
Date: Fri, 26 Jun 2020 09:14:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wZZPSAwDc7UZYMww/yhpOR6fHs/fCN1IAQ5OU6FpXcllMOcmD/S
 vgfLzaYm6eoVZGpFjpnxrw6GerzuOPQX1b0fh+gUg40Dc57e1L4gcN7/QOXMFsy9dGgkGKo
 JDbEnhRGEc3sIVgK3rfDif6kcnD8pvvryrAK71BlcE+bbGn/PSYIE2o+Ijsyqh8Y5099odY
 A4zKGv3aEDopVxTd88Oow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MWQi6QzLH+M=:dk9E4XImlAh1AwgqoTb4e9
 DXZfgryEnEoLHuzrgxp6OZOAHykFPyjyBUj28Hg+U5018XN/XiXNmc//uX11cbGJJO6fF0siX
 TkD8acpKCBB7U3PgNVsvBa8xtDWPU3wxUXzTi5yEVgTtoY/f8gqKR/TAd08Ywj/rwEJNQPprW
 EJcdvwEOTP6INiw6oakbDnNCHpcVMJWqxcM4MiScTBLuYBo5WfizkDFFhDUW9tURI80Jfe69e
 QPV+wwSrd2YUW5vxpmPAafNjId0eaAbaXVAIWd6whDzqYtZZDJGHI6V4Jbl323NFJIGAVpDyx
 +J/BcDeWeHuugAvO8gpn1cX01adzL6cWyzosul/5epwpvWvU+9TI71V/6SvC05fm4mDTdrrKF
 IM+YlsNt7YldHm60NW/NYF4BEy8DTlQaIBNSovaO8MJiiJK78KDX2qI7LFgxtCvm6db3Ukefy
 eSBTitkHLYoenzJu6E6u7uanrWnSd/3b0YNiaPNvh3nX3M5w802qK3RRSpLSdtPSIRwIaxzZC
 ySobz761im7uVhKzsvAqsD+zAIzwLHNHm6JVnbSDMMgufO8Dc632HqklzO4hDN4g9/OySKx7F
 xTIfX2Wpc3cQu2aFlscpjb6jpwpKHOuRXnllhtf1I/0CUwDGlLVsm/665F2NGeGlDGOT7SyKh
 eWN5+FKP0iPjoncW2/O1G0TfyeDWmm5z8UOjsNBvrjbIzWG8qR3THZpU1fRkWMsIUsAPd5BIx
 do5uyEc4pc2ecwK7cTewoRKSx4M91IOYL7Cx42s4CO/DXNsJ/1tpLkdhR2z6glI5kI1XRU0in
 p7mAZD4rKOPMo/dNergTww37tTe8TwmnO8nBNVhH7vie5M+x/XjZpkRMkcPpaXaQhaR8Bpa
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:14:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/06/2020 à 22:49, Mark Cave-Ayland a écrit :
> This patchset is something I have been chipping away at for a while since
> spending some time over the Christmas holidays trying to boot the MacOS
> toolbox ROM on the new q800 machine.
> 
> Initially I discovered that there were some problems when the MacOS ROM was
> enumerating ADB devices due to multiple meanings of the vADBInt bit. After
> fixing this there were still issues with keys being dropped during autopoll
> which were eventually traced back to the autopoll timer re-firing before
> the host had managed to read back the previous response.
> 
> At this point I noticed that CUDA/PMU/mac_via all had their own implementations
> of ADB autopoll, and that it would make sense to consolidate the autopoll timer,
> mask, interval and locking into the ADB bus. This would allow the logic to be
> removed from each separate device and managed in just one place.
> 
> Finally I updated the trace-events to allow separate tracing of bus requests
> and device responses which makes it easier to follow the ADB enumeration process.
> 
> The breakdown of the patchset is as follows:
> 
> - Patch 1 keeps checkpatch happy for the remainder of the patchset whilst patch
>   2 is the proper fix for a spurious ADB register 3 write during enumeration
>   caused by ignoring the request length which I had tried to work around earlier.
> 
> - Patches 3 to 10 are part of the autopoll consolidation process which moves the
>   separate autopoll implementations into a single implementation within
>   ADBBusState.
> 
> - Patches 11 to 13 update the ADB implementation to hold a status variable
>   indicating the result of the last request and allow devices to indicate
>   whether they have data to send. This extra information is required by the
>   upcoming mac_via state machine changes.
> 
> - Patches 14 to 17 add a variable and functions to block and unblock ADB
>   autopoll at bus level, adding the functions at the correct places within
>   CUDA and PMU.
> 
> - Patches 18 and 19 rework the mac_via ADB state machine so that the bus
>   can be enumerated correctly, and both explicit and autopoll requests work
>   under both MacOS and Linux.
> 
> - Patch 20 enforces the blocking and unblocking of autopoll at the ADB
>   level, including adding an assert() to prevent developers from trying to
>   make an ADB request whilst autopoll is in progress.
>   
> - Patches 21 and 22 update the trace-events to separate out ADB device and
>   ADB bus events.
> 
> The patch has been tested by myself and a couple of others during the development
> process across the PPC g3beige/mac99 and 68K q800 machine so it should be quite
> solid.
> 
> One thing to indicate is that the patchset bumps the VMState versions for the
> affected devices but does not allow older versions to load. This is a conscious
> decision given that for the mac_via device used in the q800 machine it would be
> just about impossible to map this in a way that would work for all cases. Similarly
> for the Mac PPC machines migration is already hit/miss due to timebase issues so
> I don't see this as being a big loss.
> 
> To finish off I'd also like to say a big thank-you to both Laurent Vivier and
> Finn Thain who both took time to answer my questions, dump information from a
> real q800, and analyse it in very fine detail. Without them this patchset would
> still be several months away.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> 
> v2:
> - Rebased onto master
> - Added R-B tags from Philippe
> - Fixed byte discrepency at end of bus timeout spotted by Finn
> - Added Tested-by tag from Finn
> 
> 
> Mark Cave-Ayland (22):
>   adb: coding style update to fix checkpatch errors
>   adb: fix adb-mouse read length and revert disable-reg3-direct-writes
>     workaround
>   cuda: convert ADB autopoll timer from ns to ms
>   pmu: fix duplicate autopoll mask variable
>   pmu: honour autopoll_rate_ms when rearming the ADB autopoll timer
>   adb: introduce realize/unrealize and VMStateDescription for ADB bus
>   adb: create autopoll variables directly within ADBBusState
>   cuda: convert to use ADBBusState internal autopoll variables
>   pmu: convert to use ADBBusState internal autopoll variables
>   mac_via: convert to use ADBBusState internal autopoll variables
>   adb: introduce new ADBDeviceHasData method to ADBDeviceClass
>   adb: keep track of devices with pending data
>   adb: add status field for holding information about the last ADB
>     request
>   adb: use adb_request() only for explicit requests
>   adb: add autopoll_blocked variable to block autopoll
>   cuda: add adb_autopoll_block() and adb_autopoll_unblock() functions
>   pmu: add adb_autopoll_block() and adb_autopoll_unblock() functions
>   mac_via: move VIA1 portB write logic into mos6522_q800_via1_write()
>   mac_via: rework ADB state machine to be compatible with both MacOS and
>     Linux
>   adb: only call autopoll callbacks when autopoll is not blocked
>   adb: use adb_device prefix for ADB device trace events
>   adb: add ADB bus trace events
> 
>  hw/input/adb-kbd.c           |  42 ++--
>  hw/input/adb-mouse.c         |  65 ++++--
>  hw/input/adb.c               | 210 ++++++++++++++++--
>  hw/input/trace-events        |  27 ++-
>  hw/misc/mac_via.c            | 411 +++++++++++++++++++++++------------
>  hw/misc/macio/cuda.c         |  60 +++--
>  hw/misc/macio/pmu.c          |  47 ++--
>  hw/misc/trace-events         |   3 +
>  hw/ppc/mac_newworld.c        |   2 -
>  include/hw/input/adb.h       |  26 ++-
>  include/hw/misc/mac_via.h    |   2 +-
>  include/hw/misc/macio/cuda.h |   4 -
>  include/hw/misc/macio/pmu.h  |   4 -
>  13 files changed, 620 insertions(+), 283 deletions(-)
> 

Acked-by: Laurent Vivier <laurent@vivier.eu>

