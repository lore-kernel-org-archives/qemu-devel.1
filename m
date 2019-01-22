Received: from eggs.gnu.org ([209.51.188.92]:53963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gls0k-0002R0-CS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gls0i-0000e7-Mo
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:06:22 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gls0i-0000dV-HV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:06:20 -0500
Received: by mail-ot1-x32f.google.com with SMTP id s13so23003470otq.4
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:06:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<20190121200121.GD2083@work-vm>
In-Reply-To: <20190121200121.GD2083@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 09:06:07 +0000
Message-ID: <CAFEAcA8xVHYK+=MtzTf1GrD+yscmNgsHEDcwWnBG8dCLGp4waQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 21 Jan 2019 at 20:01, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> I guess we need some tracing of the packet flow;  do you build with
> tracing on and can we enable it for a test?

What you get is "make && make check", effectively. If you want
better debuggability of the test you need to improve the test...

thanks
-- PMM
