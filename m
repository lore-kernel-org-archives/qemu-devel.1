Received: from eggs.gnu.org ([2001:4830:134:3::10]:44986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzSC-0001MG-U6
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzS8-0005r0-PZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:59:52 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gMzS8-0005pE-Gk
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:59:48 -0500
Date: Wed, 14 Nov 2018 12:59:43 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114175943.GE960@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-10-cota@braap.org>
	<87pnv7d25i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnv7d25i.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 09/48] tcg: reset runtime helpers when
 flushing the code cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Nov 14, 2018 at 17:01:13 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > In preparation for adding plugin support. One of the clean-up
> > actions when uninstalling plugins will be to flush the code
> > cache. We'll also have to clear the runtime helpers, since
> > some of those runtime helpers may belong to the plugin
> > being uninstalled.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
(snip)
> > +void tcg_reset_runtime_helpers(void);
> 
> I know tcg.h doesn't have and API doc blocks but perhaps we should
> start?
> 
>   /**
>    * tcg_reset_runtime_helpers:
>    *
>    * Remove all runtime registered helpers. Should only be called from a
>    * quiescent system while flushing old code.
>    */

Better late than never. Added to v2.

(snip)
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks,

		E.
