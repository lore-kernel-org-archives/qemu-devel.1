Received: from eggs.gnu.org ([2001:4830:134:3::10]:53835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ7cs-0008Pw-3N
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ7co-0000OF-Oe
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:43:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQ7co-0000O7-Iq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:42:58 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170623144823.42936-1-pasic@linux.vnet.ibm.com> (Halil Pasic's
	message of "Fri, 23 Jun 2017 16:48:23 +0200")
References: <20170623144823.42936-1-pasic@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 09:42:52 +0200
Message-ID: <87mv8s7e2r.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] vmstate: error hint for failed equal
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> In some cases a failing VMSTATE_*_EQUAL does not mean we detected a bug,
> but it's actually the best we can do. Especially in these cases a verbose
> error message is required.
>
> Let's introduce infrastructure for specifying a error hint to be used if
> equal check fails. Let's do this by adding a parameter to the _EQUAL
> macros called _err_hint. Also change all current users to pass NULL as
> last parameter so nothing changes for them.
>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks.
