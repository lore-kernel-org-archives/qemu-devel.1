Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB74C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABD021BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABD021BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLLA-0008Fv-6A
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hvLKA-00078V-EH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hvLK9-0003gS-6r
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hvLK8-0003dT-U3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:45:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CE018FAB4;
 Wed,  7 Aug 2019 12:45:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC71C5D9CD;
 Wed,  7 Aug 2019 12:45:43 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190803082517.15035-1-philmd@redhat.com>
 <CAFEAcA_cPDdwXkSra_8vxE8c9M2y91s5FvpB7sZh12xF-LPUWA@mail.gmail.com>
 <a4158e8a-d67f-52b5-c082-681d21ac2599@redhat.com>
 <19158743-5f00-f89c-d9af-5b991a581b6c@redhat.com>
 <CAFEAcA9zm-JXkzG05oHAfXQpEnW4x+Bi13TA7Hr1KQtEXSHWvg@mail.gmail.com>
 <9625d2b7-e61f-ead6-78ef-e2ca7b88b878@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c4221994-f66d-8d51-ea9b-444b98857c70@redhat.com>
Date: Wed, 7 Aug 2019 14:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9625d2b7-e61f-ead6-78ef-e2ca7b88b878@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 07 Aug 2019 12:45:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/1] EDK2 firmware patches
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
Cc: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/19 16:29, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/5/19 4:14 PM, Peter Maydell wrote:
>> On Mon, 5 Aug 2019 at 15:11, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 8/5/19 3:13 PM, Michal Pr=C3=ADvozn=C3=ADk wrote:
>>>> On 8/3/19 12:22 PM, Peter Maydell wrote:
>>>>> On Sat, 3 Aug 2019 at 09:26, Philippe Mathieu-Daud=C3=A9 <philmd@re=
dhat.com> wrote:
>>>>>>
>>>>>> The following changes since commit 9bcf2dfa163f67b0fec6ee0fe88ad5d=
c5d69dc59:
>>>>>>
>>>>>>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-CVE-201=
9-14378-pull-request' into staging (2019-08-02 13:06:03 +0100)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20190803
>>>>>>
>>>>>> for you to fetch changes up to 177cd674d6203d3c1a98e170ea56c5a904a=
c4ce8:
>>>>>>
>>>>>>   Makefile: remove DESTDIR from firmware file content (2019-08-03 =
09:52:32 +0200)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> A harmless build-sys patch that fixes a regression affecting Linux
>>>>>> distributions packaging QEMU.
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>>
>>>>>> Olaf Hering (1):
>>>>>>   Makefile: remove DESTDIR from firmware file content
>>>>>
>>>>> Is this pullreq intended for 4.1 ?
>>>
>>> Sorry, I was not sure how to comment on the pullreq cover (everything
>>> between the '---' lines get include in the merge commit description).
>>
>> Depends on your workflow. For me my pull-request-creation
>> script creates a bunch of files which will be the emails
>> to be sent out, and I can manually edit the 'cover letter'
>> email before sending everything.
>=20
> OK (I don't want to give you extra manual work).
>=20
>>> This fix a regression introduced during the current development cycle=
.
>>> Already 3 different distributions hit this issue and complained (Suse=
,
>>> ArchLinux and Fedora).
>>> This is not a critical/security issue and distributions can easily
>>> backport this patch, but since there is a RC4 planned, it would be ni=
ce
>>> regarding distributors to fix this if possible.
>>
>> OK, sounds good -- I just wanted to check. I've pushed the
>> pullreq to master.
>=20
> Thank you!
>=20

Thank you all, I've updated <https://bugs.launchpad.net/qemu/+bug/1838703=
>.

Laszlo

