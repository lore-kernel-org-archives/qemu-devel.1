Received: from eggs.gnu.org ([209.51.188.92]:51472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1TXM-000376-47
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1TXK-0005zU-Ac
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:12:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1TXJ-0005yq-NV
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:12:30 -0500
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
	<150efd5f-dea0-93bd-c74c-6d012f4ab7d1@redhat.com>
	<d8dd795b-1f4c-a802-e4ea-6cf06cdab5c6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6bd609b0-15e2-6a9e-2639-7904db417c0f@redhat.com>
Date: Wed, 6 Mar 2019 11:12:25 +0100
MIME-Version: 1.0
In-Reply-To: <d8dd795b-1f4c-a802-e4ea-6cf06cdab5c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>

On 05/03/2019 21.08, Eric Blake wrote:
[...]
> 'make distclean' is a heavy hammer, is there anything smaller in scope
> that will fix the problem without nuking everything, such as a strategi=
c
> touch or rm of one particular file?

Try this in the top-level folder of your build directory:

 rm *.mak.d

... not sure whether we can somehow integrate that into the Makefile
magic, though...

 Thomas
