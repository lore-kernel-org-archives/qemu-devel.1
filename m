Received: from eggs.gnu.org ([2001:4830:134:3::10]:45783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dArJa-0006Td-GL
	for qemu-devel@nongnu.org; Wed, 17 May 2017 01:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dArJZ-0005Je-LS
	for qemu-devel@nongnu.org; Wed, 17 May 2017 01:16:02 -0400
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-4-hpoussin@reactos.org>
	<20170516132107.GD4438@noname.redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <80023401-0418-5954-ab47-e4788ee5eef9@reactos.org>
Date: Wed, 17 May 2017 07:15:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170516132107.GD4438@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/13] vvfat: fix typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Le 16/05/2017 =E0 15:21, Kevin Wolf a =E9crit :
> Am 15.05.2017 um 22:31 hat Herv=E9 Poussineau geschrieben:
>> @@ -806,7 +806,7 @@ static int read_directory(BDRVVVFATState* s, int m=
apping_index)
>>                  (ROOT_ENTRIES - cur) * sizeof(direntry_t));
>>      }
>>
>> -     /* reget the mapping, since s->mapping was possibly realloc()ed =
*/
>> +    /* reset the mapping, since s->mapping was possibly realloc()ed *=
/
>
> Are you sure that this was a typo? It seems to make more sense to me as
> "re-get" (maybe easer to read with the hyphen).

IMO, both are valid. But I'll change it to "re-get" for v2.

>
>>      mapping =3D array_get(&(s->mapping), mapping_index);
>>      first_cluster +=3D (s->directory.next - mapping->info.dir.first_d=
ir_index)
>>          * 0x20 / s->cluster_size;
>
> Kevin
>
