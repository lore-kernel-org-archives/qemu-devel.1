Received: from eggs.gnu.org ([2001:4830:134:3::10]:33291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1jMA-0008At-MD
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1jM5-0006Wn-TI
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:01:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f1jM5-0006WX-OA
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:01:25 -0400
References: <20180328163630.48576-1-dgilbert@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0ce442bf-d277-6e1a-d6c0-cbf5fc8664d6@redhat.com>
Date: Fri, 30 Mar 2018 10:01:16 +0800
MIME-Version: 1.0
In-Reply-To: <20180328163630.48576-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] e1000 migration changes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, eswierk@skyportsystems.com, pbonzini@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com



On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 00:36, Dr. David Alan Gilbert (git=
) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Hi,
>    This set of patches change the e1000 migration code to make
> it easier to keep with compatibility with older versions in backwards
> migration.
>
> I think the first 3 patches are fairly uncontrovercial and I would like
> them for 2.12; it would be nice to have the lot since changing them
> after we've shipped is much more difficult.
>
> v2
>    Ed and Paolo answered my question that I asked in the cover letter;
> and I think I've followed the advice - although my testing has been
> very light.  The new patches do two things:
>     a) When we receive a stream without the subsection we duplicate the
> received pops state into both props and tso_props.
>     b) When we send without the subsection we decide which set to send
> in the main part of the state based on which state was last changed.
>
> Dave
>
> Dr. David Alan Gilbert (6):
>    e1000: Convert v3 fields to subsection
>    e1000: Dupe offload data on reading old stream
>    e1000: wire new subsection to property
>    e1000: Migrate props via a temporary structure
>    e1000: Choose which set of props to migrate
>    e1000: Old machine types, turn new subsection off
>
>   hw/net/e1000.c      | 103 ++++++++++++++++++++++++++++++++++++++++---=
---------
>   include/hw/compat.h |   4 ++
>   2 files changed, 84 insertions(+), 23 deletions(-)
>

Reviewed-by: Jason Wang <jasowang@redhat.com>
