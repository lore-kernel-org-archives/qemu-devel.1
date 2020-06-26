Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7219C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7871920768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7871920768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joj8o-0003Lc-O7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joj80-0002kN-V6; Fri, 26 Jun 2020 03:50:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:33966
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joj7y-0000MN-I8; Fri, 26 Jun 2020 03:50:28 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joj7u-00079U-AK; Fri, 26 Jun 2020 08:50:27 +0100
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, fthain@telegraphics.com.au
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
 <bca1d4a8-de1c-89f6-3958-61a6f6aec77c@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <7384413a-e596-df0f-09fa-6b7fac5d004b@ilande.co.uk>
Date: Fri, 26 Jun 2020 08:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bca1d4a8-de1c-89f6-3958-61a6f6aec77c@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 00/22] ADB: fix autopoll issues and rework mac_via
 state machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 26/06/2020 08:14, Laurent Vivier wrote:

> Le 23/06/2020 à 22:49, Mark Cave-Ayland a écrit :
>> This patchset is something I have been chipping away at for a while since
>> spending some time over the Christmas holidays trying to boot the MacOS
>> toolbox ROM on the new q800 machine.
>>
>> Initially I discovered that there were some problems when the MacOS ROM was
>> enumerating ADB devices due to multiple meanings of the vADBInt bit. After
>> fixing this there were still issues with keys being dropped during autopoll
>> which were eventually traced back to the autopoll timer re-firing before
>> the host had managed to read back the previous response.
>>
>> At this point I noticed that CUDA/PMU/mac_via all had their own implementations
>> of ADB autopoll, and that it would make sense to consolidate the autopoll timer,
>> mask, interval and locking into the ADB bus. This would allow the logic to be
>> removed from each separate device and managed in just one place.
>>
>> Finally I updated the trace-events to allow separate tracing of bus requests
>> and device responses which makes it easier to follow the ADB enumeration process.
>>
>> The breakdown of the patchset is as follows:
>>
>> - Patch 1 keeps checkpatch happy for the remainder of the patchset whilst patch
>>   2 is the proper fix for a spurious ADB register 3 write during enumeration
>>   caused by ignoring the request length which I had tried to work around earlier.
>>
>> - Patches 3 to 10 are part of the autopoll consolidation process which moves the
>>   separate autopoll implementations into a single implementation within
>>   ADBBusState.
>>
>> - Patches 11 to 13 update the ADB implementation to hold a status variable
>>   indicating the result of the last request and allow devices to indicate
>>   whether they have data to send. This extra information is required by the
>>   upcoming mac_via state machine changes.
>>
>> - Patches 14 to 17 add a variable and functions to block and unblock ADB
>>   autopoll at bus level, adding the functions at the correct places within
>>   CUDA and PMU.
>>
>> - Patches 18 and 19 rework the mac_via ADB state machine so that the bus
>>   can be enumerated correctly, and both explicit and autopoll requests work
>>   under both MacOS and Linux.
>>
>> - Patch 20 enforces the blocking and unblocking of autopoll at the ADB
>>   level, including adding an assert() to prevent developers from trying to
>>   make an ADB request whilst autopoll is in progress.
>>   
>> - Patches 21 and 22 update the trace-events to separate out ADB device and
>>   ADB bus events.
>>
>> The patch has been tested by myself and a couple of others during the development
>> process across the PPC g3beige/mac99 and 68K q800 machine so it should be quite
>> solid.
>>
>> One thing to indicate is that the patchset bumps the VMState versions for the
>> affected devices but does not allow older versions to load. This is a conscious
>> decision given that for the mac_via device used in the q800 machine it would be
>> just about impossible to map this in a way that would work for all cases. Similarly
>> for the Mac PPC machines migration is already hit/miss due to timebase issues so
>> I don't see this as being a big loss.
>>
>> To finish off I'd also like to say a big thank-you to both Laurent Vivier and
>> Finn Thain who both took time to answer my questions, dump information from a
>> real q800, and analyse it in very fine detail. Without them this patchset would
>> still be several months away.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>>
>> v2:
>> - Rebased onto master
>> - Added R-B tags from Philippe
>> - Fixed byte discrepency at end of bus timeout spotted by Finn
>> - Added Tested-by tag from Finn
>>
>>
>> Mark Cave-Ayland (22):
>>   adb: coding style update to fix checkpatch errors
>>   adb: fix adb-mouse read length and revert disable-reg3-direct-writes
>>     workaround
>>   cuda: convert ADB autopoll timer from ns to ms
>>   pmu: fix duplicate autopoll mask variable
>>   pmu: honour autopoll_rate_ms when rearming the ADB autopoll timer
>>   adb: introduce realize/unrealize and VMStateDescription for ADB bus
>>   adb: create autopoll variables directly within ADBBusState
>>   cuda: convert to use ADBBusState internal autopoll variables
>>   pmu: convert to use ADBBusState internal autopoll variables
>>   mac_via: convert to use ADBBusState internal autopoll variables
>>   adb: introduce new ADBDeviceHasData method to ADBDeviceClass
>>   adb: keep track of devices with pending data
>>   adb: add status field for holding information about the last ADB
>>     request
>>   adb: use adb_request() only for explicit requests
>>   adb: add autopoll_blocked variable to block autopoll
>>   cuda: add adb_autopoll_block() and adb_autopoll_unblock() functions
>>   pmu: add adb_autopoll_block() and adb_autopoll_unblock() functions
>>   mac_via: move VIA1 portB write logic into mos6522_q800_via1_write()
>>   mac_via: rework ADB state machine to be compatible with both MacOS and
>>     Linux
>>   adb: only call autopoll callbacks when autopoll is not blocked
>>   adb: use adb_device prefix for ADB device trace events
>>   adb: add ADB bus trace events
>>
>>  hw/input/adb-kbd.c           |  42 ++--
>>  hw/input/adb-mouse.c         |  65 ++++--
>>  hw/input/adb.c               | 210 ++++++++++++++++--
>>  hw/input/trace-events        |  27 ++-
>>  hw/misc/mac_via.c            | 411 +++++++++++++++++++++++------------
>>  hw/misc/macio/cuda.c         |  60 +++--
>>  hw/misc/macio/pmu.c          |  47 ++--
>>  hw/misc/trace-events         |   3 +
>>  hw/ppc/mac_newworld.c        |   2 -
>>  include/hw/input/adb.h       |  26 ++-
>>  include/hw/misc/mac_via.h    |   2 +-
>>  include/hw/misc/macio/cuda.h |   4 -
>>  include/hw/misc/macio/pmu.h  |   4 -
>>  13 files changed, 620 insertions(+), 283 deletions(-)
>>
> 
> Acked-by: Laurent Vivier <laurent@vivier.eu>

Thanks Laurent! I know David is busy at the moment, but he's fine with the Mac PPC
changes so I'll add your A-B tag and send a PR shortly.


ATB,

Mark.

