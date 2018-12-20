Received: from eggs.gnu.org ([2001:4830:134:3::10]:39602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZwNO-0002n8-9W
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZwNJ-00017E-BE
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:20:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZwNJ-0000yH-0B
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:20:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so1337925wrr.0
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 03:20:15 -0800 (PST)
References: <20181101183705.5422-1-philmd@redhat.com>
	<20181102064829.GB21032@magic>
	<CAAdtpL44dNQLskpUJ=33vF8Kp8jNkFYSDQXyKixvvZFUim1SUw@mail.gmail.com>
	<CAK1Eb9mWQHXY_UEfbvFvtLvM7W3vBboEQZg-mH3-J4YRodziGg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d4a6ad2-46d8-ca16-1bf4-10ee479fa185@redhat.com>
Date: Thu, 20 Dec 2018 12:20:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAK1Eb9mWQHXY_UEfbvFvtLvM7W3vBboEQZg-mH3-J4YRodziGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: Use a stable snapshot for Debian
 Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi Fam,

On 11/2/18 8:24 AM, Fam Zheng wrote:
> On Fri, Nov 2, 2018 at 3:20 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Fam,
>>
>> Thanks for picking this.
>>
>> On Fri, Nov 2, 2018 at 7:48 AM Fam Zheng <famz@redhat.com> wrote:
>>> On Thu, 11/01 19:37, Philippe Mathieu-Daudé wrote:
>>>> The Debian Sid repository is not garanteed to be stable, as his
>>>> 'unstable' name suggest :)
>>
>> There is an error in "my be" -> "might be"...
>> Do you mind to update the comment:
>>
>>>> To allow quick testing, packages are pushed various time a day,
>>>> which my be annoying when trying to use it for stable development
>>>> (which is not recommended, but Sid provides edge packages we use
>>>> for testing).
>>
>> By:
>>
>> To allow quick testing, Debian maintainers might push packages
>> various time a day. Sometime package dependencies might break,
>> which is annoying when using this repository for stable development
>> (which is not recommended, but Sid provides edge packages we use
>> for testing).
> 
> Sure, updated in my queue.

It seems your queue never hit master...
