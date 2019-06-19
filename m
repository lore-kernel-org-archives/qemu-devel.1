Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9634C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8D720851
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8D720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdkKh-0006M1-89
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 19:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hdkJ5-00052u-2R
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hdkBd-0001DA-7e
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hdkBZ-00015A-9x
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:40:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14647307D910;
 Wed, 19 Jun 2019 23:40:10 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-91.ams2.redhat.com
 [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74D6019C5B;
 Wed, 19 Jun 2019 23:40:09 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190614202333.19355-1-lersek@redhat.com>
 <CAFEAcA9PcTTagxUcxba-_qFsC97T6uEe927akjj-G4na22rf6g@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <eecc2b21-c860-9071-4322-a9fbb40a40e1@redhat.com>
Date: Thu, 20 Jun 2019 01:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PcTTagxUcxba-_qFsC97T6uEe927akjj-G4na22rf6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 19 Jun 2019 23:40:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/6] update edk2 submodule & binaries to
 edk2-stable201905
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/17/19 12:54, Peter Maydell wrote:
> On Fri, 14 Jun 2019 at 21:25, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> The following changes since commit f3d0bec9f80e4ed7796fffa834ba0a53f2094f7f:
>>
>>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-14' into staging (2019-06-14 14:46:13 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/lersek/qemu.git tags/edk2-pull-2019-06-14
>>
>> for you to fetch changes up to 541617cad3445fdc6735e9e5752e1f698e337737:
>>
>>   pc-bios: update the README file with edk2-stable201905 information (2019-06-14 21:48:00 +0200)
>>
>> ----------------------------------------------------------------
>> edk2-stable201905 was released on 2019-06-06:
>>
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201905
>>
>> Advance QEMU's edk2 submodule to edk2-stable201905, and rebuild the
>> firmware binaries. This should be the edk2 release that goes into QEMU
>> 4.1.
>>
>> Launchpad: https://bugs.launchpad.net/qemu/+bug/1831477
> 
> 
> Applied, thanks.

Thanks!

> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
> for any user-visible changes.

Done.

Laszlo

