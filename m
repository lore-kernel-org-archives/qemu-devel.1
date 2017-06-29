Received: from eggs.gnu.org ([2001:4830:134:3::10]:57840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQc8Z-00011L-RE
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQc8U-0003s3-6C
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:17:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQc8T-0003qp-Qu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:17:42 -0400
References: <20170629010300.2848-1-f4bug@amsat.org>
	<0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
	<98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
	<dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
	<20170629160749.GH32167@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <40abfed5-44fd-fc53-be7b-7836716e7e92@redhat.com>
Date: Thu, 29 Jun 2017 18:17:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170629160749.GH32167@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>

On 29.06.2017 18:07, Daniel P. Berrange wrote:
> On Thu, Jun 29, 2017 at 05:46:26PM +0200, Thomas Huth wrote:
>> On 29.06.2017 17:06, Paolo Bonzini wrote:
>>>
>>>
>>> On 29/06/2017 10:46, Thomas Huth wrote:
>>>>> Patches 7,8 are the removal, marked RFC... let's debate!
>>>> ... but NACK for a direct removal. Common sense is to make obsolete
>>>> features as deprecated first and then wait for 2 public releases bef=
ore
>>>> the final removal, so that users still have a chance to speak up in =
case
>>>> they still need the feature and are willing to maintain it.
>>>
>>> I think this is a slightly different case than what is in
>>> http://wiki.qemu.org/Features/LegacyRemoval.
>>>
>>> TCI is enabled only with a specific configure argument if your machin=
e
>>> is not supported by TCG.  This would break _build_ configurations, no=
t
>>> user configurations.  It's a remote possibility that users are buildi=
ng
>>> their own QEMU, with TCI enabled, to work around a TCG bug.  So we ca=
n
>>> be more speedy in removing the code.
>>
>> You never know ... it's unlikely, but there might be people around who
>> run configure with "--enable-tcg-interpreter" on purpose. And why the
>> hurry for removing this? It's been around in the current shape since
>> years, so waiting for two more releases does not hurt, does it?
>=20
> The flipside is that even if we delete it, if someone does suddenly
> care, the code is still there in git & easy to undelete again. Given
> that we believe there are zero users, it is known broken in many
> ways, and TCG provides a working alternative, I don't see a strong
> reason to not just kill it right away.=20

At least I was using TCI a couple of times during the last years (when I
was suspecting a bug in the normal TCG backend, so I could compare).
There might be other people, too, so I would not dare to say that there
are zero users!
Though I used it a couple of times in the past, I personally would not
object the removal of TCI nowadays since the normal TCG backends have
become pretty mature ... but other users of TCI might have a different
opinion here, so let's mark it as deprecated now and remove it next year
(unless somebody speaks up and explains why it should not be removed).

 Thomas
