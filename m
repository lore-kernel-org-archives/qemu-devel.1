Received: from eggs.gnu.org ([2001:4830:134:3::10]:33347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKAQ3-000299-W8
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKAQ0-0004ki-0O
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:05:59 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gKAPw-00046Q-Ss
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:05:55 -0500
Date: Wed, 7 Nov 2018 00:05:44 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181106230544.el2smjqvmqlkezmb@function>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
	<20181106151323.16154-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106151323.16154-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/4] slirp: Don't pass possibly -1
 fd to send()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org

Peter Maydell, le mar. 06 nov. 2018 15:13:20 +0000, a ecrit:
> Coverity complains (CID 1005726) that we might pass -1 as the fd
> argument to send() in slirp_send(), because we previously checked for
> "so->s == -1 && so->extra".  The case of "so->s == -1 but so->extra
> NULL" should not in theory happen, but it is hard to guarantee
> because various places in the code do so->s = qemu_socket(...) and so
> will end up with so->s == -1 on failure, and not all the paths which
> call that always throw away the socket in that case (eg
> tcp_fconnect()).  So just check specifically for the condition and
> fail slirp_send().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is to some extent just placating Coverity.

Applied, thanks!
