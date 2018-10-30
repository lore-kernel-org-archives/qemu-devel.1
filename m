Received: from eggs.gnu.org ([2001:4830:134:3::10]:42135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHUzv-0004AR-TE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHUzs-0003wF-MH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:27:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gHUzs-0003vf-Ce
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:27:56 -0400
References: <1540904108-30873-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540904108-30873-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <186fc673-3d5f-31c7-6e4e-204af713395e@vivier.eu>
Date: Tue, 30 Oct 2018 15:26:52 +0100
MIME-Version: 1.0
In-Reply-To: <1540904108-30873-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] linux-user: Add support for statx()
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, ysu@wavecomp.com

Le 30/10/2018 à 13:55, Aleksandar Markovic a écrit :
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Implement support for translation of system call statx(). The
> implementation includes invoking other (more mature) syscalls
> (from the same 'stat' family) on the host side. This way,
> problems of availability of statx() on the host side are
> avoided.
> 
> On some systems with __NR_statx defined, there are some difficulties
> defining variables using "struct statx", so definitions with "struct
> target_statx" is used, and this works in all cases.

Could you give more details?

This is not consistent to use the target_struct type with the host
variable, even if the struct is the same on host and target.

The size of the field can be the same, but the alignment can differ
according to the system ABI.

Thanks,
Laurent
