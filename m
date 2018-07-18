Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffnpT-0004Kj-RC
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffnpT-0001Ib-54
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:53:23 -0400
Date: Wed, 18 Jul 2018 11:53:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180718145312.GZ31657@localhost.localdomain>
References: <20180717234015.22700-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180717234015.22700-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] qemu-iotests: Adapt to moved
 location of StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

On Tue, Jul 17, 2018 at 08:40:15PM -0300, Philippe Mathieu-Daud=E9 wrote:
[...]
> -    import StringIO
> +    try:
> +        from StringIO import StringIO
> +    except ImportError:
> +        from io import StringIO

Why do we need this?  Python 2.7 has io.StringIO.

--=20
Eduardo
