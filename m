Received: from eggs.gnu.org ([2001:4830:134:3::10]:56044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0oJa-0003rn-TQ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0oJW-0006tv-0c
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:07:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f0oJV-0006s9-S1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:06:57 -0400
References: <20180327113452.19613-1-dgilbert@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0cb312f6-6c36-25ac-3c9a-0d9626abac56@redhat.com>
Date: Tue, 27 Mar 2018 21:06:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180327113452.19613-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] e1000 migration changes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, eswierk@skyportsystems.com
Cc: quintela@redhat.com, peterx@redhat.com



On 2018=E5=B9=B403=E6=9C=8827=E6=97=A5 19:34, Dr. David Alan Gilbert (git=
) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Hi Ed, Jason,
>    This set of patches change the e1000 migration code to make
> it easier to keep with compatibility with older versions in backwards
> migration;  but I do need some advice whether I need to do more as well=
.
>
> I think the first and second patch are fairly uncontrovercial and I
> would like them for 2.12, since it'll make any future changes easier.
> The third one changes the default behaviour, so again I'd prefer it but
> lets see what you think.

The patches looks good to me. So for the changes of default behavior,=20
did you mean we can make the migration to older versions work?

>
> My question however, without knowing the internals of the e1000, is
> whether when ommitting the subsection, should the code in 2.12 be
> changing the data it sends back in the main section of data?

I'm not sure I get the meaning here. But it looks to me turning it off=20
for old machine types makes sense, otherwise, management need to set it=20
explicitly.

Thanks

>
> Dave
>
>   =20
>
> Dr. David Alan Gilbert (3):
>    e1000: Convert v3 fields to subsection
>    e1000: wire new subsection to property
>    e1000: Old machine types, turn new subsection off
>
>   hw/net/e1000.c      | 46 ++++++++++++++++++++++++++++++++++----------=
--
>   include/hw/compat.h |  4 ++++
>   2 files changed, 38 insertions(+), 12 deletions(-)
>
