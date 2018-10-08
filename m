Received: from eggs.gnu.org ([2001:4830:134:3::10]:57625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1g9a23-00057I-NV
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1g9a21-0001Ny-Jn
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:13:27 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f]:43771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1g9a21-0001IW-0F
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:13:25 -0400
Received: by mail-qk1-x72f.google.com with SMTP id 12-v6so5753447qkj.10
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 11:13:11 -0700 (PDT)
References: <20180906111107.30684-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e71245c5-25aa-432c-a8f6-36cd3f684e61@gmail.com>
Date: Mon, 8 Oct 2018 15:13:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180906111107.30684-1-danielhb413@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com

ping

On 9/6/18 8:11 AM, Daniel Henrique Barboza wrote:
> changes in v2:
> - removed the "RFC" marker;
> - added a new patch (patch 2) that removes
> bdrv_snapshot_delete_by_id_or_name from the code;
> - made changes in patch 1 as suggested by Murilo;
> - previous patch set link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
>
>
> It is not uncommon to see bugs being opened by testers that attempt to
> create VM snapshots using HMP. It turns out that "0" and "1" are quite
> common snapshot names and they trigger a lot of bugs. I gave an example
> in the commit message of patch 1, but to sum up here: QEMU treats the
> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
> is documented as such, but this can lead to strange situations.
>
> Given that it is strange for an API to consider a parameter to be 2 fields
> at the same time, and inadvently treating them as one or the other, and
> that removing the ID field is too drastic, my idea here is to keep the
> ID field for internal control, but do not let the user set it.
>
> I guess there's room for discussion about considering this change an API
> change or not. It doesn't affect users of HMP and it doesn't affect Libvirt,
> but simplifying the meaning of the parameters of savevm/loadvm/delvm.
>
>
> Daniel Henrique Barboza (3):
>    block/snapshot.c: eliminate use of ID input in snapshot operations
>    block/snapshot: remove bdrv_snapshot_delete_by_id_or_name
>    qcow2-snapshot: remove redundant find_snapshot_by_id_and_name call
>
>   block/qcow2-snapshot.c   |  5 -----
>   block/snapshot.c         | 25 +++----------------------
>   hmp-commands.hx          | 24 ++++++++++++------------
>   include/block/snapshot.h |  3 ---
>   qemu-img.c               | 15 +++++++++++----
>   5 files changed, 26 insertions(+), 46 deletions(-)
>
