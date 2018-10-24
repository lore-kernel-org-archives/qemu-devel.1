Received: from eggs.gnu.org ([2001:4830:134:3::10]:46773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gFG0T-000473-IO
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gFG0L-0004yg-PI
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gFG0I-0004uY-Pa
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:03:07 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1db52b5ec7066f2fbc286288f97cc4946f94145e.1536948621.git.manish.jaggi@cavium.com>
	(mjaggi's message of "Tue, 23 Oct 2018 09:31:18 +0000")
References: <cover.1536948621.git.manish.jaggi@cavium.com>
	<1db52b5ec7066f2fbc286288f97cc4946f94145e.1536948621.git.manish.jaggi@cavium.com>
Reply-To: quintela@redhat.com
Date: Wed, 24 Oct 2018 12:02:54 +0200
Message-ID: <87sh0vll0x.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] [RFC] arm: Introduce hostinvariant
 command line option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjaggi@caviumnetworks.com
Cc: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair,
	Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki,
	Tomasz" <Tomasz.Nowicki@cavium.com>

<mjaggi@caviumnetworks.com> wrote:
> From: Manish Jaggi <manish.jaggi@cavium.com>
>
> This option is user opt-in. hostinvariant will replace guest's invariant
> registers with hosts.
>
> Signed-off-by: Manish Jaggi <manish.jaggi@cavium.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

As I said in previous discussions, I still think that you should create
a better cpu model.  But as there is nothing like that on ARM, this is a
"showstop" solution.

Later, Juan.
