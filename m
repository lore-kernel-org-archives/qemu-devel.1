Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3B6FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E8E2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E8E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiDA-0006xn-OE
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iKiCI-0006S8-7f
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iKiCH-00029T-3g
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:14:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1iKiCE-00028J-DL; Wed, 16 Oct 2019 08:14:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81FF27EB88;
 Wed, 16 Oct 2019 12:14:28 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-232.ams2.redhat.com
 [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6CF1001B08;
 Wed, 16 Oct 2019 12:14:18 +0000 (UTC)
Subject: Re: [SeaBIOS] Re: [PATCH v7 7/8] bootdevice: FW_CFG interface for
 LCHS values
To: Sam Eiderman <sameid@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
 <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
 <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
 <CAFr6bUnsxhqBqHgRdw3dtv0rEvfCVn0oM4XD8Vb1xv_UGKvepg@mail.gmail.com>
 <CAFr6bUm53A+gBVBRr00XKDkt=GiJ5QSOEEXPFfuUJ2PcLeG04w@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bf6ff260-f8ca-a593-dd3e-e78fa0551101@redhat.com>
Date: Wed, 16 Oct 2019 14:14:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFr6bUm53A+gBVBRr00XKDkt=GiJ5QSOEEXPFfuUJ2PcLeG04w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 16 Oct 2019 12:14:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, kraxel@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sam,

On 10/16/19 13:02, Sam Eiderman wrote:
> Gentle Ping,
>
> Philippe, John?
>
> Just wondering if the series is okay, as Gerd pointed out this series
> is a blocker for the corresponding changes in SeaBIOS for v 1.13

The QEMU series is still not merged, due to a bug in the last patch
(namely, the test case, "hd-geo-test: Add tests for lchs override").

To my knowledge, SeaBIOS prefers to merge patches with the underlying
QEMU patches merged first, so you'll likely have to fix that QEMU issue
first.

I explained the bug in the QEMU test case here:

  http://mid.mail-archive.com/6b00dc74-7267-8ce8-3271-5db269edb1b7@redhat.com
  http://mid.mail-archive.com/700cd594-1446-e478-fb03-d2e6b862dc6c@redhat.com

(Alternative links to the same:

  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01790.html
  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01793.html
)

I've never received feedback to those messages, and I think you must
have missed them.

FWIW, when I hit "Reply All" in that thread, you were on the "To:" list
with:

  Sam Eiderman <shmuel.eiderman@oracle.com>

but here you are present with

  Sam Eiderman <sameid@google.com>

In addition, when I posted those messages, I got the following
auto-response ("Undelivered Mail Returned to Sender"):

> This is the mail system at host mx1.redhat.com.
>
> I'm sorry to have to inform you that your message could not
> be delivered to one or more recipients. It's attached below.
>
> For further assistance, please send mail to postmaster.
>
> If you do so, please include this problem report. You can
> delete your own text from the attached returned message.
>
>                    The mail system
>
> <shmuel.eiderman@oracle.com>: host
> aserp2030.oracle.com[141.146.126.74] said:
>     550 5.1.1 Unknown recipient address. (in reply to RCPT TO command)

I didn't know your new address, so I could only hope you'd find my
feedback on qemu-devel.

Thanks
Laszlo

