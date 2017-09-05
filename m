Received: from eggs.gnu.org ([2001:4830:134:3::10]:43869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpA7y-0004l4-5J
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpA7t-0005RU-Gg
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:26:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dpA7t-0005R1-9m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:26:33 -0400
Received: by mail-wm0-x244.google.com with SMTP id p17so2448133wmd.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:26:33 -0700 (PDT)
Date: Tue, 5 Sep 2017 10:26:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905092629.GE17449@stefanha-x1.localdomain>
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

On Mon, Sep 04, 2017 at 06:19:00PM +0100, Peter Maydell wrote:
> Nobody has mentioned AIX host support on the mailing list for years,
> and we have no test systems for it so it is most likely broken.
> We've advertised in configure for two releases now that we plan
> to drop support for this host OS, and have had no complaints.
> Drop the AIX host support code.
> 
> We can also drop the now-unused AIX version of sys_cache_info().
> 
> Note that the _CALL_AIX define used in the PPC tcg backend is
> also used for Linux PPC64, and so that code should not be removed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure        | 13 +------------
>  util/cacheinfo.c | 11 +----------
>  2 files changed, 2 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
