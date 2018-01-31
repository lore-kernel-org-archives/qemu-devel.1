Received: from eggs.gnu.org ([2001:4830:134:3::10]:46041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egwRg-0001Ce-Bo
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egwRc-0004D5-EO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:45:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egwRc-0004Bj-8x
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:45:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-18-brijesh.singh@amd.com>
Date: Wed, 31 Jan 2018 18:45:01 +0100
In-Reply-To: <20180129174132.108925-18-brijesh.singh@amd.com> (Brijesh Singh's
	message of "Mon, 29 Jan 2018 11:41:26 -0600")
Message-ID: <87mv0tvs6a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 17/23] qapi: add SEV_MEASUREMENT event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Brijesh Singh <brijesh.singh@amd.com> writes:

> Add SEV_MEASUREMENT event which can be used by libvirt to get the
> measurement of the memory regions encrypted through the SEV launch
> flow. The measurement value is base64 encoded.
>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  qapi-schema.json | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 2046c96669bf..e1f5d14e2e3f 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3192,3 +3192,16 @@
>  # Since: 2.11
>  ##
>  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> +
> +##
> +# @SEV_MEASUREMENT:
> +#
> +# Emitted when measurement is available for the SEV guest.
> +#
> +# @value: measurement value encoded in base64
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'event' : 'SEV_MEASUREMENT',
> +  'data' : { 'value' : 'str' } }

New event -> automatic question: do we need a way to poll for this
information?  Say when an event could get lost during a libvirt restart.
