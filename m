Received: from eggs.gnu.org ([2001:4830:134:3::10]:56976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f85AA-0005xX-Ua
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f85A6-0007Ao-4J
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:31:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f02789cc-d5a6-eaf9-b457-396bea318d14@redhat.com>
References: <cover.1521016003.git.berto@igalia.com>
	<14bbd13c5c93211ed4e36188624f429087a6a273.1521016003.git.berto@igalia.com>
	<b9df06c2-0116-8e5c-6725-a59b6d03ed6b@redhat.com>
	<w51d0yzgsph.fsf@maestria.local.igalia.com>
	<f02789cc-d5a6-eaf9-b457-396bea318d14@redhat.com>
Date: Mon, 16 Apr 2018 16:31:15 +0200
Message-ID: <w51a7u3gr4c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: Give the refcount cache the
 minimum possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon 16 Apr 2018 04:05:21 PM CEST, Max Reitz wrote:
>> Refcount entries are used to reference host clusters, and host
>> clusters are always(*) allocated sequentially, so caching refcount
>> blocks doesn't do much. You're always loading the same refcount block
>> until it's full, then you move on to the next one. As I mentioned in
>> a previous e-mail, having a very large refcount cache would even be
>> detrimental because it would make cache hits slower (noticeable under
>> tmpfs).
>
> Ah, right.  I'm not sure whether I want to ask you whether you have
> tested internal snapshots.  I suppose it can be detrimental for them
> because when taking or deleting a snapshot you need to update the
> refcounts of a whole bunch of clusters that might be spread randomly
> across the image.  But I suspect that it would be rather
> time-consuming to produce an image with such a configuration; and I
> suppose if people want to make heavy use of internal snapshots they
> can adapt the cache size themselves?

Exactly.

Berto
