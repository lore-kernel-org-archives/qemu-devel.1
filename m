Received: from eggs.gnu.org ([2001:4830:134:3::10]:51671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6EIe-0005JH-Lj
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6EId-0008A3-CC
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:52:28 -0400
References: <20180330161040.350271-1-vsementsov@virtuozzo.com>
	<b6a499bc-b5c6-7c35-e916-d63861f0c0c5@redhat.com>
	<3d0d9016-276f-c1c6-eb7e-ef78c0744f01@redhat.com>
	<47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <766b66de-8ca8-c687-e9a3-616f1b8b55b7@redhat.com>
Date: Wed, 11 Apr 2018 13:52:12 +0200
MIME-Version: 1.0
In-Reply-To: <47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

On 2018-04-11 11:02, Vladimir Sementsov-Ogievskiy wrote:
> 03.04.2018 23:13, John Snow wrote:
>>
>> On 04/03/2018 12:23 PM, Max Reitz wrote:
>>> On 2018-03-30 18:10, Vladimir Sementsov-Ogievskiy wrote:
>>>> Use MIGRATION events instead of RESUME. Also, make a TODO: enable
>>>> dirty-bitmaps capability for offline case.
>>>>
>>>> This (likely) fixes racy faults at least of the following types:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - timeout on waiting for RESUME event
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - sha256 mismatch on 136 (138 after this pa=
tch)
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>>
>>>> This patch is a true change for the test anyway. But I don't
>>>> understand,
>>>> why (and do really) it fixes the things. And I'm not sure about do w=
e
>>>> really have a bug in bitmap migration or persistence. So, it's up to
>>>> you,
>>>> take it into 2.12...
>>>>
>>>> It was already discussed, that "STOP" event is bad for tests. What
>>>> about
>>>> "RESUME"? How can we miss it? And sha256 mismatch is really somethin=
g
>>>> strange.
>>>>
>>>> Max, please check, do it fix 169 for you.
>>>>
>>>> =C2=A0 tests/qemu-iotests/169 | 44
>>>> +++++++++++++++++++++++---------------------
>>>> =C2=A0 1 file changed, 23 insertions(+), 21 deletions(-)
>>> This makes the test pass (thanks!), but it still leaves behind five
>>> cats...
>>>
>>> Max
>>>
>>>
>> Hmm:
>>
>> jhuston=C2=A0 14772=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
84 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 14796=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
64 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 14940=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
88 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 14964=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
20 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 15052=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
68 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>>
>> Why do these get left behind? Nothing to consume the data...?
>=20
> aha, understand. it is due to last vm_b.shutdown() and vm_b.launch in
> case of should_migrate. So, at the end of the test I restart vm_b with
> -incoming parameter. But it looks like=C2=A0 a bug anyway, If we start =
qemu
> with -incoming "exec", should not we kill cat process, if there were no
> migration?

I agree, but it's your choice whether you want to fix that bug or just
change the test slightly -- I'm responsible for the iotests, but not for
migration, so I have to admit I don't mind just changing this test to
accomodate. O:-)

It appears that just removing the mig_file before the second
vm_b.launch() is sufficient (and enclosing the removal of that file in
tearDown() in a try/except block).  I suppose the cat process will
complain, but that doesn't stop the test from passing.  If you want to
be really nice, I suppose you could just overwrite the FIFO mig_file
with an empty regular file, but I don't think it's actually necessary...

Max
