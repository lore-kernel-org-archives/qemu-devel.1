Received: from eggs.gnu.org ([2001:4830:134:3::10]:45877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOWxa-0002RW-9n
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOWxZ-0005ur-Bo
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:26:22 -0400
References: <20180531222835.16558-1-jsnow@redhat.com>
	<4689e55e-49cc-48ab-4e86-b80d5b07f479@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <a653a884-7e75-2983-2588-2a08539c4d9c@redhat.com>
Date: Thu, 31 May 2018 19:26:15 -0400
MIME-Version: 1.0
In-Reply-To: <4689e55e-49cc-48ab-4e86-b80d5b07f479@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/16] AHCI: tracing improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 05/31/2018 07:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/31/2018 07:28 PM, John Snow wrote:
>> This set just adds register names so that the read/write traces make
>> more sense on their own without having to memorize register offsets.
>> It also splits read/write traces into supported/unsupported subsets,
>> so you can just monitor for things that QEMU is likely doing wrong.
>>
>> v2:
>>  - Added qemu_log_mask(LOG_UNIMP, ...) statements in addition to trace=
s
>>    for writes to unknown/unsupported registers. (Philippe)
>=20
> Thanks,
>=20
> With format string and style issues reported by checkpatch fixed:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> (I recommend you to setup the scripts/git.orderfile to ease reviews).
>=20

Ah, yeah, my environment is kind of broken at the moment, sorry :(

Just haven't had the time to figure out why git-publish is broken so I'm
missing a few of my usual pieces.

--js
