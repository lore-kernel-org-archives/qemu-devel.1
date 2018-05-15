Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fISRh-0006c7-IC
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fISRd-0002mY-Jv
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:24:21 -0400
References: <20180514173044.5025-1-peter.maydell@linaro.org>
	<20180514173044.5025-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7c0f898f-fb60-d86a-5285-09578f33a0ec@redhat.com>
Date: Tue, 15 May 2018 07:24:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180514173044.5025-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] gdbstub: Handle errors in gdb_accept()
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
> In gdb_accept(), we both fail to check all errors (notably
> that from socket_set_nodelay(), as Coverity notes in CID 1005666),
> and fail to return an error status back to our caller. Correct
> both of these things, so that errors in accept() result in our
> stopping with a useful error message rather than ignoring it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  gdbstub.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
