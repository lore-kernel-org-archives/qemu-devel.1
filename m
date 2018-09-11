Received: from eggs.gnu.org ([2001:4830:134:3::10]:50040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzixY-0006MT-8Y
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzixX-0008Uw-Ft
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:44:04 -0400
References: <20180907121319.8607-1-marcandre.lureau@redhat.com>
	<20180907121319.8607-2-marcandre.lureau@redhat.com>
	<0ac178fc-b237-2263-b32f-cd5bf91cea2b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af938c47-6d34-bd69-411d-819892bffac3@redhat.com>
Date: Tue, 11 Sep 2018 15:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <0ac178fc-b237-2263-b32f-cd5bf91cea2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] util: add qemu_write_pidfile()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 07/09/2018 16:03, Eric Blake wrote:
> On 09/07/2018 07:13 AM, Marc-Andr=C3=A9 Lureau wrote:
>> There are variants of qemu_create_pidfile() in qemu-pr-helper and
>> qemu-ga. Let's have a common implementation in libqemuutil.
>>
>=20
> Unrelated to this patch, but a question that this raises: should
> 'qemu-nbd' also have a mode for creating a pid file, since it has --for=
k
> for daemonizing the server process?

Yes, it's probably a good idea.  --fork mode is used mostly with -c/-d,
but why not.

Paolo
