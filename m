Received: from eggs.gnu.org ([2001:4830:134:3::10]:39240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejGtb-0004NG-SG
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 22:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejGta-00058l-Uc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 22:59:43 -0500
MIME-Version: 1.0
In-Reply-To: <11f684c4-9159-0e4e-5990-635194b32d65@amsat.org>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<11f684c4-9159-0e4e-5990-635194b32d65@amsat.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 6 Feb 2018 19:59:39 -0800
Message-ID: <CAHQ1cqG85MfZpSxUMDxrZj9sCmKizghQZmFsotpPgq+ZwWuEag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/14] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Wed, Jan 31, 2018 at 9:03 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Peter, Andrey.
>
> On 01/15/2018 10:36 PM, Andrey Smirnov wrote:
>> Hi everyone,
>>
>> This v4 of the patch series containing the work that I've done in
>> order to enable support for i.MX7 emulation in QEMU.
>>
>> *NOTE*: Patches 1 and 2 are provided for the sake of completness and
>>       are going to have to be adapted once Philippe's SD changes
>>       land in master. As such, they are NOT ready to be
>>       accepted/merged.
>
> Peter:
> Since my series are taking longer, if this series is ready it is
> probably easier to apply Andrey series first and I'll adapt my SDHCI
> series after.
>
> Andrey:
> I only plan to keep the sdhci.c file generic (dealing with quirks) and
> split out the imx usdhci code, similar to this patch:
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01265.html

Yes, I understand that, but I still am not clear how you propose
dealing with the fact that i.MX specific read/write functions need to
call similar functions from parent SDHC class. Are you planning on
adding overridable read()/write() methods to SDHCICommonClass?

Thanks,
Andrey Smirnov
