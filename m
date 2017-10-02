Received: from eggs.gnu.org ([2001:4830:134:3::10]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dz0GZ-0006QX-9x
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dz0GV-0000QG-Lx
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:56:11 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:55280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dz0GV-0000Pg-Ez
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:56:07 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i124so10376586wmf.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 05:56:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170929091447.GG6803@redhat.com>
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-3-berrange@redhat.com>
	<723de7c1-e617-923c-6e69-561577f0fe1a@redhat.com>
	<20170929091447.GG6803@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Oct 2017 13:55:45 +0100
Message-ID: <CAFEAcA-oUgEdQ=qsLyWWO9R36rCvRU6xYbgAsXxRMJ2ffOQGpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 29 September 2017 at 10:14, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Sep 28, 2017 at 01:03:41PM -0500, Eric Blake wrote:
>> On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
>> > When building the tarball to pass into the docker/vm test image,
>> > the code relies on the git submodules being checked out in the
>> > main checkout.
>> >
>> > ie if the developer has not run 'git submodule update --init dtc'
>> > many of the docker tests will fail due to the libfdt package not
>>
>> 'dtc' vs. 'libfdt' - is one of the acronyms wrong?
>
> For reasons I don't understand we called our submodule 'dtc'
> but it builds a libfdt library. So at least my wording here
> reflects that mismatch.

'dtc' is the name of the upstream project, whose sources can
build various things; the specific part we want happens to be
libfdt.

thanks
-- PMM
