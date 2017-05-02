Received: from eggs.gnu.org ([2001:4830:134:3::10]:36198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Vwp-0002nT-HQ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5Vwm-0005Is-C7
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5Vwm-0005I7-2n
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:26:24 -0400
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
	<f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
	<df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7c69341a-9584-8208-023a-42bfeeec6dee@redhat.com>
Date: Tue, 2 May 2017 13:26:17 +0200
MIME-Version: 1.0
In-Reply-To: <df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

On 02.05.2017 12:48, Christian Borntraeger wrote:
> On 05/02/2017 12:37 PM, Thomas Huth wrote:
>> On 02.05.2017 12:32, Christian Borntraeger wrote:
>>> On 05/02/2017 12:06 PM, Thomas Huth wrote:
>>>> The '-enable-...' option do not make too much sense: They do not
>>>> allow additional parameters, using '-accel xxx' is shorter than
>>>> '-enable-xxx' and we're also inconsistent here, since there is
>>>> no '-enable-xen' option available. So let's try to convince the
>>>> users to use '-accel xxx' instead.
>>>
>>> google has 36000 hits for "--enable-kvm" and 18000 hits for "--accel =
kvm"
>>> So I assume this will affect a lot of setups for only a very small be=
nefit.
>>
>> I'm aware of the fact that likely a lot of users are still using
>> -enable-kvm, and I did not mean that we should remove it soon yet. But
>> IMHO we should start now to inform the users that they should slowly
>> switch to the better option "-accel" instead, so that we could maybe
>> remove this "-enable-xxx" stuff sometime in the distant future (let's
>> say QEMU v4.0?).
>=20
> I come from the Linux side, where "breaking a working setup" will resul=
t in
> an angry Linus.

IMHO that's a good approach, but I think it should primarily applied for
the interfaces that are designed as "API" to other software layers, i.e.
things like QMP and the "-machine" parameter.
"-enable-kvm" is in my eyes rather a "syntactic sugar" convenience
option, so I'd not apply this rule to this option.

> We certainly have not such strict rules here and we could
> base the decision on the question "how expensive is the maintenance
> of this option?". I think marking it as "legacy option" is fine, but I =
doubt
> that removing it will make qemu maintenance cheaper.

Likely not. Actually, I have another point of view in mind here: You
have to consider that QEMU has a *lot* of options, and I think this is
very confusing for the users, especially the new ones. If we always
provide two or three ways to achieve a goal, especially in an
inconsistent way like we do it here, we likely rather create frustration
than joy for the normal users. Providing a clean, straightforward CLI
interface one day could help to improve the user experience quite a bit.

> So my preferred variant is
> - have it marked in the docs as "legacy"
> - no error_report as it might break some setups (since error_report mig=
ht write
> to the monitor)
> - never remove the option unless it turns out to be a burden
>=20
> But its certainly not my call to make.

Paolo, since you're the KVM / main loop maintainer, what's your opinion
here?

 Thomas
