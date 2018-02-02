Received: from eggs.gnu.org ([208.118.235.92]:49954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehdNd-0007lx-03
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehdMY-00065l-1b
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:55 -0500
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
	<7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
	<9ac62cef-4331-a828-5c4d-b7a2fdd7b6b5@redhat.com>
	<cbeff34d-b676-3663-654c-e7a224b389b0@virtuozzo.com>
	<90c3ab12-1bda-c3a4-fdbf-626fcefaa7ca@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <244521c0-9899-e78e-4b82-9a87b4b97d7d@virtuozzo.com>
Date: Fri, 2 Feb 2018 18:30:17 +0300
MIME-Version: 1.0
In-Reply-To: <90c3ab12-1bda-c3a4-fdbf-626fcefaa7ca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

02.02.2018 18:23, Max Reitz wrote:
> On 2018-02-02 16:18, Vladimir Sementsov-Ogievskiy wrote:
>> 31.01.2018 22:04, Max Reitz wrote:
>>> On 2018-01-29 19:43, Max Reitz wrote:
>>>> On 2018-01-22 11:41, Vladimir Sementsov-Ogievskiy wrote:
>>>>> To maintain load/store disabled bitmap there is new approach:
>>>>>
>>>>>  =C2=A0 - deprecate @autoload flag of block-dirty-bitmap-add, make it=
 ignored
>>>>>  =C2=A0 - store enabled bitmaps as "auto" to qcow2
>>>>>  =C2=A0 - store disabled bitmaps without "auto" flag to qcow2
>>>>>  =C2=A0 - on qcow2 open load "auto" bitmaps as enabled and others
>>>>>  =C2=A0=C2=A0=C2=A0 as disabled (except in_use bitmaps)
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>>> ---
>>>> Thanks, looks very reasonable.=C2=A0 Applied to my block branch:
>>>>
>>>> https://github.com/XanClic/qemu/commits/block
>>> ...aaand I've only just now seen that iotest 176 will need to be fixed
>>> along with this, so I'm going to unqueue this patch for now.
>> ohh, sorry for that. Will resend today.
>>
>>> And when I'm already at it: Should we add deprecation information to
>>> qemu-doc.texi?
>> didn't find anything in qemu-doc.texi about dirty bitmaps, so I think, n=
o.
> I mean in the "Deprecated features" appendix.  I think whenever we
> deprecate something, it should be noted there (as far as I've understood)=
.

Ok, understand, will add. (hmm no section for QMP in this appendix, I'll=20
be the first =3D(

>
> (Also on the Wiki, I think.)

nothing about autoload and persistent parameters in the wiki (=20
https://wiki.qemu.org/Features/IncrementalBackup , nothing else ? ).=20
Hovewer, it is good idea to update material in wiki, I'll think about it.

>
>> Is there a way to generate some documentation files from qapi comments?
>> Where is it?
> There is docs/interop/qemu-qmp-qapi.texi in the build directory.
>
> Max
>


--=20
Best regards,
Vladimir
