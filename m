Received: from eggs.gnu.org ([2001:4830:134:3::10]:54066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gL99R-0004lA-F0
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gL99O-0001j1-7q
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:56:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gL99O-0001aI-10
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:56:50 -0500
Date: Fri, 9 Nov 2018 10:56:40 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181109155640.GA12624@flamenco>
References: <20181109153002.597-1-crosa@redhat.com>
	<20181109153002.597-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109153002.597-2-crosa@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] tests/test-qht-par: test gets
 stuck intermittently on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, programmingkidx@gmail.com, Caio Carrara <ccarrara@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, Nov 09, 2018 at 10:30:01 -0500, Cleber Rosa wrote:
> To be fully honest, this may not be a OSX (alone) condition, but may
> be a situation that only happens with OSX on Travis-CI, were resources
> are quite limited.
> 
> I have personal experience with tests that exercise parallelism or
> depend on timing to fail on Travis.  Because I'm not 100% certain that
> this is a situation that only happens with OSX on Travis-CI, and
> because I'm not certain that we should be skipping tests because
> they're running on Travis-CI, let's disable them on OSX as a whole.
> 
> A small note: this type of change makes me believe that there should
> be a list of testing related caveats or TODO list tracked on the
> documentation.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Is there a way to know where it hangs?

Also, are these the g_test_quick tests, or the other ones? It it's
just a matter of the program taking too long to run, we could just
reduce the length of the !quick tests (currently at 5s vs. 1s for
the quick ones).

Thanks,

		Emilio
