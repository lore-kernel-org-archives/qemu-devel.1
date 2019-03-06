Received: from eggs.gnu.org ([209.51.188.92]:55767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1W2T-0005wT-VJ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1W2T-0004Xn-AQ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:52:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1W2T-0004XL-3O
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:52:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
	<7f974735-1a97-cacc-2354-5f26bc0feda0@redhat.com>
Date: Wed, 06 Mar 2019 13:52:41 +0100
In-Reply-To: <7f974735-1a97-cacc-2354-5f26bc0feda0@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 6 Mar 2019 12:17:27
	+0100")
Message-ID: <87o96oyxk6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/21] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/5/19 7:15 PM, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>=20
>> The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6=
a2d:
>>=20
>>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' =
into staging (2019-03-05 09:33:20 +0000)
>>=20
>> are available in the Git repository at:
>>=20
>>   git://github.com/dagrh/qemu.git tags/pull-migration-20190305a
>>=20
>> for you to fetch changes up to 3feabbb5fc5e3d5504c735a77ebd1d7fc1eabb9b:
>>=20
>>   qapi/migration.json: Remove a variable that doesn't exist in example (=
2019-03-05 18:04:05 +0000)
>>=20
>> ----------------------------------------------------------------
>> Migration pull 2019-03-05
>>=20
>>    a) 3 small fixes including the cancel problem
>>      that caused the ahci migration test to fail
>>      intermittently
>>    b) Yury's ignore-shared feature
>>    c) Juan's extra tests
>>    d) Wei Wang's free page hinting
>>    e) Some Colo fixes from Zhang Chen
>>=20
>> ----------------------------------------------------------------
>> Dr. David Alan Gilbert (2):
>>       migration: Fix cancel state
>>       migration/rdma: Fix qemu_rdma_cleanup null check
>>=20
>> Juan Quintela (3):
>>       tests: Add migration xbzrle test
>>       migration: Create socket-address parameter
>
> Replying to cover for Peter scripts:
>
> In patch 10/21 Daniel said he'll respin.

Just to make sure this sticks:

NAK
NACK
NAcked-by: Markus Armbruster <armbru@redhat.com>

;)
