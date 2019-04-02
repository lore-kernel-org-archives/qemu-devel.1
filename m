Received: from eggs.gnu.org ([209.51.188.92]:56427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBBxZ-0004X7-OZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBBxY-0002a5-Tf
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:27:45 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBBxY-0002Zb-Lb
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:27:44 -0400
Received: by mail-oi1-x242.google.com with SMTP id e5so9452911oii.0
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 22:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-5-git-send-email-like.xu@linux.intel.com>
	<87h8bmuj2d.fsf@zen.linaroharston>
	<2546bf3e-2009-5a76-bc63-0ad73d333a78@linux.intel.com>
	<20190401233818.GA22884@habkost.net>
	<965d5d2f-1717-dcd0-8707-f6629f54e504@linux.intel.com>
	<CAFEAcA_i9Te5Gs9GWnqH+JvTPFbp80+n2D=VAoC0e2DS7OfSeg@mail.gmail.com>
	<ca73da94-df07-ac0e-67a4-8c9b18b7dc20@linux.intel.com>
In-Reply-To: <ca73da94-df07-ac0e-67a4-8c9b18b7dc20@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 05:27:32 +0000
Message-ID: <CAFEAcA__F84deXVLxTp4PCBtGD-8sr1nKz9cvQx4=QsV1ttnfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/9] cpu/topology: add ARM support for smp
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, like.xu@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, 2 Apr 2019 at 12:20, Like Xu <like.xu@linux.intel.com> wrote:
>
> On 2019/4/2 12:45, Peter Maydell wrote:
> > My suggestion would be that we use qdev_get_machine(). I think
> > it would be nice to make the remaining dozen or so uses of
> > the global current_machine outside vl.c use qdev_get_machine()
> > instead, and then make current_machine local to vl.c instead
> > of global.

> It looks good to me and I am not sure if this refactoring should be
> added in next patch series or as a separate patch.

Changing the other uses of current_machine is definitely a
refactoring that should be a separate patch series.

thanks
-- PMM
