Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB410C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FD12231A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FD12231A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX81h-0004f3-Ng
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 13:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iX80m-0003ta-5G
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iX80k-0003Zz-Nv
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:13:59 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iX80k-0003Z4-Ek
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:13:58 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2wCg-1iYEzp2Fae-003KTm; Tue, 19 Nov 2019 19:13:33 +0100
To: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Message-ID: <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
Date: Tue, 19 Nov 2019 19:13:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rUXsme/4k7X+76RDwSbP95sPOm9EP+vhpSZpTMqzQfRL0uwjINV
 LC2cQ253VA7a1600F43Y1Ar22g5+jh1BzhxRUjlndSxNN7njih8c7V/Ghs8jag6uyl/4SgH
 6vKBY0R2N3L0fQaoKku+3YD+A/v3YETWpXta1+wsWJJY1zKFQ82eIo8QktTnsEZhEGjG0p9
 0NN3BDkB6P6ZPuMKc9HKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y3S1qJAxpY8=:RdW9PriJoDq3c9DCIiUeA9
 l6VUwx9qsifTPPesErsvbNDvouQPGE93T5tjgx4pF5VwTa6r6TcI15OLWJB+Vp+Fz05hybQ2R
 R678++3WPxn0PQWAyo4qP+CmMzgSoQvceirQxgqa3ShXCaPQACR9Ds7BFOQouLpdeTtafb5Id
 35RUZMVxfaDXYBrriJUSxkusIyJgMDHkZf9hIV+oeoBNv6sIMZvIqNaIGFUYTGv40N6ucE8vK
 5QzYYykIFyaCR+W0hhAeS2Jfu8e201GoCW/+neLukvcLAmItpLm+Tyqd0bgiGXJfBlWwYns6L
 O167ZvJlG+ywvpYHeSD1px+gwZ1glUGpI6X4/DrF6zh3X/kif4mbjr43vrH44xYg3fESjGbK5
 gJfjnCteVkDcUG+hYxi+PhP0IGpnOOy6ItAn5WDRdbdDLLs9/zaP9xX8zWh4ycATaQPl/5adx
 MxZuyf487IjsoL24hltsSG3mOSU9zsmVT1iylUlsE9iS9Xwaxs4NTehv1TJwpW2HA/lc6OgYz
 CAU5I6Tpbiw/TFFYWGrxF4OwWcMARo/UMX3yU3/gihjt7ARmAMTs0CP4tUcvkumTTqUeJRlHk
 ma9OH5hYt9XvmD/NBdgLFH4aaqbl/G88gUxCY7IVqSNrym5JpRr/SSfwz2IzAERbcywhk+d2n
 p50jP+X0pAsT+c4LtJLImBjUF9QBzZIakwywJHA7MpCQdION0hAUicm9x2heZXqIXS4aOj+NO
 b94/nv3exnAMU85N6XBWNhVexPmbCuaqDWBjBzGbR0Zh47pdfiq7HxMK+ME8Xsw317j98PBNf
 uevE7b5rz7HqjL5W+CJGTfgVVrn98gGSPY55283uVB3DFHejUHyCCqUulQe/ENmy4qrWw+sXU
 6yrZ4zklpRDZTEFGJAVP29hmt3ZelgQfGOHtHIDBk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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

Le 19/11/2019 à 18:22, Taylor Simpson a écrit :
> Thanks for all the feedback on the patch.  I'll summarize my TODO list here.  Please let me know if there's anything I missed.
> - Add a README file in the imported directory to make it clear that the code comes from another project.  Personally, I prefer keeping the name as "imported".  It was suggested by Richard at the meeting.  Also as a heads-up, that is a small subset of the files that will be in that directory eventually.  Right now, it is the minimum needed to build the skeleton target.
> - Work on the .checkpatchignore as Philippe suggested.
> - Split out the "[__SIGRTMAX - 1] = __SIGRTMIN + 1" into a separate patch.
> - Clean up the long subject line.
> - Add license text to the new files.
> - Remove the DEBUG_HEX blocks.  In general the DEBUG_HEX macro controls a bunch of debugging output as you'll see in later patches.  In the long run, I think it should be replaces with a macro that is defined when configured with --enable-debug and then an additional command-line argument.  I haven't looked into this, so any pointers would be appreciated.

You can have a look to the trace infrastructure
(docs/devel/tracing.txt). We have also some qemu_log() macros for low
level debugging.

> - Laurent suggested I split the patch into two parts: linux-user and target/hexagon.  If I do that, which one should contain the changes to common files (e.g., configure)?  Also, note that we won't be able to build until both patches are merged.  Is that OK?

You should add target/hexagon first, and it should not be build as we
don't have any target (hexagon-linux-user or hexagon-softmmu),
then you can add linux-user part that will be built and use the
target/hexagone CPU. I think the configure part should go to the
linux-user part as it enables the build.

I asked to split the patch for review purpose, but this should not break
anything (to allow bisect).

Thanks,
Laurent

> 
> Thanks,
> Taylor
> 
> 
> -----Original Message-----
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> Sent: Tuesday, November 19, 2019 9:19 AM
> To: Taylor Simpson <tsimpson@quicinc.com>; laurent@vivier.eu; riku.voipio@iki.fi; qemu-devel@nongnu.org
> Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches - linux-user changes + linux-user/hexagon + skeleton of target/hexagon - Files in target/hexagon/imported are from another project and therefore do not conform to qemu coding standards
> 
> -------------------------------------------------------------------------
> CAUTION: This email originated from outside of the organization.
> -------------------------------------------------------------------------
> 
> On 11/19/19 12:58 AM, Taylor Simpson wrote:
>> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
>> ---
> [...]
>>   target/hexagon/imported/global_types.h      |  25 +++
>>   target/hexagon/imported/iss_ver_registers.h | 183 +++++++++++++++
>>   target/hexagon/imported/max.h               |  78 +++++++
>>   target/hexagon/imported/regs.h              |  19 ++
> 
> Maybe you can rename this directory as:
> 
> target/hexagon/dsp-sdk/
> 
> and add a README "Files under this directory are imported from the SDK available once registered on developer.qualcomm.com ..."
> 
> 


