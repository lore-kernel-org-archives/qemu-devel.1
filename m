Received: from eggs.gnu.org ([2001:4830:134:3::10]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtxWS-00011C-7Z
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtxWO-00010F-V8
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:59:44 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:50825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dtxWO-0000zr-Ln
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:59:40 -0400
Received: by mail-wm0-x22a.google.com with SMTP id v142so3494548wmv.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:59:40 -0700 (PDT)
Date: Mon, 18 Sep 2017 15:59:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918145936.GE4141@stefanha-x1.localdomain>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Wed, Sep 06, 2017 at 04:28:42PM -0400, Emilio G. Cota wrote:
> Related threads:
>   [PATCH 00/13] instrument: Add basic event instrumentation
>   Date: Mon, 24 Jul 2017 20:02:24 +0300
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
> and
>   [PATCH v4 00/20] instrument: Add basic event instrumentation
>   Date:	Wed, 6 Sep 2017 20:22:41 +0300
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
> 
> This set does something similar to the instrumentation patches by Lluis,
> but with a different implementation (and for now less events).
> 
> My focus has been on working on the skeleton of a (pseudo) stable API,
> as Stefan requested. Of course more events would have to be added, but
> before spending more time on this I'd like to get some feedback on the
> core of the design. Patch 2 has all the details.
> 
> Note: yes, patch 1 is not used in the series, but this is an RFC. It's there
> because it will be needed to get the tb->plugin_mask when deciding whether
> to generate a mem_cb helper when generating loads/stores from TCG.
> 
> This set applies on top of:
>   https://github.com/cota/qemu/tree/tcg-generic-15%2Bmulti-tcg-v4-parallel
> 
> The tree can be fetched from:
>   https://github.com/cota/qemu/tree/plugins

Hi Emilio,
Thanks for sending this!  Could you and Lluís collaborate on a single
instrumentation plugin API?

Let's have a discussion with Lluís, Peter, myself, and potentially
others then we can use the QEMU Developer Conference Call that is
scheduled every 2 weeks.

The next call time slot is Tue 26 Sept at 13:00 UTC:
https://www.timeanddate.com/worldclock/fixedtime.html?iso=20170926T140000&p1=136

Stefan
