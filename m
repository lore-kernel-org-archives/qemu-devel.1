Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D01C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB901214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB901214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=durchholz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBpw-0002g3-1U
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:32:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hHBR2-0006oW-OE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hHBQy-0004pl-VX
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:06:54 -0400
Received: from 5.itsy.de ([188.40.84.14]:59843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hHBQt-0004Yj-RT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:06:48 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 8428B2C8C5D
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:06:32 +0200 (CEST)
To: qemu-devel@nongnu.org
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
	<00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
	<20190417071012.fxedabu3makmoyuz@sirius.home.kraxel.org>
	<993002d4-28dd-00f0-e8c1-7b0d9ab2de12@durchholz.org>
	<4ce336d0-6651-286f-07ee-3a5b3236309a@redhat.com>
	<55326d4f-d7a9-cf38-20ff-846d7d3d64fd@durchholz.org>
	<388b90ee-cb50-0a2d-3675-e7e8b37adcd4@redhat.com>
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <2c18854c-4728-942b-3a3f-77c0bb88244e@durchholz.org>
Date: Thu, 18 Apr 2019 20:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <388b90ee-cb50-0a2d-3675-e7e8b37adcd4@redhat.com>
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
Message-ID: <20190418180632.omI-VMGWa-BdE2gYZnf3UvtK-IkR_NLglT8kx516yFE@z>

Am 18.04.19 um 13:02 schrieb Laszlo Ersek:
> On 04/18/19 07:02, Joachim Durchholz wrote:
>> Am 17.04.19 um 20:27 schrieb Laszlo Ersek:
>>> So, let's look at your original question again (which was not a problem
>>> statement):
>>
>> So you need an explicit problem statement to know that somebody might
>> have a problem?
> 
> You're on a technical mailing list. An explicit problem statement is
> instrumental for subscribers to understand the particulars of the
> problem.

Yeah okay, another person who prefers to dismiss points raised on the 
basis of formalities.
The technical term for that behaviour is "passive-aggressive behaviour", 
and I have seen enough of that.

As I said, I have stayed to answer questions that show genuine interest 
- that's not the case, so I'm off.

/logoff

