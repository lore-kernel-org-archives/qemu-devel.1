Received: from eggs.gnu.org ([2001:4830:134:3::10]:40936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1Mmo-0001cC-7g
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 21:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1Mml-0005PB-6V
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 21:55:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f1Mml-0005Ll-0w
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 21:55:27 -0400
References: <20180328163630.48576-1-dgilbert@redhat.com>
	<20180328163630.48576-6-dgilbert@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <780d6d45-84a6-34db-e65f-3d38a6d0ea66@redhat.com>
Date: Thu, 29 Mar 2018 09:55:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180328163630.48576-6-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] e1000: Choose which set of props to
 migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, eswierk@skyportsystems.com, pbonzini@redhat.com
Cc: peterx@redhat.com, quintela@redhat.com



On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 00:36, Dr. David Alan Gilbert (git=
) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> When we're using the subsection we migrate both
> the 'props' and 'tso_props' data; when we're not using
> the subsection (to migrate to 2.11 or old machine types) we've
> got to choose what to migrate in the main structure.
>
> If we're using the subsection migrate 'props' in the main structure.
> If we're not using the subsection then migrate the last one
> that changed, which gives behaviour similar to the old behaviour.
>
>

But only after migration. Why not simply switch back to the old behavior=20
if migrate_tso_props if false?

Thanks
