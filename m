Received: from eggs.gnu.org ([2001:4830:134:3::10]:35877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAYi4-0000P1-LP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAYi1-0006QT-KE
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:56:20 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8403f7a8-2ca1-d7b0-34d4-5e027112d005@redhat.com>
References: <cover.1509550787.git.berto@igalia.com>
	<090da3a925cd09404afb7cae97bd867697e7da21.1509550787.git.berto@igalia.com>
	<8403f7a8-2ca1-d7b0-34d4-5e027112d005@redhat.com>
Date: Fri, 03 Nov 2017 10:56:13 +0100
Message-ID: <w51a803bs8y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] qcow2: Prevent allocating L2 tables at
 offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

On Thu 02 Nov 2017 06:31:18 PM CET, Max Reitz wrote:
>> +    /* If we're allocating the table at offset 0 then something is wrong */
>> +    if (l2_offset == 0) {
>> +        qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
>> +                                "allocation of L2 table at offset 0");
>> +        return -EIO;
>
> The other error paths in this function use a goto fail.  It doesn't
> make a functional difference, but not doing it here looks a bit weird.

Oh, you're right. I'll fix it.

Berto
