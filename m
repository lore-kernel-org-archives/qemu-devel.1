Received: from eggs.gnu.org ([2001:4830:134:3::10]:48310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHpi8-0008FW-Il
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHpi7-0003lD-LA
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:58:12 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dHpi7-0003ko-CD
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:58:11 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n195so72629359wmg.1
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 03:58:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+v1rkNj9XgFOGjkGoEqC-Wz6FukXJnfunzcTtBXmo-3g@mail.gmail.com>
References: <20170602074040.7400-1-marcandre.lureau@redhat.com>
	<CAFEAcA8nOzdR=ZHdkvX+aD-oCvDFcUvmgEJdE1CcUyOVMoEP8w@mail.gmail.com>
	<CAJ+F1CK5MVbEE6tMT0djyH7Rr0mWcZGdZh+rYp-qpSDoQuDtUQ@mail.gmail.com>
	<CAFEAcA8k9UoaV2Dg0E13Xq_Rzg2qGv-xArD5oFtG0oJO7iyU4w@mail.gmail.com>
	<CAJ+F1C+v1rkNj9XgFOGjkGoEqC-Wz6FukXJnfunzcTtBXmo-3g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2017 11:57:49 +0100
Message-ID: <CAFEAcA8svoPXn4AfiWhKm+ve1ve+OZ2aOt0O5GQyJh5x28v3nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/15] chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 June 2017 at 11:50, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com=
> wrote:
> Hi
>
> On Mon, Jun 5, 2017 at 2:15 PM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>>
>> On 2 June 2017 at 20:15, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.=
com>
>> wrote:
>> > Sorry, git-publish printed an error on invalid remote, but keep going.=
 I
>> > should fix it. Here is the new pull request:
>> >
>> > The following changes since commit
>> > 43771d5d92312504305c19abe29ec5bfabd55f01:
>> >
>> >   Merge remote-tracking branch
>> > 'remotes/armbru/tags/pull-qapi-2017-05-31'
>> > into staging (2017-06-01 16:39:16 +0100)
>> >
>> > are available in the git repository at:
>> >
>> >   https://github.com/elmarco/qemu.git tags/chrfe-pull-request
>> >
>> >
>> > for you to fetch changes up to 6b10e573d15ef82dbc5c5b3726028e6642e134f=
6:
>> >
>> >   char: move char devices to chardev/ (2017-06-02 11:33:53 +0400)
>>
>> Thanks, applied to master.
>>
>> You forgot to add your signed-off-by line as submaintainer to the
>> commit from Philippe -- since it's a two line patch I didn't think it
>
>
> Oh I didn't know I have to add my sign-off too, I thought reviewed-by was
> enough. Ok

Yeah, the reviewed-by: says "this code looks good", but the signed-off-by:
says "this code passed through me on its way to master". So you can have
any combination:
 * reviewed-by: only -- you just reviewed the code and it went into
   master via somebody else's tree
 * signed-off-by: only -- you took the code through your tree (so you're
   happy that it's ok license-wise and so on), but you're relying on
   somebody else to have reviewed it
 * both -- you took the code through your tree, and you've done the
   code review

thanks
-- PMM
