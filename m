Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA61EC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC5C223B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC5C223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOgt-0003AP-Ty
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 10:04:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGOfQ-0002Wd-H3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGOfO-0002E7-W2
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hGOfO-0002Dx-OF
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:02:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 060FE30B96C1;
	Tue, 16 Apr 2019 14:02:30 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-171.rdu2.redhat.com
	[10.10.120.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5345360159;
	Tue, 16 Apr 2019 14:02:20 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2af5fa7d-bbdc-a3c7-23da-dd00dd1ed351@redhat.com>
Date: Tue, 16 Apr 2019 16:02:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 16 Apr 2019 14:02:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Joachim Durchholz <jo@durchholz.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416140219._t75cY-VPq8ImGCkJ4vcb7WCxNUSkMSEPTycH05s-SA@z>

On 04/16/19 09:24, Gerd Hoffmann wrote:
> On Mon, Apr 15, 2019 at 03:10:09PM -0400, John Snow wrote:
>> <CC'ing curses maintainer>
>>
>> On 4/13/19 5:02 AM, Joachim Durchholz wrote:
>>> Hi all,
>>>
>>> what's the reasoning behind "We need a terminal output" in curses.c?
> 
> curses needs a terminal.
> 
>>> I don't really see a scenario where it's problematic if qemu emits
>>> escape sequences to a pipe.
> 
> It's not about sending escape sequences.  A pipe simply doesn't support
> all the tty ioctls (query terminal size, turn echo on/off, set all kinds
> of terminal modes, ...).

(

Indeed, it's called the "General Terminal Interface".

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap11.html

)

>>> I can see another scenario when this is problematic: Unit testing code
>>> that directly writes to the console. E.g. testing BIOS code, or testing
>>> operating systems when using the serial port is not an option.
> 
> seabios can work with the serial console just fine, try "qemu -nographic"
> 
> cheers,
>   Gerd
> 
> 


