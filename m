Received: from eggs.gnu.org ([2001:4830:134:3::10]:58964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn1gL-00089g-41
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dn1gF-0002Ci-DD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:01:17 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dn1gF-0002BW-6c
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:01:11 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k94so17905934wrc.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 05:01:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <838020276.255029.1504093138506@mail.yahoo.com>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
	<1735515901.247981.1504090406495@mail.yahoo.com>
	<838020276.255029.1504093138506@mail.yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Aug 2017 13:00:49 +0100
Message-ID: <CAFEAcA9bUktbR2iFEthjmKci=a3syS_2sjkbdfzx3ruZXWMMJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mahmood <nt_mahmood@yahoo.com>
Cc: Thomas Huth <th.huth@posteo.de>, Greg Kurz <groug@kaod.org>, Thomas Huth <huth@tuxfamily.org>, QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

On 30 August 2017 at 12:38, Mahmood <nt_mahmood@yahoo.com> wrote:
> Hello again,I installed 2.5.0 quickly and it was pretty straight forward!
>
> Here is the error message I get regarding the 'virtio-9p-pci'
> 'virtio-9p-pci' is not a valid device model name

Are you building your own QEMU binary or is it from somewhere
else? I wonder if it was built without support for the 9p
filesystem code. For this to be enabled:
 * host machine must be Linux
 * system building QEMU must have libcap development package installed

If you're building it yourself then you can pass configure
'--enable-virtfs' which will mean configure will stop with
an error if it can't enable virtfs rather than just disabling
this optional feature.

QEMU ought to produce a helpful error if you try to use -virtfs
when virtfs wasn't compiled in, but it may be that this check
was broken accidentally at some point.

Also, 2.5.0 is a couple of years old, you might try with 2.9.0
(or even with the 2.10.0 we're about to release today).

thanks
-- PMM
