Received: from eggs.gnu.org ([209.51.188.92]:36023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gnAdJ-0004QH-PQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gnAXA-0003Si-FL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:05:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gnAX8-0002tm-AN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:05:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so11984030wrp.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:04:23 -0800 (PST)
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
	<f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
	<4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
	<20190124165253.GT7953@redhat.com>
	<509cf069-5d03-8e2e-fb3c-5828d32f38e1@comstyle.com>
	<6e71d755-8dcd-5275-d635-f238271cf459@tuxfamily.org>
	<1284f2c4-57ad-061a-c920-c21cd7e142d4@comstyle.com>
	<CAFEAcA9iGqC7pfwNRuGe2nOniYTp_aEzwQLRoGpt_yCGqZT2=Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff0f9404-a317-ede3-85b5-1efe8dad5161@redhat.com>
Date: Sat, 26 Jan 2019 00:04:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9iGqC7pfwNRuGe2nOniYTp_aEzwQLRoGpt_yCGqZT2=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Cc: Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 1/25/19 7:38 PM, Peter Maydell wrote:
> On Fri, 25 Jan 2019 at 18:36, Brad Smith <brad@comstyle.com> wrote:
>>
>> On 1/25/2019 1:24 AM, Thomas Huth wrote:
>>
>>> On 2019-01-25 01:48, Brad Smith wrote:
>>>> Our ports tree has an option which results in the QEMU binaries being
>>>> linked with "-z wxneeded".
>>> Then it's maybe high time to send such changes upstream now ;-)
>>
>>
>> I have not considered submitting such a patch as it's just a workaround
>> for an
>> issue within QEMU. Everything else that we had as local patches or local
>> build
>> fiddling to build things properly has been integrated in some manner.
> 
> We'll happily take a patch that fixes the underlying issue properly
> if you'd prefer...

I sent "configure: Disable W^X on OpenBSD" to help upstream developers
to test their patches on OpenBSD here:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06674.html

Regards,

Phil.
