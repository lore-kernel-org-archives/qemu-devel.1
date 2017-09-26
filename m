Received: from eggs.gnu.org ([2001:4830:134:3::10]:42732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwsWg-0005CO-5O
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwsWK-0002Kb-87
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:16:02 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dwsWJ-0002JP-Ul
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:15:40 -0400
Date: Tue, 26 Sep 2017 12:15:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170926161538.GA8446@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56622fe7-22cf-4a41-01e0-8e64cbef412f@redhat.com>
	<c9b8e5af-3ccb-5747-78b4-de8e11e5e081@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Sep 26, 2017 at 06:22:31 +0200, Thomas Huth wrote:
> Sorry for my ignorance, but if you send a patch series like this, could
> you please elaborate a little bit more on the topic what this all is
> about? In this cover letter, you basically give only some pointers about
> other patch series and point the reader to patch 2, but also patch 2
> does not really have a proper *description* of what this is really all
> about. Sure, it's about plugins, but what kind of plugins? Audio? Video?
> CPU? Everything? If you send RFC, you should properly describe your
> vision first, and maybe give some examples, before you jump into the
> details.

On Tue, Sep 26, 2017 at 06:27:01 +0200, Thomas Huth wrote:
> If you introduce new .c files, please add some sentences with a proper
> description in the header with some very high level description about
> what the code in the file is supposed to be doing. Just reading "plugin
> interface" is not really very helpful when trying to understand new code.

You make very good points.

It was an RFC aimed mostly at people who had been following the previous
threads on this topic. However, I understand people who had not followed
those threads lacked the necessary context. Sorry about that.

As Stefan pointed out, the goal is to provide some sort of instrumentation
a la Pin/DynamoRIO. The extent of said instrumentation is still to be decided,
although we agree on that at least we should be able to "instrument" (i.e.
observe via callbacks) instructions executed and memory accesses in the guest.

Currently I'm working bottom-up on this; my goal is to simulate an ARMv8
system, so for that I need to feed the instruction stream and memory accesses
to the timing model. This could be done in different ways, so I'll evaluate
the alternatives to see how they affect performance.

Note that plugin (or instrumentation) support has been implemented in the
past. However, this was for academic projects and the code was never submitted
to the list. Some examples:
- QTrace
  code: https://github.com/x-y-z/QTRACE
  paper: http://ieeexplore.ieee.org/document/7095810/ (paywall)
- Decaf
  code: https://github.com/sycurelab/DECAF
  paper: http://www.cs.ucr.edu/~heng/pubs/issta14.pdf
- QSim
  code: https://github.com/gtcasl/qsim
  paper: http://ieeexplore.ieee.org/abstract/document/6429075/ (paywall)
- PEMU
  code: https://github.com/utds3lab/pemu
  paper: http://www.utdallas.edu/~zxl111930/file/VEE15.pdf
- ESESC
  code: https://github.com/masc-ucsc/esesc
  paper: https://users.soe.ucsc.edu/~renau/docs/hpca13.pdf

Thanks,

		Emilio
