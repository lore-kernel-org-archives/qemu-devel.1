Received: from eggs.gnu.org ([2001:4830:134:3::10]:46754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBtFL-0004TA-GP
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBtFI-0000zC-7T
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:04:11 -0500
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:48255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBtFH-0000yp-Vo
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:04:08 -0500
Received: by mail-pf0-x230.google.com with SMTP id b79so9158065pfk.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 18:04:07 -0800 (PST)
References: <20171103153333.6416-1-berrange@redhat.com>
	<CAFEAcA-n7jLjBcCAG6r30F=UUZy8vAKfMK8oC3oM+K1QTsH0zA@mail.gmail.com>
	<20171106104401.GE23361@redhat.com> <20171106143010.GI23361@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4474fa50-c6e4-973e-90e9-2756dcd3d3b1@ozlabs.ru>
Date: Tue, 7 Nov 2017 13:04:02 +1100
MIME-Version: 1.0
In-Reply-To: <20171106143010.GI23361@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Various improvements/bugfixes to
 submodule handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/11/17 01:30, Daniel P. Berrange wrote:
> On Mon, Nov 06, 2017 at 10:44:01AM +0000, Daniel P. Berrange wrote:
>> On Fri, Nov 03, 2017 at 06:03:55PM +0000, Peter Maydell wrote:
>>> On 3 November 2017 at 15:33, Daniel P. Berrange <berrange@redhat.com> wrote:
>>>> This short series of patches improves the reliability of the submodule
>>>> handling to cope with various dev env scenarios that have since emerged
>>>
>>> Can I ask you to write up a bit for the release notes at
>>> https://wiki.qemu.org/ChangeLog/2.11#Build_Information
>>> covering what users need to know about the new submodule
>>> handling, please?
>>
>> Certainly, will do that.
>>
>> Perhaps have something in the general wiki pages about building QEMU, and
>> link to it from the changelog.
> 
> I've created this now:
> 
> https://wiki.qemu.org/Documentation/GitSubmodules

This could probably also mention something like this workaround if things
do not work as expected:

git config --global --replace-all core.abbrev 8

Thanks.


> 
> and linked it from here:
> 
> https://wiki.qemu.org/ChangeLog/2.11#Build_Information
> 
> and a couple of other places in the wiki.
> 
> Regards,
> Daniel
> 


-- 
Alexey
