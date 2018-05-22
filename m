Received: from eggs.gnu.org ([2001:4830:134:3::10]:37446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL9YX-0007pc-9S
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL9YW-0005Ru-4L
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:50:33 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:44578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL9YV-0005Ri-VB
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:50:32 -0400
Received: by mail-oi0-x230.google.com with SMTP id e80-v6so16636335oig.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 08:50:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANCZdfpNMR_buj3L4xvqhh_T4QZOvV5JsXHK2Rzk-zs5iHvGrg@mail.gmail.com>
References: <CAFEAcA9a-xrtibHYb4+-xu3QVmW3tJ1v9X0s_X_PMhQGFSJgdg@mail.gmail.com>
	<CANCZdfpNMR_buj3L4xvqhh_T4QZOvV5JsXHK2Rzk-zs5iHvGrg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 16:50:10 +0100
Message-ID: <CAFEAcA-xqG+9SZ2_K5XFooJuKYyuRoL51K1JuwQ-SWGcCYcX=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU 3.0 proposed release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 22 May 2018 at 16:39, Warner Losh <imp@bsdimp.com> wrote:
> On Tue, May 22, 2018 at 9:24 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>>
>> I've put up a draft release schedule at:
>> https://wiki.qemu.org/Planning/3.0
>>
>> 2018-04-24      Beginning of development phase
>> 2018-07-03      Soft feature freeze.
>> 2018-07-10      Hard feature freeze. Tag rc0
>> 2018-07-17      Tag rc1
>> 2018-07-24      Tag rc2
>> 2018-07-31      Tag rc3
>> 2018-08-07      Release, or if necessary, tag rc4
>> 2018-08-14      Release, if we needed rc4

> I'd love to get bsd-user into 3.0. At the moment, all the changes are in
> bsd-user, and my cleanup is trending to about 50 patches. Given traditional
> timelines, when should I submit patches to the mailing list for that?

The usual recommendation is to submit early and often.
"softfreeze" means "any new feature to go in must already
be in a pull request on the list by this date", but big
features hitting the list late in the cycle are not fun to
deal with and best avoided. Also, don't feel you need to hold
on to the thing until all 50-odd patches are ready to submit;
if you can break it up into smaller patchsets that's easier
to deal with.

> Alternatively, when would a future 3.1 be expected?

We do 3 releases a year, generally in approximately April, August
and December. So 3.1 will be early December.

thanks
-- PMM
