Received: from eggs.gnu.org ([2001:4830:134:3::10]:55053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gIG0T-0003nX-Qr
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gIG0N-0000Oc-5a
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:39:41 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181101163037.800-1-peter.maydell@linaro.org>
References: <20181101163037.800-1-peter.maydell@linaro.org>
Date: Thu, 01 Nov 2018 17:38:33 +0100
Message-ID: <w51bm783g8m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-3.1] blockdev:
 Consistently use snapshot_node_name in external_snapshot_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 01 Nov 2018 05:30:37 PM CET, Peter Maydell wrote:
> In the function external_snapshot_prepare() we have a
> BlockdevSnapshotSync struct, which has the usual combination
> of has_snapshot_node_name and snapshot_node_name fields for an
> optional field. We set up a local variable
>         const char *snapshot_node_name =
>             s->has_snapshot_node_name ? s->snapshot_node_name : NULL;
>
> and then mostly use "if (!snapshot_node_name)" for checking
> whether we have a snapshot node name. The exception is that in
> one place we check s->has_snapshot_node_name instead. This
> confuses Coverity (CID 1396473), which thinks it might be
> possible to get here with s->has_snapshot_node_name true but
> snapshot_node_name NULL, and warns that the call to
> qdict_put_str() will segfault in that case.
>
> Make the code consistent and unconfuse Coverity by using
> the same check for this conditional that we do in the rest
> of the surrounding code.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
