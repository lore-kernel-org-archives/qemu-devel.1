Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E706C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6217205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6217205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38518 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONxF-00018p-6W
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:53:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hONrn-0005lJ-M6
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hONrm-0004Ra-Kz
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hONrm-0004RM-Dj; Wed, 08 May 2019 10:48:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91B65C0578FA;
	Wed,  8 May 2019 14:48:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ED42C5DD8A;
	Wed,  8 May 2019 14:48:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7141F1132B35; Wed,  8 May 2019 16:48:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
	<87sgtv4wjo.fsf@zen.linaroharston> <87imulaude.fsf@dusky.pond.sub.org>
Date: Wed, 08 May 2019 16:48:13 +0200
In-Reply-To: <87imulaude.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 08 May 2019 16:33:33 +0200")
Message-ID: <87ftpp9f4i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 08 May 2019 14:48:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Thu, 2 May 2019 at 19:58, Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511=
e41df:
>>>>
>>>>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-reque=
st' into staging (2019-05-02 12:04:51 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>>>
>>>> for you to fetch changes up to f7c03a68b814254df414977ff299468fbf0fa1c=
0:
>>>>
>>>>   sockets: avoid string truncation warnings when copying UNIX path (20=
19-05-02 20:50:47 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> Pull request trivial branch 2019-05-02
>>>>
>>>> ----------------------------------------------------------------
>>>
>>> Markus's "Clean up includes" patch breaks 'make check' on
>>> big-endian hosts:
>>> cd /home/pm215/qemu/build/all/tests/fp && ./fp-test -s -l 1 -r all  i32=
_to_f16 i
>>> 64_to_f16 i32_to_f32 i64_to_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_t=
o_f128 >
>>>  int-to-float.out 2>&1 || (cat  int-to-float.out && exit 1;)
>>>>> Testing i32_to_f16, rounding near_even
>>> ^M372 tests total.
>>> ^M372 tests performed.
>>> In 372 tests, no errors found in i32_to_f16, rounding near_even.
>>>>> Testing i32_to_f16, rounding minMag
>>> [...]
>>> ^MErrors found in i32_to_f128:
>>> 1006FFFF  =3D> +0000.000000000000401B006FFFF00000 .....
>>>         expected +401B.006FFFF000000000000000000000 .....
>>> ^M0001DDEB  =3D> +0000.000000000000400FDDEB00000000 .....
>>>         expected +400F.DDEB000000000000000000000000 .....
>>> ^MFFF6FFFC  =3D> +0000.000000000000C012200080000000 .....
>>>         expected -4012.2000800000000000000000000000 .....
>>> ^MFFFFFFF8  =3D> +0000.000000000000C002000000000000 .....
>>>         expected -4002.0000000000000000000000000000 .....
>>> [etc]
>>
>> Considering the header clean-ups moved bswap related stuff and the
>> patterns look incorrectly swapped something has gone fishy.
>>
>> If it's just stuff touching f128 then we have some magic in
>> softfloat-types:
>>
>>  typedef struct {
>>  #ifdef HOST_WORDS_BIGENDIAN
>>      uint64_t high, low;
>>  #else
>>      uint64_t low, high;
>>  #endif
>>  } float128;
>>
>> but I would have though HOST_WORDS_BIGENDIAN is in the config. I shall

Me too; qemu/osdep.h should pull it in.

>> have a poke once I get onto the s390 machine.
>
> Any luck?
>
> In my own poking, I stumbled over
>
>     #ifndef HOST_WORDS_BIGENDIAN
>     #define LITTLEENDIAN 1
>     /* otherwise do not define it */
>     #endif
>
> in platform.h.  Is LITTLEENDIAN unused, or am I confused?

INLINE appears just as unused.

> [...]

