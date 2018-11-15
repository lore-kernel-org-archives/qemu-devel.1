Received: from eggs.gnu.org ([2001:4830:134:3::10]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNEzF-0008B4-2o
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNEz8-00056K-02
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:34:58 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNEz7-00054Y-PZ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:34:53 -0500
Received: by mail-wr1-f45.google.com with SMTP id j17-v6so20602232wrq.11
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 02:34:50 -0800 (PST)
References: <CAP2KGUnz+vLfSX9+9bgBohKhJ-JxZPQY253M3tPX=Zn3KUzdMg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <975c044d-f44f-ca85-5ea8-28bce1cc6e40@redhat.com>
Date: Thu, 15 Nov 2018 11:34:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAP2KGUnz+vLfSX9+9bgBohKhJ-JxZPQY253M3tPX=Zn3KUzdMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [OVMF+VIFO+QEMU] Large VM RAM allocation = Long
 Boot Times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: A Z <adam@zegelin.com>, edk2-devel@lists.01.org, QEMU Developers <qemu-devel@nongnu.org>

Cc'ing qemu-devel@

On 15/11/18 6:58, A Z wrote:
> This is an issue that involves a combination of different software
> packages, so my apologies in advance if this is the wrong list to post on.
> 
> I'm experiencing terrible boot times when I assign a large amount of RAM to
> a VM when used in combination with VIFO/PCI-passthrough.
> 
> On a VM with a Nvidia GTX 970 + USB controller and 24GiB of RAM assigned,
> the time to the TianoCore splash screen is ~5 minutes. It's then ~30
> seconds before Windows 10 begins to boot (spinning dots). During this time,
> the QEMU CPU core threads are 100% busy.
> 
> According to `perf`, the QMU CPU core threads are spending most of their
> time waiting on a spinlock over kvm->mmu_lock that's created by
> kvm_zap_gfn_range.
> 
> I'm fairly certain that ~1 year ago (if not longer) the same configuration
> didn't take this long to boot.
> 
> Regards,
> Adam
