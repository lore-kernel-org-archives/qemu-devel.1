Received: from eggs.gnu.org ([2001:4830:134:3::10]:36479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4fv-0007G1-94
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4et-0003EJ-Ky
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:56:57 -0500
Date: Tue, 6 Nov 2018 17:54:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106165427.GE4758@linux.fritz.box>
References: <20181101163037.800-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101163037.800-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1] blockdev: Consistently use
 snapshot_node_name in external_snapshot_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 01.11.2018 um 17:30 hat Peter Maydell geschrieben:
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

Thanks, applied to the block branch.

Kevin
