Received: from eggs.gnu.org ([2001:4830:134:3::10]:57671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpTqO-0005V6-9J
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpTqL-0003MK-76
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:34:20 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpTqK-0003LS-QJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:34:17 -0400
Date: Tue, 14 Aug 2018 03:34:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180814073412.GA32086@flamenco>
References: <20180814013801.26036-1-cota@braap.org>
	<20180814013801.26036-4-cota@braap.org>
	<5a55a78e-d4f2-2528-481c-9eda97718f81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a55a78e-d4f2-2528-481c-9eda97718f81@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] target/i386/translate: use
 thread-local storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, Aug 14, 2018 at 08:31:02 +0200, Paolo Bonzini wrote:
> On 14/08/2018 03:38, Emilio G. Cota wrote:
> > Needed for MTTCG.
> > 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> Why not always use TLS, even in user-mode?

To avoid TLS waste; user-mode uses a single TCGContext,
so a single copy of these variables is all that's needed because
code generation is serialized with a lock.

If in user-mode we just have a few threads it'd be no big deal,
but apps can easily spawn thousands of threads.

		E.
