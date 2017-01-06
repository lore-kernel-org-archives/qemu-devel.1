Received: from eggs.gnu.org ([2001:4830:134:3::10]:40387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPYHd-0005AV-Sq
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPYHZ-0004FE-S2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:26:29 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:36957 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cPYHZ-0004F5-F3
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:26:25 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-47-berrange@redhat.com>
Date: Fri, 06 Jan 2017 18:26:20 +0100
In-Reply-To: <20170106155543.12827-47-berrange@redhat.com> (Daniel
	P. Berrange's message of "Fri, 6 Jan 2017 15:55:42 +0000")
Message-ID: <87wpe814n7.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 46/47] trace: update docs to reflect new
 code generation approach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Daniel P Berrange writes:

> Describe use of per-subdir trace events files and how it impacts
> code generation.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  docs/tracing.txt | 61 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 52 insertions(+), 9 deletions(-)

> diff --git a/docs/tracing.txt b/docs/tracing.txt
> index f351998a..3262a61 100644
> --- a/docs/tracing.txt
> +++ b/docs/tracing.txt
> @@ -27,18 +27,51 @@ for debugging, profiling, and observing execution.
 
>  == Trace events ==
 
> +=== Sub-directory setup ===
> +
>  Each directory in the source tree can declare a set of static trace events
> -in a "trace-events" file. Each trace event declaration names the event, its
> -arguments, and the format string which can be used for pretty-printing:
> +in a "trace-events" file. The first (non-comment) statement in the file
> +must be "@id_offset(NN)" where NN is an integer that is unique among all
> +"trace-events" files in the QEMU source tree. The IDs can be arbitrarily
> +chosen, but for extra fun the current "trace-events" files use values from
> +the "powerful number" integer sequence :-)

I think that the description of @id_offset is a leftover from a previous version
of the series.


Cheers,
  Lluis
