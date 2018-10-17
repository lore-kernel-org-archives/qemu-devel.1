Received: from eggs.gnu.org ([2001:4830:134:3::10]:45916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCnq9-0000s4-WB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCnq2-0006Yt-GL
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:34:28 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181017153132.GI31479@localhost.localdomain>
References: <cover.1539786605.git.berto@igalia.com>
	<e0ba08677155b2cf3820b580fb5057458ed017d0.1539786605.git.berto@igalia.com>
	<20181017153132.GI31479@localhost.localdomain>
Date: Wed, 17 Oct 2018 17:34:09 +0200
Message-ID: <w518t2woadq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] quorum: Return an error if the
 blkverify mode has invalid settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed 17 Oct 2018 05:31:32 PM CEST, Kevin Wolf wrote:
> Am 17.10.2018 um 16:33 hat Alberto Garcia geschrieben:
>> The blkverify mode of Quorum can only be enabled if the number of
>> children is exactly two and the value of vote-threshold is also two.
>> 
>> If the user tries to enable it but the other settings are incorrect
>> then QEMU simply prints an error message to stderr and carries on
>> disabling the blkverify setting.
>> 
>> This patch makes quorum_open() fail and return an error in this case.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>
> While reviewing this, I think I found another problem: Shouldn't
> .bdrv_add_child refuse to add a child if s->is_blkverify == true? (And
> probably assert in .bdrv_del_child that s->is_blkverify == false after
> checking s->num_children <= s->threshold)

I think you're right. Do you want me to send this in a later patch or do
you prefer that I make it part of this series?

Berto
