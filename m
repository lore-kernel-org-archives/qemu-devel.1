Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D05C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B60E2063F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B60E2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=durchholz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGSSs-0008CA-J7
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 14:05:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hGSRT-0007MB-Kn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hGSRN-0003ey-PP
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:04:21 -0400
Received: from 5.itsy.de ([188.40.84.14]:50319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hGSRL-0003Y0-O1
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:04:15 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 614546505E
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 20:04:08 +0200 (CEST)
To: qemu-devel@nongnu.org
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
Date: Tue, 16 Apr 2019 20:04:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.40.84.14
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416180408.2i-_S88fpKnhJOGEO4Mg471Edoie505LMj2uhcVnCMk@z>

Am 16.04.19 um 09:24 schrieb Gerd Hoffmann:
> On Mon, Apr 15, 2019 at 03:10:09PM -0400, John Snow wrote:
>> <CC'ing curses maintainer>
>>
>> On 4/13/19 5:02 AM, Joachim Durchholz wrote:
>>> Hi all,
>>>
>>> what's the reasoning behind "We need a terminal output" in curses.c?
> 
> curses needs a terminal.

I commented out the check, and guess what: qemu and the OS in the VM 
would run just fine.

>>> I don't really see a scenario where it's problematic if qemu emits
>>> escape sequences to a pipe.
> 
> It's not about sending escape sequences.  A pipe simply doesn't support
> all the tty ioctls (query terminal size, turn echo on/off, set all kinds
> of terminal modes, ...).

Then I don't understand why it just ran fine.
I don't expect fullscreen output to work perfectly anyway; just enough 
so I can use qemu expect-style.

Also, is qemu -curses actually using all the terminal shenanigans?
I don't think so. If it is, it's not really needed it seems, things work 
fine.

>>> I can see another scenario when this is problematic: Unit testing code
>>> that directly writes to the console. E.g. testing BIOS code, or testing
>>> operating systems when using the serial port is not an option.
> 
> seabios can work with the serial console just fine, try "qemu -nographic"

Well, can you tell me how convince any *BSD to talk to seabios intead of 
to the terminal...

Regards,
Jo

