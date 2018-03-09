Received: from eggs.gnu.org ([2001:4830:134:3::10]:53245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euIV8-0005qB-Fe
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euIV7-0001uL-J0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:56:02 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:40938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euIV7-0001u9-Cj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:56:01 -0500
Received: by mail-oi0-x22a.google.com with SMTP id c12so7001116oic.7
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:56:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zi3hjqzw.fsf@linaro.org>
References: <20180308130626.12393-1-peter.maydell@linaro.org>
	<87zi3hjqzw.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 13:55:40 +0000
Message-ID: <CAFEAcA_Px3_dnoE3cgCPwRpv-9JzoHnGceDE66BvreHi1kxbbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 9 March 2018 at 13:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> This patchset adds support for '-cpu max' to Arm, along the lines
>> of the existing support we have for x86 targets:
>>
>>  * under KVM, -cpu max is the same as -cpu host
>>  * under TCG, -cpu max means "emulate with as many features as
>>    possible"
> <snip>
>
> It all looks good to me. The only minor problem I ran into was setting
> -M virt,gic-version=3Dmax silently hangs with the stock QEMU_EFI.fd on my
> version of Ubuntu. It would be nice if there was better feedback we
> could give to the user in this case.

Presumably that also fails if you ask for gic-version=3D3 ?

> It works with the latest snapshot from:
>
>   http://snapshots.linaro.org/reference-platform/enterprise/firmware/15/r=
elease/qemu-aarch64/

Sounds like "earlier firmware versions didn't have gicv3 support,
later ones do" ?

thanks
-- PMM
