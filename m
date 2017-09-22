Received: from eggs.gnu.org ([2001:4830:134:3::10]:47531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvMia-0007j6-Eh
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvMiU-00068A-26
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:06:04 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:44980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvMiT-00067P-Sp
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:05:58 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m127so1791121wmm.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 05:05:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEgYsbFZGT3GARy7LEkU7uvb4__Xg6AdA2oU9wHtctmKhewkmw@mail.gmail.com>
References: <CAEgYsbFZGT3GARy7LEkU7uvb4__Xg6AdA2oU9wHtctmKhewkmw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 13:05:36 +0100
Message-ID: <CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SunOS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Tribble <peter.tribble@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <n54@gmx.com>

On 20 September 2017 at 19:50, Peter Tribble <peter.tribble@gmail.com> wrote:
> To introduce myself: I'm a member of the illumos community (the successor
> to OpenSolaris, to those unfamiliar with us), and I maintain my own illumos
> distribution.
>
> Having seen the scary 'SUPPORT FOR THIS HOST OS WILL GO AWAY'
> message, I'm reaching out to see what needs to be done so that support for
> SunOS (not just illumos, I include Oracle's Solaris in the same family)
> needs to be kept and, where possible, enhanced.
>
> I'm willing to act as a contact in this effort, and can work with others in
> the illumos community to see if there are other resources we can bring to bear.

Hi; thanks for getting in touch with us. Kamil Rytarowski (who I've
cc'd) is also interested in keeping Solaris-variant support working.

Essentially what we need as upstream is:
 * access to a machine which we can use for our continuous
   integration build testing, so we don't break compile
   support for the platform. This is ideally a machine that
   somebody else admins and we just use (because we don't
   want to become solaris/illumos admins ;-)), but failing
   that, instructions on how to get a VM running under
   KVM on Linux would also be OK (that's how we've ended
   up handling the BSDs)
 * somebody to look at the places where 'make && make check'
   currently fails and submit upstream patches for them. Kamil
   has been doing a great job here but would probably
   appreciate extra help :-)
 * somebody who's willing to be listed in our MAINTAINERS file
   as maintaining the port, so we can ask them questions if/when
   any platform-specific issues come up in future

Overall we're happy to continue to support hosts that people
are still using -- we just want to avoid blindly maintaining
code for platforms we can't test and where we don't have
any idea if anybody's even using it (for instance we just
dropped the support for AIX and for Itanium CPUs...)

thanks
-- PMM
