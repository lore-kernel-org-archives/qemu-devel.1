Received: from eggs.gnu.org ([2001:4830:134:3::10]:44314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBwc-0002PD-Q7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBwX-0000V6-2v
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:01:34 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170221115512.21918-19-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-19-berrange@redhat.com>
Date: Tue, 21 Feb 2017 16:01:22 +0100
Message-ID: <w518tozbnb1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 18/18] block: pass option prefix down to
 crypto layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue 21 Feb 2017 12:55:12 PM CET, Daniel P. Berrange wrote:
> While the crypto layer uses a fixed option name "key-secret",
> the upper block layer may have a prefix on the options. e.g.
> "luks-key-secret", "aes-key-secret", in order to avoid clashes
> between crypto option names & other block option names. To
> ensure the crypto layer can report accurate error messages,
> we must tell it what option name prefix was used.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
