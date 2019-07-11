Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7121BC74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454882084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454882084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYVT-0000KQ-Hn
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ari@tuxera.com>) id 1hlYU6-0007sP-Pd
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ari@tuxera.com>) id 1hlYU5-0002GC-NY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:47:38 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:55352)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ari@tuxera.com>) id 1hlYU5-0002DC-BC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:47:37 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
 by mgw-02.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id x6BCkEXk008827;
 Thu, 11 Jul 2019 15:47:30 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-02.mpynet.fi with ESMTP id 2tjfb8y4tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2019 15:47:30 +0300
Received: from [192.168.110.208] (194.100.106.190) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Jul 2019 15:47:29 +0300
To: Sebastian Audet <smaudet2@gmail.com>, <qemu-devel@nongnu.org>
References: <CAB8WYtoXtTxS18a6iOUfQKUFiaiz08jy69eQF3xp4nxoFsx4Mw@mail.gmail.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <28fad998-5c40-3d16-ebda-97bcb2ac4f27@tuxera.com>
Date: Thu, 11 Jul 2019 15:47:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAB8WYtoXtTxS18a6iOUfQKUFiaiz08jy69eQF3xp4nxoFsx4Mw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-11_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907110145
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 82.197.21.91
Subject: Re: [Qemu-devel] Use Case for Qemu BT
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

Hi!

On 7/8/19 4:46 AM, Sebastian Audet wrote:
> So...this is not really a use-case per-say as it is actually a thing I
> would like to do but can't at present...
> 
> Win 10 is lacking an ad2p sink and this means if I'm using it to play a
> windows-only game and want to stream from e.g. my phone to my computer, I
> can't (natively). Enter Linux, which mostly ignores most of the crazy crap
> from MS... and VirtualBox which can see my bluetooth adapter, relay to the
> audio outputs, problem solved (yay? - well I also had to modify a kernel
> parameter and some config files, but it worked at least)!
> 
> So anyhow, the bluetooth stuff not working from qemu is a bit of a shame -
> VBox is bad at virtualizing stuff I guess unless the OS explicitly says
> "hey I support this!" and I was hoping to use a super-light-weight distro
> to solve my problem, not the mega-behemoths such as Manjaro, Ubuntu,
> Fedora...
> 
> I'm not familiar with the project, so I don't know, but it seems like this
> shouldn't have changed very much, and probably should just work? The only
> way I know bit-rot happens at the protocol layer is that a bunch of
> developers made a bunch of changes they didn't have any business making, or
> the original code wasn't written very well to begin with...
> 
> Anyhow, cheers. Hope to see BT live in Qemu again someday!
> 

Can you elaborate on your desired setup a bit more? Are you intending to 
use a Linux guest on a Windows host to view gaming streams - or the 
other way around?

Anyway, how is your Bluetooth adapter connected to the host computer? It 
may be possible to pass-through the adapter to the guest OS, allowing it 
to use the adapter using its native drivers.

Best regards,
Ari Sundholm
ari@tuxera.com

