Received: from eggs.gnu.org ([2001:4830:134:3::10]:53579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXs82-0002Wj-A8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXs7y-0007Ey-9o
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:24:02 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42439)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXs7y-0007Es-49
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:23:58 -0500
Date: Fri, 14 Dec 2018 13:23:55 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181214182355.GA25356@flamenco>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-6-cota@braap.org>
	<20181214155724.GB4314@quinoa.localdomain>
	<20181214170822.GA15965@flamenco>
	<20181214175915.GD4314@quinoa.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214175915.GD4314@quinoa.localdomain>
Subject: Re: [Qemu-devel] [RFC v2 05/38] plugin: add user-facing API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Fri, Dec 14, 2018 at 17:59:20 +0000, Aaron Lindsay wrote:
> On Dec 14 12:08, Emilio G. Cota wrote:
(snip)
> > The idea is that a plugin can "reset" itself, so that (1) all
> > its CBs are cleared and (2) the plugin can register new callbacks.
> > This would all happen in an atomic context (no vCPU running), so
> > that the plugin would miss no CPU events.
> 
> The implication being that there would not be the same possibility of
> other callbacks being called between when qemu_plugin_reset and the
> qemu_plugin_reset_cb_t callback are called as there is at plugin
> un-installation time?

The callback is needed for the same reason -- we can only guarantee
that there will be no callbacks once the current RCU read critical section
expires.

> > How does this sound?
> 
> I think what you describe is exactly what I'm interested in.

Nice. I'll work on this for v3.

Thanks,

		Emilio
