Received: from eggs.gnu.org ([2001:4830:134:3::10]:59706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLPM-0004Kt-N8
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLPH-0003Bv-Np
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:02:48 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQLPH-00030I-4Z
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:02:43 -0500
Date: Fri, 23 Nov 2018 19:02:40 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181124000240.GB17229@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-17-cota@braap.org>
	<87tvk7hh2o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvk7hh2o.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 16/48] tcg: add plugin_mask to TB hash
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

On Fri, Nov 23, 2018 at 16:52:31 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> This commit message needs more description. What is this plugin mask
> for? Are we extending the TB flags with a mask of loaded plugins so we
> can correctly identify what code was generated under what plugins?

This is similar to the bitmap for trace events, which we added to the
TB hash so that when the TCG events have no subscribers left, we just
regenerate the TBs.

It's true though that in this RFC there are no good use cases for this,
because the callbacks that affect performance are all unconditionally
embedded in the generated code. So at least for now we could drop
this patch.

Thanks,

		Emilio
