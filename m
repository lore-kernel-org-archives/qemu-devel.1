Received: from eggs.gnu.org ([2001:4830:134:3::10]:44486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXTwZ-0003np-3O
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXTwX-0002TN-FH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:34:35 -0500
References: <20181213162727.17438-1-lvivier@redhat.com>
	<20181213162727.17438-2-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <827ac081-587f-d365-b682-3a65271a0a4a@redhat.com>
Date: Thu, 13 Dec 2018 10:34:12 -0600
MIME-Version: 1.0
In-Reply-To: <20181213162727.17438-2-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block/ssh: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 12/13/18 10:27 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>=20
> Notes:
>      v2: use %zu with size_t
>          change an uint64_t to int64_t to match % PRIi64

Why PRIi64?  It's identical to PRId64, but the sources show a strong=20
preference for %d over %i:

$ git grep PRIi[0-9] | wc
      25     172    1885
$ git grep PRId[0-9] | wc
     415    3991   40345

$ git grep '%i' | wc
     231    1664   18269
$ git grep '%d' | wc
    5492   46211  498225

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
