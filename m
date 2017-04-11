Received: from eggs.gnu.org ([2001:4830:134:3::10]:39726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxuuR-0005kf-OW
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxuuO-0004Sj-Kr
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:28:35 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxuuO-0004SP-DP
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:28:32 -0400
Received: by mail-wm0-x230.google.com with SMTP id u2so59754641wmu.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 05:28:32 -0700 (PDT)
References: <20170411095654.18383-1-stefanha@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170411095654.18383-1-stefanha@redhat.com>
Date: Tue, 11 Apr 2017 13:28:39 +0100
Message-ID: <87inmbjfgo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] simpletrace: document Analyzer method
 signatures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org


Stefan Hajnoczi <stefanha@redhat.com> writes:

> Users can inherit from the simpletrace.Analyzer class and receive
> callbacks when events of interest occur in a trace file.  The method
> signature is a little magic because the timestamp and pid arguments are
> optional.  Document this.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  scripts/simpletrace.py | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> index 4c99004..d60b3a0 100755
> --- a/scripts/simpletrace.py
> +++ b/scripts/simpletrace.py
> @@ -116,7 +116,28 @@ class Analyzer(object):
>      is invoked.
>
>      If a method matching a trace event name exists, it is invoked to process
> -    that trace record.  Otherwise the catchall() method is invoked."""
> +    that trace record.  Otherwise the catchall() method is invoked.
> +
> +    Example:
> +    The following method handles the runstate_set(int new_state) trace event::
> +
> +      def runstate_set(self, new_state):
> +          ...
> +
> +    The method can also take a timestamp argument before the trace event
> +    arguments::
> +
> +      def runstate_set(self, timestamp, new_state):
> +          ...
> +
> +    Timestamps have the uint64_t type and are in nanoseconds.
> +
> +    The pid can be included in addition to the timestamp and is useful when
> +    dealing with traces from multiple processes::
> +
> +      def runstate_set(self, timestamp, pid, new_state):
> +          ...
> +    """
>
>      def begin(self):
>          """Called at the start of the trace."""


--
Alex Bennée
