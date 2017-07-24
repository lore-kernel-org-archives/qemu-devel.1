Received: from eggs.gnu.org ([2001:4830:134:3::10]:36267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZdjw-0007ld-V4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZdju-0004AR-7Q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:49:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZdju-00047u-0j
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:49:38 -0400
References: <20170719100802.14094-1-berrange@redhat.com>
	<20170719100802.14094-2-berrange@redhat.com>
	<d659c0cb-0cb2-3af7-b97f-05ad15aa3550@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee0b3e06-7037-f2c9-18e9-1fb1dcb0784a@redhat.com>
Date: Mon, 24 Jul 2017 15:49:29 +0200
MIME-Version: 1.0
In-Reply-To: <d659c0cb-0cb2-3af7-b97f-05ad15aa3550@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/2 (for 2.10)] docs: document support
 lifetime for features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 19/07/2017 13:56, Thomas Huth wrote:
> +@node Machine types
> +@section Machine types
> +
> +For architectures which aim to support live migration compatibility
> +across releases, each release will introduce a new versioned machine
> +type. For example, the 2.8.0 release introduced machine types
> +``pc-i440fx-2.8'' and ``pc-q35-2.8'' for the x86_64/i686 architectures.
> +
> +To allow live migration of a guest running on a 2.8.0 release to a
> +2.9.0, the QEMU 2.9.0 version must support the ``pc-i440fx-2.8'' and
> +``pc-q35-2.8''. To allow users live migrating VMs to skip multiple
> +intermediate releases when upgrading, new releases of QEMU will
> +support machine types from many previous versions.
> +
> +The supported lifetime for versioned machine types is 12 releases,
> +which is equivalent to 4 years worth of previous QEMU releases.

I think there's still no consensus on this.  The first two paragraphs
should be added to the documentation for -machine in qemu-options.hx,
since "-machine [type=]foo" is currently not documented at all.

Paolo
