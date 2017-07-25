Received: from eggs.gnu.org ([2001:4830:134:3::10]:42843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZwG7-0008LN-Fx
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZwG2-0000aU-Gt
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZwG2-0000Wz-B0
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:36:02 -0400
References: <20170719100802.14094-1-berrange@redhat.com>
	<20170719100802.14094-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c54bf8d4-571e-e4b5-0103-e23be3785139@redhat.com>
Date: Tue, 25 Jul 2017 11:35:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170719100802.14094-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2 (for 2.10)] docs: document
 deprecated features in appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 19.07.2017 12:08, Daniel P. Berrange wrote:
> The deprecation of features in QEMU is totally adhoc currently,
> with no way for the user to get a list of what is deprecated
> in each release. This adds an appendix to the doc that records
> when each deprecation was made and provides text explaining
> what to use instead, if anything.
> 
> Since there has been no formal policy around removal of deprecated
> features in the past, any deprecations prior to 2.10.0 are to be
> treated as if they had been made at the 2.10.0 release. Thus the
> earliest that existing deprecations will be deleted is the start
> of the 2.12.0 cycle.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-doc.texi | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
[...]
> +@subsection -monitor default=on (since 2.4.0)
> +
> +The ``default'' option to the ``-monitor'' argument is
> +now ignored. When multiple monitors were enabled, it
> +indicated which monitor would receive log messages
> +from the various subsystems. This feature is no longer
> +required as messages are now only sent to the monitor
> +in response to explicitly monitor commands.

BTW, seems like it's the "-mon" option, not the "-monitor" option that
has this "default" parameter?

 Thomas
