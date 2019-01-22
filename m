Received: from eggs.gnu.org ([209.51.188.92]:43590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gm12X-0002Ul-HR
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gm12U-0003Wo-1t
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:44:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gm12T-0003Pf-J2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:44:45 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so21547200ita.5
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
	<242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
	<CAPyFy2BLuGCYx0-GUdy5w8HD0u3hkvH3DGmCV+9OKYjtkr6rew@mail.gmail.com>
	<CAPyFy2DNJvE4GbXxtzFJe8bPiXQm+bOmp+D_zVSCtaJML18vzw@mail.gmail.com>
	<6272e5b7-477c-6a38-97cd-a16b94c209d5@redhat.com>
In-Reply-To: <6272e5b7-477c-6a38-97cd-a16b94c209d5@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Tue, 22 Jan 2019 08:42:05 -0500
Message-ID: <CAPyFy2DKo=pBrxhbawf5fJVSVwXnnjaXUHbdWFJ+-M5R_f7irQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 22 Jan 2019 at 04:40, Thomas Huth <thuth@redhat.com> wrote:
>
> Then I finally increased the CPUs back to 8 again, but stick with 8G of
> RAM, and that indeed finished in time successfully:
>
>  https://cirrus-ci.com/build/6218565876187136
>
> So yes, looks like 8 CPUs should work indeed, but I think you should
> decrease the amount of memory of the VM, to make sure that it does not
> get killed so easily. 8 GB of RAM should also be enough to compile QEMU,
> as far as I can tell.

Ok. I think Cirrus-CI might be having some growing pains.

I can submit a v4 patch with 8G for the VM and V=1 only on the tests,
then after it gets merged keep an eye on results for a while before we
consider enabling build notifications etc.
