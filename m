Received: from eggs.gnu.org ([2001:4830:134:3::10]:58173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH7Vd-0000nZ-L0
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH7VZ-00070P-J8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:50:53 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH7VZ-00070E-Dl
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:50:49 -0400
Received: by mail-ot0-x241.google.com with SMTP id y10-v6so6070232otg.10
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:50:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511124253.GH22098@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
	<20180511124253.GH22098@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:50:28 +0100
Message-ID: <CAFEAcA9TyhX+UyskvuHMSEnJXi-dUdw-E1Es_Fs5NjfdwgZiLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/30] Misc patches for 2018-05-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11 May 2018 at 13:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrot=
e:
> On Fri, May 11, 2018 at 01:19:51PM +0100, Peter Maydell wrote:
>> Some of my build setups barf on the new glib version requirement:
>>
>>  * my aarch64 build host (a gcc compile farm machine which is running
>>    Ubuntu 14.04.5 LTS and has glib 2.40.2)
>
> That is expected - per the policy we only aim to support the most recent,
> and most recent but one for 2 years overlap. Since LTS releases are two
> years apart, this basically means always just 2 most recent LTS releases
> for Ubuntu. Since we Ubuntu 18.04 LTS came out last month, we don't
> need to continue 14.04 LTS

...well, I could ask the GCC compile farm admins what their
upgrade plans are, but I don't particularly see the need
to impose load on a volunteer set of admins when the distro
they're running is still supported for another year. And I
don't want to drop aarch64 from my build test set.

>>  * my windows cross compile setups (which have glib 2.34.3)
>
> Presumably you're using a Debian host for that ?

Ubuntu.

> The debian-win64-cross.docker job seems to pull in packages from
>
>   deb http://pkg.mxe.cc/repos/apt/debian jessie main
>
> And mxe claims to have glib 2.54

Thanks, I will have a look at this. (They seem to have tarballs
as well as debian packages.)

-- PMM
