Received: from eggs.gnu.org ([2001:4830:134:3::10]:55697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxhmx-0007Lt-Iz
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 19:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxhms-0002WO-PG
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 19:00:15 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dxhms-0002VV-Id
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 19:00:10 -0400
Received: by mail-wm0-x243.google.com with SMTP id q132so189153wmd.2
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 16:00:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170928094453.GD26066@lemon.lan>
References: <20170928084430.17059-1-berrange@redhat.com>
	<20170928084430.17059-3-berrange@redhat.com>
	<20170928094453.GD26066@lemon.lan>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Sep 2017 15:59:38 -0700
Message-ID: <CAKmqyKN+CWQyMWisSbwRDa698Kncd6VUq1qi_-LKyLdrXKJC+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 28, 2017 at 2:44 AM, Fam Zheng <famz@redhat.com> wrote:
> On Thu, 09/28 09:44, Daniel P. Berrange wrote:
>> When building the tarball to pass into the docker/vm test image,
>> the code relies on the git submodules being checked out in the
>> main checkout.
>>
>> ie if the developer has not run 'git submodule update --init dtc'
>> most (all?) of the docker tests will fail due to the missing dtc
>> package in the test images.
>
> Not all, fail only in envs/configs where libfdt devel doesn't exist. But I'm not
> sure about this patch (*).
>
>> Patchew manually checks out the dtc
>> submodule in the main git checkout, but this is a bad idea. The
>> docker tests should never mess around with the developer's main
>> GIT checkout.
>
> Or in general, scripts should not mess around with developer's GIT checkouts,
> which is the reason ./configure doesn't do it?
>
> How about we clone/checkout dtc into a temporary dir from ./configure
> automatically instead?

I like this! Submodules cause lots of issues for us. Other users
building QEMU don't expect to have to clone submodules and we get
complaints back to the QEMU. Especially DTC which is always required.

Thanks,
Alistair
