Received: from eggs.gnu.org ([2001:4830:134:3::10]:58874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnPaR-0001VR-1I
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnPaJ-0007AF-7h
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:32:47 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnPaJ-00079t-19
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:32:39 -0400
Received: by mail-wr0-x229.google.com with SMTP id p14so2147701wrg.3
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 06:32:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831132526.GM17315@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<87r2vrlwr3.fsf@dusky.pond.sub.org> <20170831131412.GK17315@redhat.com>
	<CAFEAcA_OHsZJd4hMtbMuaVD2QDT7H2XEPD03w8NKJ901Cj0Hcw@mail.gmail.com>
	<20170831132526.GM17315@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 14:32:17 +0100
Message-ID: <CAFEAcA-B6pAbo9Mfuok+BJAVp0jRnrU479xV6tTe1K6oxMLNXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 31 August 2017 at 14:25, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Aug 31, 2017 at 02:19:05PM +0100, Peter Maydell wrote:
>> On 31 August 2017 at 14:14, Daniel P. Berrange <berrange@redhat.com> wrote:
>> > NB, some distros have already changed /usr/bin/python to point to py3
>> > so all the files with #!/usr/bin/python in QEMU are already broken on
>> > those distros.
>>
>> This is a bug in those distros and they should fix it. Python 3
>> is not Python 2 and making /usr/bin/python point to the wrong
>> interpreter will have predictably bad results for their users...
>
> Having /usr/bin/python point to py3 is what upstream Python will
> eventually recommend. Some distros jumped a bit early, but the
> others will eventually follow, and I don't see those early distros
> moving back.
>
> https://www.python.org/dev/peps/pep-0394/

That appears to be "Arch Linux broke this, and rather than just
telling them to fix this we decided to make everybody else deal
with the breakage". Water under the bridge, I guess :-(

thanks
-- PMM
