Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKAhE-0005br-3m
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKAXm-0000Za-EH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:14:01 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gKAXl-00025V-Sl
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:13:58 -0500
Date: Wed, 7 Nov 2018 00:11:38 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181106231138.fmqxn7rer3ij6ihz@function>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
	<20181106151323.16154-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106151323.16154-5-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1 4/4] slirp: fork_exec(): create and
 connect child socket before fork()
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

Peter Maydell, le mar. 06 nov. 2018 15:13:23 +0000, a ecrit:
> Currently fork_exec() fork()s, and then creates and connects the
> child socket which it uses for communication with the parent in
> the child process. This is awkward because the child has no
> mechanism to report failure back to the parent, which might end
> up blocked forever in accept(). The child code also has an issue
> pointed out by Coverity (CID 1005727), where if the qemu_socket()
> call fails it will pass -1 as a file descriptor to connect().
> 
> Fix these issues by moving the creation of the child's end of
> the socket to before the fork(), where we are in a position to
> handle a possible failure.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied, thanks!

Samuel
