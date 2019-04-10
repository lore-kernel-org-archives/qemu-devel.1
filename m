Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556FFC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DCA2077C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DCA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35533 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEHnI-0007Ho-DW
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 14:17:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEHmJ-0006uM-Mg
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEHmI-0001Qw-LM
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hEHmG-0001JC-LX; Wed, 10 Apr 2019 14:16:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBB4D33025E;
	Wed, 10 Apr 2019 18:16:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-133.rdu2.redhat.com
	[10.10.121.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B5F11001E67;
	Wed, 10 Apr 2019 18:16:47 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-trivial@nongnu.org, qemu-devel@nongnu.org
References: <20190410045707.16923-1-philmd@redhat.com>
	<e52ff725-a297-5b3c-af7a-1df30baf464f@redhat.com>
	<94d17504-2366-c5c9-59ee-a958e9dc0b82@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <78374d70-fa22-73a0-823e-9d483b91d008@redhat.com>
Date: Wed, 10 Apr 2019 20:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <94d17504-2366-c5c9-59ee-a958e9dc0b82@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 10 Apr 2019 18:16:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] roms: Correct the
 EDK2_BASETOOLS_OPTFLAGS variable description
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
Message-ID: <20190410181646.5HM2W2QQ9uyyCmkdUC8EKSgP9vZh7zEa0w9ERG5e2xE@z>

On 04/10/19 17:10, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/10/19 4:58 PM, Laszlo Ersek wrote:
>> On 04/10/19 06:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>> In commit 1cab464136b4 we incorrectly described the
>>> EDK2_BASETOOLS_OPTFLAGS can pass CPPFLAGS and CFLAGS
>>> options to the EDK2 build tools, but it only expands
>>> the CFLAGS (not to the CPPFLAGS).
>>> Update the description to be more accurate.
>>>
>>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>  roms/Makefile | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/roms/Makefile b/roms/Makefile
>>> index 1ff78b63bb3..d7fd6025e7c 100644
>>> --- a/roms/Makefile
>>> +++ b/roms/Makefile
>>> @@ -120,8 +120,8 @@ build-efi-roms: build-pxe-roms
>>>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>>>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>>> =20
>>> -# Build scripts can pass compiler/linker flags to the EDK2 build too=
ls
>>> -# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
>>> +# Build scripts can pass compiler/linker flags to the EDK2
>>> +# build  tools via the EDK2_BASETOOLS_OPTFLAGS (CFLAGS) and
>>>  # EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
>>>  #
>>>  # Example:
>>>
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>
>> Please noone submit a pull request with this patch (for 4.1) until my
>> edk2 bundling series is merged; as this one will likely introduce
>> another contextual conflict, and I'd *really* like to avoid another
>> rebase on my end, due to such an issue.
>=20
> Thanks for the review. I'll rebase it on top of your 'bundle edk2
> platform firmware with QEMU' v4 and resend (later).

Thank you!

> Feel free to include it on top of your pullreq.

... I think I'll keep that pullreq as minimal as it can be. :)

Thanks
Laszlo

>=20
> Regards,
>=20
> Phil.
>=20


