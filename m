Received: from eggs.gnu.org ([2001:4830:134:3::10]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eC2fe-0003HD-5Q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eC2fa-000572-1A
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:07:58 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <c12f0934-d3a6-10e2-918f-7602518789ad@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-17-mreitz@redhat.com>
	<w51shdwwxpn.fsf@maestria.local.igalia.com>
	<b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
	<c12f0934-d3a6-10e2-918f-7602518789ad@redhat.com>
Date: Tue, 07 Nov 2017 13:07:40 +0100
Message-ID: <w51lgji2sxf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 16/25] block: Add 'base-directory' BDS
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Thu 02 Nov 2017 11:06:28 PM CET, Eric Blake wrote:

>>>> Using this option, one can directly override what bdrv_dirname()
>>>> will return. This is useful if one uses e.g. qcow2 on top of quorum
>>>> (with only protocol BDSs under the quorum BDS) and wants to be able
>>>> to use relative backing filenames.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>
>>> Who would be using this option in practice? I understand that
>>>management tools should be using always absolute filenames, and this
>>>API doesn't seem so convenient for humans.
>> 
>> Hmmm.  I seem to recall Eric liked it a couple of years ago when he
>> was still more on the libvirt side of things. :-)
>
> Ideally, libvirt should be using node names rather than filenames
> (whether absolute or relative); but I still think it could be
> something that turns out to be useful.

But what would be the use case? For a management tool it's not more
convenient to use relative file names, or is it?

Berto
