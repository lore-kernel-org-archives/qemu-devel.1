Received: from eggs.gnu.org ([2001:4830:134:3::10]:37440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8yKN-0005SX-Nv
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8y5L-00070b-CD
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:42:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8y5L-00070T-5s
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:42:19 -0400
Date: Sat, 6 Oct 2018 21:42:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181007014216.GC23787@flamenco>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005154910.3099-5-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 04/21] trace: enable the exec_tb trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Fri, Oct 05, 2018 at 16:48:53 +0100, Alex Bennée wrote:
> Our performance isn't so critical that we can't spare a simple flag
> check when we exec a TB considering everything else we check in the
> outer loop.

[I know this is just done to illustrate how function names
in plugins can bind to tracing calls, but someone might
get confused by expecting more from "exec_tb" than it
actually does.]

This flag check costs nothing because "exec_tb" is
almost never called. The way it works right now, we
need -d nochain for "exec_tb" to actually generate
an event every time a TB executes.

IMO an eventual plugin API should let plugins decide whether
to subscribe to the execution of a particular TB, when
said TB is being translated, instead of providing
an all-or-nothing switch.

Thanks,

		E.
