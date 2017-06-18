Received: from eggs.gnu.org ([2001:4830:134:3::10]:55782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbOD-0006ke-No
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbO8-0005Qw-SF
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:41:21 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:57384 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbO8-0005PR-G8
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:41:16 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727927074.28532.17986481795216498698.stgit@frigg.lan>
	<20170616001842.GA25056@flamenco>
Date: Sun, 18 Jun 2017 17:41:02 +0300
In-Reply-To: <20170616001842.GA25056@flamenco> (Emilio G. Cota's message of
	"Thu, 15 Jun 2017 20:18:42 -0400")
Message-ID: <87mv95cq9t.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 6/6] target: [tcg,
 arm] Port to generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> On Mon, Jun 12, 2017 at 17:54:30 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> target/arm/translate-a64.c |  346 ++++++++++-----------
>> target/arm/translate.c     |  720 ++++++++++++++++++++++----------------=
------
>> target/arm/translate.h     |   46 ++-
>> 3 files changed, 560 insertions(+), 552 deletions(-)

> This one makes my arm-softmmu hang while booting debian. The last line
> I see is:

>> Freeing unused kernel memory: 300K (80669000 - 806b4000)

> Note that this happens even after disabling goto_ptr, so it shouldn't
> be related to that feature.

> The problem might be with the rebase. For instance, the
> hunk below was modified by commit 542b3478a ("armv7m: Replace armv7m.hack
> with unassigned_access handler"). Might be a good idea to go over
> the latest changes to arm/translate.c. What commit was your last working
> version based on?

I didn't write it down on the series docs, so I don't really know. I'll bre=
ak
the patch down into multiple as you suggested, and review them manually to =
see
if I'm able to catch the error (all the exit reason code is quite burdensom=
e to
port to the new infrastructure).

Is there any ready-made kernel or disk image I can test with?


Thanks,
  Lluis
