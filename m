Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS1C1-0003VZ-SY
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS18g-0003KX-J0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:48:35 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gS18g-0003Jh-6U
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:48:30 -0500
Date: Wed, 28 Nov 2018 09:48:25 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181128144825.GB1763@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-49-cota@braap.org>
	<87bm694f1w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm694f1w.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 48/48] plugin: add a couple of very simple
 examples
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

On Wed, Nov 28, 2018 at 11:28:11 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  plugin-examples/bbcount_avgsize_racy.c | 50 ++++++++++++++++++++++
> >  plugin-examples/mem_count_racy_both.c  | 58 ++++++++++++++++++++++++++
> >  plugin-examples/Makefile               | 31 ++++++++++++++
> 
> So I think we need to be putting these somewhere else and also building
> the examples by default. As plugins only make sense with tcg guests

Most of plugin functionality is related to TCG, but some of
it is not. For instance, one could use a plugin to just control
the guest clock, and nothing else. This would work with KVM.

This is why I think $SRC_PATH/plugin.c makes sense.

Wrt the examples, I just included them here for reviewing purposes.
If we end up adding them, I think tests/plugin[s] would be an appropriate
place for them.

> > +# QEMU installed path, set by --prefix during configure
> > +QEMU_PATH ?= /data/src/qemu-inst/plugin-test
> 
> I guess we should use SRC_PATH (or maybe QEMU_SRC_PATH) if we want the
> Makefile to be both invoked as a sub-make from a normal QEMU build and
> to be used as an example for out-of-tree builds.

(As I said, this was a quick hack just to get the RFC out :P)

Thanks,

		Emilio
