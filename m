Received: from eggs.gnu.org ([2001:4830:134:3::10]:43921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euLMi-0002Ge-IU
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euLMd-0008Qw-9G
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:59:32 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:38371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1euLMd-0008Qi-13
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:59:27 -0500
Received: by mail-wr0-x235.google.com with SMTP id n7so9661777wrn.5
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 08:59:26 -0800 (PST)
References: <20180308130626.12393-1-peter.maydell@linaro.org>
	<87zi3hjqzw.fsf@linaro.org>
	<CAFEAcA_Px3_dnoE3cgCPwRpv-9JzoHnGceDE66BvreHi1kxbbw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_Px3_dnoE3cgCPwRpv-9JzoHnGceDE66BvreHi1kxbbw@mail.gmail.com>
Date: Fri, 09 Mar 2018 16:59:24 +0000
Message-ID: <87vae5jic3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 9 March 2018 at 13:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> This patchset adds support for '-cpu max' to Arm, along the lines
>>> of the existing support we have for x86 targets:
>>>
>>>  * under KVM, -cpu max is the same as -cpu host
>>>  * under TCG, -cpu max means "emulate with as many features as
>>>    possible"
>> <snip>
>>
>> It all looks good to me. The only minor problem I ran into was setting
>> -M virt,gic-version=3Dmax silently hangs with the stock QEMU_EFI.fd on my
>> version of Ubuntu. It would be nice if there was better feedback we
>> could give to the user in this case.
>
> Presumably that also fails if you ask for gic-version=3D3 ?

Yes.

>
>> It works with the latest snapshot from:
>>
>>   http://snapshots.linaro.org/reference-platform/enterprise/firmware/15/=
release/qemu-aarch64/
>
> Sounds like "earlier firmware versions didn't have gicv3 support,
> later ones do" ?

According to the dpkg changelog it should have:

  Adds GICv3 support.  Closes: #810495

However it seems like it wasn't complete support.

--
Alex Benn=C3=A9e
