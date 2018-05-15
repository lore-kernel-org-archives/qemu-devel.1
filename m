Received: from eggs.gnu.org ([2001:4830:134:3::10]:59944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fISQJ-0005cN-Qj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fISQF-0001yC-T7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:22:55 -0400
References: <20180514173044.5025-1-peter.maydell@linaro.org>
	<20180514173044.5025-2-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <716c53cb-89f6-088e-a5f1-47a6c5f740a7@redhat.com>
Date: Tue, 15 May 2018 07:22:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180514173044.5025-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] gdbstub: Use qemu_set_cloexec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

On 14.05.2018 19:30, Peter Maydell wrote:
> Use the utility routine qemu_set_cloexec() rather than
> manually calling fcntl(). This lets us drop the #ifndef _WIN32
> guards and also means Coverity doesn't complain that we're
> ignoring the fcntl error return (CID 1005665, CID 1005667).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  gdbstub.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
