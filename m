Received: from eggs.gnu.org ([2001:4830:134:3::10]:44435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn4NL-0006la-Pl
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn4NL-0007wC-2E
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:58:23 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn4NK-0007vl-SY
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:58:22 -0400
Received: by mail-oi0-x243.google.com with SMTP id v8-v6so29308298oie.5
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 08:58:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmae41qz.fsf@dusky.pond.sub.org>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180807125223.GF2556@work-vm> <20180807125819.GP7335@redhat.com>
	<00ac9577-52cc-bf48-f0b8-7d15abb2c21f@redhat.com>
	<20180807130958.GQ7335@redhat.com>
	<CAFEAcA99ybqO=f+s2_S8ypU6-Hy5iRGwviFceaN8Trne+MA8jw@mail.gmail.com>
	<87bmae41qz.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 16:58:01 +0100
Message-ID: <CAFEAcA9t7D=Vdje+KHpJqCbCQ1S-cgPRQdxqwW6NF_kCO4fy2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, liqsub1 <liqsub1@163.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-stable <qemu-stable@nongnu.org>

On 7 August 2018 at 16:47, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 7 August 2018 at 14:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>>> On Tue, Aug 07, 2018 at 03:07:07PM +0200, Thomas Huth wrote:
>>>> But 864036e251f54c9 was never part of an official QEMU release, was it=
?
>>>> Or did it go into a stable release already? If not, I think you simply
>>>> need both patches to fix the CVE instead.
>>>
>>> Ah possibly - I  didn't look at where 864036e251f54c9 was actually
>>> release or not. If its onyl git master, then yeah, we can use the
>>> same CVE we already have.
>>
>> Yeah, we haven't released anything with 864036e251f54c9 in it yet.
>> (In particular we did not flag it up for stable and so it is not
>> in 2.12.1...)
>
> Pointing out the obvious: this is a second opportunity to flag the CVE
> fix for stable.

Well, as long as we get both halves of it, yes :-)
(ie commits 864036e251f54c9 + 09b94ac0f29db3b022a77a).

thanks
-- PMM
