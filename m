Received: from eggs.gnu.org ([209.51.188.92]:60944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1UBd-0006NC-IO
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1UBc-0008Gm-Md
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:54:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1UBc-0008Fl-DL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:54:08 -0500
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-10-peter.maydell@linaro.org>
	<7ec8917a-eabd-6a14-3c1f-38b1d429c900@redhat.com>
	<CAFEAcA-G8FN63M57JJt8K_0omq8kujABetsr31unCxxxno+MiA@mail.gmail.com>
	<CAFEAcA-L=fQPvT_biEm0ko8jUP88H++Gf7ttMyZx=f6dcjd+bg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c45090c1-77c6-6741-e24b-46c2ff742d9f@redhat.com>
Date: Wed, 6 Mar 2019 11:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-L=fQPvT_biEm0ko8jUP88H++Gf7ttMyZx=f6dcjd+bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 05/03/19 16:24, Peter Maydell wrote:
> On Tue, 5 Mar 2019 at 12:47, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>
>> On Thu, 28 Feb 2019 at 15:49, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 2/28/19 3:56 PM, Peter Maydell wrote:
>>>> +# Sphinx builds all its documentation at once in one invocation
>>>> +# and handles "don't rebuild things unless necessary" itself.
>>>> +# The '.doctrees' files are cached information to speed this up.
>>>
>>> Can you add .doctrees to .gitignore?
>>
>> Since this was the only change request for this patchset,
>> I plan to send out a pullreq containing it, with this folded
>> into this patch:
>>
>> diff --git a/.gitignore b/.gitignore
>> index b66b7725512..77522561b8e 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,3 +1,4 @@
>> +/.doctrees
>>  /config-devices.*
>>  /config-all-devices.*
>>  /config-all-disas.*
>=20
> Testing on various hosts revealed that we have a problem on
> hosts with ancient versions of sphinx that predate the 'alabaster'
> theme, so the configure test needs to be smarter. The fixup is
> the change below.
>=20
> Are people OK with me squashing this in too, or have we
> reached the point where it really ought to have a v3 sent out ?

Nah, go ahead.

Paolo
