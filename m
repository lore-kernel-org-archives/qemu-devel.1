Received: from eggs.gnu.org ([2001:4830:134:3::10]:37265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUCJ5-0003D4-7r
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUCJ1-00073D-2h
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:08:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUCIy-00071J-W5
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:08:10 -0500
References: <CAFEAcA8rx-ZzHfb5ABcGBHOWDcDwxOejxp_SW9LLuOf1-_cxdg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <302d4d66-e879-beaf-4f95-92b8eb80af97@redhat.com>
Date: Tue, 4 Dec 2018 16:08:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rx-ZzHfb5ABcGBHOWDcDwxOejxp_SW9LLuOf1-_cxdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] hax_enabled() cannot be called in vl.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

On 2018-12-04 15:45, Peter Maydell wrote:
> In vl.c we do this:
> 
>     if (hax_enabled()) {
>         hax_sync_vcpus();
>     }
> 
> But hax_enabled() varies depending on CONFIG_HAX: if that is
> not defined then it is "#define hax_enabled() (0)", otherwise
> it is a function. And CONFIG_HAX is a per-target configuration
> define, only set for i386-softmmu and x86_64-softmmu.

I guess we should add CONFIG_HAX to include/exec/poison.h, just like
CONFIG_KVM can already be found there...?

 Thomas
