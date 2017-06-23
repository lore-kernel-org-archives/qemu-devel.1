Received: from eggs.gnu.org ([2001:4830:134:3::10]:47311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dON1F-0004v4-9o
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dON1C-0004eu-6B
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dON1B-0004ep-Ti
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:44:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170606110556.12922-1-berrange@redhat.com>
	<20170606110556.12922-2-berrange@redhat.com>
Date: Fri, 23 Jun 2017 13:44:46 +0200
In-Reply-To: <20170606110556.12922-2-berrange@redhat.com> (Daniel
	P. Berrange's message of "Tue, 6 Jun 2017 12:05:55 +0100")
Message-ID: <878tkjexn5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] docs: document deprecated features
 in appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> The deprecation of features in QEMU is totally adhoc currently,
> with no way for the user to get a list of what is deprecated
> in each release. This adds an appendix to the doc that records
> when each deprecation[1] was made and provides text explaining
> what to use instead.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>
> [1] This is a lie. I've only listed one deprecated feature. Once
>     we agree on the general concept, we can fill out the doc
>     with the rest of the currently deprecated features.

As written, this is PATCH RFC.  We can either collect the currently
deprecated features before we commit (with the footnote dropped), or
collect later (but then we should note the incompleteness in
qemu-doc.texi, not just the commit message).

> ---
>  qemu-doc.texi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 965ba59..29f89d8 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -37,6 +37,7 @@
>  * QEMU Guest Agent::
>  * QEMU User space emulator::
>  * Implementation notes::
> +* Deprecations::
>  * License::
>  * Index::
>  @end menu
> @@ -3016,6 +3017,19 @@ Run the emulation in single step mode.
>  
>  @include qemu-tech.texi
>  
> +@node Deprecations

Perhaps "Deprecated Features"?  Not a native speaker...

> +@appendix Deprecations
> +
> +The following is a list of features which have been marked as deprecated,
> +pending removal in a future release:
> +
> +@section -drive boot=on|off (since v1.3.0)
> +Since release 1.3.0, the ``boot=on|off'' parameter to ``-drive''

I wouldn't repeat "since v1.3.0".  It'll get old quickly when the list
grows.

> +is no longer honoured. It is currently ignored, but a future verson
> +will reject this parameter with an error. Applications should use
> +the ``bootindex=N'' parameter to set an absolute ordering between
> +devices instead.
> +
>  @node License
>  @appendix License

I like it.

Of course, new deprecations need to be in release notes, too.  If the
duplication bothers us, we could perhaps just point to release notes.
We'd have to check and amend old release notes to make sure all
currently deprecated features are covered.
