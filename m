Received: from eggs.gnu.org ([2001:4830:134:3::10]:52224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evR5L-0006a6-Pu
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evR5G-0005GB-7G
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:18:07 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:51853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evR5F-0005Fc-Vn
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:18:02 -0400
Received: by mail-wm0-x229.google.com with SMTP id h21so18113515wmd.1
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:18:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312171122.GC8326@lemon.usersys.redhat.com>
References: <20180312120849.20073-1-marcandre.lureau@redhat.com>
	<CAJ+F1CJM2mk8BKUm=kkKwTJJSjqNT7Hd0pdLM_=ZTMzxnb6FHw@mail.gmail.com>
	<20180312171122.GC8326@lemon.usersys.redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 18:17:59 +0100
Message-ID: <CAJ+F1CKugGNH7kdchrpuF+GXSPMd4s2-w7bSCpH3UNHiwQGR1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: make docker-test-debug@fedora run
 sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Mar 12, 2018 at 6:11 PM, Fam Zheng <famz@redhat.com> wrote:
> On Mon, 03/12 15:11, Marc-Andr=C3=A9 Lureau wrote:
>> Hi Fam,
>>
>> It would be great if patchew could run the debug/sanitizer build.
>> Unfortunately, except x86 target, the run is full of ASAN leaks or
>> warnings.
>>
>> Do you think patchew could learn to do regression testing? By that I
>> mean that patchew could compare a patchset output with the current
>> master (that output should be cached for multiple tests). The output
>> to compare here would be the errors reported by ASAN during the build.
>> (eventually, this could be used for other metrics some day). If so,
>> would you be willing to help me implementing it?
>
> The question is can we simply rely on the exit code of cmp or diff for th=
at kind
> of comparison? If there is any out-of-order texts, that simple diff won't=
 work.

If the tests are run sequentially, i think it should produce the same
output when run multiple times (to be verified).

However, if there are leaks already, and the address of allocation or
symbols change, this may produce diff on existing lines.

What I would like to see is the diff of added (or removed) lines.

I suppose that should be possible, I'll do some experiments.

> Anything more intelligent/sensible should go as a policy, and patchew sho=
uld
> continue focus on mechanisms.

hmm ok :)

> I'll send a pull for the patch. Thanks!
>

thanks


--=20
Marc-Andr=C3=A9 Lureau
