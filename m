Received: from eggs.gnu.org ([2001:4830:134:3::10]:41035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fn4DH-0007RV-SA
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fn4DD-0002kL-4B
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:47:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180807125223.GF2556@work-vm> <20180807125819.GP7335@redhat.com>
	<00ac9577-52cc-bf48-f0b8-7d15abb2c21f@redhat.com>
	<20180807130958.GQ7335@redhat.com>
	<CAFEAcA99ybqO=f+s2_S8ypU6-Hy5iRGwviFceaN8Trne+MA8jw@mail.gmail.com>
Date: Tue, 07 Aug 2018 17:47:48 +0200
In-Reply-To: <CAFEAcA99ybqO=f+s2_S8ypU6-Hy5iRGwviFceaN8Trne+MA8jw@mail.gmail.com>
	(Peter Maydell's message of "Tue, 7 Aug 2018 14:47:20 +0100")
Message-ID: <87bmae41qz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, liqsub1 <liqsub1@163.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-stable <qemu-stable@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 7 August 2018 at 14:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>> On Tue, Aug 07, 2018 at 03:07:07PM +0200, Thomas Huth wrote:
>>> But 864036e251f54c9 was never part of an official QEMU release, was it?
>>> Or did it go into a stable release already? If not, I think you simply
>>> need both patches to fix the CVE instead.
>>
>> Ah possibly - I  didn't look at where 864036e251f54c9 was actually
>> release or not. If its onyl git master, then yeah, we can use the
>> same CVE we already have.
>
> Yeah, we haven't released anything with 864036e251f54c9 in it yet.
> (In particular we did not flag it up for stable and so it is not
> in 2.12.1...)

Pointing out the obvious: this is a second opportunity to flag the CVE
fix for stable.
