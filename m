Received: from eggs.gnu.org ([2001:4830:134:3::10]:58529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebgOs-0002HF-CW
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 00:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebgOn-000579-M2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 00:36:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebgOn-00056O-F6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 00:36:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id b141so12732373wme.1
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 21:36:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a89ba2c9-0248-644e-2d95-83985780e422@linaro.org>
References: <20180116033404.31532-1-richard.henderson@linaro.org>
	<CAFEAcA_6KgcmRFa_AyyhpUb2EQKNBUsQQ9Wk_-guJXsoS-h-tw@mail.gmail.com>
	<a89ba2c9-0248-644e-2d95-83985780e422@linaro.org>
From: Fam Zheng <fzheng@redhat.com>
Date: Wed, 17 Jan 2018 13:36:01 +0800
Message-ID: <CAK1Eb9meLQ9k4ivb5HZ9K+svyAuy94e=f14xmTe1Di8b18Y_ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 00/26] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

gcc-4.8.5-16.el7_4.1.ppc64le

On Tue, Jan 16, 2018 at 11:50 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/16/2018 03:59 AM, Peter Maydell wrote:
>> /var/tmp/patchew-tester-tmp-r7vd2rsz/src/accel/tcg/tcg-runtime-gvec.c:533:26:
>> internal compiler error: in emit_move_insn, at expr.c:3495
>
> Bah.  I remember seeing this myself on the gcc 4.8.x that is the system
> compiler on the gcc compile farm machines.  I forgot about it because I
> immediately changed my path to select gcc 7.x.  ;-P
>
>> We need to either work around that or update the compiler in patchew's
>> setup or disable that build before we can merge this, or patchew will
>> start mailing complaints about every series that's sent to the list...
>
> I can work around it in configure, but it might be worth updating the compiler
> as well -- this bug has been fixed for years.

This gcc is the CentOS 7 packaged version and an update (from
gcc-4.8.5-16.el7.ppc64le
 to gcc-4.8.5-16.el7_4.1.ppc64le) doesn't fix it.

Fam
