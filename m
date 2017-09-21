Received: from eggs.gnu.org ([2001:4830:134:3::10]:43429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv0WX-0002nE-KO
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv0WU-00042i-F7
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:24:09 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:48413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dv0WU-00041v-8E
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:24:06 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m127so1304345wmm.3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:24:04 -0700 (PDT)
Date: Thu, 21 Sep 2017 13:24:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170921122401.GE32364@stefanha-x1.localdomain>
References: <20170921100529.2462-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921100529.2462-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: add trace events for websockets frame
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Sep 21, 2017 at 11:05:29AM +0100, Daniel P. Berrange wrote:
> It is useful to trace websockets frame encoding/decoding when debugging
> problems.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 23 ++++++++++++++++++-----
>  io/trace-events      |  5 +++++
>  2 files changed, 23 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
