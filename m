Received: from eggs.gnu.org ([2001:4830:134:3::10]:57609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWcTS-0001Qd-RS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWcTS-0008Rz-4g
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:28:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <94f9fc23-961c-7109-643b-ba1e8c625d92@yandex-team.ru>
Date: Tue, 11 Dec 2018 08:28:48 +0100
In-Reply-To: <94f9fc23-961c-7109-643b-ba1e8c625d92@yandex-team.ru> (Anton
	Kuchin's message of "Mon, 10 Dec 2018 22:10:30 +0300")
Message-ID: <87h8fkbjyn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] block: Is name of BlockBackend deprecated
 with -blockdev parameter?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

I figure Kevin knows, but you typoed his e-mail address.  I fixed it for
you.

Anton Kuchin <antonkuchin@yandex-team.ru> writes:

> Hello,
>
> I'm trying to switch from -drive parameter to -blockdev + -device and
> having problems. Looks like with this option I have no way to set the
> name of=C2=A0 created BlockBackend, but some QMP and HMP commands are
> trying to find blk with blk_by_name() and fail to locate my device
> (e.g. hmp_commit, qmp_x_bloc_latency_histogram_set ...). Was it
> intentional and BB names are going to be deprecated?
>
> This also seems to be a the case for all block devices hotplugged with
> QMP as they use the same code path.
>
> As far as I understand all named backends are stored in
> monitor_block_backends list, but I can't get what is the point of
> having this list, and why parse_drive() function doesn't call
> monitor_add_blk() like blockdev_init() does with -drive option. Can
> someone give me a hint on this?
>
> I also noticed that some commands fallback to search by qdev_id or
> BDS->node_name,=C2=A0 but at the creation time (both in
> bdrv_assing_node_name and monitor_add_blk) it is already checked that
> names are unique across these namespaces so may be it would be useful
> to introduce generic search function?
>
> Thanks,
> Anton
