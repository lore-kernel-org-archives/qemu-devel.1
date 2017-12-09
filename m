Received: from eggs.gnu.org ([2001:4830:134:3::10]:38389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eNTct-0004oL-67
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eNTcs-0008Vk-70
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:08:23 -0500
Date: Fri, 8 Dec 2017 23:08:11 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171209010811.GJ3037@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Thu, Dec 07, 2017 at 07:37:31PM +0000, Peter Maydell wrote:
> On 7 December 2017 at 18:14, Peter Maydell <peter.maydell@linaro.org> wrote:
> > This patchset adds support for '-cpu max' to Arm, along the lines
> > of the existing support we have for x86 targets:
> >
> >  * under KVM, -cpu max is the same as -cpu host
> >  * under TCG, -cpu max means "emulate with as many features as
> >    possible"
> 
> Forgot to mention: -cpu max for qemu-system-aarch64 will
> be a 64-bit cpu, and for qemu-system-arm it will be a 32-bit
> cpu. (This differs from all the other TCG CPU types, which
> behave the same for the 32-bit and 64-bit binaries. I think
> it is the same way that x86 -cpu max works, though.)

Are they going to be represented by two different QOM type names?

(In the case of x86, all the CPU classes have different names on
qemu-system-x86_64 and qemu-system-i386).

-- 
Eduardo
