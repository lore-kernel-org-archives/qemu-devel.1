Received: from eggs.gnu.org ([2001:4830:134:3::10]:44709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7GbZ-0003jK-Pp
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7GbZ-0007Dz-1Y
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:04:33 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:34689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7GbY-0007DB-HA
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:04:32 -0400
Received: by mail-ot1-x333.google.com with SMTP id i12-v6so1178619otl.1
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:04:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <021f3f1e-e767-8d84-0189-fbfa7ca5f143@redhat.com>
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
	<87lg7hlend.fsf@linaro.org>
	<CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
	<021f3f1e-e767-8d84-0189-fbfa7ca5f143@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 10:04:10 +0100
Message-ID: <CAFEAcA-M_x8oC_1Z5A9Lv3DQ1Z+_vVdyUnaHoBMv4nkJepcBhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] racing between pause_all_vcpus() and
 qemu_cpu_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>

On 2 October 2018 at 09:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> First, the reset code should indeed use run_on_cpu (it need not be safe
> i.e. stop-the-world; just run it in the vCPU thread).  It certainly
> doesn't do this right now.

I don't understand this part. We're resetting the entire world:
surely we need to stop the entire world first ?

(Also, other things use pause_all_vcpus() and hit this race
condition, like VM suspend and shutdown.)

thanks
-- PMM
