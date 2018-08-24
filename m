Received: from eggs.gnu.org ([2001:4830:134:3::10]:56389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ft83H-0006UE-BB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ft83G-0004cd-C6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:06:43 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ft83F-0004cB-VY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:06:42 -0400
Received: by mail-oi0-x244.google.com with SMTP id p84-v6so14182213oic.4
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 02:06:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824085220.GF31581@lemon.usersys.redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<20180824082237.GA3430@redhat.com>
	<20180824085220.GF31581@lemon.usersys.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:06:20 +0100
Message-ID: <CAFEAcA-Qqsnwo3CwtbTMoPvNqkVc6f+4Uj15a2=a2BQdvqmLkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 24 August 2018 at 09:52, Fam Zheng <famz@redhat.com> wrote:
> On Fri, 08/24 09:22, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Aug 24, 2018 at 09:21:26AM +0800, Fam Zheng wrote:
>> > Upgrade OpenBSD to 6.3 using auto_install. Especially, drop SDL1,
>> > include SDL2.
>> >
>> > One limitation of this patch is that we need a temporary HTTP server o=
n
>> > host 80 port for auto_install, because slirp cannot do guest forward o=
n
>> > "host addr".
>>
>> That's a pretty big limitation, as port 80 requires root privileges,
>> and that's a pretty strict no for automated testing IMHO.
>>
>> Why does it have to be port 80 in particular - is it not possible
>> to use 8080 or even better, detect a random free port ?
>
> OpenBSD autoinstall[1] is hardcoded to fetch from port 80. Maybe we can i=
nstead
> persuade it into fetching from a different http server than 10.0.2.2. To =
do that
> we'd need to implement a new slirp option for either "option tftp-server-=
name"
> or "next-server" according to the manpage. I'll have to experiment with i=
t to
> see if it will work.

Can you use the usermode networking "guestfwd" option to make guest
tcp connections to wherever:80 go to host:8080 or something instead?
(watch out for https://bugs.launchpad.net/qemu/+bug/1628971 if it
is still relevant, I guess).

thanks
-- PMM
