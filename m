Received: from eggs.gnu.org ([2001:4830:134:3::10]:50164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1elZou-00078n-3k
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1elZor-0004Al-1X
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:36:24 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180213123217.GE5083@localhost.localdomain>
References: <cover.1517840876.git.berto@igalia.com>
	<bd3547b670b8d0af11480c760991a22bcae5b48c.1517840877.git.berto@igalia.com>
	<20180213123217.GE5083@localhost.localdomain>
Date: Tue, 13 Feb 2018 13:36:16 +0100
Message-ID: <w51o9kt5anz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 37/39] iotests: Test valid values of
 l2-cache-entry-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Tue 13 Feb 2018 01:32:17 PM CET, Kevin Wolf wrote:
>> +# Invalid cache entry sizes
>> +$QEMU_IO -c "open -o l2-cache-entry-size=256 $TEST_IMG" \
>> +    2>&1 | _filter_testdir | _filter_imgfmt
>> +$QEMU_IO -c "open -o l2-cache-entry-size=300 $TEST_IMG" \
>> +    2>&1 | _filter_testdir | _filter_imgfmt
>
> If you wanted to test non-power-of-two values here, it would be better
> to use a value that isn't < 512 at the same time.

Good idea, if there's no new version of the series whoever applies this
can feel free to change this value to 3000 or something like that.

Berto
