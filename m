Received: from eggs.gnu.org ([2001:4830:134:3::10]:50310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKjt-0008IF-KL
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKjo-0000Id-0P
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:19:57 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQKjn-0000HM-Rc
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:19:51 -0500
Date: Fri, 23 Nov 2018 18:19:48 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181123231948.GB13782@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-11-cota@braap.org>
	<874lc9hwe5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lc9hwe5.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 10/48] exec: export do_tb_flush
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

On Thu, Nov 22, 2018 at 17:09:22 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > This will be used by plugin code to flush the code cache as well
> > as doing other bookkeeping in a safe work environment.
> 
> This seems a little excessive given the plugin code could just call
> tb_flush() directly. Wouldn't calling tb_flush after scheduling the
> plugin_destroy be enough?
> 
> If there is a race condition here maybe we could build some sort of
> awareness into tb_flush as to the current run state. But having two
> entry points to this rather fundamental action seems likely to either be
> misused or misunderstood.

We have to make sure that no callback left in the generated code is
called once a plugin has been uninstalled. To me, using the same safe
work window to both flush the TB and uninstall the plugin seems the
simplest way to do this.

Thanks,

		Emilio
