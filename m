Received: from eggs.gnu.org ([209.51.188.92]:57662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwU3p-0000Mh-Rx
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwU3i-0002dj-HB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:45:24 -0500
References: <1550652953-24393-1-git-send-email-like.xu@linux.intel.com>
	<27254af5-b490-165f-8ca3-f60ab7642d72@redhat.com>
	<b10cd713-1441-92fb-59e3-4b3162728070@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30d93f35-8ee4-e6e5-69e6-237322ab816c@redhat.com>
Date: Wed, 20 Feb 2019 07:45:31 -0600
MIME-Version: 1.0
In-Reply-To: <b10cd713-1441-92fb-59e3-4b3162728070@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] doc: update .gitignore and fix typos for
 docs in tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>, qemu-trivial@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 2/19/19 11:39 PM, Like Xu wrote:
> On 2019/2/20 11:09, Eric Blake wrote:
>> On 2/20/19 2:55 AM, Like Xu wrote:
>>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>>
>> This feels like two independent patches - the .gitignore change is
>> different from typo fixes.
>>
>> Actually, for .gitignore, you could just as easily do:
>>
>> echo '*.patch' >> .git/info/exclude
>>
>> and fix it so you never commit patch files locally, while still leavin=
g
>> them visible through 'git status' to other users.=C2=A0 I actually lik=
e
>> knowing when I have stale patch files lying around, so that I can 'rm'
>> them before creating my next patch batch and using 'git send-email
>> *.patch' - but of course, I could just as easily add '!*.patch' to my
>> .git/info/exclude to override the project default if we decide to go
>> with your patch.
>=20
> Adding '*.patch' to .gitignore is consistent with LKML tree.

Fair enough - but then make it a separate patch, and include that
justification in your commit message.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
