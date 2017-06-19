Received: from eggs.gnu.org ([2001:4830:134:3::10]:56278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMvDH-0003KU-Iz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMvDE-000562-Hr
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:51:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170616153142.GB4366@noname.fritz.box>
References: <cover.1496844254.git.berto@igalia.com>
	<1f133befcfa4b89978d7fee980bb61ae1298e224.1496844254.git.berto@igalia.com>
	<20170616153142.GB4366@noname.fritz.box>
Date: Mon, 19 Jun 2017 13:50:39 +0200
Message-ID: <w51k248ryb4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 7/7] qcow2: Merge the writing of the COW
 regions with the guest data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri 16 Jun 2017 05:31:42 PM CEST, Kevin Wolf wrote:
>> +        /* Make sure that adding both COW regions to the QEMUIOVector
>> +         * does not exceed IOV_MAX */
>> +        if (hd_qiov->niov > IOV_MAX - 2) {
>> +            continue;
>> +        }
>> +
>> +        m->data_qiov = hd_qiov;
>
> I don't think having this side effect is good for a function that is
> called can_xyz(). I'd either call it merge_cow() or move the
> assignment to the caller.

You're right, I think I prefer to move the assignment to the caller for
now.

Berto
